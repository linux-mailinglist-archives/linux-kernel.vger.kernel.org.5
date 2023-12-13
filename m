Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72928106B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377878AbjLMAhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377843AbjLMAhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:37:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F0B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:37:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bce78f145so7318353e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702427861; x=1703032661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyawuRNxUOJx4krMuVIPeAGsZD64pCzULSxldkl4c04=;
        b=so9U7L81tX9wygfCAlf5taDnYOo6Q7aQPEvHp0Xe01TxPXm8X8kwVUsfBzSqyFWAzT
         mHjbZPjsOw6/Jidc0fgAjoorMoXZvEwQV8iNco6yMbKihaURWWK40L/w/Zw5N3cZwfac
         /jonttLThDQwgtrOdDV/aTGtPKIcsu6TCsY5sT5jvjQemwgjZSLLJQC7+j4INLzsYAPd
         saUPO4lXk2jQ6xkaLTdwOw9XSbu4Mb1Q1vRE/CxeM+tWfHEUSqqJgyQC345ZkDQMbY8Z
         l5gwV+o3lui5K+dIlajk2NHF5YElsE5t79PE+7HCQ8t16IYrQLW/QVMeTGGbQVhp8l+a
         SO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427861; x=1703032661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyawuRNxUOJx4krMuVIPeAGsZD64pCzULSxldkl4c04=;
        b=hf7T43H6MXQFBxLvq32NB6G1zaO0+kNQ4vEQCJVf+KSAt6AR/JrNJuhdhUq5vc9Ivz
         vNQcs1e7a/LtcJj8okG29cpqQLDS0fsB8ao15dJX5+pHBQbLTKrfH5EsWDxsyvgUQR0P
         64ZAZSznbjNRmCp7Qp4SdV4ww/2astjkB6t3nJBHDMEIVGMs1SlEet4g9/k8xkzVbEDY
         /X4t3owHHLlShcUIQakwEQoixARDWd+0dLhxxPo8IAhtyOBbX+JEO3BayzFX2BBbmzNC
         lXzdI5KkDoyvug27HZ/Jw6NDWjEaY7AlxL2PemceO2g8zt5KpW5p7su6KyEWKhWpQNR6
         xZ1A==
X-Gm-Message-State: AOJu0Yyto45CEB/xl6My0hqmUENPA8kHzdOAGhi84j1ByZ2vvxk08w7h
        PJyVW+uzvghPVXY8elEENvCMVg==
X-Google-Smtp-Source: AGHT+IELJg6xtBV3YwWzHW35+oAMMuqoqq9emUlpwuefa9mMo13YdC5VxvXXbHCtbJlZxVgL/oczQQ==
X-Received: by 2002:a05:6512:12cb:b0:50d:1a52:7760 with SMTP id p11-20020a05651212cb00b0050d1a527760mr1929464lfg.149.1702427861132;
        Tue, 12 Dec 2023 16:37:41 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a4-20020a194f44000000b0050bef1c5a50sm1517467lfk.267.2023.12.12.16.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:37:40 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Ratelimit framedone timeout msgs
Date:   Wed, 13 Dec 2023 02:37:34 +0200
Message-Id: <170242755506.12964.11418268791653188536.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211182000.218088-1-robdclark@gmail.com>
References: <20231211182000.218088-1-robdclark@gmail.com>
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


On Mon, 11 Dec 2023 10:19:55 -0800, Rob Clark wrote:
> When we start getting these, we get a *lot*.  So ratelimit it to not
> flood dmesg.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Ratelimit framedone timeout msgs
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e37cb117b819

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
