Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4972F797AC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbjIGRsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbjIGRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:48:00 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D581FCF;
        Thu,  7 Sep 2023 10:47:40 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 14E03408FB;
        Thu,  7 Sep 2023 15:03:04 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694080985; bh=UydgDVQiSUviGozQ38IeSZQCohfutWy5gMlbsDElVGI=;
        h=From:Subject:Date:To:Cc:From;
        b=TTl3YhZOTLW5oLj4fT9j2yYvOMgL4+xe6tXIO7+dbx+g6JvuoRRlUdXor2El+nDu5
         5L7BHZC3I2wtfzoQXqK8ww5vj8zG3EZjb23vztrU8lLbYIx+OPRI/a2aRhtDEvkdpr
         qfzSTbKfrHu7Lo/VL+SY0U5Z1Jel/LziUbouBuVvzN9Dbpp98M1N7yoPFExYjsADXr
         ohXECoi8FryPEkkzmiZTwx2JYXZq8WP6UywPng0lQMUK7gtDPuIqN9Z0M8kLyXX9os
         mKcH6A0rl9b4bQHTiGL0vElfaknXlYpzTprkYPfN53x+sEGZ9uuZF8Kwd4f1fkF87U
         CND7wMVUnfmpA==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 0/4] sc7180: Add ADSP
Date:   Thu, 07 Sep 2023 15:02:33 +0500
Message-Id: <20230907-sc7180-adsp-rproc-v3-0-6515c3fbe0a3@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALqf+WQC/4WOQQ6CMBBFr2Jm7ZihCG1deQ/jYqBFugEyxUZDu
 LuFjTtdvkne+7NA9BJ8hMthAfEpxDAOGcrjAdqeh4fH4DKDIlWSpQpjqwtDyC5OKJOMLbI+V40
 x3ClrIHuT+C689ubtnrkPcR7lvU+kYrv+qqUCCV3nWdfWOtbNdZY0nOQJWyupv77KvuFG53dsT
 cRff13XD2Hu+q/wAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=UydgDVQiSUviGozQ38IeSZQCohfutWy5gMlbsDElVGI=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk+Z/WMvI8KZwdvygbbGoASchk5qt3AjBHgUYYU
 st7UotEVBSJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPmf1gAKCRBDHOzuKBm/
 daa4D/47b2bcaSAm0q55I/o1527ZcR87PYQWgs8tk7O3H8biqTfugg9KwBhvwUqXALIJgFYFay+
 ofNXd91lPtTdv2Y4B7MoBysTcK4IFHGH7qnnin3Tn0lcBljHBBXdzqvDI+YRBsI1YGN226MtAxz
 y+2bynO9JfD1kZOJ6jKCGvJOQXHowqUWWDwtDQKO0slv/X8Fj2tsI9cRp6cVTml4ssTdk2iOLMk
 l82WUXl2VyAiaB9jK2HcxBwaTiM4YhqXe4yges78zLJCMLsheU/GKDvKKcSySBxDDSsMOcGk5Zg
 J5xBrCnnth2QPR8sgMD8er3KeHzNomSFuuL6M4fDxV//6SeESsPBl4B7ZrSE5Na2xIQrAZsaMX7
 HbDAWAcI8A71aoRJL6mCCGGWAATBAojnkV74tT5e+P3/duVyzREE6XGbqulCYc5rExJK8ams8w8
 W1GbhYakeBBGAUybQs5HhJIjvM3XHadJk9lpKGh1xa4FYR3yxZ/C8qkanA3swZ8+tADFrKnKRdx
 dFhQIihNUUE9T9Q+QsGlB5RyhWkpg2x+tsVezyUaSJQ/LP5W1E6aQaHDV6y2lX0uBM+PK0yp8O0
 ZOl4FpQ2tRCxeVuAPXdw1/aWoGp2MeHwoG3D9ajGbMQEBXlE0wsmdCIfDE73KVVE62Rp77kpMjb
 a4AHxeY8n++etFQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180 has an ADSP remoteproc that can be used to control the sound
hardware. This remoteproc has to be used on those devices that use
Qualcomm firmware and thus are locked out of driving the lpass directly.

Introducing the ADSP would allow multiple WoA laptops such as Aspire 1
to provide sound. It's also useful for the sm7125 devices that are to be
included to the kernel [1]

This series adds the ADSP and the sound services needed to make use of
it later.

[1] https://lore.kernel.org/all/20230824091737.75813-1-davidwronek@gmail.com/

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v3:
- Reorder the pinctrl
- Fixup remoteproc submode per schema
- Link to v2: https://lore.kernel.org/r/20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru

Changes in v2:
- Refactor the pas binding to fit adsp better
- Fixup remoteproc subnode names and property order
- Link to v1: https://lore.kernel.org/r/20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru

---
Nikita Travkin (4):
      dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP compatible
      remoteproc: qcom: pas: Add sc7180 adsp
      arm64: dts: qcom: sc7180: Add tertiary mi2s pinctrl
      arm64: dts: qcom: sc7180: Add ADSP

 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |  81 +++++++++----
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 127 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 |   1 +
 3 files changed, 184 insertions(+), 25 deletions(-)
---
base-commit: cd04b2fab5ee58862674e9bab3cbc8e9a8576845
change-id: 20230905-sc7180-adsp-rproc-a745b88af298

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

