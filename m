Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADC7C8609
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjJMMrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJMMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:47:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C391
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:47:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406609df1a6so21658175e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697201259; x=1697806059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ervPFL/TG3o0dE2xT/eAo5yG2fgj6Cb0JMvl2Z2fxv0=;
        b=Ze7p7RlyRLPD1Iw7I9UzFRPbCE5NASMViu8baKiPBKcDdePz6ma9MOcqWbVaCvpp1U
         cPJ9pl1fgSb34Hrenm3n7Lom2cgEoXV0wY4PxDjTFZsgUvwch9pEt5hvzN85ihr3MbZ5
         Ge6llrv0DFOh/VdFd//GQMh/6UTnwA6lwrnT39Zg4SMtmFc75ai0aKlL6GKKI1uq/tqS
         W55RUSAi/94a4PaLqQTzXdrN8YU3h3STZvNzW8g2KAp5q7kZmze88pyalLmafiEMXcBe
         st2ZfMFM8xOT8k6Appnh6ScXzIcxuau1P5Km8d301r5+aSkU0m4k47gmZmyq2ChvZjTI
         iZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201259; x=1697806059;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ervPFL/TG3o0dE2xT/eAo5yG2fgj6Cb0JMvl2Z2fxv0=;
        b=lNmOn62kdyfuU2WBEHgFImskWAedIi9l1CNomE4AULwOHxbmN4dahe3U/qlKZoyLZK
         4/Zn6CouvZiRnoADdzdwQzjceMcd3mReGHC1XBF4mW5qlLJIUINF1G5/XE+kWuJq1En0
         kp8EbhuPMvT85w7eWmqIwZb/PATGgT+Is6xetHURKWD8W/mlqsU99g89EqmIKgAV9ynk
         6P3hODRf2DkOUWJ0jzeXdN8T/cv7t1BbHlgu29IOqUtMzjnYAn6p9RGk0kie9jm6Gagu
         bb37UN3XQQIJXlRJo7AjGxpqqEu8Y/LwpMNJ+A5rNXHlw5hommUZrDw9TM6ULkcesdqh
         OjbQ==
X-Gm-Message-State: AOJu0YykqO58RNs2EwA4AnN6KV1RzHapB3RzdIS18iCNHbcf+lmwdtdk
        BF+HpPZJQM8fNLR2M+K9oGx+Iw==
X-Google-Smtp-Source: AGHT+IHhzIlFxj8d4ohukDY7iqXaClJZbJDY308xKT0JLX1n0fbOwxxPKsjOIQ58MCRH3/ui/VpKqw==
X-Received: by 2002:a05:600c:3b14:b0:407:4944:76e5 with SMTP id m20-20020a05600c3b1400b00407494476e5mr12663582wms.22.1697201258612;
        Fri, 13 Oct 2023 05:47:38 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm20649689wrn.101.2023.10.13.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:47:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Stable@vger.kernel.org
In-Reply-To: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
References: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
Subject: Re: [PATCH v2 0/3] nvmem: imx: correct nregs for i.MX6UL/ULL/SLL
Message-Id: <169720125773.175470.3037003596155345027.b4-ty@linaro.org>
Date:   Fri, 13 Oct 2023 13:47:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Oct 2023 15:57:26 +0800, Peng Fan (OSS) wrote:
> The current code does not include the register space hole, after check
> the fuse map of the three SoCs, update the nregs to fix the issue.
> 
> 

Applied, thanks!

[1/3] nvmem: imx: correct nregs for i.MX6SLL
      commit: e898831a66834fb7c9ec5816c9683e746656c25c
[2/3] nvmem: imx: correct nregs for i.MX6UL
      commit: f46cfdaf5c0723abcec6da48408fc52d710b424d
[3/3] nvmem: imx: correct nregs for i.MX6ULL
      commit: d0b450caca6f07826dfac1f60faabadf0a226b05

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

