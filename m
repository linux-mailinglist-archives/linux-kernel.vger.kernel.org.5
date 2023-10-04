Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAFC7B820C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbjJDORg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbjJDORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:17:31 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8186BA1;
        Wed,  4 Oct 2023 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=1udQNw5vCZHub2MtRBdFnqxAYq5T193WBJrN0AkjydA=; b=Vj8LdpYyntASnKF4i2mN+Jlltb
        3CnKeISLlUzJJqDRytOuHKO63lH0TZsl6RoFwA1g9iZ3klX2OFI4go+0ZpR2xfHx4IA5cl2AuByko
        GqKXCXwvvKLae/lLCL3f16RcwvAFw+0czVdHajzAXcpdoT6Z4M0yiAqeWH8D6uAop/dS6yCYv4ojG
        h8fIUYzb24fOR8u8LmM9C5Z0tMHQ8YcWoZzLy6aNkumwBHKzykZnMGOeYZqHijJ9gAYg18Z8MOVLe
        pePHYFAo7PSTvyBe4XwmVWv7Td5M7m2BvfSaDBMPiR+/BXYlrzb3sfY3f03SXARYo0F2EJsbe3Sbu
        WLp9IalQ==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qo2gj-0071hO-1A;
        Wed, 04 Oct 2023 16:17:21 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH RFC 0/2] regulator: qcom_smd: Disable unused regulators
Date:   Wed, 04 Oct 2023 16:17:16 +0200
Message-Id: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxzHWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwMT3aLUdN3i3BTd0rzS4tQUXUvTpOQ0gxRTC7O0JCWgpoKi1LTMCrC
 B0UpBbs5KsbW1AK576KllAAAA
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment unused regulators managed by the RPM firmware on Qualcomm
platforms stay on forever if they are already on during boot. This is
because we have no way of checking if they are really on or not.

Fix this by sending an explicit disable request for all unused
regulators managed by the qcom_smd-regulator driver.

I'm sending this as RFC mainly for the change in the regulator core.
There is also a slight chance of breakage for incomplete device trees
that mistakenly rely on having unused regulators always-on.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Stephan Gerhold (2):
      regulator: core: Disable unused regulators with unknown status
      regulator: qcom_smd: Disable unused regulators

 drivers/regulator/core.c               | 9 +++++++--
 drivers/regulator/qcom_smd-regulator.c | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)
---
base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
change-id: 20231004-reg-smd-unused-95bcf0d586fb

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

