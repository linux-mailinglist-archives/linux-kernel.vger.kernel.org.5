Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFB790E61
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349441AbjICVmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349071AbjICVmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:42:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C647119
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:41:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5008faf4456so1289358e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693777318; x=1694382118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1gyG4EA+KF88AUvqDVJpMyc5ibJn0KvVHVwRSeTDTM=;
        b=UHecZlFu28oyM1EdwF5xu4mbh3c2hb9MD1AU+tQzl8OtnJ90IX3AnYpsaXP5H/9n+K
         7RSSHsOk6xIOwWDE4bzOUWVpuwqj4GACfNrd9MPwiQGsouwn9HIoabmEZiv31jSd1KrL
         uH23NUO7LadsBKSRoVYdeINOieKFf8Bho2p5Vo7JqZ3cT5Ev0sLvodGS/LF7wv5huys8
         xPfGsgB9scNjYQbe3XUeXoj51Oh2/YtvW2bmycHFSM6JDAfHrhk2JqaNa2ftxlwZdEOY
         q255uEOuw3G3ki2y9VodbHLknRoerdOIWj9YaEAZaymp4DGlP7RHW0bVu2DXodZvkzvx
         nbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777318; x=1694382118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1gyG4EA+KF88AUvqDVJpMyc5ibJn0KvVHVwRSeTDTM=;
        b=OkD4+GnB0rTWk5SPC7hU00tqLVXgWwQM6HlRJ189cKAE3LaV4+XeBtrxjx8u7uhZKE
         xEzkwbcgKeajYl0l79AxpeVqwloQU7OE6mkY/LzWF7bv6sCKBDkqb2b7LG1x4hR6zGzO
         KTEGo7PfkwRRXNgb+nMQtXyS1sgJCl/EFaVTCOHG5swws49U2gch70Lo1P7/0HhPn5Vg
         i3O94j6p2U3f6kegpY3WnmplCgPgzosEcsSZkIIEkyp7VPEsyaC113EO+v/r+1uWQZjM
         LJFSJoPJfrfZ87Ep3IaI2ixJPCIHFpb4QVGr3avLvpSaGYAWJ4dDAXrAnVhZEI32Q9Tx
         oaUA==
X-Gm-Message-State: AOJu0YxXlwf7b019RlkO3npveY/1PxscmmNwXj0/IAB1AG7na/veBcuJ
        LnO5xanrCLBXnTyWocUBjcdjWg==
X-Google-Smtp-Source: AGHT+IFeimZforUo3xm2aTW6r+gvYdhOH4RX08O1w99CKPaCyS3lubUtNJ5cXMhhp/mnVE4/u6CHlg==
X-Received: by 2002:a05:6512:3b8a:b0:4f8:7055:6f7e with SMTP id g10-20020a0565123b8a00b004f870556f7emr6244283lfv.44.1693777317966;
        Sun, 03 Sep 2023 14:41:57 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x17-20020ac25dd1000000b004f8555f7aa1sm1422506lfq.52.2023.09.03.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:41:57 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH v1 09/12] usb: typec: tcpm: support generating Type-C port names for userspace
Date:   Mon,  4 Sep 2023 00:41:47 +0300
Message-Id: <20230903214150.2877023-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need a way to generate and return the Type-C port device names. For
example, it is going to be used by the DRM to provide PATH property for
DisplayPort connectors.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
 include/linux/usb/tcpm.h      |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d962f67c95ae..9709b56a3046 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5539,6 +5539,20 @@ bool tcpm_port_is_toggling(struct tcpm_port *port)
 }
 EXPORT_SYMBOL_GPL(tcpm_port_is_toggling);
 
+/**
+ * tcpm_port_get_name - get the name of the corresponding USB Type-C port
+ * @port: TCPM port instance
+ *
+ * Returns a name of the USB Type-C port correponding to the passed TCPM port
+ * instance on success or NULL when the port has not been enumerated yet. The
+ * resulting string should be freed by the caller.
+ */
+char *tcpm_port_get_name(struct tcpm_port *port)
+{
+	return typec_port_get_name(port->typec_port);
+}
+EXPORT_SYMBOL_GPL(tcpm_port_get_name);
+
 static void tcpm_enable_frs_work(struct kthread_work *work)
 {
 	struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index ab7ca872950b..623c34788680 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -161,6 +161,8 @@ struct tcpm_port;
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc);
 void tcpm_unregister_port(struct tcpm_port *port);
 
+char *tcpm_port_get_name(struct tcpm_port *port);
+
 void tcpm_vbus_change(struct tcpm_port *port);
 void tcpm_cc_change(struct tcpm_port *port);
 void tcpm_sink_frs(struct tcpm_port *port);
-- 
2.39.2

