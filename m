Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847977D3AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjJWPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJWPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD8DF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 415E7C43391;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075025;
        bh=Qde5lD2H9pgYacxOPvWGUoIweuMUBvcPozp5suB9kJI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=atOJP2NaWlB+bkSZfHdWNKdLZ2W2rKacrDJXUjL2ffderZs6lmRxWwo3/R+zukcaS
         KmBFgd9Q7UeKnwjeBoOh9CmUCVlDELjpOGpzrqMr3iTSxT5RNHm+SKJBcQAtbs4Rqc
         M4PtUXo+L5fTv047Xy75ZubyJqlJULEnQTmK0tAl+QYWq9CbK9k3QC7fk77EXnbFZT
         thLma4AHKdB/StGwIjIPjlvsYK5M9gLqPMLXKl41oArLTzhlebyNyEL1n4U1JAddzP
         Anga6cH/HefM+r3T8LlIG8ixiwAnEGlNSLAfYree4srg1YOBwZgp1m2yNU0wY0IMi/
         CQH8kryxtOfzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 187B8C595C5;
        Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: stop iterating f2fs_map_block if hole
 exists
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169807502509.26537.10000141345816003464.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 15:30:25 +0000
References: <20231003225208.1936359-1-jaegeuk@kernel.org>
In-Reply-To: <20231003225208.1936359-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  3 Oct 2023 15:52:08 -0700 you wrote:
> Let's avoid unnecessary f2fs_map_block calls to load extents.
> 
>  # f2fs_io fadvise willneed 0 4096 /data/local/tmp/test
> 
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 386, start blkaddr = 0x34ac00, len = 0x1400, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 5506, start blkaddr = 0x34c200, len = 0x1000, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 9602, start blkaddr = 0x34d600, len = 0x1200, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 14210, start blkaddr = 0x34ec00, len = 0x400, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 15235, start blkaddr = 0x34f401, len = 0xbff, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 18306, start blkaddr = 0x350200, len = 0x1200, flags = 2
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 22915, start blkaddr = 0x351601, len = 0xa7d, flags = 2
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25600, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25601, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25602, start blkaddr = 0x351601, len = 0x0, flags = 0
>   ...
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1037188, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1038206, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1039224, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 2075548, start blkaddr = 0x351601, len = 0x0, flags = 0
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: stop iterating f2fs_map_block if hole exists
    https://git.kernel.org/jaegeuk/f2fs/c/4ed33e69e136

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


