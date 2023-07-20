Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1167E75A57F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGTFiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGTFiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF31726
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793AF61803
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC4CC433C8;
        Thu, 20 Jul 2023 05:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689831479;
        bh=a4gK1D97qFOeqsvBd2dHAlBTxcjDDuDOYGdbrbAW3bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5vaqIQNSWRtNNeV0sxBPgE6Nu23tFiqCWrelX/PN3qtlgs7brOuJPbOPLbRpg6L4
         aaU0eF0YcHxLe0LdaU/Bbc2qECE3LLOf/b4s2rTDpoTX63hjrM51DrD98nj17ES2FQ
         MWe9XaWwkqWmiiokl5CPdiTIOVFKF4yyaqUbCjqw9iOUZEevTMc0ooZrj+a4GDFct+
         yexyxWdKjtCTYOLwI3WG3MvoKKmkYymqbL+tjkqgMbh1TEh9MQKqxIf7eFCgBwXxQD
         HzEYRLUe5T5TezlqlmW/ULE7+hRDYsYovGkAuvFyrfQ0GdW/lSuG59J3zrQ9o7+hYN
         MgyxXV8w3fW4Q==
Date:   Thu, 20 Jul 2023 08:37:36 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] add page_ext_data to get client data in page_ext
Message-ID: <20230720053736.GM1901145@kernel.org>
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
 <20230719094421.GI1901145@kernel.org>
 <aa2134aa-3767-b9fe-1504-d6945e8c2f7b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2134aa-3767-b9fe-1504-d6945e8c2f7b@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 20, 2023 at 10:38:39AM +0800, Kemeng Shi wrote:
> 
> on 7/19/2023 5:44 PM, Mike Rapoport wrote:
> > On Tue, Jul 18, 2023 at 10:58:09PM +0800, Kemeng Shi wrote:
> >> Current client get data from page_ext by adding offset which is auto
> >> generated in page_ext core and expose the data layout design insdie
> >> page_ext core. This series adds a page_ext_data to hide offset from
> >> client. Thanks!
> > 
> > Implementers of page_ext_operations are anyway intimately related to
> > page_ext, so I'm not convinced this has any value.
> >  
> Hi Mike, thanks for reply. I thinks page_ext_operations can be futher splited
> into public part which used by client to simply register and private part which
> only page_ext core cares and should not be accessed by client directly
> to reduce decoupling.

It would be easier to justify changes in this series if they were a part of
the refactoring you describe here.

> This series makes offset to be private which client
> doesn't really care to hide data layout inside page_ext core from client.
> There are some concrete gains I can list for now:
> 1. Future client cound call page_ext_data directly instead of define a
> new function like get_page_owner to get it's data.
> 2. No change to client if layout of page_ext data change.

These should be a part of the changelog.

> I hope this could be more convincing to you now.
> Thanks!
> 
> -- 
> Best wishes
> Kemeng Shi
> 

-- 
Sincerely yours,
Mike.
