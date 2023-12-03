Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01AA8022D6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjLCL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjLCL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:37 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A1E3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bce78f145so4215544e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602801; x=1702207601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDvSSyhIogsacvQW40yMxNj+Caft2xG+QOP3JVD4tRY=;
        b=lchwMtZreLGThhoWbBgjpK99UDs7tTWCMpat4IjciFU+kPWYZZLqWPuqjt2iiojFr4
         Di/MgHJ6iXAjt99xyLCLO7QYbSghT0bl8E4KFBdwLEIdXWUADbLVXY5YqWXn2iIqLBXv
         1J87VERD5uvxMD+hgmnVtKYK1RN/sBWda7cuOEguDOPBoy/GjH6NBqdv2Zw1qrN4JCPk
         r6SseDNRECe96pGbks2zyrWZlHeUsBCVH+kkkKEGZW2tkPykF6ZyEqDekjSSxbH56Gap
         BtozslHtpvmm40n8WISZvwPJH96u2MYduj3xibP12Sbk5bGTDt2xjwkyMOnrHSUDp5Xt
         dczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602801; x=1702207601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDvSSyhIogsacvQW40yMxNj+Caft2xG+QOP3JVD4tRY=;
        b=GbJuNWtNN2QPChOofHebc0mTDfvsouq9P5LZ2Dem1HXRJyOxy1pQsWWx/84ct7KirV
         2FF/YrDmnR2aTLXqEBJixbKnGVFu/0VCV+I2/aZDQYLLoRvvjRH+CEntN45J73+r1b/l
         xu7RmL1aSTcuacZ2qs2Iza30tPvt8L3Ey5ndsBzvmDsRAwzCmvXd+/gZXO6mL8/lA89W
         PF3vWTJPtBSdT2Ew4W+52RGemWCAFvRHi9Ntw+fgwXfgbKfeiXD9yL7nyYhgz7mX6ErG
         SkMj5Gv+giahTiwvV+GIFa4PdC5OsIMbbKp1etXV+8Orm4PTBWLV1unYW/ZyQ83B/W/V
         DpjA==
X-Gm-Message-State: AOJu0Yy7DaPu6gAOooTdHhFdkysG1fLh8m5VyMKGQC1YzF38hGAj3Vpl
        3gFDx0IbBoe4O/+GeDlwpNXTdw==
X-Google-Smtp-Source: AGHT+IHeQWsaMBnunkzlkzcMxwXy3zyg7txAp2V9eKonjJ9riO+tx8XwpNeNPJTEU8JMafH3go4NbA==
X-Received: by 2002:a05:6512:10d4:b0:50b:f04e:6629 with SMTP id k20-20020a05651210d400b0050bf04e6629mr180503lfg.224.1701602801775;
        Sun, 03 Dec 2023 03:26:41 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:41 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: enable smartdma on sm8350
Date:   Sun,  3 Dec 2023 14:26:26 +0300
Message-Id: <170160265547.1305159.4757803162001385229.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908193314.27008-1-quic_abhinavk@quicinc.com>
References: <20230908193314.27008-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Fri, 08 Sep 2023 12:33:13 -0700, Abhinav Kumar wrote:
> To support high resolutions on sm8350, enable smartdma
> in its catalog.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: enable smartdma on sm8350
      https://gitlab.freedesktop.org/lumag/msm/-/commit/921e32bf6c0c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
