Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E511B7E9F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKMOxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:53:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A6171F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:53:31 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507b9408c61so6117637e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699887209; x=1700492009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h53jKEflW3e/C/cuKnWnlAqCfzD5OxoKB9wqj+QaJ9E=;
        b=cQQEoaJQpUIvNyXM+Zrt7QDmVvZDwUD8AFvXeaYQQ8b4HwbhKu3leLBD9ewNjEoGDu
         Ijyd0LNohIvYFtJ4pU5tPSQOGGwHzKy6fDni5vaLKtjwSyNq/2pmfDmMnlrLOhCvJzBU
         VYInYRckRoBNMBLOCC18Si2dDsipo+YVfz4JcaqncesHZO7piwq5599fsqTslSS5djI5
         f4kTwpDtSXTWHm3YUo51NTWLvtN7MWNTwi9my/sxPERKvhWOYbp45zPpz2flx3Swla3i
         Hj2RcbfJOR95hZuV58etrbURfCXB60AjU/huMfwTHORNsbt0mljHqEorCqN4FXW3P4lP
         J8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887209; x=1700492009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h53jKEflW3e/C/cuKnWnlAqCfzD5OxoKB9wqj+QaJ9E=;
        b=gcyCW7M4V3qczx4y1tPS7f6Cu+5oiaRjr+PJsdGmJDrRXQ+XhGKX1p3vT8z73vsoKz
         VaSB4UNBMv/n2Q6W8+Y7SK3t5ZApzga9AQMqvB6zc+RMWA4cu/bgPJeK7r0X62RoYVmK
         GYNkEBH3PUOAgkbERC15X4bXpQHi24S6EO7cNregFfBXzpHs/WeehR98+M/MCQbDJNyc
         XqDr8r57r6gl7O3kjEJlejDuSsmBHiQb55KaormevJ9tKSVwt9NWWI4yfZ/+70ttPpKN
         6tb8CJybUvkGvvAr+6jubThKj/nmKn7ZStfCCSA+Jvz9B2pHpgNA626J6/2S3d+BZ4c9
         BhIA==
X-Gm-Message-State: AOJu0YyslSff+V8Ufg09GnLBCElUfMQW1EDqEj5SMQ8D0YOHZRUAyDkH
        Nq3tGpiXXLhROGKK4AXoGFGONA==
X-Google-Smtp-Source: AGHT+IEfWdXO8U4PcYgb7/pI01WDceQuQrzLOIYLYfOMG5ddcS10/Cscv2kajtCO4iZUCZ+f2JiyYA==
X-Received: by 2002:ac2:5def:0:b0:509:f45c:fae6 with SMTP id z15-20020ac25def000000b00509f45cfae6mr4757338lfq.10.1699887209584;
        Mon, 13 Nov 2023 06:53:29 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x24-20020ac24898000000b0050794b05c8asm991429lfc.42.2023.11.13.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:53:28 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: connector: usb: provide bindings for altmodes
Date:   Mon, 13 Nov 2023 16:33:06 +0200
Message-ID: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases we need a way to specify USB-C AltModes that can be
supportd on the particular USB-C connector. For example, x86 INT33FE
driver does this by populating fwnode properties internally. For the
Qualcomm Robotics RB5 platform (and several similar devices which use
Qualcomm PMIC TCPM) we have to put this information to the DT.

Provide the DT bindings for this kind of information and while we are at
it, change svid property to be 16-bit unsigned integer instead of a
simple u32.

Dmitry Baryshkov (3):
  dt-bindings: connector: usb: add altmodes description
  usb: typec: change altmode SVID to u16 entry
  arm64: dts: qcom: qrb5165-rb5: use u16 for DP altmode svid

 .../bindings/connector/usb-connector.yaml     | 35 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  2 +-
 drivers/platform/x86/intel/chtwc_int33fe.c    |  2 +-
 drivers/usb/typec/class.c                     |  5 +--
 4 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.42.0

