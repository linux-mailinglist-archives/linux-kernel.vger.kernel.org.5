Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BC275E8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjGXBmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjGXBmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075125247;
        Sun, 23 Jul 2023 18:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5585760F7B;
        Mon, 24 Jul 2023 01:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A014C433CB;
        Mon, 24 Jul 2023 01:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162393;
        bh=aa56GfC1x9AiCZc4k2h1zfBoi97OMbCa9OPaLFbbEPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REklOBtDfxs2yXxHE2+x7ZAp+TlTcHYdKyUI1PDPQzMuXBY/9NWDv2wYmNsmcwgh4
         z5E4qs54izt/rwHNnWGje8Z/maFRyyfhvvxevCI4GeDgI2q/0cYMnpLl/Tki80aqnH
         rvg4fYrvfzYbA/URQOb1oL5Xkchj3eobh4+hFhLAuV3wCEaZsFPofDDzF4pmsFdyWl
         JoZ8MMm2hd1oGrHpqAz6cnRY0QcT1rF7v3c74Hy+ARYhnBgddhkCEfQyZlHr6UqeAn
         eE8NmE1Blbke94Dt5lsdz28kFmgaXEjBp/ZU9GPByaCWit3hQ1Ps5153YneewaAFfT
         dE/3hoBIRLEOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju@buaa.edu.cn>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 26/34] fs: ntfs3: Fix possible null-pointer dereferences in mi_read()
Date:   Sun, 23 Jul 2023 21:32:29 -0400
Message-Id: <20230724013238.2329166-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju@buaa.edu.cn>

[ Upstream commit 97498cd610c0d030a7bd49a7efad974790661162 ]

In a previous commit 2681631c2973 ("fs/ntfs3: Add null pointer check to
attr_load_runs_vcn"), ni can be NULL in attr_load_runs_vcn(), and thus it
should be checked before being used.

However, in the call stack of this commit, mft_ni in mi_read() is
aliased with ni in attr_load_runs_vcn(), and it is also used in
mi_read() at two places:

mi_read()
  rw_lock = &mft_ni->file.run_lock -> No check
  attr_load_runs_vcn(mft_ni, ...)
    ni (namely mft_ni) is checked in the previous commit
  attr_load_runs_vcn(..., &mft_ni->file.run) -> No check

Thus, to avoid possible null-pointer dereferences, the related checks
should be added.

These bugs are reported by a static analysis tool implemented by myself,
and they are found by extending a known bug fixed in the previous commit.
Thus, they could be theoretical bugs.

Signed-off-by: Jia-Ju Bai <baijiaju@buaa.edu.cn>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index af1e4b364ea8e..07037ec773ac8 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -124,7 +124,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	struct rw_semaphore *rw_lock = NULL;
 
 	if (is_mounted(sbi)) {
-		if (!is_mft) {
+		if (!is_mft && mft_ni) {
 			rw_lock = &mft_ni->file.run_lock;
 			down_read(rw_lock);
 		}
@@ -148,7 +148,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 		ni_lock(mft_ni);
 		down_write(rw_lock);
 	}
-	err = attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, &mft_ni->file.run,
+	err = attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, run,
 				 vbo >> sbi->cluster_bits);
 	if (rw_lock) {
 		up_write(rw_lock);
-- 
2.39.2

