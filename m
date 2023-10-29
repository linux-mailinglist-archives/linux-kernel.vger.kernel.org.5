Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F617DAF76
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjJ2W7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjJ2W7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:59:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB24692;
        Sun, 29 Oct 2023 15:58:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40C8C433BB;
        Sun, 29 Oct 2023 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620269;
        bh=/hoZrSFkrFBTJcCRbT2QPw/OfnnvF91P8+vYphp+inI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbgBNm+BisdRej34qGSfghRm81bAUho/yXHr8b4WPrWNzr1Grms8cJrJU2i+/OgqE
         wMoEd1fxypXUGKE015h9HObEBGsy3Nc0DvQHLY9MB78X5f6KzECl84UO+4s34Vzkyo
         qcMTebxMfMD5rsgLkwoEZpWZNahGohhku1dgYtbmDKm/J1HWELct0rLNID48chPeZa
         CDsnI5DcZETPc90pPpHKlkCnY4BBbsKjYFabZ3RAlLCcwXNSZPYU1aWp+4v0CIMRl0
         HzJU8/5UKdQ5Hw0DpYfncf1Jg19sczu4zOjrpprCzek7NJHIXKHotYB/n8j3H3AyIH
         D6Lr+AySYNvLg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 06/39] fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
Date:   Sun, 29 Oct 2023 18:56:38 -0400
Message-ID: <20231029225740.790936-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 32e9212256b88f35466642f9c939bb40cfb2c2de ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 166c3c49530ec..bb7e33c240737 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2149,7 +2149,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 
 	for (i = 0; i < pages_per_frame; i++) {
 		pg = pages[i];
-		if (i == idx)
+		if (i == idx || !pg)
 			continue;
 		unlock_page(pg);
 		put_page(pg);
-- 
2.42.0

