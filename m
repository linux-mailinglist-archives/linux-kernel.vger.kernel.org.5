Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA107CD605
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjJRIGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjJRIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:06:19 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411AB101;
        Wed, 18 Oct 2023 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=wSnE6AHtReJkLWNCNsw2deG5mtnwk5thFtDKs+hSJYs=; b=o0YoW5fI8+ZfZjFx3X/xaPh/y3
        r3mLLIkTjISzwpKgufg7Xo4C2xacaJkrWIDdZ75qIJ29D0NvK7k8dB+eIDDo3kNX/ER9/7j6F9OAA
        A1IH8/6uuig++gr0I37pUrZInQDRkwvuygam54rUH09WSTF3LaPh3YR87IJTsjsv+uuZ5Yy9gKf/0
        XzXed/knQrS7/NsQh4t6yE7UCPX+5wfBgGuaBs+Jc/epIbEBi/6PUA+7jHTYxkbdIA8VBIGg+UCZ1
        rb9GRxByXCzyFkmafHXZSHzK9BOy9KgfpILk4wkLFJ2VrNtgGbOhpW0SXjk/Y7rfRhfTY8h4zfl2x
        vFDOjTuQ==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qt1ZC-009lIU-04;
        Wed, 18 Oct 2023 10:06:10 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Date:   Wed, 18 Oct 2023 10:06:01 +0200
Message-Id: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOmRL2UC/2WN0Q6CIBhGX8X919EQDcWr3qN5kfCTzAkE5irHu
 0euuy7P2b7zbRAxGIzQFRsEXE00zmZghwLkeLU3JEZlBkZZRQXlZI5zK6gg0j90wDtRWrOqVSi
 0riCvfEBtnnvx0mceTVxceO0Ha/m1v1bJ/lprSShpeCOR8+FU18N5wmAnZ9/ol6N0M/QppQ/Sh
 gUztAAAAA==
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
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v2:
- Reword commit messages based on discussion with Uffe
- Use generic power domain name "perf" (Uffe)
- Fix pm_runtime error handling (Uffe)
- Add allocation cleanup patch as preparation
- Fix ordering of qcom,msm8909 compatible (Konrad)
- cpufreq-dt-platdev blocklist/dt-bindings patches were applied already
- Link to v1: https://lore.kernel.org/r/20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com

---
Stephan Gerhold (3):
      cpufreq: qcom-nvmem: Simplify driver data allocation
      cpufreq: qcom-nvmem: Enable virtual power domain devices
      cpufreq: qcom-nvmem: Add MSM8909

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 124 +++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 34 deletions(-)
---
base-commit: 2e12b516f5e6046ceabd4d24e24297e4d130b148
change-id: 20230906-msm8909-cpufreq-dff238de9ff3

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

