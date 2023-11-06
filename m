Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5047E1C2A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjKFI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjKFI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:29:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00D10B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:28:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32ded3eb835so2950040f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259338; x=1699864138; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xVg64v95yLO2xex1BL7gRMAJXMhEd7O/tj6FlUFZN0M=;
        b=lVc29szezIrH76YjM49RJCPV1pOMEiTyQhQG5m+DPG6AnkzrZta/qlcaHFyqXQ1uj7
         CgYQ/Zh0xQcPItwcxPtyLEm53P7ObXt7rkN8ESMvKesglxgXNK3IKLiGtFK2qrjusUJn
         wOiT7TBOfz0JcIIqoIGAEOsjpD274juG3ByUsWtF0MUfOT+evDLUsUQqdVaZWoe40UYB
         0+2UyFkzhLzS1i/Aa1XaxtvhK5S4Mf6CxMq7EfmuqjY3fy1NX2kxSOE5H6dn3ZZ8IKsj
         7Y+68LehX52mBcUU8+p2D/4xCAG63PGA8xr+RpSwZFDyXBTMBVDD+5YR87g8UMT9t3vI
         w+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259338; x=1699864138;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVg64v95yLO2xex1BL7gRMAJXMhEd7O/tj6FlUFZN0M=;
        b=TrTk7i0NaQXK6A4WMT0z/Hj2e1IQQtRQtIaINE38jgXubXq4iT3RvZNSdSgDx2O849
         cus4e/6t0h1Q0WXUzTbJpkbw4dClNf1Lu8AcVsuQ7VfxYtbDimjOVKprEcibcnPSubfk
         ENon89iPPmsupHUl3VxtdDVrukqSt6/4O79Aj3U97qHXwPrMvPs+9XTTU/f4kALB/LJ7
         X6sotYxGhJZcWOpbjJK0vwVTrsPompeKr3kPyf0sagzeDs8GzsRhQde6FwjHpbN2HdI4
         zpZu3RQjMtOSkh7zPgjuS7Fb66nqoINOgLR23MN7qQV7tsIkmOEvkRjhCJCv98pjk5bZ
         w37A==
X-Gm-Message-State: AOJu0Yy9/wwuGRb1tZ7IR+BsWCJOJAfpDYB+en/f72lqo8NSfJmiZmJ3
        J5CZz5Ryt6py0kCLcbur9kYPFg==
X-Google-Smtp-Source: AGHT+IGY2cnezhqD5a4Qn8SdP/PaZgVRABtO639WGkDzPC167MVcjgtV+XmebbSkphTrwU19Hwpatg==
X-Received: by 2002:adf:f212:0:b0:32d:6891:f819 with SMTP id p18-20020adff212000000b0032d6891f819mr20273331wro.41.1699259337837;
        Mon, 06 Nov 2023 00:28:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p12-20020adfce0c000000b0032dc1fc84f2sm8796126wrn.46.2023.11.06.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:28:57 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] remoteproc: qcom: Introduce DSP support for SM8650
Date:   Mon, 06 Nov 2023 09:28:51 +0100
Message-Id: <20231106-topic-sm8650-upstream-remoteproc-v3-0-dbd4cabaeb47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMOjSGUC/43NsQ6CMBSF4Vcxna1pixR08j2MQy0HaCK0uUWiI
 by7hTjopON/hu9MLIIcIjtuJkYYXXS+T5FtN8y2pm/AXZWaKaEyKaTmgw/O8tiVOhf8HuJAMB0
 ndH5AIG+51qYsgKuuAZaYQKjdY704X1K3Lg6enuvjKJf1jav8Nz5KLrgpKyWwt5ClPd1cb8jvP
 DVs0Uf1IWbiD1ElUYsDkBcKwqgvcZ7nFzPUOYAjAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=B9X5JABasgtm+WcKFvPVEvO8N6PQClAuoGJpo8AsdPc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKPHD0YsdSh7bY7ujlTyUQ0TyrgYOE/BHb3ZL5Ed
 hbLqxB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUijxwAKCRB33NvayMhJ0bNrEA
 C3HPFS9RGc/8QaBBAHA1RQLRecbUsa+gJpLyMm0G/d+BsyP5wBN1Hf5j//tJczS+t13PRXOkUdrXM0
 7rBmkfo+0aORAr5MAeQUKlqKp6j7uz0vLn6XH74f0zaRtXH5niDYiIGjIEs7y0AgtaY8s3qvvksCFn
 D9xXgpF6/pRs8QafX9PTezYGksatZtm5vDRnJBsmS1iDtJxTw3vWVjSKqfZd/ErnsD8K3bwgzjUKIE
 l6r0RRGyg52HLUFi1/MovpThuRVK2CRVK0bAPQtcIZ4xBd20RexxAAB+LLbaZMDctGtzt7DQCnMIBq
 ChFf2m4Ac5V3mpfan0WUCYZ72Sa6tbBG7G9JDtAOBezEWaE570ZIc9+h1EcyGY4HfqrepQre1XGQBI
 /bsYwk7B8BIyQ9wZGVmv+wbZ/n6uHQWeTHboaZtaPPNxXEAjWs+if8Be4rkiG7ns4T+6N+FDWBuNVw
 qWP6lobtoxe3GfiuJYgUzHw+JkiyhwKOHw6KBTJa8uDrqQ5jbbQoUcoT5Slr5xfK53ShwiJ91ChFmD
 4PfGsZpIzr4BP8dU5miYdeEtvS3t3y/lbGKWpBI8iumOQuY5IoF/eQoo0ef0jmoHvxrjMpB+zq7ts+
 W8IUY3kSbwTorCbGVkZPmQd2o40cR5nNIIhkGPHHvsaikcPLyAc998cJb57A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings and driver changes for DSP support on the
SM8650 platform in order to enable the aDSP, cDSP and MPSS
subsystems to boot.

Compared to SM8550, where SM8650 uses the same dual firmware files,
(dtb file and main firmware) the memory zones requirement has changed:
- cDSP: now requires 2 memory zones to be configured as shared
  between the cDSP and the HLOS subsystem
- MPSS: In addition to the memory zone required for the SM8550
  MPSS, another one is required to be configured for MPSS
  usage only.

In order to handle this and avoid code duplication, the region_assign_*
code patch has been made more generic and is able handle multiple
DSP-only memory zones (for MPSS) or DSP-HLOS shared memory zones (cDSP)
in the same region_assign functions.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Collected bindings review tags
- Small fixes suggested by Mukesh Ojha
- Link to v2: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org

Changes in v2:
- Fixed sm8650 entries in allOf:if:then to match Krzysztof's comments
- Collected reviewed-by on patch 3
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-remoteproc-v1-0-a8d20e4ce18c@linaro.org

---
Neil Armstrong (3):
      dt-bindings: remoteproc: qcom,sm8550-pas: document the SM8650 PAS
      remoteproc: qcom: pas: make region assign more generic
      remoteproc: qcom: pas: Add SM8650 remoteproc support

 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |  44 +++++-
 drivers/remoteproc/qcom_q6v5_pas.c                 | 151 ++++++++++++++++-----
 2 files changed, 159 insertions(+), 36 deletions(-)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-remoteproc-66a87eeb6fee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

