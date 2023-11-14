Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9763A7EB5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjKNRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjKNRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:44:08 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E9103
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:44:05 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-777745f1541so379724485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1699983844; x=1700588644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/Se8NuL5JKZV2azJTKlvFmjep69ofpc3jvqTI1b0ug=;
        b=OC5xPt1k3Xh2bhIYSKP0jgJJ2babStSoVDqbwb0oFKt9iN+m7MIjh4YwaXzI3BbOyb
         7rEhIXIBV7flKRnqq1K5m4NK57JiKZzbbvwZwQAZJ8/QWbekN+Rmn018z+j63UeDiVjT
         Own204oYyHBD4tpEg9lvKLhUlBr6uKHx3XtzwdUlMcwSZ/32BRhuyjgqPV2sNh+7WrSl
         Y82T7pT0vOgoehPmKyetF2Sfx//2I99CaCtoSilF/fFYkGqMdhQqNbiCP3rIg/Fn4FOH
         oWfWysShI1nUUhCqsaRLFoEVb8Hvvmd6D810VKgPqx4yx4ev4ntm/Uub5oooLmM0mSJX
         cJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983844; x=1700588644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/Se8NuL5JKZV2azJTKlvFmjep69ofpc3jvqTI1b0ug=;
        b=ZQiybxpeqO086NkKrXZ6poLLYJgHp6pj7WT/0d9jBnqD/56Su5gQNJFML11UkaRMi7
         Vz4l7vp0Qd1JtmSF9LKwyy4nDtVwKu77WqZm9vEj+VDCUhE7Dyj1EftgpEZQ5xnkvSt/
         YGfbgS6lcUJC5sC4as5UsIL7kdALK2h9yFgx5rUfabQKwYUjq7pX+FsW/LkSS7eCU9Hu
         1kforcWGIELwELmuWEytVMOi9yAchM7f2qIm1fNtPdFxihOn6aXWLMDCELApvybyRPxF
         bEJBW0dRAtM2Un/CzyLlYqjtM62Tz5MCLZxvlb0E90suwTu37PSB9VkBb/2eRqvupC8K
         WluA==
X-Gm-Message-State: AOJu0YyrFtQtTvRxQwDXEzf9RTW9HiPbV0Hb9fbSp0XlQEVtcgz1EVnA
        jlCadQMvBY5uOAPw7cujXXMJbA==
X-Google-Smtp-Source: AGHT+IEVo5nwOKH3fh3lUeHfJPuHsZveyp2ikuoOIr0IRzcdZCJpfEChO6qWMjdi051wikBpH2Rarg==
X-Received: by 2002:a05:620a:4627:b0:779:efb4:73bb with SMTP id br39-20020a05620a462700b00779efb473bbmr3357188qkb.41.1699983844031;
        Tue, 14 Nov 2023 09:44:04 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05620a318800b007671cfe8a18sm2833350qkb.13.2023.11.14.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:44:03 -0800 (PST)
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
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] drm/msm/dsi: add a comment to explain pkt_per_line encoding
Date:   Tue, 14 Nov 2023 12:42:14 -0500
Message-Id: <20231114174218.19765-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20231114174218.19765-1-jonathan@marek.ca>
References: <20231114174218.19765-1-jonathan@marek.ca>
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

Make it clear why the pkt_per_line value is being "divided by 2".

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index bddc57726fb9..2ea2fc105fbf 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -875,6 +875,8 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
 	/* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
 	 * registers have similar offsets, so for below common code use
 	 * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
+	 *
+	 * pkt_per_line is log2 encoded, >>1 works for supported values (1,2,4)
 	 */
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
 	reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
-- 
2.26.1

