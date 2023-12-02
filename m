Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD419801EA6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjLBVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjLBVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:22:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A99188
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce3534bf44so341503b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552143; x=1702156943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2E08Wp0PAEeNbIbiRL8xBMi7hvEIIZj0Of8hDuuB3w=;
        b=e3jNmR613paODAYSh88L9xEM1dImp1Y1d4fMXxu7hLE96OH4/DxiuFv5TFirICroY0
         9IEtMZEoSQvevDOT1SxS0njT9bMRpIYNJczQL34VJUKG7O+VnAIYKEFcWC5l5n/tDAt0
         1I4i22JWnCJ+Uq/U9Czv8sTDNmpFIJ9m9OGoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552143; x=1702156943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2E08Wp0PAEeNbIbiRL8xBMi7hvEIIZj0Of8hDuuB3w=;
        b=BsiG7kG7q8mbJAAGWvxz5JChyngs+BpQEp2pntt5hivhGy2Yy/GF/Gxok5PTyS6frG
         SwbeLE0MsEv28AubqEkeiBwh5eTWK3K9Tk7+3bG+cYokxjJGM1X6qH7mwq/NrxTJnmV9
         1ek3fjtj2MMeMJ56ukjgl3mgMtZ+/fYFXtJuFf01Sbb4KUFnRXluOHFGTMLWMyWScf53
         zcF55GRbSkJ8f/lJWVluFXxNDcVtu+4Q4ppWBEgm2JkKgmy1PbiLAwJn2RsX2SHdUd1m
         FUgjvgBGCP2X62JAjxJtBkNODyIcWIvScCSghxJe54xq4j4/liD37Oj/x0/fJ71sR3t4
         c5ww==
X-Gm-Message-State: AOJu0Ywa49widsY+7JnuDbdBLyUy9f+5wH/065ey8kwLPJfLj6Z1xjg4
        3aP7wAe4dnWadaRPBXK2uyi1HQ==
X-Google-Smtp-Source: AGHT+IEWeGIVqNPJWbRT9NWl7jrkJIsQKREylxAfpFjmc/wXrAXG7QNSQDRnz8gq/R7XqyavdXpj+Q==
X-Received: by 2002:a05:6a20:8427:b0:18a:e4ed:cc41 with SMTP id c39-20020a056a20842700b0018ae4edcc41mr2235604pzd.23.1701552143416;
        Sat, 02 Dec 2023 13:22:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00219200b006cdd82337bcsm398007pfi.207.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] pstore: inode: Convert mutex usage to guard(mutex)
Date:   Sat,  2 Dec 2023 13:22:12 -0800
Message-Id: <20231202212217.243710-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4977; i=keescook@chromium.org;
 h=from:subject; bh=I6QANnpHLWcA4i3gT5wmHz8vdSJtJ/8W9NRntgr7o9Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGe1kl5grDFz02MlwEMZbNkkvJk+E/REGw8
 MmUW++dTRaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 JnVZD/0UHs7QQfhB4ny79i1LX6AIB3t/4fS9e8+i2EAXHtqKM/YB5Q/5MNIUITrQoyUbCa0qP6Z
 VKlNoZ/6xCOgH8io2/ZSdrrJ2NpdxAaf5+F4NjBdgTBwZr77g1gzTf2/JdDVcCK9WGk/3Nu8NW8
 vEd16nBhaCwVS3t6PhXUgZQNJ/03uiXrSrcVrv6tiLZ5SR722H9vozHpZay7NyLQS4W+obF3i7H
 xMmN5s8bZVPDrfY0lhPdVrlP5ECSYWdS4ZpfRGf2TzWzOFehtrsIJ9t+SYHxxVqtMMsJl6wobW5
 RRQKp0uvQbN1/5U6JmTIiOpthVu8tWgnBgVVG7O3JLsDo8AyFFfqCTZYIUB0k4HAO9wff0kmA1P
 KOuPovXn43Wl0jimp/DlMzDSUOmj6a9B2PwoWD8ILBmLB2VTky/Lc0AFlqTE2ggkpdhm2vFtGfB
 GSc8k285KXlWH2rJkCP+R9m6mbnWk8imsHwdrJ6EEhbI/pGs+7QDqTg/5SXEcYNyWHIsbX+QWJS
 0Pwm0uUDlv5M3Qe82I7evHxp7ApQb9xzv69YXLfcKD6JQJFO21yMBZFoIJdtBeS1LZkeuJuobZa
 L0FF1MDhDNL8HlysbWdEFBIfpKoW5rjPXAA9ISnU03BWvMbcQjlu7gadJaOvb4eBfRpa4p/Xm7y LKT/rW6jE9s3J9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open-coded mutex handling with cleanup.h guard(mutex) and
scoped_guard(mutex, ...).

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 76 +++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 45 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 20f3452c8196..0d89e0014b6f 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -180,25 +180,21 @@ static int pstore_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct pstore_private *p = d_inode(dentry)->i_private;
 	struct pstore_record *record = p->record;
-	int rc = 0;
 
 	if (!record->psi->erase)
 		return -EPERM;
 
 	/* Make sure we can't race while removing this file. */
-	mutex_lock(&records_list_lock);
-	if (!list_empty(&p->list))
-		list_del_init(&p->list);
-	else
-		rc = -ENOENT;
-	p->dentry = NULL;
-	mutex_unlock(&records_list_lock);
-	if (rc)
-		return rc;
-
-	mutex_lock(&record->psi->read_mutex);
-	record->psi->erase(record);
-	mutex_unlock(&record->psi->read_mutex);
+	scoped_guard(mutex, &records_list_lock) {
+		if (!list_empty(&p->list))
+			list_del_init(&p->list);
+		else
+			return -ENOENT;
+		p->dentry = NULL;
+	}
+
+	scoped_guard(mutex, &record->psi->read_mutex)
+		record->psi->erase(record);
 
 	return simple_unlink(dir, dentry);
 }
@@ -290,19 +286,16 @@ static struct dentry *psinfo_lock_root(void)
 {
 	struct dentry *root;
 
-	mutex_lock(&pstore_sb_lock);
+	guard(mutex)(&pstore_sb_lock);
 	/*
 	 * Having no backend is fine -- no records appear.
 	 * Not being mounted is fine -- nothing to do.
 	 */
-	if (!psinfo || !pstore_sb) {
-		mutex_unlock(&pstore_sb_lock);
+	if (!psinfo || !pstore_sb)
 		return NULL;
-	}
 
 	root = pstore_sb->s_root;
 	inode_lock(d_inode(root));
-	mutex_unlock(&pstore_sb_lock);
 
 	return root;
 }
@@ -317,19 +310,19 @@ int pstore_put_backend_records(struct pstore_info *psi)
 	if (!root)
 		return 0;
 
-	mutex_lock(&records_list_lock);
-	list_for_each_entry_safe(pos, tmp, &records_list, list) {
-		if (pos->record->psi == psi) {
-			list_del_init(&pos->list);
-			rc = simple_unlink(d_inode(root), pos->dentry);
-			if (WARN_ON(rc))
-				break;
-			d_drop(pos->dentry);
-			dput(pos->dentry);
-			pos->dentry = NULL;
+	scoped_guard(mutex, &records_list_lock) {
+		list_for_each_entry_safe(pos, tmp, &records_list, list) {
+			if (pos->record->psi == psi) {
+				list_del_init(&pos->list);
+				rc = simple_unlink(d_inode(root), pos->dentry);
+				if (WARN_ON(rc))
+					break;
+				d_drop(pos->dentry);
+				dput(pos->dentry);
+				pos->dentry = NULL;
+			}
 		}
 	}
-	mutex_unlock(&records_list_lock);
 
 	inode_unlock(d_inode(root));
 
@@ -353,20 +346,20 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	if (WARN_ON(!inode_is_locked(d_inode(root))))
 		return -EINVAL;
 
-	rc = -EEXIST;
+	guard(mutex)(&records_list_lock);
+
 	/* Skip records that are already present in the filesystem. */
-	mutex_lock(&records_list_lock);
 	list_for_each_entry(pos, &records_list, list) {
 		if (pos->record->type == record->type &&
 		    pos->record->id == record->id &&
 		    pos->record->psi == record->psi)
-			goto fail;
+			return -EEXIST;
 	}
 
 	rc = -ENOMEM;
 	inode = pstore_get_inode(root->d_sb);
 	if (!inode)
-		goto fail;
+		return -ENOMEM;
 	inode->i_mode = S_IFREG | 0444;
 	inode->i_fop = &pstore_file_operations;
 	scnprintf(name, sizeof(name), "%s-%s-%llu%s",
@@ -394,7 +387,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	d_add(dentry, inode);
 
 	list_add(&private->list, &records_list);
-	mutex_unlock(&records_list_lock);
 
 	return 0;
 
@@ -402,8 +394,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	free_pstore_private(private);
 fail_inode:
 	iput(inode);
-fail:
-	mutex_unlock(&records_list_lock);
 	return rc;
 }
 
@@ -449,9 +439,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		return -ENOMEM;
 
-	mutex_lock(&pstore_sb_lock);
-	pstore_sb = sb;
-	mutex_unlock(&pstore_sb_lock);
+	scoped_guard(mutex, &pstore_sb_lock)
+		pstore_sb = sb;
 
 	pstore_get_records(0);
 
@@ -466,17 +455,14 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 
 static void pstore_kill_sb(struct super_block *sb)
 {
-	mutex_lock(&pstore_sb_lock);
+	guard(mutex)(&pstore_sb_lock);
 	WARN_ON(pstore_sb && pstore_sb != sb);
 
 	kill_litter_super(sb);
 	pstore_sb = NULL;
 
-	mutex_lock(&records_list_lock);
+	guard(mutex)(&records_list_lock);
 	INIT_LIST_HEAD(&records_list);
-	mutex_unlock(&records_list_lock);
-
-	mutex_unlock(&pstore_sb_lock);
 }
 
 static struct file_system_type pstore_fs_type = {
-- 
2.34.1

