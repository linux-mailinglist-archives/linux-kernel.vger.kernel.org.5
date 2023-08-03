Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9776F040
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjHCRAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHCRAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:00:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C8212D;
        Thu,  3 Aug 2023 10:00:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo2007692e87.2;
        Thu, 03 Aug 2023 10:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691082040; x=1691686840;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSV8tU2Xed0CrxKN0ExqCQL3NAOiSSNTMwftFExPE74=;
        b=bTI7LqXuTY4jIVIzXGBXT2VOfOzZOmBbruZhrAAGCW16E4QoEzU/+UIg9tapBTHtmg
         0URTLql0r17ZBF94jEWD4ifRu5dT1wKi27LsZFnhmQoFxLir3tMSys5B1kWz+FVmZZ2Z
         al7qQDVbs1Jb5tjhkYJqwO8yIw1+bqQQlH+lBhexKmV7A1vjnMOEjXnCquewEE0VF3uf
         P0g3Pf5R08PKpNrUxqxakoN1MgbQ2U6lSYm+iIaeKDpxsmZW/PBVK0MV7VbGHWOwAQk4
         S/zvENXF5PsKTi5PTIONjYzRtbJiCE7/5Owt6v/tN0S8zuZB9zmp3Kq9kNvViPmEhhA8
         iJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691082040; x=1691686840;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSV8tU2Xed0CrxKN0ExqCQL3NAOiSSNTMwftFExPE74=;
        b=hfGy9A89tcP76rYZss+nZK0ttaxlHdj9DqwM4UWYXc2tZpBRtNPicGUlcTW04lyuPK
         yMn5C9vDbYq2CRh1JLG+8uNnbiNjCLdI5w6IZqUzLXORpNv+Ex2Vx8XFqEGCccbYKWNf
         uKOrmWTL3dyB29eGuCg0oBaiEu5yHgLi+QBirGC8pHAkRVPZ4p4dBNdRyI0MxJAx1K7c
         7XkqH4C1Z+pogs9js8c5CGb2IiGdgRoj2h+QRqw0/Xg7xm0xoRopeP1kiFXHDQSZZYQG
         9QyU5RiOsRjCUeKqZr5Xf+LU4q3D1AlDj93mj1uykS4gP6uLgYiNbZIZyfLjyxkcmDrs
         1U9Q==
X-Gm-Message-State: ABy/qLYKVgYqTk0iqDe6M41d9e5onywUdVwv/l/3HKxTqgqQaARvEFFT
        3vUev7ysSCgM54MdxtCnkhZvwkGg1FM=
X-Google-Smtp-Source: APBJJlExghUM8ysBRm/2An6b744Ys4TQw6w1hZy4xU12spPy8OqXdpTKVTm2XNKETo4zoihWKs5kBQ==
X-Received: by 2002:ac2:5e6b:0:b0:4f8:5905:8e0a with SMTP id a11-20020ac25e6b000000b004f859058e0amr6476941lfr.6.1691082039582;
        Thu, 03 Aug 2023 10:00:39 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.72.24])
        by smtp.gmail.com with ESMTPSA id o15-20020a056512050f00b004fb85ffc82csm38322lfb.10.2023.08.03.10.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 10:00:38 -0700 (PDT)
Subject: Re: [PATCH -next v3] usb: gadget: udc: gr_udc: Do not check 0 for
 platform_get_irq()
To:     Zhu Wang <wangzhu9@huawei.com>, gregkh@linuxfoundation.org,
        herve.codina@bootlin.com, stern@rowland.harvard.edu,
        robh@kernel.org, aaro.koskinen@iki.fi, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803121136.86037-1-wangzhu9@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e85efc8e-5a12-5f9f-a23e-d701b5722896@gmail.com>
Date:   Thu, 3 Aug 2023 20:00:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230803121136.86037-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 3:11 PM, Zhu Wang wrote:

> When platform_get_irq() failed, it may return -EPROBE_DEFER, -EINVAL or
> -ENXIO, it is important to propagate the detail upstream, we cannot
> override it.

   Deferred probing being fixed should be emphasized. And the patch is
no longer "-next" material due to that...

> And platform_get_irq() used to return 0 (as both IRQ0 and error
> indication), there are several patches fixing the inconsistencies.

   No, this "historical" passage wasn't meant to be a part of the patch
description.

> Commit ce753ad1549c ("platform: finally disallow IRQ0 in
> platform_get_irq() and its ilk") makes sure IRQ0 is not returned.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> 
> ---
> Changes in v2:
> - Update the commit message, present the reason of replacing the return
> value of the probe.
> 
> ---
> Changes in v3:
> - Update the commit message, explain in detail why the return value of
> platform_get_irq() cannot be override.

   As I said, your descrioption isn't very convincing as you don't
emphasize the deferred probing being fixed.

[...]

MBR, Sergey
