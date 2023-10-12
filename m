Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA77C778C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442584AbjJLUDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442407AbjJLUC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:02:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A18B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:02:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-327be5fe4beso1228297f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697140975; x=1697745775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5PX3vmU8+Vj8vt9h1WPewaDZBGFm1gw8XnL4XGRfQI=;
        b=eCWALsmsmXm8MjUUwm8cVdU70Bpf19uu6rHCH3wRGUtfto+96fPcPSFjjNgbMaIX0w
         3OB1rqQFS3oLwP33wE2o1SODrIPf0DKsVb98fr6u81mircz4xYRDnLkXrZOFNGAXmLuW
         8GIUbmSmKcaJ5sIWxWfjSTbG1x1GzB76p6Gv3LpYXgClhIFjPQFBpdt04S18m9hzc82u
         pzr9CBZRLk8YgJ1wRMqykLqVNDo2MiPVvhpQ3HmKXafRaxJOFtzqL3CvOOquhMoQ/VJW
         X8BtQJNVXeDd4PZHy60Duai68j6+osyaQq5gvX+kT1OHMw2r9vAFBUBmop2gGcxo5xhs
         U3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140975; x=1697745775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5PX3vmU8+Vj8vt9h1WPewaDZBGFm1gw8XnL4XGRfQI=;
        b=UmCWpwKhknul/l/LECN9jp6ENY2rc5ddoQMi498nzUIRqOpjkLvf9Mqya1aeUDNXJQ
         WudFGJY3REhkKYDaIktnYAywoDLlliUJNpEqVTnYceXumyhA0+zu7smYylpoZR5sPOZW
         7N9cNPGRP16BrjuBmU1x+i9JtlqAbpkIALWQjTBnQt3ktW4RlGUSxmSWFNIHuaC5Tz1z
         PF0jfNBXLquudjKtRAFBzHvif3KgUQE9pKqLrePTYXjctuNpbMQXdir50aVJ37dnbxy5
         8GcD4YODWTsiwtWpo9fHGZbOnRhMh+Ra6IIVBNg5Q3i5xlbXHTJAQCtu2KywQsN/v3er
         8+SQ==
X-Gm-Message-State: AOJu0YxYOnRllTuaUCGCCbI4NTuEUu2tUgl8QQCi4edDHOKiZyxcXxHG
        VOEby7B7Fdh6LZQToPOUa717QA==
X-Google-Smtp-Source: AGHT+IG75Ik8+NEqcFu/jc7KU/R2jkk0DH5rTrxFKbzC0EcDU+NsXwc2ZWc4tkvA4ZRUOpoB8JGL2w==
X-Received: by 2002:adf:f407:0:b0:31f:eed7:2fdc with SMTP id g7-20020adff407000000b0031feed72fdcmr22612405wro.35.1697140974743;
        Thu, 12 Oct 2023 13:02:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d6b0b000000b00324853fc8adsm19008694wrw.104.2023.10.12.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: exynos: Add reserved memory for pstore on E850-96
Date:   Thu, 12 Oct 2023 22:02:51 +0200
Message-Id: <169714096778.12426.2726125345142435040.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008033633.21304-1-semen.protsenko@linaro.org>
References: <20231008033633.21304-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 07 Oct 2023 22:36:33 -0500, Sam Protsenko wrote:
> Reserve a 2 MiB memory region to record kmsg dumps, console, ftrace and
> userspace messages. The implemented memory split allows capturing and
> reading corresponding ring buffers:
>   * dmesg: 6 dumps, 128 KiB each
>   * console: 128 KiB
>   * ftrace: 128 KiB for each of 8 CPUs (1 MiB total)
>   * userspace messages: 128 KiB
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: Add reserved memory for pstore on E850-96
      https://git.kernel.org/krzk/linux/c/23e4a49943624dd83199989c852565a3ff760fa7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
