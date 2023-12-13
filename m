Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558A08122A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjLMXLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMXLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:11:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1818DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:11:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bf26b677dso7284434e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702509073; x=1703113873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/j1Onoc3138zJnsU8yDEiGjQqVsbV45Cqho1Gb5ccE=;
        b=CY12NKHirTZd/peeQpXugxANJZ+D4q5OPHO3Cxkol5PMRsmpRFLaNV9NU5GTg2LLwv
         JaorTwRE4USK+qjeibdMJ1Z3a4oBynyhR+MC7oTy980u95PKFIUVjHpmpMcNsG9CPNpo
         TVqatkRTIdgO0gjem54LbvODpg+bL+bROVRKNLbdjgUNOmkxjlNY07DOKsnEd8NvmB9N
         jr1BvH/f8aJdGhF5b9tF80UswG0G4RxB8WQni5rJhCQc4Llng9UMm1xjNHmhBheWC7Fk
         ia1mwl7t/tlmksqK9ReTd77Hr0Rd/i1ZXd0zmqWIuLNJk0zq4ZHV1x+KXzK8NvvlKHyg
         Hmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702509073; x=1703113873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/j1Onoc3138zJnsU8yDEiGjQqVsbV45Cqho1Gb5ccE=;
        b=xQa27dAFszSo8O+BWRxY0tQzaZTPzG9TmHT7RTPAfWNONjkFdYl5mD9stz3YxCx4Fr
         mVOjRX3NUNFOOWS8MrfGYsQS958UxyaZIqv8XAD2MQU9HyWhNujF1wyZWCstr8jfstxj
         SvZcGrioEj6HoJsjK5PyTKSZsvKb8q3whrkle8WsembRT7ukIBY5nShO3SC0k4VYczcv
         4YSfNhgK2P5d9q7e6VyQzVpJr4Fl4x/2Wb0sZR4TkYj7olAY5BB3gp+CELMNKLHeOiiM
         8lfLBVrSFYe+WxjPeH5e8qEVrQ397CMvjywqkVTO8z8Q98WYiW0zgwVJDj+Rdf0y2gaA
         Fl6w==
X-Gm-Message-State: AOJu0YzOpKQtpUweSeY9fDtx3nD54Qm3vi5qOAs1u8GA8o2F90hx3Aph
        mOQvfg99L6Vuf6GtaN+6BGuWWA==
X-Google-Smtp-Source: AGHT+IEhLGLbpNE5ofHBlyMYQRBnTcLYD16vUtw/hL1PzWKS86x81znzu3niMguSuXMWF+hvlixwCg==
X-Received: by 2002:ac2:592f:0:b0:50b:c2ed:e28a with SMTP id v15-20020ac2592f000000b0050bc2ede28amr2806480lfi.13.1702509073150;
        Wed, 13 Dec 2023 15:11:13 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u17-20020ac248b1000000b0050c031e2873sm1735908lfg.288.2023.12.13.15.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:11:12 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] drm/msm/dpu: INTF CRC configuration cleanups and fix
Date:   Thu, 14 Dec 2023 01:11:11 +0200
Message-Id: <170250905097.800728.11004644949884575762.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213-encoder-fixup-v4-0-6da6cd1bf118@quicinc.com>
References: <20231213-encoder-fixup-v4-0-6da6cd1bf118@quicinc.com>
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


On Wed, 13 Dec 2023 13:30:16 -0800, Jessica Zhang wrote:
> This series drops the frame_count and enable parameters (as they're always
> set to the same value). It also sets input_sel=0x1 for INTF.
> 

Applied, thanks!

[1/2] drm/msm/dpu: Set input_sel bit for INTF
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1b932e07c321
[2/2] drm/msm/dpu: Drop enable and frame_count parameters from dpu_hw_setup_misr()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/e5c08a41bcf3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
