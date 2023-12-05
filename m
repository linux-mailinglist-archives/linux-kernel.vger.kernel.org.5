Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D094805DD2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbjLES0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbjLES0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:26:19 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C0137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:26:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce2ff70619so1890830b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701800785; x=1702405585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuxQ4uEqTh0xr8Jo9gHGOWhQKXUz5PFS1McwFiwms38=;
        b=kYMGpcR6NvWhsyLGXapA1Mxh+WEP5QkZQadGQ9ENlXW0jpWUrqG7i0u4NxkvNP3VfT
         z8AI2k1ILCkB3Ttcc0QiaMEhHEgnuwfUeJMF64ls5D992zkPbP+w3/a1LZY6zHJ/VPMG
         PrV0/hs+Jk6obHWe/oHBewcucrmM3fQObsjRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800785; x=1702405585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuxQ4uEqTh0xr8Jo9gHGOWhQKXUz5PFS1McwFiwms38=;
        b=lHulIHDhvWolj5PQbFj9jaRcQ7qRvGW7xq2f7zAVQeYqPmMcJXUVinGekedTZxhQ3s
         M9/7rMGDyky0dhFRujJdWNJBcYj0sj5AWeQ8kijlwFXP+NCEMeZwHRP7agK2ljccPcBz
         5VmPGtvj8tBkhxWfZ8f9UGO7XRVPqsEQHdzU1zccaR2rSa/Md8l31YQshIn2zWWq0NZr
         wkyJ6kLV7w+eaw7jNGcnI9QWRvHrefIQrUpcV4SS1YzPfm/e0HKCutZhMebFCYQfA/+6
         biSNjYqmQ3J+ztZUqYLpFhKMYoN45Mi4wa/pW8pEFduF3fPpigs2k95a1f6qjN6fQJdE
         CDWw==
X-Gm-Message-State: AOJu0YwaWO1b/seW3hgk38KWzFllSghKHKF3nqYDB/y1uLFpTFiKL2F1
        8PYQI8dTOiRsEyQFGlB8HHhiCg==
X-Google-Smtp-Source: AGHT+IGmxDHh2M3VVTF5lhwx2Q/UaSFsZ5L0bYmNdOy0AoKESrPPnSc+UEc5cYrQDTdFxPljL770+g==
X-Received: by 2002:a05:6a20:c18b:b0:18b:251d:d6fb with SMTP id bg11-20020a056a20c18b00b0018b251dd6fbmr4756254pzb.1.1701800785254;
        Tue, 05 Dec 2023 10:26:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o8-20020a056a001b4800b006ce61c9495bsm2857795pfv.10.2023.12.05.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:26:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] pstore: inode: Use cleanup.h for struct pstore_private
Date:   Tue,  5 Dec 2023 10:26:17 -0800
Message-Id: <20231205182622.1329923-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205175449.work.110-kees@kernel.org>
References: <20231205175449.work.110-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=keescook@chromium.org;
 h=from:subject; bh=qpvwINQCBBhSlr2YiFBK7IVLldJIfzDFIzXihlbwuNo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlb2tJ0NO5bX9t437Te4BZBA88PaTXhLUdX8dYv
 bPubelLTBqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZW9rSQAKCRCJcvTf3G3A
 Jge5D/9zVFV3uQy+F+nnWJbw8ItnBnX+gIAOgrDiVi/bCgLfIrXvONEkARgQuNpwpm4niCP7p7W
 KfzyCu/itdtokNnIdASfrJN8sFz7Ht1ILJIKu3ramlpWqTNrPVfoExjsE6d5hWXxBGEcx2WHaER
 kd1nUPtutrm2suz62fxtYMdC/igGGNh2+zKDeVg0ruBBOav/O+t3KXFrSsCrdk6KjdM6rZnauuC
 dvzWxDNIgnEUs2aMC82l1dsyTWJDudgR8SEhoeM5ydW2vh7umO0+S708rpSveW1lK/AZNPhuy6T
 PSXGWAqu66RbBAVs4pwJNAyZNEDU8RgXp370jAjUtx2xmF8okZUHfGpx2a2U2+eYcGA4skT9Yn/
 c7poD9On2cU4O5J5WdOKLJrNWx/ryDub/kqHhlFQVKvoEKMG6kFteq08Y5L4CnOWAU0DlZiufu8
 rGtC0auMBum0JhHh+qXZ/8XkNQNnStjXfTlMXvyTLZ2trQtn8ralN4T/Phh4TGne2jrWX53KBOF
 9gNp8cNByu13rBiav9Jg4/D9ZkCFBeOrnGXmi97pYg6gsz6HuUgCjgOnzaopoI2RIgZ0VnCnnry
 UH9qCnW+319MQJmQdOW6q/h9svQwPlytdJ3WF948zHbqAjDvtU6wrL9HEDniL+aw3LyAARYTzQt EoIvaWUvLLV5dgg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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

Simplify error path when "private" needs to be freed.

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index a27764341079..d0d9bfdad30c 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -63,6 +63,7 @@ static void free_pstore_private(struct pstore_private *private)
 	}
 	kfree(private);
 }
+DEFINE_FREE(pstore_private, struct pstore_private *, free_pstore_private(_T));
 
 static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 {
@@ -340,9 +341,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 {
 	struct dentry		*dentry;
 	struct inode		*inode __free(pstore_iput) = NULL;
-	int			rc = 0;
 	char			name[PSTORE_NAMELEN];
-	struct pstore_private	*private, *pos;
+	struct pstore_private	*private __free(pstore_private) = NULL, *pos;
 	size_t			size = record->size + record->ecc_notice_size;
 
 	if (WARN_ON(!inode_is_locked(d_inode(root))))
@@ -358,7 +358,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 			return -EEXIST;
 	}
 
-	rc = -ENOMEM;
 	inode = pstore_get_inode(root->d_sb);
 	if (!inode)
 		return -ENOMEM;
@@ -375,7 +374,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	dentry = d_alloc_name(root, name);
 	if (!dentry)
-		goto fail_private;
+		return -ENOMEM;
 
 	private->dentry = dentry;
 	private->record = record;
@@ -388,13 +387,9 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	d_add(dentry, no_free_ptr(inode));
 
-	list_add(&private->list, &records_list);
+	list_add(&(no_free_ptr(private))->list, &records_list);
 
 	return 0;
-
-fail_private:
-	free_pstore_private(private);
-	return rc;
 }
 
 /*
-- 
2.34.1

