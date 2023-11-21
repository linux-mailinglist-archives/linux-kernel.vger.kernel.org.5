Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E277F3A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjKUXOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjKUXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:14:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1797
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:14:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so2469001a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1700608450; x=1701213250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5G4Wz4OBw0AmK7UNuw/1S873XlbXYn1AKtv0k3We8A=;
        b=nIZF8YKPnyIysTz1y/ITBp5YZROL6AzVEq+zRJRyJgKu/p2PUG3KFBnWw3v+U2M51X
         AXT9dAnpMBvqimu8vvRhIPfUsxe8SG3DidDI8H4nUMRBWhLs1U6jj9OC7b6suneZhmSC
         ZzypXKqf0+JQr869pqINuFz175ywM3yInFABdAWWVdCz309U1Zg9ChMWGdBXPuJUMytx
         9eD+ju8/X+TY8bG/OiLXS7zd837c2djumvDij9ibCIcNYZNVLEvapxU/SE6olYIfljY2
         YIfrgHjxKgqE53nlIyJC305iK5DVgmvIrX2dD5HuV5mMllkGmxkfKJUGzStiM/DHZp8G
         fqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700608450; x=1701213250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5G4Wz4OBw0AmK7UNuw/1S873XlbXYn1AKtv0k3We8A=;
        b=vOie3MoLfTSdyGCQr3Og1qu5mfybNf71HVTiNVi2W50DU7c6rMK8awhKqhadjNiv/y
         qOwnfL5KWX2OtN+Zo/q/I7IFWaUQDwyRIEU/NEATqnz7QKaZQYvO+bKwtBshR07Wq/1i
         avzUSxT3b9aTSgs4tlKXmN7LZWcVn3Mq1J8Fo9d7SHweuDonBQy0tAu/P9PkZpV9Xq7V
         k3sEvRbhoYmaWVILv6DGIM7K42aByalHeX4x+21O2el58kUYKNqYXsqz+noOSSWiXM6K
         dGIWYnd56ew4NIExBSgIVgBMUfvNm8SnfFyOVuCKRK0cJYGSJ3M4o2DmbxVNslmiz5Ho
         RjOw==
X-Gm-Message-State: AOJu0YyWzyBq1pv+0dkqsVlqxU+3SZeKNXS1lWfFY0coqUaBARXntjZD
        i3INGWYbYA/x5oiVgG/lMWq645tW9fc+qE8AVlA3WQ==
X-Google-Smtp-Source: AGHT+IFTxSdrSlmhmXOplaI4q3oP69PNKO1lACWlHuTNtH43wOnVvJhKyCQrKOO++lnl9mfdi71BhA==
X-Received: by 2002:a05:6402:1a2e:b0:53f:9ced:e5b4 with SMTP id be14-20020a0564021a2e00b0053f9cede5b4mr572213edb.13.1700608450571;
        Tue, 21 Nov 2023 15:14:10 -0800 (PST)
Received: from ntb.lan ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id f7-20020a056402160700b00548b6175881sm2964840edv.77.2023.11.21.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 15:14:10 -0800 (PST)
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org
Cc:     mhiramat@kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
        oss@malat.biz
Subject: [PATCH 2/2] bootconfig: Apply early options from embedded config
Date:   Wed, 22 Nov 2023 00:13:42 +0100
Message-Id: <20231121231342.193646-3-oss@malat.biz>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231121231342.193646-1-oss@malat.biz>
References: <20231121231342.193646-1-oss@malat.biz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate all allocations in embedded config handling to allow calling
it from arch_setup and applying early options.

Config stored in initrd can't be used for early options, because initrd
is set up after early options are processed.

Add this information to the documentation and also to the option
description.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 Documentation/admin-guide/bootconfig.rst |   3 +
 init/Kconfig                             |   4 +-
 init/main.c                              | 141 ++++++++++++++++++-----
 lib/bootconfig.c                         |  20 +++-
 4 files changed, 132 insertions(+), 36 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 91339efdcb54..fb085f696f9b 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -161,6 +161,9 @@ Boot Kernel With a Boot Config
 There are two options to boot the kernel with bootconfig: attaching the
 bootconfig to the initrd image or embedding it in the kernel itself.
 
+Early options may be specified only in the embedded bootconfig, because
+they are processed before the initrd.
+
 Attaching a Boot Config to Initrd
 ---------------------------------
 
diff --git a/init/Kconfig b/init/Kconfig
index 9161d2dbad0c..04de756c935e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1310,7 +1310,9 @@ config BOOT_CONFIG
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
 	  The boot config file must be attached at the end of initramfs
-	  with checksum, size and magic word.
+	  with checksum, size and magic word. Note that early options may
+	  be specified in the embedded bootconfig only. Early options
+	  specified in initrd bootconfig will not be applied.
 	  See <file:Documentation/admin-guide/bootconfig.rst> for details.
 
 	  If unsure, say Y.
diff --git a/init/main.c b/init/main.c
index 0cd738f7f0cf..9aac59673a3a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -158,6 +158,9 @@ static size_t initargs_offs;
 static char *execute_command;
 static char *ramdisk_execute_command = "/init";
 
+static int __init do_early_param(char *param, char *val,
+				 const char *unused, void *arg);
+
 /*
  * Used to generate warnings if static_key manipulation functions are used
  * before jump_label_init is called.
@@ -406,63 +409,134 @@ static int __init warn_bootconfig(char *str)
 	return 0;
 }
 
-static void __init setup_boot_config(void)
+static void __init boot_config_pr_err(const char *msg, int pos, const char *src)
+{
+	if (pos < 0)
+		pr_err("Failed to init bootconfig: %s.\n", msg);
+	else
+		pr_err("Failed to parse %s bootconfig: %s at %d.\n",
+				src, msg, pos);
+}
+
+static int __init setup_boot_config_early(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
-	const char *msg, *initrd_data;
-	int pos, ret;
-	size_t initrd_size, embeded_size = 0;
-	char *err, *embeded_data = NULL;
+	static int prev_rtn __initdata;
+	struct xbc_node *root, *knode, *vnode;
+	char *embeded_data, *err;
+	const char *val, *msg;
+	size_t embeded_size;
+	int ret, pos;
 
-	/* Cut out the bootconfig data even if we have no bootconfig option */
-	initrd_data = get_boot_config_from_initrd(&initrd_size);
-	/* If there is no bootconfig in initrd, try embedded one. */
-	if (!initrd_data || IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD))
-		embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
+	if (prev_rtn)
+		return prev_rtn;
 
+	embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
 	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
 			 bootconfig_params);
-
-	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
-		return;
-
+	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE))) {
+		prev_rtn = embeded_data ? -ENOMSG : -ENODATA;
+		return prev_rtn;
+	}
 	/* parse_args() stops at the next param of '--' and returns an address */
 	if (err)
 		initargs_offs = err - tmp_cmdline;
 
-	if (!initrd_data && !embeded_data) {
-		/* If user intended to use bootconfig, show an error level message */
-		if (bootconfig_found)
-			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
-		else
-			pr_info("No bootconfig data provided, so skipping bootconfig");
-		return;
+	if (!embeded_data) {
+		prev_rtn = -ENOPROTOOPT;
+		return prev_rtn;
 	}
 
 	ret = xbc_init(embeded_data, embeded_size, &msg, &pos);
-	if (ret < 0)
-		goto err0;
+	if (ret < 0) {
+		boot_config_pr_err(msg, pos, "embedded");
+		prev_rtn = ret;
+		return prev_rtn;
+	}
+	prev_rtn = 1;
+
+	/* Process early options */
+	root = xbc_find_node("kernel");
+	if (!root)
+		goto out;
+
+	xbc_node_for_each_key_value(root, knode, val) {
+		ret = xbc_node_compose_key_after(root, knode,
+				xbc_namebuf, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			continue;
+
+		vnode = xbc_node_get_child(knode);
+		if (!vnode) {
+			do_early_param(xbc_namebuf, NULL, NULL, NULL);
+			continue;
+		}
+
+		xbc_array_for_each_value(vnode, val) {
+			if (strscpy(tmp_cmdline, val, sizeof(tmp_cmdline)) < 1) {
+				pr_err("Value for '%s' too long\n", xbc_namebuf);
+				break;
+			}
+			do_early_param(xbc_namebuf, tmp_cmdline, NULL, NULL);
+		}
+	}
+
+out:	return embeded_data ? 1 : 0;
+}
+
+static void __init setup_boot_config(void)
+{
+	const char *msg, *initrd_data;
+	int pos, ret;
+	size_t initrd_size, s;
+
+	/* Cut out the bootconfig data even if we have no bootconfig option */
+	initrd_data = get_boot_config_from_initrd(&initrd_size);
+
+	ret = setup_boot_config_early();
+	if (ret == -ENOMSG || (ret == -ENODATA && initrd_data)) {
+		pr_info("Bootconfig data present, but handling is disabled\n");
+		return;
+	} else if (ret == -ENODATA) {
+		/* Bootconfig disabled and bootconfig data are not present */
+		return;
+	} else if (ret == -ENOPROTOOPT) {
+		/* Embedded bootconfig not found */
+		if (!initrd_data) {
+			pr_err("'bootconfig' found on command line, but no bootconfig data found\n");
+			return;
+		}
+		ret = xbc_init(NULL, 0, &msg, &pos);
+		if (ret)
+			goto err0;
+	} else if (ret < 0) {
+		/* Other error, should be logged already */
+		return;
+	} else if (initrd_data && !IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD)) {
+		/* Embedded bootconfig handled, but we should not append to it */
+		xbc_get_info(&ret, &s);
+		pr_info("Replacing embedded bootconfig of %d nodes and %zu bytes.\n", ret, s);
+		xbc_exit();
+		ret = xbc_init(NULL, 0, &msg, &pos);
+		if (ret)
+			goto err0;
+	}
 
 	/* Call append even if no data are there as embedded bootconfig is in .init */
 	ret = xbc_append(initrd_data, initrd_size, &msg, &pos);
 	if (ret < 0)
 		goto err0;
 
-	xbc_get_info(&ret, NULL);
-	pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)(embeded_size + initrd_size), ret);
+	xbc_get_info(&ret, &s);
+	pr_info("Load bootconfig: %d nodes %zu bytes.\n", ret, s);
 	/* keys starting with "kernel." are passed via cmdline */
 	extra_command_line = xbc_make_cmdline("kernel");
 	/* Also, "init." keys are init arguments */
 	extra_init_args = xbc_make_cmdline("init");
 	return;
 
-err0:	if (pos < 0)
-		pr_err("Failed to init bootconfig: %s.\n", msg);
-	else
-		pr_err("Failed to parse %s bootconfig: %s at %zu.\n",
-				pos < embeded_size ? "embedded" : "initrd",
-				msg, pos < embeded_size ? pos : pos - embeded_size);
+err0:	boot_config_pr_err(msg, pos, "initrd");
 }
 
 static void __init exit_boot_config(void)
@@ -766,6 +840,11 @@ void __init parse_early_param(void)
 	if (done)
 		return;
 
+#ifdef CONFIG_BOOT_CONFIG_EMBED
+	/* Process early options from boot config */
+	setup_boot_config_early();
+#endif
+
 	/* All fall through to do_early_param. */
 	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	parse_early_options(tmp_cmdline);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 841163ce5313..4048057e3e23 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -45,7 +45,11 @@ char * __init xbc_get_embedded_bootconfig(size_t *size)
  * node (for array).
  */
 
+#ifdef CONFIG_BOOT_CONFIG_EMBED
+static struct xbc_node xbc_nodes[XBC_NODE_MAX];
+#else
 static struct xbc_node *xbc_nodes __initdata;
+#endif
 static int xbc_node_num __initdata;
 static char *xbc_data __initdata;
 static bool xbc_data_allocated __initdata;
@@ -914,8 +918,12 @@ void __init xbc_exit(void)
 	xbc_data_size = 0;
 	xbc_data_allocated = 0;
 	xbc_node_num = 0;
+#ifdef CONFIG_BOOT_CONFIG_EMBED
+	memset(xbc_nodes, 0, sizeof(xbc_nodes));
+#else
 	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
+#endif
 	brace_index = 0;
 }
 
@@ -973,6 +981,7 @@ int __init xbc_init(char *data, size_t size, const char **emsg, int *epos)
 		return -ERANGE;
 	}
 
+#ifndef CONFIG_BOOT_CONFIG_EMBED
 	xbc_nodes = xbc_alloc_mem(sizeof(struct xbc_node) * XBC_NODE_MAX);
 	if (!xbc_nodes) {
 		if (emsg)
@@ -980,7 +989,7 @@ int __init xbc_init(char *data, size_t size, const char **emsg, int *epos)
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
-
+#endif
 	if (!data)
 		return 0;
 	xbc_data = data;
@@ -999,6 +1008,7 @@ int __init xbc_append(const char *data, size_t size, const char **emsg, int *epo
 {
 	size_t new_size, parse_start;
 	char *new_data;
+	int ret;
 
 	new_size = xbc_data_size + size;
 	if (new_size > XBC_DATA_MAX) {
@@ -1024,8 +1034,8 @@ int __init xbc_append(const char *data, size_t size, const char **emsg, int *epo
 
 	if (xbc_data_size) {
 		memcpy(new_data, xbc_data, xbc_data_size - 1);
-		new_data[xbc_data_size - 1] = '\n';
 		parse_start = xbc_data_size - 1;
+		new_data[parse_start] = '\n';
 	} else {
 		parse_start = 0;
 	}
@@ -1039,6 +1049,8 @@ int __init xbc_append(const char *data, size_t size, const char **emsg, int *epo
 
 	if (!data)
 		return 0;
-
-	return xbc_parse_and_verify_tree(parse_start, epos, emsg);
+	ret = xbc_parse_and_verify_tree(parse_start, epos, emsg);
+	if (ret && epos)
+		*epos -= parse_start;
+	return ret;
 }
-- 
2.30.2

