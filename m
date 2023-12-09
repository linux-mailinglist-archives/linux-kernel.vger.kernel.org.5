Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B93480B6FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjLIW5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjLIW5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:57:54 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BBF9;
        Sat,  9 Dec 2023 14:58:00 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-333536432e0so3071151f8f.3;
        Sat, 09 Dec 2023 14:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702162679; x=1702767479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAIlBevUevXrKEyLl8WmeuOwp9gUqiZZAn2K412EKIM=;
        b=TymjYtaP++jhqMgtZ8/aBolHA0TMUs2tgfdvlV0YU410UaSpQS9BGgwsVmia82pk7h
         U7DUZfa/Qudd/qUpt/J1d+25hERrIRfUyfzZ+UdNSW6udB7Aeaq+dCXMxY+n+hT+eQfz
         Z3RBgsFUxAAjo2ZwJTLHelxG5f2qQVsv3UUUfnuIN8ymJV+04WrKSYAEElh4uhndr9OI
         IHmQxU61+JYKzZKVwQaqNxCRR1Dgk/6Rrqi/LrzIH2hMbHxqVz82XbdsFqplVupUPOk+
         FC4Yxx2a+kpi+5vIJm0F1oWyKLciHa++lSo+tiTLAwMkt6jKdf9XFNORYGzaf6GhyXlV
         zv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702162679; x=1702767479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAIlBevUevXrKEyLl8WmeuOwp9gUqiZZAn2K412EKIM=;
        b=e1p6PprXuL5Z7HABD083S2NgYO++NbBAp4vexBUpgXFmaaVGAWb5tZg3STbdmYS4OT
         Tq4tVpRcC4wm3SnNij1VKttUYxDal3MbQGp0PypYqYSvrHcCdXxQTX1K5lQQq+AnRaA2
         jarK7SmcnyeQxLUaVzH08lufjuV5gzcmbA7NTAV7SZKVj5nBK/rc4kN3J2OVXC+fTrBO
         ZW3QMG71mqSMNp7hP68F1B0RALY2Ju8e2UcwfgbhC5dD73zcL+uzZOYt5rGVqUWjPg1e
         ELBEY3AZ2MmmxAsxno1h4M6MeqinGELuoGKYqEg/5BxmbJaoJL2whyYG2gh/Bc2nFi93
         U5Cw==
X-Gm-Message-State: AOJu0YzIS+4fWkuaNN2jaZVu3yiMfCmk7UbzsnANso+ggSVJvU9AHQOd
        ehCddqo1hq0/cLevA79G1qQ=
X-Google-Smtp-Source: AGHT+IFt/dBTIsv2RLCWFXFYS2R03MC1rIRuWdn7TJMPqHYH/7C4VL61To6xzKEvyIR6M/UPChvjUA==
X-Received: by 2002:adf:e98e:0:b0:333:218b:cc88 with SMTP id h14-20020adfe98e000000b00333218bcc88mr1239905wrm.68.1702162678871;
        Sat, 09 Dec 2023 14:57:58 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b003332aa97101sm5179380wrv.38.2023.12.09.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 14:57:58 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/gma500: Fix spelling mistake "patter" -> "pattern"
Date:   Sat,  9 Dec 2023 22:57:57 +0000
Message-Id: <20231209225757.4055520-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a DRM_DEBUG_KMS message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 8992a95076f2..2c7d0416e623 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -1548,7 +1548,7 @@ cdv_intel_dp_start_link_train(struct gma_encoder *encoder)
 	}
 
 	if (!clock_recovery) {
-		DRM_DEBUG_KMS("failure in DP patter 1 training, train set %x\n", intel_dp->train_set[0]);
+		DRM_DEBUG_KMS("failure in DP pattern 1 training, train set %x\n", intel_dp->train_set[0]);
 	}
 
 	intel_dp->DP = DP;
-- 
2.39.2

