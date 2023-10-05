Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD4B7BAA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjJETly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjJETlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:41:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563AAE7;
        Thu,  5 Oct 2023 12:41:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5056ca2b6d1so1702890e87.1;
        Thu, 05 Oct 2023 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696534907; x=1697139707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPAvwi8YA99Xf45ZeLAPc7eM1W0BiMyMfMXa0USvgDQ=;
        b=lusx4EFN4iL2qf6bW6HCd07yIeXTFBq+E3OYoIYue2uPXcDrSUKJaHF9IntA5+YbdV
         Clxgx5/ExwHqwtpMo43dddtshAWq72pDE70qsVI6bsr4lMVr5ux519wYuJEAqax02YF4
         kiPhuIrbHvtt3bs9B7qBHFRe7THQuh/4xpO4qGL9IDT1F706A2dkSTfcwe+v323TM/cS
         +diIO8xTsQb8aXqpwHIo2jLPywgQ2izUGp3JuXah275Edzukb4aw2HitAGF8Hi6K9+Hv
         GIDddKBs1SoF/TzvxM10rTOoSUizgY1MZO4an1mzYHTXXEnhh44ZWe+tWkCAZqY4yNSZ
         7ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696534907; x=1697139707;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPAvwi8YA99Xf45ZeLAPc7eM1W0BiMyMfMXa0USvgDQ=;
        b=mr7ZTUbFf2fI3psCzPaIFfo/LKjyi5quPpM0Ek7xj9lYWuO+qPpFG21bKCBj8l6ZDM
         eXu1hWOcvlP0QQP9kdzrIvwjXEYEo2H1Fpe+Y81Gk5TD4PY1bfeaCHaJI2k8b1ID+YbP
         CTlxMH/QPgqFGUnNxEFxVSb7Iyf06dRK2UeUB2e+P+jHLVR6EgvYYgNbQ017OHv/AR68
         9ZJlphtotkEoNgIrfHtM71lceaIevMoKJUwtRSArv6r3LbRWO0GmUnd+B5HZ+rd/MfDS
         x1MRYF9ro3Uv7YkTor3SYWhPwoZh3KGf4Q1YexGwtvwHEqfUuwHLNxlj5eR72VabX2Eg
         nUKw==
X-Gm-Message-State: AOJu0Yy46cAvRpJybl+FN+q2FhBkxxJpRw9eW5BRYi9eIyLDcLjsyLMX
        6P5wEdtlnHZt9Q7abofIlq2rJYFS1+Y=
X-Google-Smtp-Source: AGHT+IHqTabc1IGY1RZWJdXcF/NPsCmiKxtiFcWUSfw/FqlkoLm3vuBxwkuA1AyoGcEYFp4v5tUjIQ==
X-Received: by 2002:a05:6512:230c:b0:504:7d7e:78dd with SMTP id o12-20020a056512230c00b005047d7e78ddmr3442962lfu.23.1696534906926;
        Thu, 05 Oct 2023 12:41:46 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.73.3])
        by smtp.gmail.com with ESMTPSA id l29-20020ac2555d000000b004fdba93b92asm415325lfk.252.2023.10.05.12.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 12:41:46 -0700 (PDT)
Subject: Re: [PATCH 1/4] ata: pata_parport: fix pata_parport_devchk
To:     Ondrej Zary <linux@zary.sk>, Damien Le Moal <dlemoal@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231005192440.4047-1-linux@zary.sk>
 <20231005192440.4047-2-linux@zary.sk>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <5ee61099-2868-864d-2d3b-e82404885787@gmail.com>
Date:   Thu, 5 Oct 2023 22:41:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231005192440.4047-2-linux@zary.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 10:24 PM, Ondrej Zary wrote:

> There's a 'x' missing in 0x55 in pata_parport_devchk(), causing the
> detection to always fail. Fix it.
> 
> Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
