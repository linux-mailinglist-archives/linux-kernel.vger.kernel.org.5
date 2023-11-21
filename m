Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBB7F2251
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjKUAkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjKUAkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:40:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCA0CA;
        Mon, 20 Nov 2023 16:40:10 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso3138692a34.0;
        Mon, 20 Nov 2023 16:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527209; x=1701132009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYOj379SOV2UbK9laVZ0cIdfJ+7kdLAIQwa994Jd5yg=;
        b=Nv4V/xDTd7md1BA6Ni3F+r9zWISB33lJg+fWIP6bw4SH4c9xMsrYxixX6vkhW/t5G0
         u2oXyVpns4NV2szh1fh5KV7/oEJcPCo5bOAG+rsxGpt1AxdbBp8tmb/tJhgu9Tdy6kcs
         DLOxyC5ccP4NIrG13QuhrYBq+vBAancpSuRRHfn1d2dRMxbQF+YcpiPCl//3O4ieFt3L
         7UoETVodGiUuUq5eOyB7brvnVg2SuqpMyl8hNBV363RU3wsqPvlzsctJOS2bhfVdnOnx
         NnX600dPR0Nk8EFzFD2BGNpanc4GFQNPMSsZwzuQNYwJGh3Qn7lTFTnWb4sh06W0gT78
         732A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527209; x=1701132009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYOj379SOV2UbK9laVZ0cIdfJ+7kdLAIQwa994Jd5yg=;
        b=b8a7h8NnR1uhDq59hDKeIeLbCSmRtlN8petnNjumamggrDnZXNah6E7zDZ6vIqavwO
         SH9endLGnlWsMi7xVTZv155rjSLrd/lrXjWOswW8ilPYD1n+0sawNw1JEY07LhzFKozh
         fcIJPMjrwYUjq/rETSRbv6SIVH1ga6kEuzq8dreEkrBIqkfY4BqPWYocRzMd1JhO2gbP
         5QKaYHh+M0Ix0mKqZ5R7gwCsMWSlqSYL7SOWyFs0rKdlqrlCVvkYeU/18jYFbjjXpPDW
         xxXpNdxwkf1BGoLmeiKEmoPdU4gV3E9w1YeaBbvMwBEJkg+D7tzHbxNeXeEr9BE1hclB
         skAg==
X-Gm-Message-State: AOJu0YzdS//tiViR11wtFPbI9k/ETzKrCtW9W5LbUP5f0dZajIoNllb2
        KuuNe+xVYHgqXujE6Bwgl0Q=
X-Google-Smtp-Source: AGHT+IEvgLhoaeclWGQbluYzwOZp4JoyP7RhFpckX77W1BHHUivUh5KC3AVkJ82uQaL1insC8VVbPg==
X-Received: by 2002:a05:6870:d3cc:b0:1f0:c29:d75c with SMTP id l12-20020a056870d3cc00b001f00c29d75cmr11052773oag.47.1700527209326;
        Mon, 20 Nov 2023 16:40:09 -0800 (PST)
Received: from localhost ([47.215.232.245])
        by smtp.gmail.com with ESMTPSA id it14-20020a056a00458e00b006c8721330fesm6666553pfb.74.2023.11.20.16.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:40:08 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/7] drm/msm/gem: Don't queue job to sched in error cases
Date:   Mon, 20 Nov 2023 16:38:47 -0800
Message-ID: <20231121003935.5868-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121003935.5868-1-robdclark@gmail.com>
References: <20231121003935.5868-1-robdclark@gmail.com>
MIME-Version: 1.0
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

From: Rob Clark <robdclark@chromium.org>

We shouldn't be running the job in error cases.  This also avoids having
to think too hard about where the objs get unpinned (and if necessary,
the resv takes over tracking that the obj is busy).. ie. error cases it
always happens synchronously, and normal cases it happens from scheduler
job_run() callback.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 2d5527dc3e1a..786b48a55309 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -946,6 +946,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (ret)
+		goto out;
+
 	submit_attach_object_fences(submit);
 
 	/* The scheduler owns a ref now: */
-- 
2.42.0

