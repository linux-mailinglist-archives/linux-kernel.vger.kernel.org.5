Return-Path: <linux-kernel+bounces-114879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F408891F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FF9292BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83013D884;
	Mon, 25 Mar 2024 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoGN31up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1330178211;
	Sun, 24 Mar 2024 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323531; cv=none; b=TabGGEkWFlSSJ8w/xeYwm0YIueQxy3LrF3nNDR+CVD6WjG2aPWfJZMcKYW98tlq2UsC3Y9riSPsHrCICtwMWmuPD2tQu4Mk/Su4vbnWXhImKIs3t/VDi7/8QrDJo1XlrIfFytnvD25lcr/JIowjLNQcBtZ/LD9OWVPL37UPtOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323531; c=relaxed/simple;
	bh=ekz+yDMcr1veQyBZhE80r6z8Gn2VEWhWBGbG/gtC1ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4Ti6A8sPXlUnvmPl90hSuzc/3q508IUr/OKQf8LTtv2b4mKbgdMxRE8crTniHMOP7Fy30xMpYCuUykEGDyr43abGhato9+jbwM2BMYM2LjN1M7jDmpWge4p+VFCxf2Y45IEkFclFxsRz0XlHIWryK70I1ZO8h/xM8Q0xOd3Y1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoGN31up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07367C433C7;
	Sun, 24 Mar 2024 23:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323530;
	bh=ekz+yDMcr1veQyBZhE80r6z8Gn2VEWhWBGbG/gtC1ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qoGN31upPX+owZkZ9tK9OeH3RfiyMhoFa4Wwo5goBEVpxDEXkAdMfTmUv4cdU0lnu
	 uMrGN3MEMEsfE0HfNdjDeGfQ15acAIiLJb0uFQ71opwhjLSYBf0q8r1wecZt07Vloo
	 9CKd1ytmdQHg7wrpbSKu9pOksx2spEFLCV92hcVpO0cB3RvSFoZGvu5j2QHtsdrl7K
	 VaObvwT84+T+irAKx6mqZgqeZYP8TpiSaRFPpvqRNATJFMtF5kLP7aWnmkZdkJPzPF
	 cMPhoEUdSXEV+FoZVjE9Xq8YjAaGFkfXHtJkq1ifgZVjwiRJMlnQnpjYWNtR9OWbOc
	 /R6qRQVYKAZqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>,
	Aaron Tomlin <atomlin@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 238/317] module: Add support for default value for module async_probe
Date: Sun, 24 Mar 2024 19:33:38 -0400
Message-ID: <20240324233458.1352854-239-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit ae39e9ed964f8e450d0de410b5a757e19581dfc5 ]

Add a module.async_probe kernel command line option that allows enabling
async probing for all modules. When this command line option is used,
there might still be some modules for which we want to explicitly force
synchronous probing, so extend <modulename>.async_probe to take an
optional bool input so that async probing can be disabled for a specific
module.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Aaron Tomlin <atomlin@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Stable-dep-of: 8f8cd6c0a43e ("modules: wait do_free_init correctly")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++--
 kernel/module.c                                 | 11 ++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 34b093e7f8910..c4c7273419bda 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1084,8 +1084,12 @@
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
 
-	<module>.async_probe [KNL]
-			Enable asynchronous probe on this module.
+	<module>.async_probe[=<bool>] [KNL]
+			If no <bool> value is specified or if the value
+			specified is not a valid <bool>, enable asynchronous
+			probe on this module.  Otherwise, enable/disable
+			asynchronous probe on this module as indicated by the
+			<bool> value. See also: module.async_probe
 
 	early_ioremap_debug [KNL]
 			Enable debug messages in early_ioremap support. This
@@ -3137,6 +3141,15 @@
 			For details see:
 			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
 
+	module.async_probe=<bool>
+			[KNL] When set to true, modules will use async probing
+			by default. To enable/disable async probing for a
+			specific module, use the module specific control that
+			is documented under <module>.async_probe. When both
+			module.async_probe and <module>.async_probe are
+			specified, <module>.async_probe takes precedence for
+			the specific module.
+
 	module.sig_enforce
 			[KNL] When CONFIG_MODULE_SIG is set, this means that
 			modules without (valid) signatures will fail to load.
diff --git a/kernel/module.c b/kernel/module.c
index ba9f2bb57889c..d8d677f01adb5 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3713,6 +3713,12 @@ static void do_free_init(struct work_struct *w)
 	}
 }
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "module."
+/* Default value for module->async_probe_requested */
+static bool async_probe;
+module_param(async_probe, bool, 0644);
+
 /*
  * This is where the real work happens.
  *
@@ -3943,7 +3949,8 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 	int ret;
 
 	if (strcmp(param, "async_probe") == 0) {
-		mod->async_probe_requested = true;
+		if (strtobool(val, &mod->async_probe_requested))
+			mod->async_probe_requested = true;
 		return 0;
 	}
 
@@ -4110,6 +4117,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto bug_cleanup;
 
+	mod->async_probe_requested = async_probe;
+
 	/* Module is ready to execute: parsing args may do that. */
 	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
 				  -32768, 32767, mod,
-- 
2.43.0


