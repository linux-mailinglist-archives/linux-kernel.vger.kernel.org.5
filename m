Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443057A86E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjITOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjITOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D812EB;
        Wed, 20 Sep 2023 07:36:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C5CC4339A;
        Wed, 20 Sep 2023 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220577;
        bh=BW2baC+EjniG/ZZH9QzIRlNDubJbbQk6ybbnPB50Z5U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QMBksauG5pswKb5xB6CtFYwYj/cC83Oq2vsnPv8kALZhCI10FuNF5SZpcK4o+5VgO
         q9YLBerNyF4mOPxy9qIWuJngvp6RlmKFQkpviJCdnITZwa8UStAVgcrUmUUSlZacCp
         Sa2C2VOhysj9NjsuPS4yy1LVShpmUzrhC6E+OBrVPcQEJWLdOD/GttdkMZpJKx4REu
         QuZ4oS21epq72qPxBepINbE8FBg4I7pYlVsX0RJLjLS/Sgdc8i89dHjwLMsLYkBE3/
         0d5F8jJR8Bsu+TTGYWGoka4sn5IS4RjCrpj6RCs9rXKkxyslwX2z6JFL1SrDvi602N
         Fj+2L5zbOPfUA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:27 +0200
Subject: [PATCH RFC v2 12/37] drm/connector: hdmi: Create Infoframe DebugFS
 entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-12-17932daddd7d@kernel.org>
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
In-Reply-To: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4166; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BW2baC+EjniG/ZZH9QzIRlNDubJbbQk6ybbnPB50Z5U=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczJaRkYxeC5/cu/6kZtIa8yim+905h7sbs8JbZ68TW
 772kl1dRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACZyrpaRofn+RoszV7+s+B2n
 8H2vhHafnbr/kr5ZHA5rNqXcmLrCfh8jw6nixe+rhGdLvVZnva8SxvgyfN6G03kCOXaM08qlijz
 WsAIA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been some discussions recently about the infoframes sent by
drivers and if they were properly generated.

In parallel, there's been some interest in creating an infoframe-decode
tool similar to edid-decode.

Both would be much easier if we were to expose the infoframes programmed
in the hardware. It won't be perfect since we have no guarantee that
it's actually what goes through the wire, but it's the best we can do.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_debugfs.c | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 2de43ff3ce0a..3c65b1d3f926 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -538,6 +538,114 @@ static const struct file_operations drm_connector_fops = {
 	.write = connector_write
 };
 
+struct debugfs_wrapper {
+	struct drm_connector *connector;
+	struct drm_connector_hdmi_infoframe *frame;
+};
+
+#define HDMI_MAX_INFOFRAME_SIZE		29
+
+static ssize_t
+infoframe_read(struct file *filp, char __user *ubuf, size_t count, loff_t *ppos)
+{
+	const struct debugfs_wrapper *wrapper = filp->private_data;
+	struct drm_connector *connector = wrapper->connector;
+	struct drm_connector_hdmi_infoframe *infoframe = wrapper->frame;
+	union hdmi_infoframe *frame = &infoframe->data;
+	u8 buf[HDMI_MAX_INFOFRAME_SIZE];
+	ssize_t len = 0;
+
+	mutex_lock(&connector->hdmi.infoframes.lock);
+
+	if (!infoframe->set)
+		goto out;
+
+	len = hdmi_infoframe_pack(frame, buf, sizeof(buf));
+	if (len < 0)
+		goto out;
+
+	len = simple_read_from_buffer(ubuf, count, ppos, buf, len);
+
+out:
+	mutex_unlock(&connector->hdmi.infoframes.lock);
+	return len;
+}
+
+static const struct file_operations infoframe_fops = {
+	.owner   = THIS_MODULE,
+	.open    = simple_open,
+	.read    = infoframe_read,
+};
+
+static int create_hdmi_infoframe_file(struct drm_connector *connector,
+				      struct dentry *parent,
+				      const char *filename,
+				      struct drm_connector_hdmi_infoframe *frame)
+{
+	struct drm_device *dev = connector->dev;
+	struct debugfs_wrapper *wrapper;
+	struct dentry *file;
+
+	wrapper = drmm_kzalloc(dev, sizeof(*wrapper), GFP_KERNEL);
+	if (!wrapper)
+		return -ENOMEM;
+
+	wrapper->connector = connector;
+	wrapper->frame = frame;
+
+	file = debugfs_create_file(filename, 0400, parent, wrapper, &infoframe_fops);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	return 0;
+}
+
+#define CREATE_HDMI_INFOFRAME_FILE(c, p, i)		\
+	create_hdmi_infoframe_file(c, p, #i, &(c)->hdmi.infoframes.i)
+
+static int create_hdmi_infoframe_files(struct drm_connector *connector,
+				       struct dentry *parent)
+{
+	int ret;
+
+	ret = CREATE_HDMI_INFOFRAME_FILE(connector, parent, audio);
+	if (ret)
+		return ret;
+
+	ret = CREATE_HDMI_INFOFRAME_FILE(connector, parent, avi);
+	if (ret)
+		return ret;
+
+	ret = CREATE_HDMI_INFOFRAME_FILE(connector, parent, drm);
+	if (ret)
+		return ret;
+
+	ret = CREATE_HDMI_INFOFRAME_FILE(connector, parent, spd);
+	if (ret)
+		return ret;
+
+	ret = CREATE_HDMI_INFOFRAME_FILE(connector, parent, vendor);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void hdmi_debugfs_add(struct drm_connector *connector)
+{
+	struct dentry *dir;
+
+	if (!(connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	      connector->connector_type == DRM_MODE_CONNECTOR_HDMIB))
+		return;
+
+	dir = debugfs_create_dir("infoframes", connector->debugfs_entry);
+	if (IS_ERR(dir))
+		return;
+
+	create_hdmi_infoframe_files(connector, dir);
+}
+
 void drm_debugfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_minor *minor = connector->dev->primary;
@@ -565,6 +673,8 @@ void drm_debugfs_connector_add(struct drm_connector *connector)
 	debugfs_create_file("output_bpc", 0444, root, connector,
 			    &output_bpc_fops);
 
+	hdmi_debugfs_add(connector);
+
 	if (connector->funcs->debugfs_init)
 		connector->funcs->debugfs_init(connector, root);
 }

-- 
2.41.0

