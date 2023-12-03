Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0558022BD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjLCL0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjLCL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:33 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5077FFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso4790470e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602797; x=1702207597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYGb31/GvDPJsBFOKGrOafxuEsUy0gUvwyHcMJDnEIw=;
        b=C3Dt6dH0GoHne2XM5ZxLsDV5OeQAJQb114Db7l9SsOSjdYjLwFJnXP55eq5NQ1t5Ju
         H8Xgorfwpi6c9dKqrk4A5jHEMzalY3NGNMGc6l0ULDpn5Ifno0M9qM0P1Qg1UgvxqhLr
         EZQ8c1l59Rrdrz/5SG+u6Qc77ck3iT9RIIa55CM/BUHRav7ggZNc3kqJTPYhpYUT8YJt
         wRHGSWmsDFB2IzcaifzkEtMCc8IaKjf4FZXFa4SEOsd3AtRv1fkaPr4dFjmjxfoH4oKO
         ASb0hkQzr2XNFOKTZ5Nl6fYUPmYffxqjviaMb/qP3PU3ImPPgL9ANwVxiPcN1fExFk80
         07bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602797; x=1702207597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYGb31/GvDPJsBFOKGrOafxuEsUy0gUvwyHcMJDnEIw=;
        b=hmrQ8TmWuP6f8cg7Q/8SK0WmXN14C0MJ6jg7JNjt3reKAZ1OmaA/ufV3CRW7xQZtIp
         lfCTL+V+F6mTwC2ePvAt0FYy67T3tmgMe5OXpqozR9wr+kSurnM4ViTOMOfm5RYUaA6I
         ihNIlhGnaGFmL163lmd8J1wJtLejqFhacrojD9FCXLoByirrtV29Q3UvZpaR5loFPXiO
         Irj+to/52fapALKLVsGZVFh00EZFHALMpjI5j/VF0onscODWsOowlLcuaAgMmBYRATmF
         KbXd9niOeeVk3LwvGQ7V0mHsnR1bFinTfo/Rht83zUVvapHgQwjFr6dJKi28uqrKHf4n
         qlLw==
X-Gm-Message-State: AOJu0Yz0pejJWrW4y015US0L9TVhwxj+Lp1Vd88CDK/mUrqU/4sG+7bo
        rJjBjWdADDh2p6+SYxLTDZk05A==
X-Google-Smtp-Source: AGHT+IEizxhWQJi3VQazccosbJ0mirj6XMMfi7nH6/rfvt2MEcHPNTAfYO5Vehd0QrtjXGShm8OT5g==
X-Received: by 2002:a19:ad4b:0:b0:50b:d336:3170 with SMTP id s11-20020a19ad4b000000b0050bd3363170mr1969173lfd.12.1701602797619;
        Sun, 03 Dec 2023 03:26:37 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:37 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] DSIPHY RPM
Date:   Sun,  3 Dec 2023 14:26:22 +0300
Message-Id: <170160265537.1305159.8541320986435504084.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
References: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
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


On Tue, 20 Jun 2023 13:43:19 +0200, Konrad Dybcio wrote:
> Some recent SoCs use power rails that we model as GENPDs to power the
> DSIPHY. This series attempts to make such configurations suspendable.
> 
> Tested on SM6375.
> 
> 

Applied, thanks!

[1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3d07a411b4fa
[2/2] drm/msm/dsi: Enable runtime PM
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6ab502bc1cf3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
