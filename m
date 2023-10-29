Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9BF7DAF02
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjJ2Wzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjJ2WzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:55:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18921B6;
        Sun, 29 Oct 2023 15:55:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB43DC433CD;
        Sun, 29 Oct 2023 22:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620104;
        bh=pyCdkn/dJ0qS0Zv0n21ByAtdrhLUzh1LXYsv29Xd2Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojQmZhvxY5GoHEahZ34IXRvBTyD6kN/IEQ27ZXLp5ZO5xWfhXRm3uEWZQ6SfUTtMC
         GapwPHnwRpUYbnXiRuDNldPFxct9PUssQdbMuAXwNia96bdoSBLm1RCgpFBG3/mAmM
         SekL3t6Gm1H5VJNdqn8h8gQQVw/Zi/mwvcy0U5DaR6X0jZ9VQ+d1z4xc7DpyE4PTqG
         d+ecExMyrJXfiU4JggS55mcU/yngYZJ8P0gMqwvkJPyrzmOAUo3KphUuV9Jukwg3Wq
         8Xa8CHBufSd0DqJIVndJ1W+daG6CC8yVzqgW9yU5x6dLEhj/IZlNXx5mXUcCoVF4vT
         16yeB9lrddYRA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Su Hui <suhui@nfschina.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 15/52] fs/ntfs3: Avoid possible memory leak
Date:   Sun, 29 Oct 2023 18:53:02 -0400
Message-ID: <20231029225441.789781-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Hui <suhui@nfschina.com>

[ Upstream commit e4494770a5cad3c9d1d2a65ed15d07656c0d9b82 ]

smatch warn:
fs/ntfs3/fslog.c:2172 last_log_lsn() warn: possible memory leak of 'page_bufs'
Jump to label 'out' to free 'page_bufs' and is more consistent with
other code.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 12f28cdf5c838..98ccb66508583 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2168,8 +2168,10 @@ static int last_log_lsn(struct ntfs_log *log)
 
 			if (!page) {
 				page = kmalloc(log->page_size, GFP_NOFS);
-				if (!page)
-					return -ENOMEM;
+				if (!page) {
+					err = -ENOMEM;
+					goto out;
+				}
 			}
 
 			/*
-- 
2.42.0

