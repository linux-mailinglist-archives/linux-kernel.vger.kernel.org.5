Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8957A96C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjIURAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjIURAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:00:33 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8241732;
        Thu, 21 Sep 2023 09:59:47 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-658967a5334so6909476d6.0;
        Thu, 21 Sep 2023 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315578; x=1695920378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CKMGYQM2xSphxnd7h9aDjiueXWWZ1DAS0m32zMMcFc=;
        b=ihh+vfMTouVZ4kHkqz55JUi5Kad8Ns9leVA3naA7SvvDm91N5GY8MF+0yi1Zo7p36V
         JJNO6Zewwfl/9Z9O3PbbN+vyOY7dMi9fkPOH4D+e1kWGz2pUNhbk+BEy0KfbhU4P20hk
         itubwbdxsknJ7AK3Z37xgRkOTvzaBZZEcHiWMrUGUoJaUIPfD1Q8vmq8KxwjkOOJNjRe
         I5lpP4KjeFVNZIJHTkEyfcCLLoIy9mnoRplD5N+VwjaZxV79B5Jn7fonvrO/3613Xo9d
         RrEyBLj67mBCgg8zQ7CzR3IQ2DKbm+I7+VKKVIBAiKBXpBzwLfDZXzb0yCOJ1xKoXmtD
         oSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315578; x=1695920378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CKMGYQM2xSphxnd7h9aDjiueXWWZ1DAS0m32zMMcFc=;
        b=RAQL5Q7a4qAX2/ga0fSJ8fIy7U06DMgaAVoo2m1lxgrHrMTwEpFYby8W0R8oWNC1mo
         33c1KT1OyUFVd1dKCDle8rDqOTU8iIfb62dLg24g08g6U5m69D8C8S0Kg+HDGHl7rUtf
         kDSEqidJtna2cSfFbSPBUSe73HVcxLNKA4xhwD9grXLW1HeW8qRr3rcnOh3DDZggHkHE
         0o0qrUBl6uqnypO4twVqrr2AuDltzen8cXO00e80wxflKM3gdghId+37TnogBmN6Q2DG
         +Qxv++KqVMte862zOOSE7jbELLu9bO8MjqB6FNcQBSUY1ra5D7X/TNJsSWljr26xXQlR
         CPbg==
X-Gm-Message-State: AOJu0Yxqjj6/ajPZs5csuA1THyTx1v++H/qdeZD7sEGAFsv2zPAXFoyH
        VGeXxD0aBMEbZ0OqXTRSqoCwAltQ3bU=
X-Google-Smtp-Source: AGHT+IEmzTMKRhsDTL1/zowyo19aKrYc25ObOXG2WI+wl+UKZIdrPvY/3Opqv8v4tLPBXfzLLH8Tbg==
X-Received: by 2002:a5d:8b0b:0:b0:780:bf50:32ce with SMTP id k11-20020a5d8b0b000000b00780bf5032cemr6171170ion.19.1695311738591;
        Thu, 21 Sep 2023 08:55:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id eh24-20020a056638299800b0041d73d0a412sm436805jab.19.2023.09.21.08.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 08:55:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 08:55:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
Message-ID: <8c686e7b-a770-4336-a047-4f2e2739405f@roeck-us.net>
References: <20230920112858.471730572@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
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

On Wed, Sep 20, 2023 at 01:26:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 152 fail: 2
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
Qemu test results:
	total: 464 pass: 464 fail: 0

libbpf.c: In function ‘bpf_object__close’:
libbpf.c:4205:15: error: ‘struct bpf_object’ has no member named ‘btf_vmlinux’

Old question: Should we stop build testing perf on older kernels ?
If so, why are perf patches backported ?

Guenter
