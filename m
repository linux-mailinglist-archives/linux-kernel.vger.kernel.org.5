Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB32C7799AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjHKVje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbjHKVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:39:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543132683
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E837467A09
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 21:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E076C433C7;
        Fri, 11 Aug 2023 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691789970;
        bh=KKpGLobAIF8HUegqWNTFJDMKzbP0/pVlV+z7f2QcPxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tQv9i5OPbstjA4C0wwvPncwznhOzGNf6nhbCtw/qr33UWETh6nY7OJzYZ3dcnjoz2
         n3gUX2EHsBA39UTXUP/rwEMV+yznOdhciO0GOsTOwDIn42U/jrJdeYFFud2y2ALggl
         RTSPRDwmyYdMvzFI2w28UJwADTAMLZfKUeXscTkI=
Date:   Fri, 11 Aug 2023 14:39:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] add page_ext_data to get client data in page_ext
Message-Id: <20230811143929.79ee3231cbcdfbe43852a4bf@linux-foundation.org>
In-Reply-To: <20230720053736.GM1901145@kernel.org>
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
        <20230719094421.GI1901145@kernel.org>
        <aa2134aa-3767-b9fe-1504-d6945e8c2f7b@huaweicloud.com>
        <20230720053736.GM1901145@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 08:37:36 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> Hi,
> 
> On Thu, Jul 20, 2023 at 10:38:39AM +0800, Kemeng Shi wrote:
> > 
> > on 7/19/2023 5:44 PM, Mike Rapoport wrote:
> > > On Tue, Jul 18, 2023 at 10:58:09PM +0800, Kemeng Shi wrote:
> > >> Current client get data from page_ext by adding offset which is auto
> > >> generated in page_ext core and expose the data layout design insdie
> > >> page_ext core. This series adds a page_ext_data to hide offset from
> > >> client. Thanks!
> > > 
> > > Implementers of page_ext_operations are anyway intimately related to
> > > page_ext, so I'm not convinced this has any value.
> > >  
> > Hi Mike, thanks for reply. I thinks page_ext_operations can be futher splited
> > into public part which used by client to simply register and private part which
> > only page_ext core cares and should not be accessed by client directly
> > to reduce decoupling.
> 
> It would be easier to justify changes in this series if they were a part of
> the refactoring you describe here.
> 
> > This series makes offset to be private which client
> > doesn't really care to hide data layout inside page_ext core from client.
> > There are some concrete gains I can list for now:
> > 1. Future client cound call page_ext_data directly instead of define a
> > new function like get_page_owner to get it's data.
> > 2. No change to client if layout of page_ext data change.
> 
> These should be a part of the changelog.
> 

I added this to the [0/N]:

: Benefits include:
: 
: 1. Future clients can call page_ext_data directly instead of defining
:    a new function like get_page_owner to get the data.
: 
: 2. There is no change to clients if the layout of page_ext data changes.

Mike, what is your position on this patchset now?

Thanks.
