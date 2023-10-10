Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8F7C0340
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjJJSSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:18:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5E94;
        Tue, 10 Oct 2023 11:18:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-278f0f565e2so3570303a91.2;
        Tue, 10 Oct 2023 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696961899; x=1697566699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk77dOQP27PiG73gUxQsGyH2X+lxrMRV+EDRGaRWSjQ=;
        b=hg/KUPG5lptXXvCjvTEAG/2JXaI42721QlRyyMqUOYsYRTvseBGgnhTgMtb+CS+pYV
         27JM/9dKoGIFdK4cV1I/KHyzNB/0bqhNuTf33uAT4937hkjohMN2y2Wpj2/QUeSQJcMO
         SrVQFvYwIpkrk4cx+qxy7pgQEDBeeBd4d+snAZwwEx5LIzGNfQFNzU8HEKpY5yAUMw5Y
         oCgxP2LQq8zO68e2K3F4YBfL+Tx0yo5vvFjFStkGm0Vvnt8yRyuQABcnTlXzOeQJwJsH
         S1iIzX6G0l0PCPa7Ih6m5Xei1zx0AZHlWLNz+gJTRi4RNePBLYZZp6TBVSvMNMiB6itN
         bapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961899; x=1697566699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bk77dOQP27PiG73gUxQsGyH2X+lxrMRV+EDRGaRWSjQ=;
        b=erUyiFR4wTIHsaas/KTN8bsOu7Z9vWmmaerdxDs5uP/02vtHG+vLTeLfI3su9Fr8dP
         Rogk2/bNTtM08nA3y7nvmC/JESR7C9HdcSI61nd2rvybT1vsK8XEmghZO833hzXZLo8n
         NGSzLCc6PxeQGrNCOzwtRN6H73Qr5k/MU/K8dWjDivTQiEZeI3wd9q4P/wdQhHGIdktp
         drGZ9N8WMkWGFHgO/DQ3QNZekEVnREdrxyWZRuuoeA1aJZKPymO3MUmMZo6q0a12vf/B
         miMk1R4KjvzM/3GQ7hjHLHAYjW4aLbHy9v/vDsY+EDlhcVBpUMyaRtxUuoGATlOY5yJF
         ndMg==
X-Gm-Message-State: AOJu0YzFRritdPIjJshdE567i3PO2CP7oz+8C2M/1e78g37ECzcFnqF7
        Z9vFYHuRRC23ZRTBq+9tWNU=
X-Google-Smtp-Source: AGHT+IGsj6CyB+Bgk2IelMiKwZc0FpHtAzxeQwZP2EDKXbD7aNGJKEf63jyWOYHrvbLRwvUrEG99Gg==
X-Received: by 2002:a17:90b:3e88:b0:27c:ea7a:3e84 with SMTP id rj8-20020a17090b3e8800b0027cea7a3e84mr2390535pjb.7.1696961899414;
        Tue, 10 Oct 2023 11:18:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a19c800b00274c541ac9esm11329784pjj.48.2023.10.10.11.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:18:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 11:18:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/131] 5.4.258-rc1 review
Message-ID: <1b3c65f3-9803-4904-959c-3df68a07b918@roeck-us.net>
References: <20231009130116.329529591@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
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

On Mon, Oct 09, 2023 at 03:00:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.258 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 464 pass: 464 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
