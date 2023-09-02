Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205D7904F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbjIBET1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjIBETZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:19:25 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C54B10FE;
        Fri,  1 Sep 2023 21:19:23 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34bbc5eb310so8977465ab.2;
        Fri, 01 Sep 2023 21:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628362; x=1694233162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QdftxmwE9S4q+Wm8VAAV5jDe5pULUFp51jEAHN/z6U=;
        b=OtcnTuokXzGl5ggP/0JxKYnRrH3In8SglMwLzr/mS+m6HLHbDT8Fm3UmjD+3Wfviz1
         PJJm7c9k7bcjNfeL3Fbd4IXxtCZvFbPyBPFtynTFDGTeE+InqWvqGV6BhBRER+oq4jIN
         ZkLvALrQcemolf70PjM0TgW0Qhyg/IHoChq2rSVnp4zhjOV432yCe9Q6jN/aApQvq2E6
         s6C60mAY3iSFDYn6Dr4+teplS9CTmNjXNRYXtSrVoIBIw6TVJ1hMuCWKv8IG1xqpg4qc
         N3254kDj2xqfHiSGfwuS03ZZGHVqer5246p0MB3LAk062D15PziEGa6NXiUsv67EvtN1
         30KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628362; x=1694233162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QdftxmwE9S4q+Wm8VAAV5jDe5pULUFp51jEAHN/z6U=;
        b=LuDidPWlKHt1nUaS1FvZrQbhONa1pGchR5ew/CybjXpIHVOB2PYnBNDvr+E5dzHyZH
         gTC+ZtIvbRKT8RKWGTZ6eEnrY5jXr5lPHBEB7wYVr0OM7dTSjTS2b8ZFpwbklLj9Kkro
         hLIRkAwuo50eZUoFm44Lug5qMzU9wpkKScN28ACNYtMAsElv7dSOz4NFeVZFxXzf4Ypf
         GO2CkV+H0uijF2ayjD/mKUuCO0+2mAs9CNdD7kT8b4uK/OE/FdTry7gUWL2tmP9MTAki
         F0q2On9pGJxJmWEINzhxkYJJZfzWdCfwbP7WEF4p2GdpYmh5ExLbGg/5naSJr65Fb2Dp
         zFTA==
X-Gm-Message-State: AOJu0YxP8FOVxPGvLt0QbQ/iv0FMUR0SpYd95VAWIuqqHS10aUjAnZnx
        8r0zUqlQVUGLVVJtnFCRGSU=
X-Google-Smtp-Source: AGHT+IERpXr+53LLKHCJ0ONZGVx8+rUUepKdylO8PBQm59sdQHCv/UZq4gc1yVK6qaJIVobhUcyWLw==
X-Received: by 2002:a05:6e02:d0c:b0:34b:ad7a:383f with SMTP id g12-20020a056e020d0c00b0034bad7a383fmr4796388ilj.0.1693628362441;
        Fri, 01 Sep 2023 21:19:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gg18-20020a056638691200b0042b57bbbaf2sm1568330jab.26.2023.09.01.21.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:19:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:19:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
Message-ID: <970e0987-99ae-4194-a40c-6a5e18eb0899@roeck-us.net>
References: <20230831110831.079963475@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 01:10:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 521 pass: 521 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
