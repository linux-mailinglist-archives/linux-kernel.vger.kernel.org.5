Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC58753952
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjGNLOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGNLOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:14:36 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA1626AE;
        Fri, 14 Jul 2023 04:14:34 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so17451685e9.1;
        Fri, 14 Jul 2023 04:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689333273; x=1691925273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ka9amKpo1CCxEHUIhHtGYAE4Tvgc7QiGZQoTsn95Ms8=;
        b=J8RTQIi42flq/BuJbnkc5dF9B/tmxjCjU2d/ur5E17e2E55/Dw7/zmAZw4CKZHjmsJ
         0peDvlM66FThrjbv9SdqW6aMf0OJGhchRdNQc/UQYmScp7FVb3o8r2Uyhnc9iYTU6ERU
         9y/fork9Y6sEouj6MaoYHpid5dIkNcfuZqN0RfadvNexBPEY5nqWfIz7yijklRpu2zRY
         biWDfnbMlcujfGG4JpDfyQLkm0c595ZE6HeGtDG3HXcMx7TAhPOS4QJTCkOwRdJEmK7o
         ZZ8j2doHmvKi/ne4MW52F56FTfY/ZJ1CZDOzCtxUBuGAkf8FhPk44h8XX+i61r+LX2g4
         jBNw==
X-Gm-Message-State: ABy/qLY5UoC0b2XwLLX6gy/rQ+2s1vUrID0kllLe+D912xwpIQD6ZiJE
        MosrsFt0vstwhUZ2JYtztTo=
X-Google-Smtp-Source: APBJJlHFDFUTYl5i3lcE0ReA3pP/WgSjIrl97snzNpFAEYsdN4uRpVr56VBh/MshrCYdHI/KWxq3rg==
X-Received: by 2002:a7b:cd97:0:b0:3fc:92:73d6 with SMTP id y23-20020a7bcd97000000b003fc009273d6mr4009310wmj.11.1689333273092;
        Fri, 14 Jul 2023 04:14:33 -0700 (PDT)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fba94c9e18sm1228715wmk.4.2023.07.14.04.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 04:14:32 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     leit@meta.com, Dave Jones <davej@codemonkey.org.uk>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH next-next v3] netconsole: Append kernel version to message
Date:   Fri, 14 Jul 2023 04:13:29 -0700
Message-Id: <20230714111330.3069605-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new netconsole runtime option that prepends the kernel version in
the netconsole message. This is useful to map kernel messages to kernel
version in a simple way, i.e., without checking somewhere which kernel
version the host that sent the message is using.

If this option is selected, then the "<release>," is prepended before the
netconsole message. This is an example of a netconsole output, with
release feature enabled:

	6.4.0-01762-ga1ba2ffe946e;12,426,112883998,-;this is a test

Cc: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
V1 -> V2:
 * Configured at runtime instead of at compilation time.
 * Reuse send_ext_msg_udp to avoid extra memory allocation.
V2 -> V3:
 * Do no enable netcons if parameters release is set but not extended
   log.
---
 Documentation/networking/netconsole.rst | 11 +++-
 drivers/net/netconsole.c                | 81 ++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index dd0518e002f6..7a9de0568e84 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -13,6 +13,8 @@ IPv6 support by Cong Wang <xiyou.wangcong@gmail.com>, Jan 1 2013
 
 Extended console support by Tejun Heo <tj@kernel.org>, May 1 2015
 
+Release prepend support by Breno Leitao <leitao@debian.org>, Jul 7 2023
+
 Please send bug reports to Matt Mackall <mpm@selenic.com>
 Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
 
@@ -34,10 +36,11 @@ Sender and receiver configuration:
 It takes a string configuration parameter "netconsole" in the
 following format::
 
- netconsole=[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
+ netconsole=[+][r][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]
 
    where
 	+             if present, enable extended console support
+	r             if present, prepend kernel version (release) to the message
 	src-port      source for UDP packets (defaults to 6665)
 	src-ip        source IP to use (interface address)
 	dev           network interface (eth0)
@@ -125,6 +128,7 @@ The interface exposes these parameters of a netconsole target to userspace:
 	==============  =================================       ============
 	enabled		Is this target currently enabled?	(read-write)
 	extended	Extended mode enabled			(read-write)
+	release		Prepend kernel release to message	(read-write)
 	dev_name	Local network interface name		(read-write)
 	local_port	Source UDP port to use			(read-write)
 	remote_port	Remote agent's UDP port			(read-write)
@@ -165,6 +169,11 @@ following format which is the same as /dev/kmsg::
 
  <level>,<sequnum>,<timestamp>,<contflag>;<message text>
 
+If 'r' (release) feature is enabled, the kernel release version is
+prepended to the start of the message. Example::
+
+ 6.4.0,6,444,501151268,-;netconsole: network logging started
+
 Non printable characters in <message text> are escaped using "\xff"
 notation. If the message contains optional dictionary, verbatim
 newline is used as the delimiter.
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4f4f79532c6c..31cbe02eda49 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -36,6 +36,7 @@
 #include <linux/inet.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
+#include <linux/utsname.h>
 
 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -84,6 +85,8 @@ static struct console netconsole_ext;
  *		Also, other parameters of a target may be modified at
  *		runtime only when it is disabled (enabled == 0).
  * @extended:	Denotes whether console is extended or not.
+ * @release:	Denotes whether kernel release version should be prepended
+ *		to the message. Depends on extended console.
  * @np:		The netpoll structure for this target.
  *		Contains the other userspace visible parameters:
  *		dev_name	(read-write)
@@ -101,6 +104,7 @@ struct netconsole_target {
 #endif
 	bool			enabled;
 	bool			extended;
+	bool			release;
 	struct netpoll		np;
 };
 
@@ -188,6 +192,15 @@ static struct netconsole_target *alloc_param_target(char *target_config)
 		target_config++;
 	}
 
+	if (*target_config == 'r') {
+		if (!nt->extended) {
+			pr_err("Netconsole configuration error. Release feature requires extended log message");
+			goto fail;
+		}
+		nt->release = true;
+		target_config++;
+	}
+
 	/* Parse parameters and setup netpoll */
 	err = netpoll_parse_options(&nt->np, target_config);
 	if (err)
@@ -222,6 +235,7 @@ static void free_param_target(struct netconsole_target *nt)
  *				|
  *				<target>/
  *				|	enabled
+ *				|	release
  *				|	dev_name
  *				|	local_port
  *				|	remote_port
@@ -254,6 +268,11 @@ static ssize_t extended_show(struct config_item *item, char *buf)
 	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->extended);
 }
 
+static ssize_t release_show(struct config_item *item, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", to_target(item)->release);
+}
+
 static ssize_t dev_name_show(struct config_item *item, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%s\n", to_target(item)->np.dev_name);
@@ -332,6 +351,11 @@ static ssize_t enabled_store(struct config_item *item,
 	}
 
 	if (enabled) {	/* true */
+		if (nt->release && !nt->extended) {
+			pr_err("Not enabling netconsole. Release feature requires extended log message");
+			goto out_unlock;
+		}
+
 		if (nt->extended && !console_is_registered(&netconsole_ext))
 			register_console(&netconsole_ext);
 
@@ -366,6 +390,38 @@ static ssize_t enabled_store(struct config_item *item,
 	return err;
 }
 
+static ssize_t release_store(struct config_item *item, const char *buf,
+			     size_t count)
+{
+	struct netconsole_target *nt = to_target(item);
+	int release;
+	int err;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	if (nt->enabled) {
+		pr_err("target (%s) is enabled, disable to update parameters\n",
+		       config_item_name(&nt->item));
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	err = kstrtoint(buf, 10, &release);
+	if (err < 0)
+		goto out_unlock;
+	if (release < 0 || release > 1) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	nt->release = release;
+
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return strnlen(buf, count);
+out_unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return err;
+}
+
 static ssize_t extended_store(struct config_item *item, const char *buf,
 		size_t count)
 {
@@ -576,10 +632,12 @@ CONFIGFS_ATTR(, local_ip);
 CONFIGFS_ATTR(, remote_ip);
 CONFIGFS_ATTR_RO(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
+CONFIGFS_ATTR(, release);
 
 static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_enabled,
 	&attr_extended,
+	&attr_release,
 	&attr_dev_name,
 	&attr_local_port,
 	&attr_remote_port,
@@ -772,9 +830,23 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *header, *body;
 	int offset = 0;
 	int header_len, body_len;
+	const char *msg_ready = msg;
+	const char *release;
+	int release_len = 0;
+
+	if (nt->release) {
+		release = init_utsname()->release;
+		release_len = strlen(release) + 1;
+	}
 
-	if (msg_len <= MAX_PRINT_CHUNK) {
-		netpoll_send_udp(&nt->np, msg, msg_len);
+	if (msg_len + release_len <= MAX_PRINT_CHUNK) {
+		/* No fragmentation needed */
+		if (nt->release) {
+			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
+			msg_len += release_len;
+			msg_ready = buf;
+		}
+		netpoll_send_udp(&nt->np, msg_ready, msg_len);
 		return;
 	}
 
@@ -792,7 +864,10 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	memcpy(buf, header, header_len);
+	if (nt->release)
+		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
+	memcpy(buf + release_len, header, header_len);
+	header_len += release_len;
 
 	while (offset < body_len) {
 		int this_header = header_len;
-- 
2.34.1

