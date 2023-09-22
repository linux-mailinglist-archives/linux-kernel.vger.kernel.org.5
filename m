Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F47AB7A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjIVRdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjIVRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7903F10CC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c465d59719so20697615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403941; x=1696008741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWOiU92ExO1tEuVJ2ItejZKQh8uiQWENZYmfi07W000=;
        b=JeGuage/XRPpc10At0lUzGhPQbAFlcAZX7wIxfVxlKoIxOhmhgbH4AVVfBzrHqzNZy
         lA0OMDy2yGlHJuhAd40L6xTJAvmD16UdexOnZQRZOxGAS5Y6J88fe49OHgEl9Ts3xnSC
         UjORYZrwp0VYU/JvjeE7KlxxJzXPS00f1KuTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403941; x=1696008741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWOiU92ExO1tEuVJ2ItejZKQh8uiQWENZYmfi07W000=;
        b=pRO44rzu6sSRQziqO8DOSca5d+LdofawkRx4p6mBUKw+voQsgQC+YfqqgVv88coSwv
         8KUyT5hBY6uB3RaFHplX62TqVh1HmIcTIlxFK2H8Q6CUmfEZeNgXIngYFRbnQVAHhzGH
         yzRVgikEMbXVz8cE2UIAbxQg3mX0zLhWtTFVofPOCPLYFd3JOzIemxxW62mJByOYxZO0
         QlvjFAfvH8YbZjXvAajioFf8U0cwJ0y/IdMvJIehPosX4ITiCBDDKXNT1maxvBjBhBkr
         kbFmvlfkJ7B/O3IOcrUGrzX7fPvYRYExbMUEGlrKnEyphzXAC1Oh74xWYm8n9jPnSfQz
         TM2g==
X-Gm-Message-State: AOJu0YxhXkWnkFs/d1OqIyIdg1S67VU30XIUWAmFcb8nXcSwtBpWIzuL
        iHcKi8z/Bhras321e1bJkcigUpaiUMtd9mBg5H0=
X-Google-Smtp-Source: AGHT+IHAWZxxxMwog0RsNTP3ViEwRcOmpj3co35u4pASeilOSErwEjBP6JitkXMrTa/N4OpgVNA/Tg==
X-Received: by 2002:a17:903:2281:b0:1c3:bc2a:f6b4 with SMTP id b1-20020a170903228100b001c3bc2af6b4mr173767plh.42.1695403941600;
        Fri, 22 Sep 2023 10:32:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001c5de42c185sm2815588pll.253.2023.09.22.10.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:32:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Airlie <airlied@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Harrison <john.c.harrison@Intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Melissa Wen <mwen@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Le Ma <le.ma@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Prike Liang <Prike.Liang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
Date:   Fri, 22 Sep 2023 10:32:09 -0700
Message-Id: <20230922173216.3823169-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=keescook@chromium.org;
 h=from:subject; bh=xDkJWau6qmNIlEczl2n21zh31yaWnnGb4ZbtRzkDM5w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+eutUHe9SLnXaUpaJySdpFne687ECfxzj9x
 c9gWcqZLYaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JjnbD/9OQiE+N5TDN74IQPEo9SgzH0oAvZBxcgjjWQ+yn1SxoSDB5LIrgeGtiyQGvx7BYlpt+Mk
 MT5bPfHehA9na7K4kzqg9quYRtDWvIN27rP/uwZxsg6q5pZKW93YRamZq1G+itcAKW6RA20Gl5L
 oXzlXw8xjsnhIYhIM57Pko4wOg7e7p9M1OFiWoZvPmi3jXsn0iVx99yrPXIgM7uK4j+SGaJVO/e
 Db6B/ovadEGxmj6A5SpZjflvdzGUHbCnD/wxy8R6PCGroCHj+rG2bB4Bzu1Bz+aXu2YhIKPBoAr
 CfA7YAuzv8p7/Dy4rMzzOl1WMQu/T5Rh5tIJo2Eg44ksRdJK4w4OJBgr+8wPd1dntiatR4Ulsgn
 ZfRzuaLWVaPb+FcgFpd7LGX/chEK+f5iu5eFguQ8F1ZvI4wUYZ1dYV0HliOOkBFszZQ42WITuND
 M88ZKBxyD4ccXy0nUhHCMZsLs9jr152hzbB82sQrCyl+qJ7p0yYLaHOjzT6CRZvzNUXk0DrXNdf
 cM+AdoWXZHFWhEsT+HLVIWg+oEAfqN+3W2w08etC077cqQ4Kj366BbtIh2HIlNX7LYF3uztip5O
 Cy/EA3VNLkh7U/Gwv7/PDy6HCSs6sJ32cEGquxZ7iLKQf7SPjcZHlBvml7AJOep9Fs2EukYfNDz 1KplYtpYhU7H+uA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct dpu_hw_intr.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index dab761e54863..50cf9523d367 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -61,7 +61,7 @@ struct dpu_hw_intr {
 		void (*cb)(void *arg, int irq_idx);
 		void *arg;
 		atomic_t count;
-	} irq_tbl[];
+	} irq_tbl[] __counted_by(total_irqs);
 };
 
 /**
-- 
2.34.1

