Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37A7904ED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjIBEQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjIBEQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:16:53 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0591707;
        Fri,  1 Sep 2023 21:16:50 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79241bb5807so102492639f.0;
        Fri, 01 Sep 2023 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628209; x=1694233009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn0xHwv2rnNYSCU1MdlYy8SVfM9L1gdwdaOM8IFddv0=;
        b=VxdbCXu2Sk3P0u9nmC+4pU3X8Bm0ypSUPfZ5XBEg1UecZT/qQH4IwBKW9i3bWDNkTL
         eNME8hzI/saXxUwtFxupOSQL6YjlADQqmqdotnFHkQ01dMHnR+TDyTNmqcLISIKd4uhp
         KFvKz6zqeBpz6r+N7Wywl0TaOJTyLoiIUo63ubP8Qx0H/OiNGg1WeicB5i3upQteNYFJ
         KG7zs2ISngHnQBic/TsIUDvl3SAM3tf95xEc3r3cuMpvNP3g0qBHSN8PF1u1wRQNv0s6
         xRZDIAS+t1RV+gbEKZThx/QBHPFZH0Hz+6Vo6jo2LMYFk8pS21DZl1hod4U5F6mK41mH
         Gtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628209; x=1694233009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fn0xHwv2rnNYSCU1MdlYy8SVfM9L1gdwdaOM8IFddv0=;
        b=k4SymTM2eAGQCQ1quZ0edGylvepMwM46xsr3EJDkPlB2Brrh+w5nOFS3NmOHtifjtq
         ey2K2DnroL+NjaaqCj+PiCJHAoqIaiGwNXC6rMpYPTmAMYtNjC2aH2rwpPcMj+Z6vDIu
         mzU9P1NU6FnCNdoaAcBS/GS5sq7YjdChurTzOWK1rATSDqpoQR/HcXhd9xc0xX04BPkh
         Cpm2rJ7/JuC9zHP7pqlsAbxEVTgBcy56o0xdmlZn+WbF3thVX6dW1UmxOCKyf+KTW7lV
         Bs9FG/8SGSplTl6ns7PBg0o6GdM8k2dCs4BSCw0a0XFsTkTRtB7fpDROaOq2ckD6Xov8
         46WQ==
X-Gm-Message-State: AOJu0Yx6BMqu4qk52Gct8IxwvJjG70hH6eOipCUrFV4LUWBReu7Nqptz
        Ggf2Jah/BM6R6+u3QKM0hN0=
X-Google-Smtp-Source: AGHT+IHm2mwrACbKf6pmglfjsXQvvEEMvWp5umPFE9T8iiu5ly5C3A40D0ur+m4LcI1G4d/DlGj6bw==
X-Received: by 2002:a92:c70a:0:b0:34c:fed8:8df2 with SMTP id a10-20020a92c70a000000b0034cfed88df2mr4383720ilp.21.1693628209394;
        Fri, 01 Sep 2023 21:16:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p13-20020a92da4d000000b00348730b48a1sm1517201ilq.43.2023.09.01.21.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:16:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:16:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 0/2] 4.19.294-rc2 review
Message-ID: <6adc9db8-1468-45f3-8323-fb11c54c1b73@roeck-us.net>
References: <20230831172214.759342877@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831172214.759342877@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 07:30:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.294 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 17:22:08 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 432 pass: 432 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
