Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A70801EA4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjLBVWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjLBVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:22:17 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04B125
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d048c171d6so16166815ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552140; x=1702156940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dZKi9NMCd2PNGrGsX8s5UPrOfKzB/ri42Q6YHImLKk=;
        b=elr09MWOGl290voBUBoq7u39jrDe/xO30ixZh0QZYZAORAFEjs89UMRw2WMEGRbvFa
         /98vrGb1rWz/B/I6YM2/FuEfvvidMrgNoP4f2KPMTvvENFaKwQMrorysQEYSvoY0b//W
         QpTvfB8ega9RBGbfdj4sdCZ1fQ/Pc6afycvvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552140; x=1702156940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dZKi9NMCd2PNGrGsX8s5UPrOfKzB/ri42Q6YHImLKk=;
        b=XYZthDKYfOFB0RcrpAkcyriWxylPNOY84HmlFmLyj6CLsRuiyC6R0rZbuc+6p0R5Jo
         wxhpdeniBFnzeMTXB7iVohff2JWAUecE8gVN08i31/iDWWJVRRQonx1g1lt5pJdKmkgW
         fG+/nsHBq/mP1ocdfW2laA4VgPUxDgFfkicYliws5WL52wuAEueD0I6prUFsqvpLM7tI
         ELGxZzrZBDbes14JRu1OEIqcBUbQAjlJ2Ewtp+cyrXZA0E3vCHgFnwdFeVd8X87AE/2g
         8A7esMFu2hA/CoVunlv/14P8iN8EEwQIsASMXG2UyvijgVq6WQ+8GvCcM6W84AZu4ebN
         qJIQ==
X-Gm-Message-State: AOJu0YzOqHb1tp6eiTpPA9z1WBd46INsu68+vTVVGl6MxhWZWKwjhHZE
        chZ2VTgNRSR97X0wTTx3K4vyUw==
X-Google-Smtp-Source: AGHT+IHQYZH3IlFcYH3VAbROSWfHbY4Lp+ss4pOueqIveJc3aQKHWsO1MW/WUU32lw84L7HJ6zBcSw==
X-Received: by 2002:a17:902:e844:b0:1cf:c3fb:a982 with SMTP id t4-20020a170902e84400b001cfc3fba982mr1644556plg.63.1701552139834;
        Sat, 02 Dec 2023 13:22:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b9e9edbf43sm261943plb.171.2023.12.02.13.22.18
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
Subject: [PATCH 4/5] pstore: inode: Use __free(iput) for inode allocations
Date:   Sat,  2 Dec 2023 13:22:14 -0800
Message-Id: <20231202212217.243710-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=keescook@chromium.org;
 h=from:subject; bh=LrFJJwbwaP3diV7F4yBd+rDDPSuUzm8XAAzIy+IkY44=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGPooNcpMsUpMnk7AZ7HA4049QAKPudX3SC
 5es+XxUF3uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 Jq24D/0dySbOgDPtHzuco4GLjV8/iYcSa9kl2NxlYzcrytw4fgSpsF8oNM8CLBO/GXJ5Daol0AC
 Bt8jiWEvGaGCBkZQNHWCIGJGMAtRJyDYsJZSo5rR3SBjHlROGmwejZSlN2jXViiCOqlVt5YpuWR
 eHbR+BGWN+kRXzxEcpstmju+PVhbOto4kr1BCnJiVPxQA6zonvrcinQGGOXfW4FQrX2/+F0bQLc
 53nLZwcp0uDrnn8GDTUT7qZtSGqmQeUZwEtg4evOEM00CZXSJC6DCqntTn2k7+hCKznMz5IiJtE
 hrTtOUNTs2+FivyzNehv/RqK29xEV9jqkmeo9TLdLQ7N4mTEAb+uV4yKv21mg501odxycBHoamE
 e0BCS6k6HsaMHaIDM6SrTWfFPgi6o2ns4Uf3FUsQ3/6OTUEnqH+dtWaCnqjZMmJEBMlrg0HtjmQ
 trCoUfAwQWB9c+MtiAHDLQGqn4uw4bmmTaR1tTY+raBeV5lT60xOjJxBrNpM7zQ5SLLC+FQuOEd
 zQkKLeHJij3Bufk0646mwUGtWowKcPno5w9lNbO0WEv1cVhI3EoEew402Iu8IJQwWujM/0iBI1v
 J0eRgwkEoAE8Ed/6YEelW+hrgLvz3ABThVaktG2XO7jnh2Pki7SBtdv7e/MojC5x3QYA33h3xzw or4Uvecyt9Mh/aA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify error path for failures where "inode" needs to be freed.

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 0d89e0014b6f..20a88e34ea7c 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -337,7 +337,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 {
 	struct dentry		*dentry;
-	struct inode		*inode;
+	struct inode		*inode __free(iput) = NULL;
 	int			rc = 0;
 	char			name[PSTORE_NAMELEN];
 	struct pstore_private	*private, *pos;
@@ -369,7 +369,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	private = kzalloc(sizeof(*private), GFP_KERNEL);
 	if (!private)
-		goto fail_inode;
+		return -ENOMEM;
 
 	dentry = d_alloc_name(root, name);
 	if (!dentry)
@@ -384,7 +384,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		inode_set_mtime_to_ts(inode,
 				      inode_set_ctime_to_ts(inode, record->time));
 
-	d_add(dentry, inode);
+	d_add(dentry, no_free_ptr(inode));
 
 	list_add(&private->list, &records_list);
 
@@ -392,8 +392,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 fail_private:
 	free_pstore_private(private);
-fail_inode:
-	iput(inode);
 	return rc;
 }
 
-- 
2.34.1

