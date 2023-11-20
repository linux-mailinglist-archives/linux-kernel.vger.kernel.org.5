Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9627F2148
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjKTXSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKTXSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:18:05 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D3C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:18:00 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-50aab20e828so2530722e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700522279; x=1701127079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADt8pzOsXpdfsf1HgObr0YIdUIhge4egXUaCPmB+CDg=;
        b=lacxF1LqvkmCPwO3lglQAtKCn9yNCdUD/JOLG8Qsi89G6n0vvKI99Ra/MxAcY4tMgV
         EhIxacTXDIgZ953eFf7R2zkvmxyTiQIYZ3UWOIAXyY9RQLjq6lXs8qhYsqZxJuudO1GM
         s8dfj4l17iPq+md0ByXM5G7jSqeZxODcD28p4zZat/2LFpxvm3CxFQCI1vXZ+ALfMhtP
         aFO41pjKLuXVs6IZqRL4xoxzX9+TsEF2aWUl4jFP6w7JpPHCxMHVaazT5lRQsF43z23S
         sh5EYlxKCWOsgWNLXRK3t2b9+nksOZTdbMRxC0xz6clI9k/ohzbyxOtl03l0m9R5jwDs
         h4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700522279; x=1701127079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADt8pzOsXpdfsf1HgObr0YIdUIhge4egXUaCPmB+CDg=;
        b=s+dvUPVtAWZo7BlCJxRSazggHYNMiThy0SF5xLPctbff+JvVD/PgbpiIT3iMaesRM6
         WeFT07UV0isMz7nWJcWqZVhtrA5wfuKRgg3Iphihr91lSCzoc8UmSWKYFr62HgmZ2fkQ
         L80Gop1AZtQhLEmTd5PeQ+8szIWJgNGIHxWq2sZ5wTL2MS439IB/3Am/AqHDfaAEJ4qW
         zH15QbYOTxlpJ0NkVJSyUQULF0D2by6TdIsiO8SkJXDBrVK3eItwRizejSLXeDauP1rm
         ytol6fEKCVYQ/Z/gqS9swaS9bRXYTMEmYX8V5/v512hZPbEusz2sFrLM1/EVR0tco3uO
         63OA==
X-Gm-Message-State: AOJu0YzUePb467uhlRKRjrl6E7SYz6BkDwR7L0zo/wmS1U02osqM3oTs
        N/799DEeP3yrf0dhfIg9qOBq8w==
X-Google-Smtp-Source: AGHT+IF9nbnnlfFuWTc+kca9xlA0YRyUIqjfnoareDqrnufygavYMGGnBbf+MK5jzMXQplQJTEzWKQ==
X-Received: by 2002:a19:7109:0:b0:509:494d:c3d5 with SMTP id m9-20020a197109000000b00509494dc3d5mr5445896lfc.26.1700522279090;
        Mon, 20 Nov 2023 15:17:59 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id bi32-20020a0565120ea000b0050aab042c7csm677036lfb.190.2023.11.20.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:17:58 -0800 (PST)
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
Subject: [PATCH 0/2] usb: typec: tcpm: Handle Accessory Modes
Date:   Tue, 21 Nov 2023 01:11:06 +0200
Message-ID: <20231120231757.2309482-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to Alternative Modes (see [1]), some of the TCPM-backed
boards (e.g. Qualcomm SM8150-HDK) can support USB-C Accessory Modes
(e.g. the Analog Audio). Add bindings and driver support for parsing
this kind of information.

Note, while it might make sense to put accessory-mode-audio and -debug
handling to typec_get_fw_cap(), I decided against it. Several existing
drivers use this function, while providing AccMode caps based on some
internal logic.

[1] https://lore.kernel.org/linux-usb/20231120224919.2293730-1-dmitry.baryshkov@linaro.org/

Dmitry Baryshkov (2):
  dt-bindings: connector: usb: add accessory mode description
  usb: typec: tcpm: Parse Accessory Mode information

 .../devicetree/bindings/connector/usb-connector.yaml | 12 ++++++++++++
 drivers/usb/typec/tcpm/tcpm.c                        |  7 +++++++
 2 files changed, 19 insertions(+)

-- 
2.42.0

