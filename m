Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74048022EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjLCL1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjLCL0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:26:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462BFF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:26:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso194508e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602806; x=1702207606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QBSxCXVzh9rXO4c/SO8NkEBuWtu15Ry8njynJOrfsY=;
        b=yfMwrGeZGwqMbpf9++hxuUmOnqXfa2Q4hmOCGkJAUZH+dGocf0UuSaXRgsbn9yaLSl
         amPtjnA/Z/c3wPcEIDTjF4lVtveIOJiA/SxjZuRpvlnKbvEhk0NSNghe4XL3NMOJvble
         kAXI7pJbrlaL4mzSB7Pt7dRDKIEmxl3gADnqplJc6X+4/Lny+e59tpt2FnkhhNqkhl4g
         Ql1izrneDpIDOV4PUIfdGAF+MYgdl/kAmt98+JHwo9Pv2WjKnMBnN+x3mK44OpmqBNKS
         9jUJvELozU6xjm4gx4hoSHRKZNvxWmkd5CQkzcY3UROFNuKVXVUrtfCDkejHoAAskHXn
         f45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602806; x=1702207606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QBSxCXVzh9rXO4c/SO8NkEBuWtu15Ry8njynJOrfsY=;
        b=K0/sed8s5tFJFwiEBoFC0YBV2EHaMCBkwNNIyTqE/ZH6vHuy2nqegRqYLHMmI2B9le
         RWHDiGNALfyFZle5yaVktaqZtzzQPo5L4q+/F7fEHIkwfHLRIiS0cQsOM6j6AndzFbTs
         Mt1zLieEJbOCTuyBKe1+sjyXigkIBfGBByGYbx46uT/j7QJ7p0rf15lq0yr1DhHDCWAn
         2MUkXVKXWIwXxHyb6/HKu8bxlTpYkZI0MrBKnqCcH9X0MEC5uaTjm1J3RAdOdUGRBJdB
         6i40q3kjturzLSnsyyfpAFWHNuq40NEab3s23AXZPQseNMxRS7T0emUs+rU6KVxqbJ9Q
         hj4Q==
X-Gm-Message-State: AOJu0Yw+cVE/d2a53gRHR/ne7tWXOB0S7ypTY4bWbeaLVXGTT2px5gPw
        Xo/sErT3nGt82VcJICO+58fIGQ==
X-Google-Smtp-Source: AGHT+IE7GxPDS+PrjdIRKoKcXEI0G00AkJ5kcwKcMEX1WNFa5xkbSILxwpIRZxmX3UUZ53Rok4brKg==
X-Received: by 2002:a05:6512:4019:b0:50b:debe:d35d with SMTP id br25-20020a056512401900b0050bdebed35dmr756886lfb.133.1701602806015;
        Sun, 03 Dec 2023 03:26:46 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:45 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Correct UBWC settings for sc8280xp
Date:   Sun,  3 Dec 2023 14:26:31 +0300
Message-Id: <170160265539.1305159.17862781249540372821.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130192119.32538-1-robdclark@gmail.com>
References: <20231130192119.32538-1-robdclark@gmail.com>
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


On Thu, 30 Nov 2023 11:21:18 -0800, Rob Clark wrote:
> The UBWC settings need to match between the display and GPU.  When we
> updated the GPU settings, we forgot to make the corresponding update on
> the display side.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: Correct UBWC settings for sc8280xp
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0b414c731432

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
