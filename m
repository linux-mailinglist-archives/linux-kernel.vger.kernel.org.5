Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042E17F6049
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbjKWNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:32:16 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09780D42
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:32:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50abb83866bso1068088e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746341; x=1701351141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Q3RZYDKc2FsZpbY/DwgsOyJU0rLY3O3P98wvrreFk=;
        b=GN91Olpl6/5oqv4Tu0Bu8IBq9Iv+CY4EJCjk2OoTvz9Bgxvbv8gjo9p7ZTfLSB3o+o
         ITenqo6/BwFDrtsDICL2xQXeYrmhpVs4JlEI5F/pHKyW5FYWG3pY2lNmk1DlzlovVcnC
         YlHb1b/LVH+h8uCLMNYjOwlkGkfVXdmF8O/WMG34qein3AjXgGZggWmCu9Jmj7Uc9vAx
         inp+0HNr58ueOmNRikC8gdYh4zJMjYAei2/nefEZz7ggcQbNam3LzkvwVNL5FGvRFH5O
         TL6ymqeBF6nHSaHgrLiqvPCNeZy8KRY3dtvea9hmKsr7o1CqV8p0tcH8ae1PJ3nTmY+r
         Lpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746341; x=1701351141;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7Q3RZYDKc2FsZpbY/DwgsOyJU0rLY3O3P98wvrreFk=;
        b=McLp26JE3bboaUH9s5D6tIFpTRydXVVUn9oCYtFXpWgIVmRPdnAhY7otnx4uC9uH5h
         ouiUwVgl0bvAKwkCp2hxh9jsWoNtx3I7FDlQp9Ji17spIUfwEi0v8wcG8X5gpl35o83l
         vPqXpPRaa0lfKDPj+apJiicy/GJJCdMF4KVv3YRUF70J8VUbS15vJZxNR2ZzVrqKMCkh
         sh4ghCGeZmGQnguns0HtoGT8K3MrPwD+rfo+XNZNdAzFOQZB7Yx07t0IDCRpqrHu3CEf
         zh91UtLjrBZqQ0rdC57NqgWLM6k2AqxpAeyg4Uo+EG+vHRXIXsLqLpW+8wAkn5HQn7AB
         ZiCQ==
X-Gm-Message-State: AOJu0YzmSY55BaBwSZWrGxTPXxoCA0lEkuBQQfTc3PhM2aAZ3iJpTb7/
        8Z70BEebdvyh/BpEUC+C7V7FdwCKScoaLuXxHI7haqf0
X-Google-Smtp-Source: AGHT+IF40R3U2MxW68uTyxmtH1aJIFALjg4sxuSt8tZUriPCQEjkscRmm1ZCvWzkHU54ByIf9xZyKg==
X-Received: by 2002:a19:e05c:0:b0:507:a0d6:f178 with SMTP id g28-20020a19e05c000000b00507a0d6f178mr3590022lfj.35.1700746341165;
        Thu, 23 Nov 2023 05:32:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003313a1e0ba1sm1647658wrw.89.2023.11.23.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:32:20 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] interconnect: qcom: Introduce support for SM8650
Date:   Thu, 23 Nov 2023 14:32:11 +0100
Message-Id: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtUX2UC/42NSw6CMBQAr0K69pl+UkBX3sOwqOUJL5GWvFaiI
 dzdSjyAy5nFzCoSMmES52oVjAsliqGAPlTCjy4MCNQXFlpqo6SqIceZPKSpra2E55wyo5uAQkb
 2MQT0GVqrdN+a1tuTESU0M97ptU+uXeGRUo783p+L+tpfXtt/8osCCbdGNw1K45zpLw8KjuMx8
 iC6bds+kYh8aNUAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xj9eEaLtiaHWn0GWa1onMQEQ+NWKsOyiMFekEju5+wg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX1Ri8Lf52DJM+paX1tAzv50+Vjq7jvSF9RTJfmtG
 4MIwTB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV9UYgAKCRB33NvayMhJ0VcFD/
 0U9Xo4OUpX2uri9oaJq6iX1GZbIp3PQw1fFV/FJqsiIA8b2qZb98iHhZfqip/UHRPkBjF0sPPM4r1A
 WuswVNHBrRgEP2FBnA7YTjoI+qZ4Ew41oEDZ2Y0GBB0X4yXGTP2VJigVRrczIMu8D9SS+ClkkXtYOe
 z7ZHGxSjuWPEHBBwNfQlJLuu0poNgfoOd2G/Rq47U2dk16xlfQNZSCJ7grXEd7v1OIBnpRphFcmPJ1
 eghpiq4AjtKg2WmyMayMzJ1/x6dYMwwPWnsN2fD/t/2kVxjFtgRx/lWHP98hbIKcnMqi9M848HlIUA
 5dyXe1uGQbyvoRADM3LhqO6LUXQliXQIYZ4336HxgVDZLo1vFtbIlox7XUyM9YEbjmXf38/v/RUOws
 h+BZ+ZvzU1vWcP0Ym1p2Eh6E2rzkqQtBiKTh4KahPRjae8EVfjk8XQLFkgcKKJ8jtEUwUAfONGRxPi
 YvCLJ5HaQekoq0iR+8ZcnSwaIquNozVvLXiwi/Rt329xrTovLApN3HpoXxEyxj5/ErOAmUvILAXvRC
 Zwt6rrUFYuHl7lT9OfBYSWVFegRUKdGQmU0L/h3hLQuRDFU0159pT3sn3SoDR3S+oZoHFa96uVaQ78
 kpfGgxFSnJeTv3QAi8WAjnVkdQ38uG+9Rs288/V2D73hpYYoiDmHWG1T71zA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This covers the RPMh Network-On-Chip Interconnect bindings
and driver for the interconnect framework.

As reported for earlier Interconnect drivers, the IDs
for multi-rsc voting has been removed from this driver
so the proper solution can be developed without having
to remove entries later on.

To easy Bjorn into merging the DT bits, would it be possible
to have an immutable branch with bindings shared with Bjorn once
this patchset have been properly reviewed and accepted ?

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Collected Reviewed-by
- Moved required block in bindings as requested by Krzysztof
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org

---
Neil Armstrong (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm SM8650 SoC
      interconnect: qcom: introduce RPMh Network-On-Chip Interconnect on SM8650 SoC

 .../bindings/interconnect/qcom,sm8650-rpmh.yaml    |  136 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm8650.c                 | 1674 ++++++++++++++++++++
 drivers/interconnect/qcom/sm8650.h                 |  143 ++
 .../dt-bindings/interconnect/qcom,sm8650-rpmh.h    |  154 ++
 6 files changed, 2118 insertions(+)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231016-topic-sm8650-upstream-interconnect-8512d838c593

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

