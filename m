Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD87EB5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjKNRoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:44:05 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A509103
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:44:02 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-778ac9c898dso304720285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1699983841; x=1700588641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thGoIvnqITUJB7IQaQsWGdMjOXMrq/akRqtI22GpJyQ=;
        b=FXQ7dxcxpBSE5zZsFlJRwBYnmmsznxRjIhYT40fqR7x6Yoo/1VV595U4yzi4D9idAt
         NTZMv5sQPmmA9CWcuAVmjsg6J60Nbjm5mWpmVlsqM8tkOZi60OQypnH4bi6bL7VcvmaL
         /jGRMbxx8RvMlI/Jo42qIhE0uNlPupx5UxjSlbn5yqr4cfLB5ojoy37+operULioqgWZ
         ImZIwpjncnWPbjq/QAVrCutJOuk7dSNLzgBL3Kx73PfyaVkod1IO8StGr5YxFrNnL/bl
         kQ6ZzqHYCBehXckAg+MlHbUmBjnaq1KKqjlsoubk5FCKlz9gjxK6K4OOnG9Orctrc3k7
         8MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983841; x=1700588641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thGoIvnqITUJB7IQaQsWGdMjOXMrq/akRqtI22GpJyQ=;
        b=PPuINjMrem/729+U1sDCX7MpvQghrB5rG7S4miV0uPCaVORTd3ilbEtlHNNA3eSZKn
         pix5zWYLOP2+BX6XhxoaPe4KItC4KkRcJHIuu0PtP9Hc/wPXIyF/NlqNizx9VTv4dwRr
         nnme8LdGPeMMu+4GO3aAfJS2GaH8gBJLTlky5FpqsCFqXKajSZWYl4zzpeStZu13c6/J
         BMrZEA+ZCHuACDmIODemN0GAn60wl9sQBK/9jfHrvX28TdxZ+mULDhOEl3GCSliHLzCj
         7N10Cw6BGiD1guwjxQCn8rc2BFT985cpTG4qjhTg8mNmKx3yBd+6RliKu1zgVNdWEp0w
         I9bg==
X-Gm-Message-State: AOJu0YzgnV2+HGxpRhNtA/sgnXBxLz3DVxbiIeRXJIO+oI/0C/gMJ2MB
        4FPZ9V+igF/NpIuP2RwtJeUd4w==
X-Google-Smtp-Source: AGHT+IHcVT+p/7lEFZr3H2gf88K+Xif9L02wc8rJZEdi8qlawjVvm/vlqEVvJKZyXLD4cXnfklItEg==
X-Received: by 2002:a05:620a:8c0c:b0:775:7e16:2cdf with SMTP id qz12-20020a05620a8c0c00b007757e162cdfmr2232672qkn.39.1699983841236;
        Tue, 14 Nov 2023 09:44:01 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05620a318800b007671cfe8a18sm2833350qkb.13.2023.11.14.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:44:00 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC (fix video mode DSC)
Date:   Tue, 14 Nov 2023 12:42:13 -0500
Message-Id: <20231114174218.19765-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video mode DSC won't work if this field is not set correctly. Set it to fix
video mode DSC (for slice_per_pkt==1 cases at least).

Fixes: 08802f515c3 ("drm/msm/dsi: Add support for DSC configuration")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 9d355cdc3ec1..bddc57726fb9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -847,6 +847,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	u32 slice_per_intf, total_bytes_per_intf;
 	u32 pkt_per_line;
 	u32 eol_byte_num;
+	u32 bytes_per_pkt;
 
 	/* first calculate dsc parameters and then program
 	 * compress mode registers
@@ -854,6 +855,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
 
 	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
+	bytes_per_pkt = dsc->slice_chunk_size; /* * slice_per_pkt; */
 
 	eol_byte_num = total_bytes_per_intf % 3;
 
@@ -891,6 +893,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 		dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg_ctrl);
 		dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
 	} else {
+		reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_WC(bytes_per_pkt);
 		dsi_write(msm_host, REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
 	}
 }
-- 
2.26.1

