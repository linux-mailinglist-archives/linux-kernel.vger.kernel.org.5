Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820FD79CCA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjILKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjILKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:00:06 -0400
X-Greylist: delayed 1167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 03:00:02 PDT
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ECCE6C;
        Tue, 12 Sep 2023 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=a+mMID1sDPcfh9ozAJ1YUGCRnHkjo3zaDLTz6xqF7LI=; b=e9ebnOlO6+tNLENF78E4Fqn2kN
        Cx5xxcl/iiiB6ta+U98RdY9usHt7Yaf2JzdvlLGWlRnuopGi1b+EoI1O78TM1ueCqyApmTdN3fYM5
        H2HNnRyfmmU8e3KGmBbaU0yDX54cR/V5AEozU0M7X0UdSWGidq7xmrkbG2IFxGdL/J5TUkzx5Ad7c
        pfPpAw+dVo/MJgSmFPJZze9wjU6mF5IWtEovTn1XSTXbO8vhnsE1j2xWbk/s3cxgh8Ku9DWtn6FuO
        JpRlEl02BoZsQDc8Uz53TCYYLuio6Oa3zk3wkDs0Usexm+PC8WPZz3sX5CdmhVhDBAkCs9C8rRYmq
        p9J2yh+A==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qfzsj-0030Ws-03;
        Tue, 12 Sep 2023 11:40:29 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/4] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Date:   Tue, 12 Sep 2023 11:40:14 +0200
Message-Id: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4xAGUC/x3MQQqAIBBA0avIrBNMIbSrRIvImZqFZkoRSHdPW
 r7F/xUKZsYCo6iQ8ebCR2zoOwHrvsQNJftm0Eob5dQgQwnWKSfXdFHGU3oibaxHR2SgVSkj8fM
 fp/l9P5O3FpRhAAAA
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary definitions to the qcom-cpufreq-nvmem driver to
support basic cpufreq scaling on the Qualcomm MSM8909 SoC. In practice
the necessary power domains vary depending on the actual PMIC the SoC
was combined with. With PM8909 the VDD_APC power domain is shared with
VDD_CX so the RPM firmware handles all voltage adjustments, while with
PM8916 and PM660 Linux is responsible to do adaptive voltage scaling
of a dedicated CPU regulator using CPR.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Stephan Gerhold (4):
      cpufreq: qcom-nvmem: Enable virtual power domain devices
      cpufreq: dt: platdev: Add MSM8909 to blocklist
      dt-bindings: cpufreq: qcom-nvmem: Document MSM8909
      cpufreq: qcom-nvmem: Add MSM8909

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c               | 47 +++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230906-msm8909-cpufreq-dff238de9ff3

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

