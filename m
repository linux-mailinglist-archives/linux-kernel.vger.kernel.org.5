Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80344803EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbjLDTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjLDTpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:45:38 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6211F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:45:44 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f9db9567so20448111fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701719143; x=1702323943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL0YCwWLeVAAaS8V6Q9QVlcCyCHJm88AKIY6T+RHXgI=;
        b=wHnr+BU6XBf3H8SDWPtRcVxcqAQWgAVOcrbFqmdhTIbDK18cYtaUCDJoIlXJ8bsL4f
         bWcVEu55vG1m94HfeU5K7GcUe49dXmWoHKp53KgKyzykz6z3/SaO6TyjFeGvBilyPTaN
         P3953tl3wmWReWCpK99Gn6AC4ooMdy8rUPAY2Z8xXzjZcj+MPyM/P0SWDHSFXRJwbiw2
         2/3ys0QPI35KyEJpaNWPVc5kVAywfp2VSt3IEVUsbeYPePy8x2+6S88Bs93PegagRnOU
         x9Vp8VcJBHSqcjefGhI4gCVALMgGm3iekUrTqcUUVXt9ox8Wv0Qd2TukpF1asUErlNON
         VHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719143; x=1702323943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL0YCwWLeVAAaS8V6Q9QVlcCyCHJm88AKIY6T+RHXgI=;
        b=rEaJawNDl5SYY0vJPouiArh9YXExrfdeSkcsTdza19qpUPHpKXmMnUcjiqFkrY9xII
         LXj5HmvOKOLGnbGE8aZGjrzVabb9c23iGrOXQCtMRYXfyaU8YrDYN2NnSCHDkaT2rUmk
         c+Uop6V3xWq/li1/16svCbgjCaVXxA2sd0xFGWclbrgkGcY4He/Shqersjx1uAVH2omV
         ZxqEx8hu1l01SfOvJaiOPdRvYDMSeSghLzUYHskeCCZmxGjIfi7nuArAYgzM8+lqll3o
         KEhJryElM66EyUp5nWk6D3grf9JwgYLx8O+vuK4yTIVGKDqXHBXZsVsYSz/n3p9jc+Z4
         Sopg==
X-Gm-Message-State: AOJu0Yxci2JMNuFXlWJEXFqmEBd+VaiRJUxNupWQhNx+cQqsLusUB+cf
        J0kiXdKH7WD0EQ5DZTtCO1GYMg==
X-Google-Smtp-Source: AGHT+IGUU2+rL+VrrRankPr+xbpBILPjIFZNhDvGINb4xeFiR7O7TGptVO7yxax82e3WI1uhyyeE2Q==
X-Received: by 2002:a2e:9346:0:b0:2ca:1282:d61c with SMTP id m6-20020a2e9346000000b002ca1282d61cmr116222ljh.15.1701719143192;
        Mon, 04 Dec 2023 11:45:43 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f1-20020a05651c02c100b002ca02e43f40sm455120ljo.74.2023.12.04.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:45:42 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: Re: [PATCH next] drm/msm/dp: add a missing unlock in dp_hpd_plug_handle()
Date:   Mon,  4 Dec 2023 22:45:42 +0300
Message-Id: <170171913105.1455672.8865445448285442373.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204171317.192427-1-harshit.m.mogalapalli@oracle.com>
References: <20231204171317.192427-1-harshit.m.mogalapalli@oracle.com>
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


On Mon, 04 Dec 2023 09:13:14 -0800, Harshit Mogalapalli wrote:
> When pm_runtime_resume_and_get() fails, unlock before returning.
> 
> 

Applied, thanks!

[1/1] drm/msm/dp: add a missing unlock in dp_hpd_plug_handle()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/801207c18834

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
