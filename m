Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B9C7FC2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbjK1Rtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346305AbjK1Rt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:49:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85C1B4;
        Tue, 28 Nov 2023 09:49:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a132acb67b5so166595666b.3;
        Tue, 28 Nov 2023 09:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701193774; x=1701798574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCwKOOcvZG227KNZBJVAw0tdRH4yoYqx+lNqD4UHuvE=;
        b=m7lo0+LQJ49D2oDFm6/sdfAXemmUzWYnb+CS3EM7iL5+KVGRmmKNfoNAhexAwaOIw1
         RoqUqtxDKaoXnvk2urTi+MN8EJ6A59xy46Mb4hY5glAzSF0enzX4qyRrPwM6niie6JrN
         QzKEYBCoeD/j8/YeLqWWLT6lwV7bWevEfoqYVXtS/i3ccj3pVHDkXvG0CytibgDSgIIV
         YUXbuYb7AVIHVPyTRDTbvREeJMC0lCLmZUFJBBrGAfeTcXY63NbN1yVeDot5+BXzryZP
         kYbHd0Ajha6Ua3R4IYt+JhW7Vx6b5emLfMwOlz5E4QIfCS3GcKDwZg4KI8pvuuQSCbZM
         kIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701193774; x=1701798574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCwKOOcvZG227KNZBJVAw0tdRH4yoYqx+lNqD4UHuvE=;
        b=YqOfvNwGm7oASKIJUGEPYVYlPMsmdwnGikVO8e8UOgDSozk2f90NDNvGSNLNIOneP2
         QQz/6zJVQEBtYP87wBfJds3/YMSKM75zAGLLsGbF7/IXolK59YDk8+Fj/LUzzRCwid6l
         5J0CbSLFiRlze2dTYWIGRjNGmdaYrvO0lOhrIO+D1Y6HvgmQNfOAohIkb9iQNNzP0YAC
         apTWKx7sv+dOqg6zxTldGvgrk254KHTMhH2LI/Kgl4Xp3MVc3zTJuu8frD3M2OnMu/SC
         S8U/vM8pe5+KgAPAICOG3C0c63ozN3hJ3/fJAN06OzxDBA/ZyjxX4FnWbRq3ZVv7m+Pa
         Z8ag==
X-Gm-Message-State: AOJu0Ywo/JTJ4D+JpnhopSGv7srnRxL4i8Qvh0e04+o2EY5bziPk9flE
        O/ZRRjeVRLuBWDEg3GPUO1E=
X-Google-Smtp-Source: AGHT+IFv+IODDHV2aUyGCP25pWGTd1fOh8jm9JfU859xNG4T5EWQ0fud734+4RsoprcqhFPRy7x98g==
X-Received: by 2002:a17:906:3a45:b0:a04:edd6:dea7 with SMTP id a5-20020a1709063a4500b00a04edd6dea7mr9353671ejf.7.1701193774209;
        Tue, 28 Nov 2023 09:49:34 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kh4-20020a170906f80400b00a0ad10b3f68sm4836490ejb.205.2023.11.28.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:49:33 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Michael Walle <mwalle@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: remove Xinlei's mail
Date:   Tue, 28 Nov 2023 18:49:24 +0100
Message-ID: <170119374438.445690.8441934091500162620.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123134716.2033769-1-mwalle@kernel.org>
References: <20231123134716.2033769-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Nov 2023 14:47:16 +0100, Michael Walle wrote:
> Xinlei Lee's mail is bouncing:
> 
> <xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] said:
>     550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply to
>     RCPT TO command)
> 
> Remove it.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: pwm: remove Xinlei's mail
      commit: c7861b3ffaba39021968505bd6807bf4fa7148c9

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
