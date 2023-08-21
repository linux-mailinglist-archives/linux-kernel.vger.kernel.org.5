Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA292783161
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjHUTu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHUTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0387218F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B1B617A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A03CC433CC;
        Mon, 21 Aug 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692647424;
        bh=es0bzIgys24sNzS+9pgWgwW0Yx6y8DpEGYMD/Xo+ZHg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LOI9JU2kyMrnVX4aIdjDHRNagfNKznt/O/b/bAGE1UpixxCC8rn3yvkJZr/bCRQ0C
         UppzrTyhF/caPtr900gtOWxMKp2v9Iw8Brzgddq5lKj/MdS8HCxhK1sSwMWvq8OcMW
         oXLgrrWRdgxSA7YvtV58PEQOzs7QFyCokuyZjpVpAZtawDdD9H5H0y6PTR52pq6hft
         pUu05VJt/M/+IVWUGYnsm9mjIwjCzX2wwtS1c9S4NmBhRn7ZClg/ggKs/BRMbVpS4E
         YnLtKvm8XLNjeVmHV5QnyZv6GzqrDa5GwWqqSg9ITN6PBVdp9KuIjPzD8Vg8Av7Dlz
         9wKut4UL9vyLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6E90E21EE9;
        Mon, 21 Aug 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid false alarm of circular locking
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169264742387.19522.17629491887216526280.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Aug 2023 19:50:23 +0000
References: <20230819003012.3473675-1-jaegeuk@kernel.org>
In-Reply-To: <20230819003012.3473675-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 18 Aug 2023 17:30:12 -0700 you wrote:
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.5.0-rc5-syzkaller-00353-gae545c3283dc #0 Not tainted
> ------------------------------------------------------
> syz-executor273/5027 is trying to acquire lock:
> ffff888077fe1fb0 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2133 [inline]
> ffff888077fe1fb0 (&fi->i_sem){+.+.}-{3:3}, at: f2fs_add_inline_entry+0x300/0x6f0 fs/f2fs/inline.c:644
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: avoid false alarm of circular locking
    https://git.kernel.org/jaegeuk/f2fs/c/5c13e2388bf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


