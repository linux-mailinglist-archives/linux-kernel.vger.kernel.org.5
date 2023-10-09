Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF9C7BE699
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377712AbjJIQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377189AbjJIQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:36:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017AB0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:36:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3215f19a13aso4709092f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696869383; x=1697474183; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXZYxUfPWeEMbPPzEeZyYMMduShzQMUg3B8T4BraI4A=;
        b=HXlUt7ulv75Mk15YMiP4PiityU/gLGJC/fQCWK6azAw573f3T/O9MHrRbv7SPnoXRw
         y1udQOkYSJAoCGCl/CBBnjhu7R9AjS0/DADbGYOhswR3jvhtpAKpCr+/6/sh1iHlLTqJ
         a6NkeQ7aTVGwk8NjerjwNbrZy3fVmXCjAj49Cvv8bqBPUqMprz8FCnvcezcUUI3pYfz7
         G5LY9o6i37IMRvQZfuj9muJlmQP9/U6tIilEftE6r2J6/959OsEQrxfaplMNBmPU3V2w
         gUEoUksxbxKDChQ4R0Qxp9YW5eRVezHzKOrsc0Na9MaQjk9X2IrJ6/bMxnVYWhfebPMl
         48PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869383; x=1697474183;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXZYxUfPWeEMbPPzEeZyYMMduShzQMUg3B8T4BraI4A=;
        b=b6lkD8wHj4w0PtOhImxSAYWEUdSYAUQXzpyKDIlhCRMhJzAmKmVRcjY50Y3wjFRQY3
         biLyiXbJLj8mwgtJqTfQZ5mUVwvhjTaco8aYAjwKNk7viqF4behgCAHzT37Quoo6Rjvl
         Hd3p5XTzIF9HcUBxajuu8etytOg4tPGFBsIQj3apFRrMCl13rce8Y8Sw+AAeXRk6ZzTr
         ItSKYFlJ3UYlpatRro9S7WrHM0/lipmzC4z0WpiQeLPvf+Ou8he2DKDmnt1RfH0JPUG6
         lOvkgzGGEa+6/OvIPRGOQI/Z4/Lv7oNQvIpu61KcaTbg90+UFYhEMvrD61EMHsxYnxgn
         Xeiw==
X-Gm-Message-State: AOJu0YzfHw6btVpsryWE31I+TDhK+P5U3oLBIfcnQKeqdyuul7qmeLaP
        uMc5t2qsSnFMEYCuIJ1Y6QfUKQ==
X-Google-Smtp-Source: AGHT+IGfPJmsMImnHmzvAO8xrXt2MI6NFXdIDCwux3FoksfLHJQZ7/IkZmXps3K6YqevUMp8u/IW0Q==
X-Received: by 2002:a05:6000:613:b0:329:6d09:61ff with SMTP id bn19-20020a056000061300b003296d0961ffmr10295329wrb.62.1696869383104;
        Mon, 09 Oct 2023 09:36:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b00325c7295450sm10141046wrt.3.2023.10.09.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:36:22 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC 0/5] drm/msm: dpu1: correctly implement SSPP & WB Clock
 Control Split
Date:   Mon, 09 Oct 2023 18:36:11 +0200
Message-Id: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPsrJGUC/x3NTQrCQAxA4auUrA1MZ1q1bgUP4La4GGNsQ//Cp
 IhQencHl9/mvQ2Mk7DBpdgg8UdMljmjPBRAfZw7Rnllg3c+lM41uC4qhDad69phl6L2QoZmqmg
 6yoo0DlgFCp7D6XmMEXJKE7/l+9+0cL9d4bHvP2vk8Z17AAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WMVu6zB/8xSeIulwWvxZuEDPQa3MLgZ5mjmIqZUD7wY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJCwBGferdDhV/PAijeBb5bJQvrI61bNdVSbUFY5T
 rIoZZi+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSQsAQAKCRB33NvayMhJ0QiHD/
 9D6FIMZpLwfqZp2UUrtb2IdPiquBICrYhqO6Z0k42QZ24cD48YY+DCxApdhmbKAj45y9U34LCHqIMz
 0t4HiA1XQxjjb6kCNEbjxOUpHtQpVIrP+WSi2Ha39/FOmlVT7Q6Mad5sEFLj62cATXA0zMFPdjQ38l
 gIANUQDQhJW+ZBzrFkaJIwy7KDdTtCjd9ot8iKAH/Ta409r0SPUC3UeZv77qdKa4VNIx9qbC041gbY
 jMJzFPBPoh5l8GBXdzq1VKzKyad56vN2vscDd9UWRVQTQ9O3t+O5NQCUa7gIhve1YDVWxsDU/NDFpX
 O40miRhVtStYVtgK/xbOoqoL5QXpd2Yibg9TgoIR+jmqyM+J9WCxyF9CfW4FulQBaR3MAmylpEqIYl
 snrfk0mw7KB6GZ2LybSfehaJovTSZGc/Ndul90gjHHOKnvmhoA//m4e653T4IQeLVPZBkADCaRB8Mz
 CM2J2PPv/3jvMTTOVmRkrRhIdarjkJY72Zc/wq83Zn8NvO8M1ey8NmVWydmjjlXjlsOdxe/SwSH335
 qadfr9V9BpZw9pOj1nFqXACjlhgxyuqXdwN4sA1arWikzd2HRJOYqTOtmCs6ahZG22Xiu2f80zvyz+
 R2Q1+8VqgVbbuVc2dvVrbbSQ3X997muyXa2jjW8+LvbGXMTwTMRbOxp29gqQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with the SM8550 platform, the SSPP & WB Clock Controls are
no more in the MDP TOP registers, but in the SSPP & WB register space.

Add the corresponding SSPP & WB ops and use them from the vbif QoS
and OT limit setup functions.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (5):
      drm/msm: dpu1: create a dpu_hw_clk_force_ctrl() helper
      drm/msm: dpu1: add setup_clk_force_ctrl() op to sspp & wb
      drm/msm: dpu1: vbif: add dpu_vbif_setup_clk_force_ctrl() helper
      drm/msm: dpu1: call wb & sspp clk_force_ctrl op if split clock control
      drm/msm: dpu1: sm8550: move split clock controls to sspp entries

 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 35 +++++++++-----------
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  4 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |  9 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        |  9 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         | 23 +------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        | 21 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |  4 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          |  9 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h          |  4 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  9 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           | 38 +++++++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           | 12 ++++---
 13 files changed, 120 insertions(+), 61 deletions(-)
---
base-commit: 9119cf579b4432b36be9d33a92f4331922067d92
change-id: 20231009-topic-sm8550-graphics-sspp-split-clk-43c32e37b6aa

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

