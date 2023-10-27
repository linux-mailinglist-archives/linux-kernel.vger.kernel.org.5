Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F407D9E56
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbjJ0Q7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjJ0Q7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:59:22 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C971A5;
        Fri, 27 Oct 2023 09:59:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5ac865d1358so1909468a12.3;
        Fri, 27 Oct 2023 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425960; x=1699030760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu1FhjWQAAQQu/erPFOwuagpkPUc4fNsZ+YMm7C14LI=;
        b=Z8Px8FgQIUfLikDfmRD+S+Ca7zUkT2G3MvDc3Er6y2m2MQ+ngRbFsTtXlmofrc26vd
         nc24McslOsK7fWtBVfkJwYbSLGPetHBHV09phZ64Mu/OkFdMvrC/t+xSnAA6q8A8rBuL
         fmUaKqthzl6zBJv2A4aRWPNrvUKs6NtUFTLbQQy3wpInTikdZ8nxT6vsL7HKPIqdREpD
         kw3Mb9EDZZU4lR+HgtZUbVKaktkbDYfsg7CCzKcYWCNgw/s0H2uvlJ4iT6srig6clmxk
         mSTPek9De1+FEGi6/aKk4aWWGcrk8aSYUotPW73QNPrW0r3Yt931XYsbS+i39bzmwpAp
         ur/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425960; x=1699030760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hu1FhjWQAAQQu/erPFOwuagpkPUc4fNsZ+YMm7C14LI=;
        b=f2IGeS3g4HCMOParykFikm4JosohtcmPTMRGTCYEIp1gjJyiPRXZx//aj7IQZGg2P4
         r/ihpjje2q6MMQaYrLNJUIz096ZdCp9YJdgsl5eeUYZaHfM5dwPquDK3FBJFlKSHIDXD
         pS+R2bVG3I8wheHZV2qOap9msu1YnUzIo5mx6QbvznG/aJmJOFpi3MrUwi3BgwtcNv9+
         32qOworrJ+mIkvWmAD6Oky+W3lVgCNt81X36epehCONg2UQZAW0bCJzqLcx9aOt8UXhr
         stf5I+1QoWk6d5lctXuoQ6psU9EuiZ1CJfJrOr2kexJ93HfkWAoalneoNV5TlHIgLhyx
         DkEg==
X-Gm-Message-State: AOJu0YzpUjgCtCrLuhiNHNnVmumsMSUaSLm2Cs66sL8wkFaYQWSjRUfn
        qq5gscFLm3dVriyBu8sDcVQ=
X-Google-Smtp-Source: AGHT+IGq/OT51OWFTDYcHIvbMyrTngDK3vmX2a/+eGD+RvH40j5mBW0SCq03abTpvLoM4Y/jLrb/8A==
X-Received: by 2002:a17:90a:77c2:b0:27d:5cca:9b69 with SMTP id e2-20020a17090a77c200b0027d5cca9b69mr3056136pjs.45.1698425960498;
        Fri, 27 Oct 2023 09:59:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090abc8500b002800eeafd79sm1301858pjr.52.2023.10.27.09.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:59:19 -0700 (PDT)
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
Subject: [PATCH 3/7] drm/msm/gem: Don't queue job to sched in error cases
Date:   Fri, 27 Oct 2023 09:58:37 -0700
Message-ID: <20231027165859.395638-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027165859.395638-1-robdclark@gmail.com>
References: <20231027165859.395638-1-robdclark@gmail.com>
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

We shouldn't be running the job in error cases.  This also avoids having
to think too hard about where the objs get unpinned (and if necessary,
the resv takes over tracking that the obj is busy).. ie. error cases it
always happens synchronously, and normal cases it happens from scheduler
job_run() callback.

Signed-off-by: Rob Clark <robdclark@chromium.org>
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
2.41.0

