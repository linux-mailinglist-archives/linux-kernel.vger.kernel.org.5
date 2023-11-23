Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECD17F5BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjKWKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjKWKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:07:17 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130AA1A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:07:19 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 57D921869539;
        Thu, 23 Nov 2023 13:07:15 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RbGep-jMkJqD; Thu, 23 Nov 2023 13:07:15 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 0F1A71869262;
        Thu, 23 Nov 2023 13:07:15 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d6HvdqWtd_uB; Thu, 23 Nov 2023 13:07:14 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.12.19])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 6D1E91869539;
        Thu, 23 Nov 2023 13:07:14 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Anders Larsen <al@alarsen.net>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] qnx4: add upcasting to avoid overflow
Date:   Thu, 23 Nov 2023 13:06:27 +0300
Message-Id: <20231123100627.20739-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid possible integer overflow in qnx4_statfs
cast literal to unsigned long. Otherwise multiplication
of two u32 may give a value that is outside of the range.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/qnx4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 6eb9bb369b57..4be8dba60567 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -133,7 +133,7 @@ static int qnx4_statfs(struct dentry *dentry, struct =
kstatfs *buf)
=20
 	buf->f_type    =3D sb->s_magic;
 	buf->f_bsize   =3D sb->s_blocksize;
-	buf->f_blocks  =3D le32_to_cpu(qnx4_sb(sb)->BitMap->di_size) * 8;
+	buf->f_blocks  =3D le32_to_cpu(qnx4_sb(sb)->BitMap->di_size) * 8ul;
 	buf->f_bfree   =3D qnx4_count_free_blocks(sb);
 	buf->f_bavail  =3D buf->f_bfree;
 	buf->f_namelen =3D QNX4_NAME_MAX;
--=20
2.30.2

