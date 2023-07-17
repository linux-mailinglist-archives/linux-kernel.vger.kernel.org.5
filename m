Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA11756AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGQRe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3681B5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 917F561184
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB7A7C433CA;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689615262;
        bh=sWvrP4ixrAensNWjeWVXpoXmXS3QBHBVmKy2NaIEE3o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GyB6VcKRYFCvnWLX9uTjLGZKSOcBgH+EHagbudwpzqH+iJkNjBIWoX8ebxI33rARO
         foSvxF/T7vcaRsfUQeQDSEv905bt0JintEqer2ggpR8c8/WU+69CjUcD/w78p+5whS
         OJNCL8aPiAOaK50DqAM3AN7COcooRzrBVsiRYIaz/xKI+sBeoyvdUT7phpoS9txn/U
         9UUbrSCAv2y8VIwY2n504GGcxzFkjTiQJdM72nDk/Cb+Udy3cQutwSvz8SlAfJyt0W
         VEMcRQjAGgCiiZNh8zG3iueRQ5YQbP1xWYn70lWxAt933i6UuPfKMs6UcTpjI6HGG6
         1vWICIe2VTAxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9F29C59A4C;
        Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to avoid mmap vs
 set_compress_option case
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168961526181.4078.12987776501092675695.git-patchwork-notify@kernel.org>
Date:   Mon, 17 Jul 2023 17:34:21 +0000
References: <20230706020614.2950782-1-chao@kernel.org>
In-Reply-To: <20230706020614.2950782-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  6 Jul 2023 10:06:14 +0800 you wrote:
> Compression option in inode should not be changed after they have
> been used, however, it may happen in below race case:
> 
> Thread A				Thread B
> - f2fs_ioc_set_compress_option
>  - check f2fs_is_mmap_file()
>  - check get_dirty_pages()
>  - check F2FS_HAS_BLOCKS()
> 					- f2fs_file_mmap
> 					 - set_inode_flag(FI_MMAP_FILE)
> 					- fault
> 					 - do_page_mkwrite
> 					  - f2fs_vm_page_mkwrite
> 					  - f2fs_get_block_locked
> 					 - fault_dirty_shared_page
> 					  - set_page_dirty
>  - update i_compress_algorithm
>  - update i_log_cluster_size
>  - update i_cluster_size
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix to avoid mmap vs set_compress_option case
    https://git.kernel.org/jaegeuk/f2fs/c/3174a6dbb945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


