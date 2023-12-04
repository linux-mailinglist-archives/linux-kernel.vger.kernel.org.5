Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41E580402A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbjLDUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjLDUjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:39:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24B26AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:36:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D83C433C8;
        Mon,  4 Dec 2023 20:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722191;
        bh=zIzcYR5Mkvl5xoOlH8kEYRVtlAu/iWuw8oSqyn+ZjTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJJUlJpN/LSBZvNROkajMnyHbk7xwEQV7IY7p0U2LM4U9rieB4kvbRytAtbOuL3fR
         g/sItpeA+Lu18DnMl8ZcTH60VgVK1rHYW9jR29MMLXlhYikJcLVoDpdZOjbVoaTA1r
         6Y9GNpu4aB9jsJxW+bTGKTuoMitVIW2S2JKhzl9TsWBHySkNX0nyJghdwkVZwml4Vj
         wS8tuQOF1HcRWXzoYUL4jtkn6zb0oqTU+45FU4HslL+yh9k72S0GzkQzBIDKbU2h6M
         o6zhkGSOnzauCkMqD9rw31IhlgfiktEqwaRl6miTzwl5u2krFprKaXZmY7M399oRrK
         kdTV9kVCjhgYw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, brauner@kernel.org,
        dchinner@redhat.com, senozhatsky@chromium.org, ddiss@suse.de,
        mmakassikis@freebox.fr, jlayton@kernel.org
Subject: [PATCH AUTOSEL 5.15 03/10] ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error
Date:   Mon,  4 Dec 2023 15:36:00 -0500
Message-ID: <20231204203616.2094529-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203616.2094529-1-sashal@kernel.org>
References: <20231204203616.2094529-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.141
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
 fs/ksmbd/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 656c627d1bdf7..b876572c74a25 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -8222,7 +8222,6 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	return;
 
 err_out:
-	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
-- 
2.42.0

