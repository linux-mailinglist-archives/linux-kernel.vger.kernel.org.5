Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006117A20C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjIOOXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjIOOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:23:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB541FD6;
        Fri, 15 Sep 2023 07:23:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ada6b0649fso297003166b.1;
        Fri, 15 Sep 2023 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694787779; x=1695392579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGVCkiXWOB11DyLhpvTxqW1sPBrI2lAkEGSU8kx/EBU=;
        b=Bw4nstfF2EogAobnzl9EnGcQu3ZUuNE+NJU+4tWXu//g6pnbYPkl+t2VC4PLxGqQ4R
         PPRT5MwVXsBz4ZTFXIxSf80Tuzsm2rovKMK6GWu9JjntFb/T0qwC3r2k6LhRN5/nIMr1
         gCoyN/wNtHy0+QOG0tsnRHiY4TZZ2jJXzUZltDV7/dW50MsKDnI5U40VZ8zoTe8k1V0J
         xcy8K3QZJPxgjBTtxX8yRSK4GynDmlAAkjYZSuP+/6k5th5mUPSmMJzW4Mn+FK/bAdon
         GTXEMv3C1+lX5LIs5Bb1N15YQNELIEshF3tPFWV7QQcQeIsjFfbVthLi9Agsm5vbTcvT
         /ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694787779; x=1695392579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGVCkiXWOB11DyLhpvTxqW1sPBrI2lAkEGSU8kx/EBU=;
        b=ZIdiw2HNVvJoeeVrWcNKoNOZ48vONI81gawoIuSLqbDbTmIPcamVZrKnWkArQ3ApDL
         xSzu1hTljXB7r/TiTTnrt7ZbAOMcXAqnE5ljAPMPf8fm6UGydxw4BqbghH3wojZPKXut
         Exop59Tcg5Kz+ob73wvjT/nHxUvyrrXRse0reg2YeWPsNV3b6R/uMMBy2MvVn23yEFRQ
         DfnQWMxuFHSDKFAIt8b7zB4t/HwpftD9OG3M3/w6zV2TzAt6INLo3YOoK0jCSjEaxHeh
         PApUPt1QDTh4IAmoNAw7+7zsSRmRxtWtXQm4IVK8iv6SsyMtjWEY/wxGGjZTeuSCaLcV
         ORvg==
X-Gm-Message-State: AOJu0YwOAfn7Ui2N3+hHx8SZ/Su3RKRfXY/87xJyiGYkwQ7byCmMDAlJ
        AgamNjcpWl6wzlZL+uIFHuE=
X-Google-Smtp-Source: AGHT+IGFce7UkaRu27hHw9O1XzUOv7Woyx2ch2dJ4o15aKXnWDBpslZ274zxX9Ictg7Fqo6UzDGQuA==
X-Received: by 2002:a17:907:270b:b0:9a1:e1cf:6c70 with SMTP id w11-20020a170907270b00b009a1e1cf6c70mr1653849ejk.6.1694787778485;
        Fri, 15 Sep 2023 07:22:58 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id w18-20020a170906481200b0099329b3ab67sm2485879ejq.71.2023.09.15.07.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:22:57 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:22:55 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrew Lunn <andrew@lunn.ch>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230915142255.dcosmtrh25nbw5x7@skbuf>
References: <20230912160326.188e1d13@wsk>
 <20230912142644.u4sdkveei3e5hwaf@skbuf>
 <20230912170641.5bfc3cfe@wsk>
 <20230912215523.as4puqamj65dikip@skbuf>
 <20230913102219.773e38f8@wsk>
 <20230913105806.g5p3wck675gbw5fo@skbuf>
 <20230913141548.70658940@wsk>
 <20230913135102.hoyl4tifyf77kdo2@skbuf>
 <20230913184206.6dmfw4weoomjqwfp@skbuf>
 <20230914231831.0f406585@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914231831.0f406585@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:18:31PM +0200, Lukasz Majewski wrote:
> As fair as I understood from the commit message - some part of this
> patch needs to be applied before HSR offloading v4.
> 
> Hence I will wait for it to be posted and upstreamed.
> 
> Only then some of this patch code would be squashed to v5 of hsr
> support.

No, this isn't how this is going to work. I can't post my patches and
then you post yours, because that would mean some functionality is
introduced without a user (ds->ops->port_set_mac_address), and we don't
accept that, because you may or may not resubmit your HSR patches as a
first user of the new infra.

So, what needs to happen is you need to post all the patches as an
all-or-nothing series. Somewhere in Documentation/process/ it is
probably explained in more detail what to pay attention to, when reposting
what is partly others' work. But the basic idea is that you need to keep
the Author: and Signed-off-by: fields if you aren't making major changes,
but you must also add your own Signed-off-by: at the end. You also have
responsibility for the patches that you post, and have to respond to
review feedback, even if they aren't authored for you. You are obviously
free to make changes to patches until they pass your own criteria.

The most that I can do to help you is to split that squashed patch and
put the result on a branch:
https://github.com/vladimiroltean/linux/commits/lukma-ksz-hsr-rfc-v4

But it's up to you to take it from there, rebase it on net-next, review
the result, test it, make sure that the changes are something that you
can justify when submitting, etc. You won't be alone if you need help,
of course, but the point is that you're not 100% passive to this activity.
