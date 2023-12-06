Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FD807289
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378939AbjLFOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378911AbjLFOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:35:39 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF4F1BD;
        Wed,  6 Dec 2023 06:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=G5cV7WyOSfNlO+32WPxuxl0NKPMY9OQVwS7c/m87x2U=; b=Dc1sF/QwNPbUMyqrUgdmgtq2er
        yCOxNl90T+JXZ7LGnfkn+TBghXIcd4mSBiTVYYMAOWDfaewf54rGcjliYDb6XZOfoJTrWdlYTDoR8
        toT27pqFPh9rt26+92Cpuk+acD43HDwCkmmbL/BB1bf7Z0H0qHANg0KhIIkrGdtZpocxZroAPuei5
        Tj7pLReFtv5dKrsJ0IKdXrGg5u90Hi9WVy8uBYIxmng85DgGWySlKKOmHyn6BuiVps206bWUOG7Se
        Zx/nH/3dpu2+R1sScZePPxlZ5+JupS7V9YNIhrz306QwdsiRMFZKB0P0iQIOGNoRjtP+402AdvBib
        33PHWesA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1rAszz-00AX1t-1j;
        Wed, 06 Dec 2023 15:35:39 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/2] interconnect: qcom: Add MSM8909 interconnect provider
 driver
Date:   Wed, 06 Dec 2023 15:35:28 +0100
Message-Id: <20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCGcGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwMz3czkZN3c4lwLSwNLXXOTNCMLMxOztDQjSyWgjoKi1LTMCrBp0bG
 1tQDRVKrxXQAAAA==
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings and driver for the three MSM8909 NoCs/interconnects:
BIMC, SNoC and PCNoC. The driver allows scaling the bus bandwidths
for better power management.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Adam Skladowski (2):
      dt-bindings: interconnect: Add Qualcomm MSM8909 DT bindings
      interconnect: qcom: Add MSM8909 interconnect provider driver

 .../devicetree/bindings/interconnect/qcom,rpm.yaml |    3 +
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/msm8909.c                | 1329 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8909.h    |   93 ++
 5 files changed, 1436 insertions(+)
---
base-commit: feaf241ae2da2a73cb421473f52a4732128a996f
change-id: 20231206-icc-msm8909-74f28646ff29

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

