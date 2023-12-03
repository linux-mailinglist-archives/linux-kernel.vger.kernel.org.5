Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A98022DA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjLCL0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjLCL0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:38 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25766FF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9eca5bbaeso12852651fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602802; x=1702207602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WSOjrDN/6/FPqqfnjx8kzs7rgpm6bARfoNrfKT8u5o=;
        b=wY6DJRqd7I9nU/n0JJVBF07JVrKVCfdeWjtfUxL0fUI7aJfdYuNcO0trvhvUtsKG1I
         bSoKMoRpffuSabhkSrx7Zz5JMTV/oQh1Xt3Ubh6f4vinX9vLgruq7nu3J2CW7M71iS1h
         mzoP/ZELBlkO7KY4Z/4rMViZH8d2gZmnpPKZR041SzKKrwbVFLykbJu6GN9lWqZpPtoz
         Ewe+xWTIHWVB4VCHl5AiSZCA4lmwG2j2P18oo96B2fkLYBZbgky+NLUAMbjanHyAJHMc
         CixagGyMSeJGAV8CJZnktnkxeF1U/7cHezcGud+z0Eh3UWJuvkUdai1e6ll7RTXco/Ko
         T3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602802; x=1702207602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WSOjrDN/6/FPqqfnjx8kzs7rgpm6bARfoNrfKT8u5o=;
        b=K34Sw8oHnYtUGQ0e4iCS76qk1r4tsGnI3QMwvMI/N/+02wiP2ZciLWh4ko2jezB7jN
         hBZmwA+DiHqcBWjnHNAgxr1s51O/6zV1QKDh7YxI8atqYrZ8Tx7x1o47H971+L5YV7e4
         rocl/Wcngqao3k7B+QFfNh0FWs+2iXm5366YugYeHjNmUeJWyRSAwdMLnEl64kheN0H4
         +V/qQ8mOf2e3vvjtbb2X58rEVTpigjo6kLepryCB/C+f/biPaSsvEW1SmhC7esoVQ3e4
         jyLf+HcgtdRvJ7CSK8VJTu3N1y6//0pGYdDilIi8KdvPGKSXlm6/uVGJe6RN0CcjAnz9
         5ssQ==
X-Gm-Message-State: AOJu0YzMz6Tm80tFpjnVQA0lgd9uLXHgpuUjZ9lakt4D6y+FwekkfREE
        QR5pk1GO7HEsaf8J+tBbDTABXg==
X-Google-Smtp-Source: AGHT+IHynZOlSfJkcuHWfgzZaQed2kczEHlHE2eWDEQkdE5lbgHNM141ZJ4rYNfMifeay+hwSL6g0w==
X-Received: by 2002:a05:6512:4894:b0:50b:e88a:1092 with SMTP id eq20-20020a056512489400b0050be88a1092mr290454lfb.174.1701602802514;
        Sun, 03 Dec 2023 03:26:42 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:42 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, nespera@igalia.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/msm/dpu: fail dpu_plane_atomic_check() based on mdp clk limits
Date:   Sun,  3 Dec 2023 14:26:27 +0300
Message-Id: <170160265549.1305159.13000009091015495983.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911221627.9569-1-quic_abhinavk@quicinc.com>
References: <20230911221627.9569-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 15:16:26 -0700, Abhinav Kumar wrote:
> Currently, dpu_plane_atomic_check() does not check whether the
> plane can process the image without exceeding the per chipset
> limits for MDP clock. This leads to underflow issues because the
> SSPP is not able to complete the processing for the data rate of
> the display.
> 
> Fail the dpu_plane_atomic_check() if the SSPP cannot process the
> image without exceeding the MDP clock limits.
> 
> [...]

Applied, thanks!

[2/2] drm/msm/dpu: try multirect based on mdp clock limits
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e6c0de5f4450

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
