Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368DA7F3779
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUUcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjKUUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:31:51 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745C1BE9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:29:28 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7903233e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700598567; x=1701203367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/YPc2+7OX5cSuooAWCFK/zXbyQQcMjUtmvaEdzyH0I=;
        b=Ps59Aw4+pnOcsZnMWAupwEZBkEGtOXOiqJs7dXAa0Xypq1i2WYq5D5dTNEV2ruU6Zb
         TjdhhYjxAih+QC5k1G74Z+aBFVXE+0ZG1HpigJN4sTGg3ME9cbX/bV8ex7QTP6d4OfSI
         OfIrvgvr39fH0A9tNv5wzLXgPlRh1OymF2XC7DVajXY2+0fPQnT6+z0b+J1hp9Pe5RWV
         qG+kFdoP2rL/oMXCL0LGGOSKMgPfwT1KTJqp/B3VMB6AnsnEuNXkjXUy/R+ZmtPEf/0I
         8lwee+yJjKHYmdWn3TbSI2qSYWU9arIN5AY9DeXbeyr+AN/QlGLfI0pL0cs0uGilEH+s
         EJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598567; x=1701203367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/YPc2+7OX5cSuooAWCFK/zXbyQQcMjUtmvaEdzyH0I=;
        b=Ia+PiDCuBk29JM3FQ933mIkOPbuvOGLMdkGBOLBvH196PXKUSeIA14+EMV/A1WAk7+
         zQazkS34taG4+IR5laq3QPlsoZLMnlgpjMnGtduYVCgFGOM/6q7TN8SCoil84WhHomA5
         9jnsMa1aR7BzJOVvdtkrcbyBK4gH1OKYnzsSvnOCxlcFSzMv+oO8cTt6F54y/V/Ibth0
         QpWpJbcckyb7/88Uhd86EuWLQ5RjMTivVGAaEUJIfWX2eWIpBKEQ6DNnjLZttHEdjVGu
         jQ5gQhZilkhfNDlgcZZwORvac1/576ago3ZzurBri2rh2zk5P8iboiwmYrc/cGJGWxrw
         ljyA==
X-Gm-Message-State: AOJu0Yw/XmqaqeLtYV9dkZJvrx57Zg1uZjPqv64IuR/ySeAea6/2f7B1
        pn4zDpErUyrbtxuxTeE/F1BkRA==
X-Google-Smtp-Source: AGHT+IH+lx0/QyDiMn/bUpTX/WV0RizOFIs7Tn8KJMsGYobLA7HMgbfKSNb2zVaPAad4qhxkMJIPVQ==
X-Received: by 2002:ac2:5e73:0:b0:507:a383:fe18 with SMTP id a19-20020ac25e73000000b00507a383fe18mr190070lfr.40.1700598566624;
        Tue, 21 Nov 2023 12:29:26 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b0050ab6112af2sm286287lfs.65.2023.11.21.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:29:26 -0800 (PST)
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
Subject: [PATCH v2 0/2] usb: typec: tcpm: Handle Accessory Modes
Date:   Tue, 21 Nov 2023 22:26:58 +0200
Message-ID: <20231121202925.2481471-1-dmitry.baryshkov@linaro.org>
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

Changes since v1:

- Initialised the `mode' variable to 0 (Sergei Shtylyov)

Dmitry Baryshkov (2):
  dt-bindings: connector: usb: add accessory mode description
  usb: typec: tcpm: Parse Accessory Mode information

 .../devicetree/bindings/connector/usb-connector.yaml | 12 ++++++++++++
 drivers/usb/typec/tcpm/tcpm.c                        |  9 +++++++++
 2 files changed, 21 insertions(+)

-- 
2.42.0

