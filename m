Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47DD7E01CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjKCKkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjKCKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:40:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C73187
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:40:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40859c46447so12291945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699008004; x=1699612804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy+FX8zGhNkWXszFiiW9K509Gia4V97/gsM6LXZa8JM=;
        b=edFM2OZ3tAJzFgKae8lvg7aWbFPJuuDUoSEnDY0EjwuhB1muh5sSTAoZlZdUa+065o
         xS3NH26jZXyHyhUuYlA69BqLtK1a1/RcrRuWBb7BfoYAkOR6VgVwFb9QwYTv26huASZG
         ywsmMnwKCWtPTo8gHySTSYSg/ylKkLlBz5W2Oh46vcRZVaZwXhJaFcZ3H2SDgYOrh/rX
         cfN5xwxwy5Tm1kcqGiGcV8VvM+SClzctsG8kcsKOUDZIHNu7ICAJKYWZ5Ek5sFNyNz9+
         84L09sPhPDF87aFLWiJ2P0mET2ddJEQqUhLi53P711OI2Y1AIZVAGmC7Q0AuZZTm1E9x
         gJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699008004; x=1699612804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy+FX8zGhNkWXszFiiW9K509Gia4V97/gsM6LXZa8JM=;
        b=UO9Cu0sE+I5hQGvdJ+upV9OXVWknk9WqbjDMmiRkYdweKbT4omSm48qP+GMkyvnE2S
         pOiyu+/RWdAE12iwZKAOd1YcPSD93pnhq7ldvdwq5gFP4t3fDZ0eKT0bILR1gXrRPAuL
         Kw/lM4C5aphSOlsoMwVrvR3+RHDme5RoD+fDlFpAifpsdn53EaqnmK4jfsui9YQjA5bw
         gKi/7pfYIutTnPCf6papARXS7nPBimvErljLqWrMfUpbjXfZxOhsxNgUreXPlw/Zm8sd
         ZNAXpB+7kPCBi5JIcFLO+wy3x3AL5+KXNiQe5thaD3RUiYtderz5pDIzTvAzbKvszOfL
         JWNw==
X-Gm-Message-State: AOJu0Yz+HjF7+TLQkzIz0MR7CBQug1YyNdvmuwnaGM4mTtQ+2FqNpLxO
        pfyPmOJCxU4tra25Mo6cqkjvHg==
X-Google-Smtp-Source: AGHT+IEgzh0g0qg04M6eJLpsBi4oCP5l5Qi0W2jfjVOStWT5hplVwwv9A9Wz77tyfwsKH/NEVbfitQ==
X-Received: by 2002:a05:600c:1d95:b0:409:375:5a44 with SMTP id p21-20020a05600c1d9500b0040903755a44mr17399496wms.24.1699008003596;
        Fri, 03 Nov 2023 03:40:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b004095874f6d3sm2090103wmb.28.2023.11.03.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 03:40:02 -0700 (PDT)
Date:   Fri, 3 Nov 2023 11:40:01 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Jinjian Song <songjinjian@hotmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nmarupaka@google.com,
        vsankar@lenovo.com, danielwinkler@google.com
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Message-ID: <ZUTOAd0bGVHsTKDv@nanopsycho>
References: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
 <ZQF+PHTYDZRX1gql@nanopsycho>
 <CAMZdPi-qZ3JjZmEAtEmJETNzKd+k6UcLnLkM0MZoSZ1hKaOXuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi-qZ3JjZmEAtEmJETNzKd+k6UcLnLkM0MZoSZ1hKaOXuA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Sep 21, 2023 at 11:36:26AM CEST, loic.poulain@linaro.org wrote:
>On Wed, 13 Sept 2023 at 11:17, Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
>> >Adds support for t7xx wwan device firmware flashing & coredump collection
>> >using devlink.
>>
>> I don't believe that use of devlink is correct here. It seems like a
>> misfit. IIUC, what you need is to communicate with the modem. Basically
>> a communication channel to modem. The other wwan drivers implement these
>> channels in _ctrl.c files, using multiple protocols. Why can't you do
>> something similar and let devlink out of this please?
>>
>> Until you put in arguments why you really need devlink and why is it a
>> good fit, I'm against this. Please don't send any other versions of this
>> patchset that use devlink.
>
>The t7xx driver already has regular wwan data and control interfaces
>registered with the wwan framework, making it functional. Here the
>exposed low level resources are not really wwan/class specific as it
>is for firmware upgrade and coredump, so I think that is why Jinjian
>chose the 'feature agnostic' devlink framework. IMHO I think it makes
>sense to rely on such a framework, or maybe on the devcoredump class.
>
>That said, I see the protocol for flashing and doing the coreboot is
>fastboot, which is already supported on the user side with the
>fastboot tool, so I'm not sure abstracting it here makes sense. If the
>protocol is really fasboot compliant, Wouldn't it be simpler to
>directly expose it as a new device/channel? and rely on a userspace
>tool for regular fastboot operations (flash, boot, dump). This may
>require slightly modifying the fastboot tool to detect and support
>that new transport (in addition to the existing usb and ethernet
>support).

Sounds sane. Please let devlink out of this.

>
>Regards,
>Loic
