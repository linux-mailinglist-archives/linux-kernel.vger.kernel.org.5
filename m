Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C67A97BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjIUR11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjIUR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2F93D2;
        Thu, 21 Sep 2023 10:23:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3adc9770737so765344b6e.3;
        Thu, 21 Sep 2023 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316996; x=1695921796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrawzLTr2iedIiVQVMU2FN2MVVtTCN9TYNgtIQ11vvc=;
        b=HwrP8J5kFfuNLmZTfrNeFKeYCC3mglo49FeXFahjIkPfAzJ228YPvtmTB5ST+9qRw9
         HNYeEiphN8a2O9fUDovdzTipUtIcFadgXl7fb9pXJvkIZqxUUMDu2vPAVP5UvifbRIpl
         3lAWGjWtn/XwNlea+ujfidgdHBmwdfIus89qmdTOvbvfbczPeG4647NxjwOY2L+n/kUf
         FpAuI/8+XPni0qZq8RER3gxrX9+itAp65N91PmCRV7daky0KX2MEU5V0BpFfwVpRloFx
         e+50VyZp+0rjx69lKdgSQeTBDz6qv6R+d979EnWk7O7nYdGScg4Ae0/GwYw/hcRLdjCB
         BStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316996; x=1695921796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrawzLTr2iedIiVQVMU2FN2MVVtTCN9TYNgtIQ11vvc=;
        b=m0rEtDiGC1qz3tZecFDsqvLzAQFVdNz3aRL3SHjE0ma6PduHFVbgGZ7TQZJBLlTuh6
         043aaM1dMo4m/t9fSUGhLX7H7cbcV4ZzQiaCdrWGFaf9DpV9/pVH3Yhld4nKLDS/B97C
         /GEO2hRQ9jtuI4PHjXUPf2jXvh4v5NuRB1xdPeWzXKeI6/bLPUIZ3GBW1rOm9xNHXylV
         jtqYvYou/U1SkEcJ9JSG7In6qbhz5p20+6HLarB9aACj4qe94IlkKa4zad2rUhkTF0W3
         3ZBflNsKEc/h+KIVN9FmxIKpAo7lAZMyn0zhysAWYKz2V0ge9TAQpr3zI8b9Z6c9OTJt
         kLwg==
X-Gm-Message-State: AOJu0YyfCOscty/ZNj18Dpxg45RyTnDLB1SWlsbHwD+8bbNMvFlNs/rt
        YQMvr8EhFQ4kjsCBG8j8X08rslbP1is=
X-Google-Smtp-Source: AGHT+IGPpmxjWfaXq0c6bI7Mft6n53Xh+KMLL5prPGbYlR2vVDTIDw6iOS89hs4+8Uw4U1p0icd3zA==
X-Received: by 2002:a5e:834c:0:b0:780:d031:bc42 with SMTP id y12-20020a5e834c000000b00780d031bc42mr6402829iom.16.1695312883880;
        Thu, 21 Sep 2023 09:14:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t23-20020a02c497000000b0042b10d42c90sm419890jam.113.2023.09.21.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 09:14:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 09:14:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
Message-ID: <5b6e4c12-28c4-4026-a68b-937d750a059b@roeck-us.net>
References: <20230920112845.859868994@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:27:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Note that there is a new lockdep warning, inherited from mainline.

[   11.144387] INFO: trying to register non-static key.
[   11.144483] The code is fine but needs lockdep annotation, or maybe
[   11.144568] you didn't initialize this object before use?
[   11.144640] turning off the locking correctness validator.
[   11.144845] CPU: 2 PID: 688 Comm: ip Tainted: G                 N 6.6.0-rc2 #1
[   11.144956] Hardware name: Allwinner sun8i Family
[   11.145137]  unwind_backtrace from show_stack+0x10/0x14
[   11.145610]  show_stack from dump_stack_lvl+0x68/0x90
[   11.145692]  dump_stack_lvl from register_lock_class+0x99c/0x9b0
[   11.145779]  register_lock_class from __lock_acquire+0x6c/0x2244
[   11.145861]  __lock_acquire from lock_acquire+0x11c/0x368
[   11.145938]  lock_acquire from stmmac_get_stats64+0x350/0x374
[   11.146021]  stmmac_get_stats64 from dev_get_stats+0x3c/0x160
...

I didn't bisect, but it looks like it was introduced by commit a828c9b08531
("net: stmmac: use per-queue 64 bit statistics where necessary").

Guenter
