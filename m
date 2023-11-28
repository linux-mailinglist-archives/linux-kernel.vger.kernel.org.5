Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F987FB638
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjK1Jsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjK1Jsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:48:36 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E4DD;
        Tue, 28 Nov 2023 01:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=qqD5FhYjTlrMhvo9H9Ud7tOWyJdz/L1HRDU0aJZunQs=; b=bLCJbpS15T6e6UbeFBQuRcwcAy
        WRIkpCQVF1x0WSK/YCENnhXMk5gd31wDctSwhTOMPwgWm8wdgga2k2Cz2k5PbOLJ4HM7Y62kzWK1I
        XZ+NPKRxMQx1F1F3Ph2aAo4nfADdjz8BY1w+GXO31WTcxzz4nBa5IffczTRTskGkO+Y39E87yC0dv
        qtJ6OrL0biub8GhYcwg28WfQK+N5GXoOml6Bpfoa0ZyRFnJSlhwIGSpjV/NdIxwFhrxfV5+gji3Ld
        xegF/08FluSg6sK9HoB82ua2/1qigPzLJUfsmXS9FPvhf0RuKCWf03TNfQCoZE3x2xuEuW2lyu2t6
        iM75m4UQ==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1r7uhr-008Pi6-2D;
        Tue, 28 Nov 2023 10:48:39 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/3] i2c: qup: Allow scaling power domains and interconnect
Date:   Tue, 28 Nov 2023 10:48:34 +0100
Message-Id: <20231128-i2c-qup-dvfs-v1-0-59a0e3039111@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHK3ZWUC/x3MQQqAIBBA0avErBtQA9GuEi1Kx5qNmVIE0t2Tl
 m/xf4VCmanA2FXIdHPhIzbIvgO3L3EjZN8MSqhBSqGRlcPzSujvUHB1WpCy1nhvoCUpU+Dn303
 z+35PDgNQXgAAAA==
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Make it possible to scale performance states of the power domain and
interconnect of the I2C QUP controller.

This is necessary to guarantee performance with power management
enabled. Otherwise these resources might run at minimal performance
state which is not sufficient for certain workloads.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Stephan Gerhold (3):
      dt-bindings: i2c: qcom,i2c-qup: Document power-domains
      dt-bindings: i2c: qup: Document interconnects
      i2c: qup: Vote for interconnect bandwidth to DRAM

 .../devicetree/bindings/i2c/qcom,i2c-qup.yaml      | 14 +++++++++
 drivers/i2c/busses/i2c-qup.c                       | 36 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231106-i2c-qup-dvfs-bc60e2998dd8

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

