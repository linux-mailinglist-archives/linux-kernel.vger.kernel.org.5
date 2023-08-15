Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB68B77C80D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjHOGpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjHOGpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0422173D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59BF563659
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E22C433C8;
        Tue, 15 Aug 2023 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692081898;
        bh=N/4HsXYS350f+iJkjsF8MsfXr2M7KiE37MDOm3Kw0lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPj9wVk5xpXrsnlHJ10aHVTpPUNZij6r8fuG6qaGGV1lWlwwm51IiVptZo1xCN8q8
         rWshzJ0rDR9aW7dvQsExfmz+P/AxUVhabzzzlcwXOpeMANKqfQWt3aBSeCTRfBOZ/S
         KKW/yP3r5DVq8fCF841czMZX6++DG+SxJik/f9GlMrx4YL6fOWk/uaTgEnUpP49QM7
         mWbiI61KbGgS1RlJ+EjZR0eWwTHR55IgQI8XSeinQ/mbKKUMQgX9OQIii/lrrf+kUc
         GtjbJXEEe0eVAW6kdTkeOUObuSEiqpcmE22Sz/1fc/ZGFILL+ozNLYGKxwQlZVTrjC
         RWprzgy1+S29Q==
Date:   Tue, 15 Aug 2023 09:43:56 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] add page_ext_data to get client data in page_ext
Message-ID: <20230815064356.GP2607694@kernel.org>
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
 <20230719094421.GI1901145@kernel.org>
 <aa2134aa-3767-b9fe-1504-d6945e8c2f7b@huaweicloud.com>
 <20230720053736.GM1901145@kernel.org>
 <20230811143929.79ee3231cbcdfbe43852a4bf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811143929.79ee3231cbcdfbe43852a4bf@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 02:39:29PM -0700, Andrew Morton wrote:
> On Thu, 20 Jul 2023 08:37:36 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Hi,
> > 
> > On Thu, Jul 20, 2023 at 10:38:39AM +0800, Kemeng Shi wrote:
> > > 
> > > on 7/19/2023 5:44 PM, Mike Rapoport wrote:
> > > > On Tue, Jul 18, 2023 at 10:58:09PM +0800, Kemeng Shi wrote:
> > > >> Current client get data from page_ext by adding offset which is auto
> > > >> generated in page_ext core and expose the data layout design insdie
> > > >> page_ext core. This series adds a page_ext_data to hide offset from
> > > >> client. Thanks!
> > > > 
> > > > Implementers of page_ext_operations are anyway intimately related to
> > > > page_ext, so I'm not convinced this has any value.
> > > >  
> > > Hi Mike, thanks for reply. I thinks page_ext_operations can be futher splited
> > > into public part which used by client to simply register and private part which
> > > only page_ext core cares and should not be accessed by client directly
> > > to reduce decoupling.
> > 
> > It would be easier to justify changes in this series if they were a part of
> > the refactoring you describe here.
> > 
> > > This series makes offset to be private which client
> > > doesn't really care to hide data layout inside page_ext core from client.
> > > There are some concrete gains I can list for now:
> > > 1. Future client cound call page_ext_data directly instead of define a
> > > new function like get_page_owner to get it's data.
> > > 2. No change to client if layout of page_ext data change.
> > 
> > These should be a part of the changelog.
> > 
> 
> I added this to the [0/N]:
> 
> : Benefits include:
> : 
> : 1. Future clients can call page_ext_data directly instead of defining
> :    a new function like get_page_owner to get the data.
> : 
> : 2. There is no change to clients if the layout of page_ext data changes.
> 
> Mike, what is your position on this patchset now?

I'm fine with it, so if it's not too much hassle to add it now

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

 
> Thanks.

-- 
Sincerely yours,
Mike.
