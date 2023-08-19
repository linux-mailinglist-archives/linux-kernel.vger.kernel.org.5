Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB03781601
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbjHSARf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbjHSARN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:17:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F63598
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:17:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf57366ccdso1508875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692404231; x=1693009031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl3HSKdP9YyG6XfcZQMdMolTOKjSPOnqvZmltAU/pms=;
        b=vvAIxrqSKvFwGXMIOkOtTmTZVCjquR1CworpjEAd9AyRGuMfbYpCCHzzOt6EkJm5QT
         JpfIRGVD0udXvv5hMtGEY8a0GaQqn7r8xTGsgeYxQ0HWSky2FMzZHcDjD4ModhWqP1fr
         Rq5bOL+Yix8kltg13xsycLauBeKCispL/UI2BMiqqKMq9BU6vZw7Nv0NAYz172XTL2fD
         IlDGKPCnC7VKGYpEGULSIDhMHPjGWin3qQjvU8ciy7R6g/qFedDB0/G7PWK4Ylwi6qMg
         gG9y23hF7TyzIRrJwfAb3Jtzy9xi4c+pl40Q8m/RF6MBeEqFuWEfAZsHDN7uxtHInF90
         tKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692404231; x=1693009031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl3HSKdP9YyG6XfcZQMdMolTOKjSPOnqvZmltAU/pms=;
        b=c2ZRIbwmz/ZtmOHhpPIil/0+eKeR2TMl2YDtHA0CCfvu14d5j+6mbWC52X28OZ4Fit
         hklnBxS1A3GWX6bZEvnqKDmccrKvVbVVR8NV+4rTyY/t5nEbCBtIxkGbYcItKkWW1P3C
         W5VGOAfNUzgxHXP4xOeFWC5Fa57gDY7VHhW88waxJASlhVCMlTgqJmBZxfwlMVLey+v3
         0je3ylsg+EOQcRztZpYWNAWjK2UyHkp7FqejB/2Dt0+7CpXFXXHb+S83ky+FjThisNGn
         WwpcE0jDL5eRctu+vVBk3dUsSqUEFKMLYO4gSSA/26LU143KobuhUuZqFhFyqCzUxIz8
         o61A==
X-Gm-Message-State: AOJu0YxeY56pOM4QzB2w46mkhlQCCnWr+ZTOM1F+nurrm+ikUDdWkXXj
        /zZ2ZM0AqxbbrHxV6wfl8NagzA==
X-Google-Smtp-Source: AGHT+IH4/TzxhIX71BTgsw0idlC14Gy98pX06t/ra6t309RFxHdktVqwKFDUCVTDOr/ITc0zbcbRqQ==
X-Received: by 2002:a17:902:f547:b0:1bd:ea18:925d with SMTP id h7-20020a170902f54700b001bdea18925dmr883088plf.6.1692404231414;
        Fri, 18 Aug 2023 17:17:11 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001bc21222e34sm2302569plz.285.2023.08.18.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 17:17:11 -0700 (PDT)
Date:   Fri, 18 Aug 2023 17:17:09 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Francois Michel <francois.michel@uclouvain.be>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/3] netem: use a seeded PRNG for loss and
 corruption events
Message-ID: <20230818171709.56f8be07@hermes.local>
In-Reply-To: <20230815092348.1449179-1-francois.michel@uclouvain.be>
References: <20230815092348.1449179-1-francois.michel@uclouvain.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 11:23:37 +0200
Francois Michel <francois.michel@uclouvain.be> wrote:

> From: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>
>=20
> In order to reproduce bugs or performance evaluation of
> network protocols and applications, it is useful to have
> reproducible test suites and tools. This patch adds
> a way to specify a PRNG seed through the
> TCA_NETEM_PRNG_SEED attribute for generating netem
> loss and corruption events. Initializing the qdisc
> with the same seed leads to the exact same loss
> and corruption patterns. If no seed is explicitly
> specified, the qdisc generates a random seed using
> get_random_u64().
>=20
> This patch can be and has been tested using tc from
> the following iproute2-next fork:
> https://github.com/francoismichel/iproute2-next
>=20
> For instance, setting the seed 42424242 on the loopback
> with a loss rate of 10% will systematically drop the 5th,
> 12th and 24th packet when sending 25 packets.
>=20
> v1 -> v2: Address comments and directly use
> prandom_u32_state() instead of get_random_u32() for
> generating loss and corruption events. Generates a random
> seed using get_random_u64() if none was provided explicitly.
>=20
> Fran=C3=A7ois Michel (3):
>   netem: add prng attribute to netem_sched_data
>   netem: use a seeded PRNG for generating random losses
>   netem: use seeded PRNG for correlated loss events
>=20
>  include/uapi/linux/pkt_sched.h |  1 +
>  net/sched/sch_netem.c          | 49 +++++++++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 15 deletions(-)
>=20
>=20
> base-commit: f614a29d6ca6962139b0eb36b985e3dda80258a6

Would you please send an iproute2 patch now for iproute-next
