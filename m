Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE65B784919
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjHVSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjHVSCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:02:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C7CC;
        Tue, 22 Aug 2023 11:02:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf078d5fb7so31628845ad.0;
        Tue, 22 Aug 2023 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727360; x=1693332160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQPrHId/lCHDPLFw57GJfdnbAiLt5erdzCNTXGSDhdo=;
        b=Ie2ANdwPuvvaJZxkLtrV0mygSDZzPCCbtaixTP8JhVB/Dc8l9V7ZwtmGdhFz5nHUp8
         0pwhfQZmLpaJW8iDA2VwHvcAgkKpV0TMqB9fKSlHP7RDEocY2yvNGjhM95DxrPb8fidf
         FlIJaGh+hNfhxNGHXNRMtQy2Bwu71FYUO/2lsS+d0iD75UwGCdHdk+430CWP03moOP/g
         vh1w62NFiGunZUR5wq3X8AXFQHYj7/ZNM0nvpnAGGzLB7biAnJZAKd/hS/75nPJidBRd
         wyB7HRXthbT3p8bRWgKtAX5Wh9DXBfund8EKANorutH3NVpoOehVuli/wxpVea/0kRs9
         FAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727360; x=1693332160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQPrHId/lCHDPLFw57GJfdnbAiLt5erdzCNTXGSDhdo=;
        b=NV7eOdpwyf22aGloh5Tr5HzLMuSfyhavubVTydg6XeL7aHzsiplqRTRJFZ7DTlu433
         9li4AMWSfqo+oBPVRlzm/JLB+OvMkx5eKRuz0Xy+M2sJQ4AvVkWQNu+uNBX0z/p1af/d
         k3NpP2hbLRcczPZ4JpMYJMOE27jbPExYYbe1IZQXHEOqfgerfK/NP+EBOxuOrNTHWBBx
         ijSVwbO33Sa/XnSUDJEuz1BAAECgSS2b1xc2RbkvF76ij1NIcG4MKi2Rk23rdQMGi3vN
         I0xOOoi10XCiaeff3HlCLaKgzdxqgwqSwgdduUltMoab7kZAp+R977DLqLlQfd2/hsrK
         vwsg==
X-Gm-Message-State: AOJu0YzscdrVEfr/oNOXZ4rmcPIag44pQsjdHcH351knpanIQsKhZ8KQ
        Jb4g2RTziYHLGK6jTinb03I=
X-Google-Smtp-Source: AGHT+IGraTUb9fjtbBbpbEedDJNHXKDUjifcWUB+DLrPWbQJCnkqOHt2z8O4M1Y+WpOEnMa46nzFqw==
X-Received: by 2002:a17:902:c086:b0:1bc:5924:2da2 with SMTP id j6-20020a170902c08600b001bc59242da2mr8036097pld.56.1692727360397;
        Tue, 22 Aug 2023 11:02:40 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b001bf6ea340b3sm5744775pln.116.2023.08.22.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:39 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 05/11] PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
Date:   Tue, 22 Aug 2023 11:01:52 -0700
Message-ID: <20230822180208.95556-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822180208.95556-1-robdclark@gmail.com>
References: <20230822180208.95556-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Annotate dev_pm_qos_mtx to teach lockdep to scream about allocations
that could trigger reclaim under dev_pm_qos_mtx.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/qos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 09834f3354d7..2018c805a6f1 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -1017,3 +1017,14 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
 	pm_runtime_put(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
+
+static int __init dev_pm_qos_init(void)
+{
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&dev_pm_qos_mtx);
+	fs_reclaim_release(GFP_KERNEL);
+
+	return 0;
+}
+early_initcall(dev_pm_qos_init);
-- 
2.41.0

