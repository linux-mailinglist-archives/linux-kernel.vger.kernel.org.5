Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C768B7F7915
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjKXQf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjKXQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:35:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043019A4;
        Fri, 24 Nov 2023 08:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=liAhozg7Mw19h9BQg+C0TH1QJAs+IpxQtgvDIZ45qPY=;
        t=1700843720; x=1702053320; b=O0k0ulbtJS8ygJhQrmxW7+kEchrVYQ6Xcz+cBuYRS+Vs+WT
        u++r4apCdiNEOI81+ivYE7/LWUU3XEanONBCiZRlwywwejyAetFPbXutAqeNIz4FbAh6RiY/2cIKM
        nKWa05FpEsAA5LDEQB698L+RDRLqJHP+RUvt5OGIbyZuMnlcYKxuZ44m3FP2QRGCKIkrD6/Mmpqih
        copzgWuvDTpVJ6336UNvyDTo8dO/PJzA+jHlgyWbRXMWJJpFQ1t44qp8PKeoSxMKJi5LynxscLKEm
        Lwsc/WopaEtOOr3IQvehOm3rsOmzRBsMlU/lzWcfLrCWS5oU9EMAKFEOtKHtJdFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r6Z9B-00000002fA8-2i2H;
        Fri, 24 Nov 2023 17:35:18 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 4/6] wifi: cfg80211: add locked debugfs wrappers
Date:   Fri, 24 Nov 2023 17:25:27 +0100
Message-ID: <20231124172522.e79351e3900f.I52daf6c4d8f70b5c5c2de7f0918c6748f11f1e8b@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124162522.16344-7-johannes@sipsolutions.net>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add wrappers for debugfs files that should be called with
the wiphy mutex held, while the file is also to be removed
under the wiphy mutex. This could otherwise deadlock when
a file is trying to acquire the wiphy mutex while the code
removing it holds the mutex but waits for the removal.

This actually works by pushing the execution of the read
or write handler to a wiphy work that can be cancelled
using the debugfs cancellation API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  46 ++++++++++++
 net/wireless/debugfs.c | 160 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..4ecfb06c413d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9299,4 +9299,50 @@ bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
  */
 void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
 
+#ifdef CONFIG_CFG80211_DEBUGFS
+/**
+ * wiphy_locked_debugfs_read - do a locked read in debugfs
+ * @wiphy: the wiphy to use
+ * @file: the file being read
+ * @buf: the buffer to fill and then read from
+ * @bufsize: size of the buffer
+ * @userbuf: the user buffer to copy to
+ * @count: read count
+ * @ppos: read position
+ * @handler: the read handler to call (under wiphy lock)
+ * @data: additional data to pass to the read handler
+ */
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+				  char *buf, size_t bufsize,
+				  char __user *userbuf, size_t count,
+				  loff_t *ppos,
+				  ssize_t (*handler)(struct wiphy *wiphy,
+						     struct file *file,
+						     char *buf,
+						     size_t bufsize,
+						     void *data),
+				  void *data);
+
+/**
+ * wiphy_locked_debugfs_write - do a locked write in debugfs
+ * @wiphy: the wiphy to use
+ * @file: the file being written to
+ * @buf: the buffer to copy the user data to
+ * @bufsize: size of the buffer
+ * @userbuf: the user buffer to copy from
+ * @count: read count
+ * @handler: the write handler to call (under wiphy lock)
+ * @data: additional data to pass to the write handler
+ */
+ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
+				   char *buf, size_t bufsize,
+				   const char __user *userbuf, size_t count,
+				   ssize_t (*handler)(struct wiphy *wiphy,
+						      struct file *file,
+						      char *buf,
+						      size_t count,
+						      void *data),
+				   void *data);
+#endif
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 0878b162890a..40e49074e2ee 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2009	Luis R. Rodriguez <lrodriguez@atheros.com>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2023 Intel Corporation
  */
 
 #include <linux/slab.h>
@@ -109,3 +110,162 @@ void cfg80211_debugfs_rdev_add(struct cfg80211_registered_device *rdev)
 	DEBUGFS_ADD(long_retry_limit);
 	DEBUGFS_ADD(ht40allow_map);
 }
+
+struct debugfs_read_work {
+	struct wiphy_work work;
+	ssize_t (*handler)(struct wiphy *wiphy,
+			   struct file *file,
+			   char *buf,
+			   size_t count,
+			   void *data);
+	struct wiphy *wiphy;
+	struct file *file;
+	char *buf;
+	size_t bufsize;
+	void *data;
+	ssize_t ret;
+	struct completion completion;
+};
+
+static void wiphy_locked_debugfs_read_work(struct wiphy *wiphy,
+					   struct wiphy_work *work)
+{
+	struct debugfs_read_work *w = container_of(work, typeof(*w), work);
+
+	w->ret = w->handler(w->wiphy, w->file, w->buf, w->bufsize, w->data);
+	complete(&w->completion);
+}
+
+static void wiphy_locked_debugfs_read_cancel(struct dentry *dentry,
+					     void *data)
+{
+	struct debugfs_read_work *w = data;
+
+	wiphy_work_cancel(w->wiphy, &w->work);
+	complete(&w->completion);
+}
+
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+				  char *buf, size_t bufsize,
+				  char __user *userbuf, size_t count,
+				  loff_t *ppos,
+				  ssize_t (*handler)(struct wiphy *wiphy,
+						     struct file *file,
+						     char *buf,
+						     size_t bufsize,
+						     void *data),
+				  void *data)
+{
+	struct debugfs_read_work work = {
+		.handler = handler,
+		.wiphy = wiphy,
+		.file = file,
+		.buf = buf,
+		.bufsize = bufsize,
+		.data = data,
+		.ret = -ENODEV,
+		.completion = COMPLETION_INITIALIZER_ONSTACK(work.completion),
+	};
+	struct debugfs_cancellation cancellation = {
+		.cancel = wiphy_locked_debugfs_read_cancel,
+		.cancel_data = &work,
+	};
+
+	/* don't leak stack data or whatever */
+	memset(buf, 0, bufsize);
+
+	wiphy_work_init(&work.work, wiphy_locked_debugfs_read_work);
+	wiphy_work_queue(wiphy, &work.work);
+
+	debugfs_enter_cancellation(file, &cancellation);
+	wait_for_completion(&work.completion);
+	debugfs_leave_cancellation(file, &cancellation);
+
+	if (work.ret < 0)
+		return work.ret;
+
+	if (WARN_ON(work.ret > bufsize))
+		return -EINVAL;
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, work.ret);
+}
+EXPORT_SYMBOL_GPL(wiphy_locked_debugfs_read);
+
+struct debugfs_write_work {
+	struct wiphy_work work;
+	ssize_t (*handler)(struct wiphy *wiphy,
+			   struct file *file,
+			   char *buf,
+			   size_t count,
+			   void *data);
+	struct wiphy *wiphy;
+	struct file *file;
+	char *buf;
+	size_t count;
+	void *data;
+	ssize_t ret;
+	struct completion completion;
+};
+
+static void wiphy_locked_debugfs_write_work(struct wiphy *wiphy,
+					    struct wiphy_work *work)
+{
+	struct debugfs_write_work *w = container_of(work, typeof(*w), work);
+
+	w->ret = w->handler(w->wiphy, w->file, w->buf, w->count, w->data);
+	complete(&w->completion);
+}
+
+static void wiphy_locked_debugfs_write_cancel(struct dentry *dentry,
+					      void *data)
+{
+	struct debugfs_write_work *w = data;
+
+	wiphy_work_cancel(w->wiphy, &w->work);
+	complete(&w->completion);
+}
+
+ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
+				   struct file *file, char *buf, size_t bufsize,
+				   const char __user *userbuf, size_t count,
+				   ssize_t (*handler)(struct wiphy *wiphy,
+						      struct file *file,
+						      char *buf,
+						      size_t count,
+						      void *data),
+				   void *data)
+{
+	struct debugfs_write_work work = {
+		.handler = handler,
+		.wiphy = wiphy,
+		.file = file,
+		.buf = buf,
+		.count = count,
+		.data = data,
+		.ret = -ENODEV,
+		.completion = COMPLETION_INITIALIZER_ONSTACK(work.completion),
+	};
+	struct debugfs_cancellation cancellation = {
+		.cancel = wiphy_locked_debugfs_write_cancel,
+		.cancel_data = &work,
+	};
+
+	/* mostly used for strings so enforce NUL-termination for safety */
+	if (count >= bufsize)
+		return -EINVAL;
+
+	memset(buf, 0, bufsize);
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	wiphy_work_init(&work.work, wiphy_locked_debugfs_write_work);
+	wiphy_work_queue(wiphy, &work.work);
+
+	debugfs_enter_cancellation(file, &cancellation);
+	wait_for_completion(&work.completion);
+	debugfs_leave_cancellation(file, &cancellation);
+
+	return work.ret;
+}
+EXPORT_SYMBOL_GPL(wiphy_locked_debugfs_write);
-- 
2.42.0

