Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED519772C33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjHGRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHGRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:58 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071821A3;
        Mon,  7 Aug 2023 10:11:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso6588859a12.3;
        Mon, 07 Aug 2023 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691428315; x=1692033115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n++x1VyupiNA1jLZvucgYL91izWJdNor+dndheNguCo=;
        b=W9Rx6EozIRNL2uZal/Q25+X+xyX9WQ88IheKymL4vdDvOWHBLHyCkkkDKq/+5tZXh1
         fY24hvgjUggAzq1XcWKgw3U97gJMnxgmWA9mIU6hGlu0RP+QDyeB2S7ZjDA8p4PVg4Ab
         PZYvBukK2p5Qqfio/Wj1oiS1+moack1GwTjQ2liT8a2ygSlFANPEZxxGKPyeJIxfDrnT
         YC83t9RRrUoIBe+BBLSZExpmufDAw/So2rEVMkpHNEnBjqGTnAtheiYwRQHZBtZysBK1
         3L8EbDc8YyJfLVKPmUctI0TEDv/k8AwEBxmUcTuBTZe/C74vQ5hq7DznahUfvRUYxmbP
         i8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428315; x=1692033115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n++x1VyupiNA1jLZvucgYL91izWJdNor+dndheNguCo=;
        b=D5Y9jquOp0qYqJlom1ZzqQvcLZfJBd3nhRWF0y5XzdMX2MsHVWiFaKbgn4NoQmxe4p
         N1xZvv178Hr+bBzbFSdoYnyQWYo5pB0spqth2ZWoo4BiWsen+tw6qdzXL+532ndiN5E8
         JO3KuAbgCOt5yNk+XwF6Z1U9ftzeCqKcPcsj5opENpK40eZaQ3AosiCf9IOLRWIRT6Nk
         16D31IzCUU0Qs8CzL4bdgHPytI+VRvlMw67/tajTCletahGRuxOGqco/+tyHYHMbOBD1
         LaxE/FNn61Y6TpGf1xXKZFoFAs5r69ZMhwkM9oyfzNo90JyxjlmaMQ/p2GojwHzoHv7K
         RKvg==
X-Gm-Message-State: AOJu0YwDBgceInAhiFjABBcskjil11S/SrO2/fwro74zHqOpZ5aSH2+V
        Q/M8g/iaJOTMnvYEtXMkkBjl5JH7F69t2Q==
X-Google-Smtp-Source: AGHT+IHUdCLdza+YiraPasZnGbIcTqMVGNbrozQCAkRkbk+2XE5/9GN/9Yb7c6tXyG0rgvi13FHn2g==
X-Received: by 2002:aa7:da96:0:b0:523:38eb:395f with SMTP id q22-20020aa7da96000000b0052338eb395fmr2338743eds.2.1691428315338;
        Mon, 07 Aug 2023 10:11:55 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b005224d960e66sm5420814edv.96.2023.08.07.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] selinux: avoid implicit conversions in selinuxfs code
Date:   Mon,  7 Aug 2023 19:11:39 +0200
Message-Id: <20230807171143.208481-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807171143.208481-1-cgzones@googlemail.com>
References: <20230807171143.208481-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use umode_t as parameter type for sel_make_inode(), which assigns the
value to the member i_mode of struct inode.

Use identical and unsigned types for loop iterators.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - drop leftover declaration in init-clauses of for loops
  - use unsigned int instead of u32 for loop iterator with loop bounds
    known at compile time to be small (<100)
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/selinuxfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b969e87fd870..107b028d5e40 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -97,7 +97,7 @@ static int selinux_fs_info_create(struct super_block *sb)
 static void selinux_fs_info_free(struct super_block *sb)
 {
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
+	unsigned int i;
 
 	if (fsi) {
 		for (i = 0; i < fsi->bool_num; i++)
@@ -1075,8 +1075,8 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	u32 sid, *sids = NULL;
 	ssize_t length;
 	char *newcon;
-	int i, rc;
-	u32 len, nsids;
+	int rc;
+	u32 i, len, nsids;
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
@@ -1192,7 +1192,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	return length;
 }
 
-static struct inode *sel_make_inode(struct super_block *sb, int mode)
+static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *ret = new_inode(sb);
 
@@ -1613,7 +1613,7 @@ static int sel_make_avc_files(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
+	unsigned int i;
 	static const struct tree_descr files[] = {
 		{ "cache_threshold",
 		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
@@ -1649,7 +1649,7 @@ static int sel_make_ss_files(struct dentry *dir)
 {
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
-	int i;
+	unsigned int i;
 	static const struct tree_descr files[] = {
 		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
 	};
@@ -1700,7 +1700,7 @@ static const struct file_operations sel_initcon_ops = {
 
 static int sel_make_initcon_files(struct dentry *dir)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 1; i <= SECINITSID_NUM; i++) {
 		struct inode *inode;
-- 
2.40.1

