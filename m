Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E007F9355
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjKZPRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjKZPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:17:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C234FB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:17:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8D5C433C9;
        Sun, 26 Nov 2023 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701011838;
        bh=mlKmjTq1YkDid0Jztqm64+Hd0IdQBCJuAG//PGNC4vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMgQA+y+63fGhGr3hSYLUWHuMxc44IydSrsbsu9Nkyz1PVjHPYYK/5XDlbMGEj8p7
         nwPAnZHDnzsOzTCeaDnVNv6XxqXTHEG3KeBjKqK+a/BTQ6ynlQVZ7Xwfj904hUB5B+
         ZeFaBXB91AzkmtMAGFujDIYHq7/4mIpCeSatTszw=
Date:   Sun, 26 Nov 2023 15:17:15 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernfs:  reorder 'struct kernfs_node' to save some memory
Message-ID: <2023112636-ouch-estrogen-1a5e@gregkh>
References: <465890c56c6f5ad702a091a1ecd3c70bd4a3a74c.1701010150.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465890c56c6f5ad702a091a1ecd3c70bd4a3a74c.1701010150.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 03:49:37PM +0100, Christophe JAILLET wrote:
> 'struct kernfs_node' uses a dedicated cache, so shrinking its size is
> always a good idea.
> 
> On my system, each entry is 128 bytes and their are 32 entries per pages.
> After the re-ordering, the struct is 120 bytes and 34 entries are stored
> in each page.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The numbers below are with a allmodconfig configuration. The delta is
> related to CONFIG_DEBUG_LOCK_ALLOC and struct lockdep_map	dep_map.
> 
> When I checked on my system, it would have saved 372kb of RAM:
>   sudo less /proc/slabinfo | grep kernf
>   kernfs_node_cache  49397  49504    128   32    1 : tunables    0    0    0 : slabdata   1547   1547      0
> 
> I have left flags close to the union, I *think* that they are related.
> I don't if having 'mode' here is logical or not.

I'm all for fixing up holes, but have you checked this before and after
with lockdep disabled?  That's usually the biggest chunk, and can cause
alignment issues, perhaps moving that to the end would make more sense?
With that, I think everything can fit in 2 cachelines except for the
lockdep structure?

thanks,

greg k-h
