Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23F7FB61C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjK1Jni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjK1Jng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:43:36 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75233D6;
        Tue, 28 Nov 2023 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=dhnXcjMI9E7q+q8qflgLfPbgmQz993e+7z5nLM7la5Q=; b=mcT9MeLj12lISJj27FhbjYI2Bw
        hfjPVGBe0GInISaBancGe0GbfBEamz5K2VungQeIhCN13DEfySOEYS9G/uiUMyJugwi/3TZJ6tsL8
        Od4rW6Kd4krfdT+tYao73grAH0mrqSGzffqpUSFfPuZVuwOgzstLFS4avpxlm1v3BzHTaAssM6olK
        E9WCOfsk8bfFqG+5UmqIX9UD15zZa8ahDIjO/bsAzfekxKWK3NpZSWoRuLcgsu+NPeT8WYkxyrJRE
        ZC7Zjg8dqYnHe+BKH/ex4/B1q7DKnubHb02hxb8T6n0ekWVmSEwPfJuiq5iFBjGHvnldZ3dj24jHa
        HhnacPNw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1r7ucz-008PbT-0B;
        Tue, 28 Nov 2023 10:43:37 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/2] serial: msm: Allow scaling power domains and
 interconnect
Date:   Tue, 28 Nov 2023 10:43:31 +0100
Message-Id: <20231128-serial-msm-dvfs-v1-0-4f290d20a4be@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEO2ZWUC/x2MQQqAMAzAviI9W3CTgfgV8VBcpwU3ZQURZH93e
 gwkeUA5CyuMzQOZL1E5UgXTNrBslFZG8ZXBdrY3xhr8fNoxakR/BUViT25YnKNgoVZn5iD3f5z
 mUl6NnpBIYQAAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
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
interconnect of the UART DM controller in relation to the selected UART
baud rate. This is done by setting up an OPP table in the device tree
that describes the necessary power domain states in relation to the UART
clock rate.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Stephan Gerhold (2):
      dt-bindings: serial: qcom,msm-uartdm: Vote for shared resources
      serial: msm: Use OPP table for DVFS support

 .../devicetree/bindings/serial/qcom,msm-uartdm.yaml   | 13 +++++++++++++
 drivers/tty/serial/msm_serial.c                       | 19 +++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)
---
base-commit: ab58841ab9fca536e5579312d7b46cbc4822e29c
change-id: 20231121-serial-msm-dvfs-aeda58c55af2

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

