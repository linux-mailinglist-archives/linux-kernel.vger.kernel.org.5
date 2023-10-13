Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29967C8599
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjJMMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJMMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:22:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64940A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:22:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso21562215e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199732; x=1697804532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyHFcssb/VuHTaRYJQiKUZDakpNW7s6ZQnEzNiBDC/o=;
        b=DMVY5Hty6E5s9a+H/svU3+LbXHqH/FdoMjwGo/4BRnKNozwE+xuDVNKRYsGk3VV6QJ
         VV4CxCtGFr4gqRXZjr/ZeVNkVf13MXeYLD/kvrBj9CIFewk/g6JHtcMKmrbeDzq79P3u
         lgzB9J54NLUO3OTUw4hxB5mgyP5gYQIXbZ5VwbxyxPfK15jnltpa0EWtvzjq0B91sI7q
         TQMSf41MEX5LpMbq9ciSi5Tm1UzmWdvY4z/vOeUpNjGlLdMhTX9Ddz0ZPMg9uARLWb0A
         2ujeACSnNakI/4pe4CX6Ox+Cl3rQ+c3QrOZL7g7pBRdh94oI2XTLG43S/JjWizCdvxUn
         HTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199732; x=1697804532;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyHFcssb/VuHTaRYJQiKUZDakpNW7s6ZQnEzNiBDC/o=;
        b=ri7AymBbp5papNVLFAh9GxM/SoG4py/hMQOa44klQXSkjz+tHf13oRqDUWP+6KBtvF
         LcoqCVI21VrtAEjjRPALF2dDZXxe81C3efiq4Wui/MVQzHZuagvoa7bHuCdTvJlMjFvp
         AKVhnBeIbqLUB1w1rjGpuCA9DqFiPyJ5RdTmFvNX4Gu2EoYCN29w3sUsagpdUoYtUBJo
         B4pVkchBSLYu9OhpN+leYiZAinYkj8E0dTGCAMdNjbqJR5ZAeIAt62dBt//efmd1yDYA
         nZjJwYWt3iwWnO/Mrz3yKyxgp6XFyRDMeCsDH84RfHa5Qvs1wRl2PsucfRbuBdPkNJLY
         LN9w==
X-Gm-Message-State: AOJu0YxrFwqZoFS0MOe3lSUL7jotEZHKnz2E7MEY4qf36Qs4Z4k6H1Pw
        HHJpzn9StRmOnVo4jn5/0O9BRA==
X-Google-Smtp-Source: AGHT+IGpbalHHfW+Fd8M+WaWQzY1M1h0TfQplqg15+qAJ7WW2wQOmeBYfXMwQwIJ4F4UGYZIsrJFqQ==
X-Received: by 2002:a05:600c:22cf:b0:401:4542:5edd with SMTP id 15-20020a05600c22cf00b0040145425eddmr23431521wmg.34.1697199731842;
        Fri, 13 Oct 2023 05:22:11 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b0040775501256sm995502wmq.16.2023.10.13.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:22:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20231009172923.2457844-12-robh@kernel.org>
References: <20231009172923.2457844-12-robh@kernel.org>
Subject: Re: [PATCH] nvmem: Use device_get_match_data()
Message-Id: <169719973088.174758.14111137268313332597.b4-ty@linaro.org>
Date:   Fri, 13 Oct 2023 13:22:10 +0100
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


On Mon, 09 Oct 2023 12:29:07 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied, thanks!

[1/1] nvmem: Use device_get_match_data()
      commit: 24bd074c417b7c538fe5297201855447a6162547

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

