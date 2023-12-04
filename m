Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C545280400F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbjLDUhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbjLDUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:37:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367C359B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFACC433C8;
        Mon,  4 Dec 2023 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722126;
        bh=U8lKSXm6oWYfv9aGWHQQ2wtvUQVQ/g7PATqFBLi70tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et3UT5EjpVliNlsLq5wi8oXgR6Bu0GpzuX8s7QthNCjZnzYgygAJjybcgodonqomU
         C0jKHAOO7qSn7ruIbWxmV+p4aR//T2tKkUptOWzcC8CWq2oweG/2eX73ooOfl9H/R7
         RJtuiOEGn1Y0hLClTnLpneKsh+ENiRvggaDhZduW1nOfekc0IQyYvBkHOInAWLnnvY
         cqMLy+cI4KLXg8so/KjAYI0NzlF+wNwNKLDNe21diA0zGyaLRbuGQMMAcLeAKtZZFx
         bA6xAf7NOfFx3sUcL/fYDOBNvn7yqiySrCuIJkN4dt3yf1XWPHF/V7PhyPSpT6xCwM
         PfGzegmSNihgQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/17] ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
Date:   Mon,  4 Dec 2023 15:34:48 -0500
Message-ID: <20231204203514.2093855-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit cd80ce7e68f1624ac29cd0a6b057789d1236641e ]

ksmbd set ->op_state as OPLOCK_STATE_NONE on lease break ack error.
op_state of lease should not be updated because client can send lease
break ack again. This patch fix smb2.lease.breaking2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 683152007566c..603d9170d28a7 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8294,7 +8294,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	return;
 
 err_out:
-	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
-- 
2.42.0

