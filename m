Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B55803F78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbjLDUd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjLDUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:33:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DB194
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:33:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755A3C433CA;
        Mon,  4 Dec 2023 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722021;
        bh=X1klMmWdf1dNqRM/ewLPdf27HcjpBybRBVQtAuh6UXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZejgbE4vcAkhEmZFqS5njVCbKsQMPqwGjtuzaBIWlI+aQg6Hs3oogpdJ49yvKPs/
         lcRKUmSD3QVJX/SHedpUIPTGZ1/b3eijLdeIqda0ME2BAXS9bJHBKA3pU8jmCnPZ26
         PRqUuJT4CIXY0tLUqsr2nstqC1iB7a2/IQQExhK/UADrPJIsbCpFnCBx8iLo99QapH
         cGSLz50wViDcs8uSI040hs4oCd8c9mhDqVWFUSl6A2uSg/PGbfuup3LyvqtbiDVSTZ
         ob+wHUQd+nY8SGtjgvYDgXFWlrzCFu+JR6RilhSEmdigu0mHntp64ctU4MoMw2aqWQ
         ITGvYqQ0jO1+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/32] ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
Date:   Mon,  4 Dec 2023 15:32:29 -0500
Message-ID: <20231204203317.2092321-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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
index 7eaac1098f637..78517e3b53104 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8228,7 +8228,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 		return;
 
 err_out:
-	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
-- 
2.42.0

