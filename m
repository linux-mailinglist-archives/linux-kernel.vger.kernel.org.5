Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB57704D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHDPda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHDPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:33:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EC349E5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:33:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe58faa5cfso1469390e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691163204; x=1691768004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct+HhFSf3JuuA0pS4qW/YHF3pCVOsmudw0iO0Dt49tI=;
        b=O+O0DdJB7gDBLNjPG25N+i5iYBocWpOSXo1e9KKSn+uIzN4wAkWVfWxNpAQshTubR9
         hIsogftgGgdnA573RdL2yI/56LIDgGsrEFwi/idXWw91cGDCG9kdxQ1qOVF88OmOfRBz
         ebA+TEDovyrAC24Acvnr78RW5R3lvnA73XPnz7TaA+MHOBaQF6KsdxZrqF1aYIZH2RM5
         DzPjNzVL+YCdXTSwKiAecoe6klmEvqqyJYM6+wUuOJ9I+TwV+ST5yg0s4DJhWyi0g1Ez
         vDrRPQ4GcQr2jAsH5tXyi003crAiyZfRiJv7wFvJTWzS+i/xLVQUa2A9jvEDarwGe6Tp
         PDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691163204; x=1691768004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct+HhFSf3JuuA0pS4qW/YHF3pCVOsmudw0iO0Dt49tI=;
        b=VQLtsdaQWYLTaYi+LLqTy44Ig+IvIu9J7KuL5xV+wnijNlGc0zmBFZL2cEln65/Agj
         gAneOfSoxQvFv+qKz+xGhSBBCXR10AJiVzh5gKzulVZ89GI/aZCQJMx5chXFQPGilypn
         VcAv9uXc/CT1msGe78nyeHScY7TjpsUCLIwzT+jqCR+nIcakCMbcmctiQjY2yqc9TaQr
         g2ZIPNw3MN7DilRHH+MaxY1R/OI4SYdRdLxWzkCOrF1DfL+JGgFL/FeVMViIp4acfncR
         XhkHzKTay0gjn4A+/PRJU5/cMEOOrWkBNxMmDo6f2edUczsOWsiPeO/f4+hCpNyryWAS
         A1eA==
X-Gm-Message-State: AOJu0YyGrf1Alo71ndaQ2unz3yof8PoKAG1AeIfAq9cAiTN3D2Ghfab7
        c5I82hM+YygYabpt/UOWOvBvdw==
X-Google-Smtp-Source: AGHT+IHEKmz6wgZTpApnn2eeHnpWC8wifjJXIPan0+O+hTJlVADjPVgOzrAW4CFWVh8fXkk9hmfB9w==
X-Received: by 2002:a19:4f5e:0:b0:4fe:89f:cbad with SMTP id a30-20020a194f5e000000b004fe089fcbadmr1431945lfk.51.1691163203868;
        Fri, 04 Aug 2023 08:33:23 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651204cc00b004f873ca4139sm411874lfq.71.2023.08.04.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:33:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     robdclark@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] drm/msm/dpu: clean up some inconsistent indenting
Date:   Fri,  4 Aug 2023 18:33:18 +0300
Message-Id: <169116308155.148471.3951374224625324432.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804075746.77435-1-jiapeng.chong@linux.alibaba.com>
References: <20230804075746.77435-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 04 Aug 2023 15:57:46 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c:183 dpu_core_perf_crtc_check() warn: inconsistent indenting.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: clean up some inconsistent indenting
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b0fe70105056

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
