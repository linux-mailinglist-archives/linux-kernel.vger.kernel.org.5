Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFF809894
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444216AbjLHBZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjLHBZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:25:16 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1461710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:25:21 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2cb20b965dbso3527331fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701998720; x=1702603520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUBLaybwTm71uGPidtWtYcj7suB58tDThikG9Ry5Y4U=;
        b=UFgbV/f06Uzb6gF5GLkrzYH/G+swr1ZS6mlfHH5QjXSJGTiCMgxvLd8g0Jfq+K+MX1
         tdiPBHid+z7+Zerri4o9zBWzpQrIZ+1EqwO4GTThBhFqSjmdPXQxCZZRO6mn9KxU0pX9
         KdEm+rSgsXH3l1eUzIC/hzngULRVCdYY+p+nzUaPnoNuT2XsXzR6/NvK5fakkgChPiV4
         jhBcss2ZhLoo2bAli/OXl3KQneUJetSBko8ME55VOdwN029oxL4IQf+wnuRFUa0LMWpl
         jbxUziMI1CtRtq0DX1cr7B6XzoYsH9FSOZtgMbzAT6kJDjtfO/Dop0SrpUfMOjBreBbI
         JP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701998720; x=1702603520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUBLaybwTm71uGPidtWtYcj7suB58tDThikG9Ry5Y4U=;
        b=GEJtC3Qid7fJCto47ZOv3YRXQhBlyJbVvrtcGH63ogrEybJUfngl0M+qNy5xxznFKt
         MjZ6elBec6oZRxvF8z96G6aRr59ky2WLqXW9TOPXNFjisC9ZaH10owajP+VmjTTMLB+z
         7QadEXzL6I4r0CVYCmot0MqMUkp5eR5ivHW0mRrjZbfFDVnNHq0wjTq92zo6rYQ21aSq
         0qgSfDoFfdeOFLcFqb9SPjBypvd8oBrRXD+qyX5xXA/7jOi/vcAWjK3stj8+izVaw6bZ
         tNXrY76nPfZTRC085eQSonHn5g2gYDp75N+KgagZ6LoyTC2JA1ukWGUChXFneZOXaYAP
         qJww==
X-Gm-Message-State: AOJu0Yzmj8WJYJ8uMFpowsZK35dRn8aNaRG741Fxn9g1As5AXoXtSXrZ
        ENjbaRn4hzL+MzdaqCpwst6IUw==
X-Google-Smtp-Source: AGHT+IF9bDKrRKCba9gxrOM/tv9o1YC1+NYXv7vs1r/qhP8tdOvA0jMXldtsflhEAx2LflOS1OjuMA==
X-Received: by 2002:a05:651c:111:b0:2c9:f427:9e52 with SMTP id a17-20020a05651c011100b002c9f4279e52mr1019018ljb.134.1701998720030;
        Thu, 07 Dec 2023 17:25:20 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g26-20020a2ea4ba000000b002c9f58169a8sm88639ljm.120.2023.12.07.17.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:25:19 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: Fix platform_get_irq() check
Date:   Fri,  8 Dec 2023 04:25:17 +0300
Message-Id: <170199868355.3399536.717291970669174612.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <c12bb69b-d676-4345-9712-48aab48f2b48@moroto.mountain>
References: <c12bb69b-d676-4345-9712-48aab48f2b48@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2023 15:02:05 +0300, Dan Carpenter wrote:
> The platform_get_irq() function returns negative error codes.  It never
> returns zero.  Fix the check accordingly.
> 
> 

Applied, thanks!

[1/1] drm/msm/dp: Fix platform_get_irq() check
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c4ac0c6c96f0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
