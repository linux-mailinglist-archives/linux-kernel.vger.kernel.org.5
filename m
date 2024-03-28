Return-Path: <linux-kernel+bounces-100140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A50879267
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B3C1C217C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9077655;
	Tue, 12 Mar 2024 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EV5ikQYR"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FB7829C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240488; cv=none; b=Vjqkf3VLZ/UdeonAVVoHWvDRgk8EX3CXHJlL2ROoMdYK9jiPhDJUTO04SaUC98zy0r9cDiFKHasqnBD0h8HodoeFQRpLrLA7OqQvU8Y0vC0wxIpCgBVJT9KXIkHSRFCGHAfFBoL8gWNT21NBWW1EC/iGof1WOQMWUY4+r+N3WgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240488; c=relaxed/simple;
	bh=dcVyGoqqSlaWVI7Li40ed8FGrya0uubWHggdOxoRbuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mk/g/DQgLTNx7cOPJuiB+UXM6G6mqdxqrqJzsLcM9N9wM8OZtMYVu5In2QprjSzWPqIEK1xZ1vt3kaJyoZitCjeGA0aadhhApZb9zAHtwdMlKcwrXos/sjLKywGyuGmyejcTTW+ZqgPZhtOLVpEndqvtP1lnqO/Ya8jujweINDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EV5ikQYR; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710240482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UbrlcU0EbD+LwFEqoMDJGLaOY8fY9hhUZwUFeO9+S4k=;
	b=EV5ikQYRM9TRKP5nYt6zSLLy6G5Qf6UjNRx/LKktZBXxyMtOKSPyPBnwYw5g5Y3i1MrK5M
	SZulHP/40OpAYvRnBTbJ/2hy7F3jxILwB7/8OrsT/k5+ivmkkRok0/mMbJBJloLcTaOAEo
	38+8uVhaDllZSSkEo9E3pWXbjDGvyPc=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] fs_parser: move fsparam_string_empty() helper into header
Date: Tue, 12 Mar 2024 10:47:57 +0000
Message-ID: <20240312104757.27333-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since both ext4 and overlayfs define the same macro to specify string
parameters that may allow empty values, define it in an header file so
that this helper can be shared.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/super.c           | 4 ----
 fs/overlayfs/params.c     | 4 ----
 include/linux/fs_parser.h | 4 ++++
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a8ba84eabab2..2e5592c87c3a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1724,10 +1724,6 @@ static const struct constant_table ext4_param_dax[] = {
 	{}
 };
 
-/* String parameter that allows empty argument */
-#define fsparam_string_empty(NAME, OPT) \
-	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
-
 /*
  * Mount option specification
  * We don't use fsparam_flag_no because of the way we set the
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 36dcc530ac28..4860fcc4611b 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -139,10 +139,6 @@ static int ovl_verity_mode_def(void)
 	return OVL_VERITY_OFF;
 }
 
-#define fsparam_string_empty(NAME, OPT) \
-	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
-
-
 const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_string_empty("lowerdir",    Opt_lowerdir),
 	fsparam_string("lowerdir+",         Opt_lowerdir_add),
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 01542c4b87a2..d3350979115f 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -132,4 +132,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
 
+/* String parameter that allows empty argument */
+#define fsparam_string_empty(NAME, OPT) \
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
+
 #endif /* _LINUX_FS_PARSER_H */

