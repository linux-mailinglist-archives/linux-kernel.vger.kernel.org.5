Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6D7DC8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjJaI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjJaI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:59:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C517611B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:59:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50797cf5b69so7458651e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698742778; x=1699347578; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNOnxQseUn+sdzcn++tRPmK5DAb/ytwQ21KP2ZD3yF8=;
        b=J6nCG4YFqgEFdX1t0NzbCF48/yxhDKHE3rp2/7yzhr40yH+l7JCa9OQFMwidONwCHc
         apjDRXhPwaB1imBLjzuRvuVZSj3rS0RDE2fNLLOU6NM1zY4M/4/uvtn3ohhJ5AxjxvIa
         FM8yfqNknfNjS0CV0Em5Z4ZwRAnQzu/+qtWY4pxuV0rWWiXD5oLQ1AY86TrSdH4jHIRy
         F0J1z+0nWURU4gcYgRj/XG06iubZOHM6wHAXCIuptqZHJDJXBrGlb6FDvxul7IJRpXDn
         Ph32JhVrXN896YkHGrGPl3ghD/+QCXcdPiep/8kALWMpB3ZmrIct91FaUrlrCli30jgh
         5LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698742778; x=1699347578;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNOnxQseUn+sdzcn++tRPmK5DAb/ytwQ21KP2ZD3yF8=;
        b=rKffavWAPJDuXa0yerV0VnZfPM0IBwl1KTTy2FbLXNVSdjDe4vmawuF3466pepwT7A
         eWjJ7Yp1ghCEyJhMf8V2mmcFSfbse2oUVK6e+TBxpO354Bju5vdZgYXzzfegAjLmTCV8
         aH5xkzG6rXa9xVZWMmC6ftYPM+kHiuJLqk4wLgexxGMa9k3dwXVD8kNT+bAHbItYu6OC
         wvksYvaoMHEyCpVlxS0IsLlKqJyl4kj6wfsvv+o3NVuucr7khLtHuu9W2DJO8gMXkhYm
         YnBGrbaDo+BJVO/7UJkuFmXC8rSPzzr/fOrTtGqYKo61y4WODVtqfISwhynyroFAs3xP
         fHqw==
X-Gm-Message-State: AOJu0YxhFJP+A5Bu/RV7g+jw09MA+l3XK/vVL3lO7yQULHsqf1eMKSok
        UyQidSOcjc1k0ppEgngRlyY2iQ==
X-Google-Smtp-Source: AGHT+IEz7RBymWwGaxhsiouoy6qvMnV1G4Gz7ZzpjpSRrBR9AiCIjw9PoA1bkmrCkpDthe9/kykFuw==
X-Received: by 2002:a05:6512:ea8:b0:507:ac56:66a0 with SMTP id bi40-20020a0565120ea800b00507ac5666a0mr8295514lfb.56.1698742778001;
        Tue, 31 Oct 2023 01:59:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d684b000000b0032f9a0fe0absm103388wrw.96.2023.10.31.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 01:59:37 -0700 (PDT)
Date:   Tue, 31 Oct 2023 11:59:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Umang Jain <umang.jain@ideasonboard.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: vc04_services: remove unnecessary NULL check
Message-ID: <1dff4d9b-d067-4525-95e0-ffdc1185cccd@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We ensured that "service" as non-NULL in the previous if statement so
there is no need to check again here.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 39b857da2d42..a0117efa2991 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2040,8 +2040,7 @@ sync_func(void *v)
 			continue;
 		}
 
-		svc_fourcc = service ? service->base.fourcc
-				     : VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
+		svc_fourcc = service->base.fourcc;
 
 		vchiq_log_trace(state->dev, VCHIQ_SYNC,
 				"Rcvd Msg %s from %p4cc s:%d d:%d len:%d",
-- 
2.42.0

