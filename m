Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC1809ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjLHJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbjLHJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:10:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486D172D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:10:33 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso2288723e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702026632; x=1702631432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12BmaJuhbEbncP7+ftMTLuwVOUi9eU3Yjw6BIudZUgw=;
        b=g0T4xKQwuY/YlPHarRAPgYZlqMl+vNy2vzQmd0TjjyCRW3vOWM6PYBqAYIpnY75m47
         PLzhwABk8Gus5HZV4JV+l4aB957/j/13L3oJTDFq2oI6APF5OtlROJTdR6Dc9/qhhNQJ
         FKKNotPAdHUAgNebeRMyTH7XzNqhI+rKymtVGyxu/l6mnzvu3rXDBiCW7/uwbzS9AcGD
         GbTp3OnwAj34PQNxtzaYH0O6fgnMqC6TghzXBULSye6xHHB1j9mtRg6mPHYnYiU0se4h
         0Ff6tjDtv8KA2M3WI/cYG4ZzgHwWfOgQUSOcgVwQq66NpRl04XYcFo8XfnQ6n27ZQBAs
         ZjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026632; x=1702631432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12BmaJuhbEbncP7+ftMTLuwVOUi9eU3Yjw6BIudZUgw=;
        b=hAYEWkzPwGeBUOskFszo4NzpPrYzW/b33n7/z6R+f8Pj4B3CvhYxPbE5p6H4GJgnP5
         8/d3iroW1ml6mwm/g/gaQAGFRCnxihknjDgHzq1GTZlhhZocVGTIcPuHg6KKVvtsU1+R
         m0kuez05lak7pWCyAOBQOhYvHI60NjZpN0A+ASYBDoXuF/0HBnMsYQyRLwp4dsILc8Da
         U9MwOBz0XZqMCKX0JQMuKBWbMbJeIdctuBoDjB0LHVr93wknI1voZ6JMRR2vHF+o+HPM
         kFiGGWqmi+V0wWgin4zJbY0A6Oero8xYjTSl4khCieEVvICJcESg2Hrf9z3ULqExG9Wa
         g2Jw==
X-Gm-Message-State: AOJu0Yz5yu6uyd2RXOzAk6n2E8YmblOE6XnFEC/TjRI1tupsAa5rEwFC
        4O6eufszIZWYGyDv6f1He5oBjw==
X-Google-Smtp-Source: AGHT+IEuAvHPJ6MPE6Pyhi39JMfaPxgtraeVoZbvofdAwVPfKIYoAMgYX+RB88hkBR3//GVeQ8tsTA==
X-Received: by 2002:ac2:5316:0:b0:50b:efe8:f5e8 with SMTP id c22-20020ac25316000000b0050befe8f5e8mr2266675lfh.88.1702026632109;
        Fri, 08 Dec 2023 01:10:32 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm1572705wrt.22.2023.12.08.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:10:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 0/3] Bluetooth: power-on QCA6390 correctly
Date:   Fri,  8 Dec 2023 10:09:33 +0100
Message-Id: <20231208090936.27769-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Resending with all maintainers in CC.

Patch 1 is just a typo fix as we're already touching this bindings. The
second patch adds more regulator definitions and enforces them for the
QCA6390 model. The final patch enables the power sequence for the BT
module of QCA6390 in the hci_qca driver.

v1 -> v2:
- squashed the two bluetooth patches into one
- changed the naming convention for the RFA regulators to follow the
  existing ones
- added dt-bindings patches

Bartosz Golaszewski (3):
  dt-bindings: net: bluetooth: qualcomm: fix a typo
  dt-bindings: net: bluetooth: qualcomm: add regulators for QCA6390
  Bluetooth: qca: run the power-on/off sequence for QCA6390 too

 .../net/bluetooth/qualcomm-bluetooth.yaml     | 26 ++++++++++++++++++-
 drivers/bluetooth/hci_qca.c                   | 14 +++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.40.1

