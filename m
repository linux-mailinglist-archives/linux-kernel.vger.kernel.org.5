Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41D6772C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHGRNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjHGRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AC199C;
        Mon,  7 Aug 2023 10:12:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6877eb31261so3425072b3a.1;
        Mon, 07 Aug 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428336; x=1692033136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXZWjfN9jRVe+H33im5sYKdcYpl83+nexah9W681kvs=;
        b=JxtZ0TOHGdOvBVososgY9Zy15pOWAkF7x8gemX+XNHlZcmEwUGJH6gS7S5u0636e08
         DiOV4aG8XKBk3aaL1ZVD2tiUaTPI4gMubJmq7Mf+JpRTj/mhbtWlFt1qLc2v7ofqYi9t
         RgK5Ym7wckZkEwX/gvnpwuxMT77wMtDJbPIIqtaOpUGM0EWb8lnlk67dEBK4XSbfidgo
         p/Lj6BMenBt7K/mvIRlCIIaM5NFCKtT8GCuCba+blaWeK8LMDukx8oHEyivtwKyHFaOC
         8YnI1Rh7Y+KYIKJdx/rIQylrQUic0EKQNctdRw4RtQh+uRsx/lrMKyfUtbbVPy6r/06n
         +3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428336; x=1692033136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXZWjfN9jRVe+H33im5sYKdcYpl83+nexah9W681kvs=;
        b=cy1bcnJXfmtL9HVpiqQfhrLd9zgtHX4+75yH7N0rWVrgSy9Bf6l/9lQ5UhhNsacdto
         Xcqf3bHPiKCCpVUNco9UZ3/YB0YuQqCzjzB+jCH4QYrbIpDataTRIa4FQaBIwd6E7X9C
         +LObSCbQ0vnKwU2MfWXHlMjLLUHAfZtbtwc1OFIyL5rAwBeqO/gJAtKRfXfqiEVB8xH7
         g7K04nTJgza9zBcJyI4N4e8buRiKYgHe3YXCih1BV7l9BC/J7HGHfAQHiUZEG53GRNSm
         Ynvjj16uGz3g+Z1xBtn8gIxuC6p6zdBI4ACo0fow6Xqjfmyn8sykXRHmGOC5hx2dsPzM
         EGQA==
X-Gm-Message-State: AOJu0YwAlzvkbC72ps//GUgnI4+ZIRQkqxkBXO0fSfPbhtnyjO5nFZ9N
        sqtCf7z6SkC8Kh8vDVzMM3k=
X-Google-Smtp-Source: AGHT+IFHBNbwLQimjGOtzcaKvIByqk/TQzJWCN/W+g5iL3kJg/6pWmYPHRMzc0ZNijBedo2YSdDiqw==
X-Received: by 2002:a05:6a20:1604:b0:13f:4e70:ad48 with SMTP id l4-20020a056a20160400b0013f4e70ad48mr12770238pzj.52.1691428336288;
        Mon, 07 Aug 2023 10:12:16 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id j8-20020aa783c8000000b00682c864f35bsm6624048pfn.140.2023.08.07.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:15 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 9/9] drm/msm: Enable fence signalling annotations
Date:   Mon,  7 Aug 2023 10:11:43 -0700
Message-ID: <20230807171148.210181-10-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807171148.210181-1-robdclark@gmail.com>
References: <20230807171148.210181-1-robdclark@gmail.com>
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

Now that the runpm/qos/interconnect lockdep vs reclaim issues are
solved, we can enable the fence signalling annotations without lockdep
making it's immediate displeasure known.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_ringbuffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 7f5e0a961bba..cb9cf41bcb9b 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -97,6 +97,7 @@ struct msm_ringbuffer *msm_ringbuffer_new(struct msm_gpu *gpu, int id,
 	 /* currently managing hangcheck ourselves: */
 	sched_timeout = MAX_SCHEDULE_TIMEOUT;
 
+	ring->sched.fence_signalling = true;
 	ret = drm_sched_init(&ring->sched, &msm_sched_ops,
 			num_hw_submissions, 0, sched_timeout,
 			NULL, NULL, to_msm_bo(ring->bo)->name, gpu->dev->dev);
-- 
2.41.0

