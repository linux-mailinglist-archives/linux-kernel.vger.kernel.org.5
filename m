Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9F813620
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjLNQZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:25:21 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A0710F;
        Thu, 14 Dec 2023 08:25:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1e35c2807fso1099593166b.3;
        Thu, 14 Dec 2023 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702571126; x=1703175926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAh9hLA7/3vJZkTHk2ApYbTI4ADCNqSEYHhLSzcSf7g=;
        b=DfdipaSn8GBSt0vGKyWk6+i1XW02Vzeuy6Bz/CjQzNfoFdiMeqxaXZ15BnNXpqwJMB
         DtFD9mRhLf8FCAEddJsTW8zABRaadUJZrQWmhDh7clPB/5hV7vN0wCgW2aIBLiHnlyn4
         X2zUPDX5c5+s0R1xATpfiIw7QISKKjAR09bjDd4muPYP8wKn6GBcRDY/Qal8u2+dAcPG
         ehxPTfgwoaBdov2yExbR52qa9Qll8H7DLxc5GazWpIoke0eAkisxHsUqzwHbEK8LQ0M0
         3MKC8/A0Y4auVBYczH3gF5XOauw/3GdxhNh83mD3J7lv5jY0LNX4ck+3/nD8d9652wQ1
         iZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571126; x=1703175926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAh9hLA7/3vJZkTHk2ApYbTI4ADCNqSEYHhLSzcSf7g=;
        b=n3qC9JA8KWSuywFfGCJSlWpmmINpfgjwg6JCTCF8hXtY/vEvTEnuzSEj1R7u60HufI
         Jf3olvIp+nWlAbQoB1o/iOIZNXZwNjEwkIFBgvAN3dt89e19GmcPE124szTDTWBbM5J2
         Tz0rV95XKAkNrMPpkx7ApP9fdQIIfxfcAPmERhHueYxIOoSgxAkrT6TFj/DT1coQ5/0O
         1BJtYlPUPLembycyXapWnLdHuIh2sTqZHy7MmVktP0YecdlrWDBSvsPp3ptY8zi2ENyQ
         F5xxpTf51MC62iASV1W+El/IYFWqp8WwncJWXeLincFKBmhQHEeRwcXnf+ipPvlUVeHv
         //PA==
X-Gm-Message-State: AOJu0Yzpq0IjW763liEuln88KuGBsiytpWUQLN4ILMrVMEoHGoenYU7C
        BJAx7f3lQ1/vptdEizrcTb8=
X-Google-Smtp-Source: AGHT+IE2yCLDkuvnAGzuGQCgb+g82SQy0V+xnj+sV1DuFTKwWQZGgTCilxOSm5OBuK/K6XS2NmhyxQ==
X-Received: by 2002:a17:906:1c4b:b0:a1c:8f41:299b with SMTP id l11-20020a1709061c4b00b00a1c8f41299bmr4936084ejg.56.1702571125834;
        Thu, 14 Dec 2023 08:25:25 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id uv6-20020a170907cf4600b00a1f699e5217sm9307467ejc.135.2023.12.14.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:25:25 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/3] dt-bindings: arm: hwmon: gpio-fan: Convert txt bindings to yaml
Date:   Thu, 14 Dec 2023 17:25:21 +0100
Message-ID: <170257110824.3783528.16373927104486935046.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231209171653.85468-1-david@ixit.cz>
References: <20231209171653.85468-1-david@ixit.cz>
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

From: Thierry Reding <treding@nvidia.com>


On Sat, 09 Dec 2023 18:15:39 +0100, David Heidelberg wrote:
> Convert fan devices connected to GPIOs to the YAML syntax.
> 
> 

Applied, thanks!

[3/3] ARM: dts: tegra30-ouya: make dts use gpio-fan matrix instead of array
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
