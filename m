Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5AF7D4E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjJXKy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjJXKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E6B128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698144821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6ob6RKRIAPi5Khx0xpjNiWs6euw8iDGvt/Bc/jthnM=;
        b=YEQRjnw8EYq2ay8qrTSYfsQQ3Ob1AgZSb77capLIsYJe+yEx0t5qhZ+2IMwvRQlWcEVkJ8
        0Fo2kVWUp5cE6zSmgMFiWoxN3aXPMpWF7AtF1jHmK6Trm+BQZ6RZRDJ6LMOquj3XyNW9qj
        7Tmmrl0E1IKxxFAgSaM5t081vVbDcbA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-JCDgLq7aPJeO5NyVE20PwA-1; Tue, 24 Oct 2023 06:53:30 -0400
X-MC-Unique: JCDgLq7aPJeO5NyVE20PwA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c50cf8cf25so7607381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698144809; x=1698749609;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6ob6RKRIAPi5Khx0xpjNiWs6euw8iDGvt/Bc/jthnM=;
        b=qasBACy2Rj4u7SQhMwhwlc5GT/uaWXoSjMq4FLbXxe5DAFs+VqIVtArwznDWyb7mu1
         yRgm44v80MK30xFc5oZq4zCJeFbciY2mc/e0Tpfe0PUmLnyweEoJCsrYUC7XUnAH/fok
         pN/cUp5XE4YdqKdc4DONPQKcibrLLYtJvWReg9YgWsobUsoUhKk6EQyRz+ShEQP8yXJf
         DRv+BioqKRrkdC92uUioBP8tGfH/Nonr3JI++ho+YbxbvrPqdS+ewRgjmrmX/iwYrmjX
         H3AD8tuLdOgB1qEx0yOGAYfq0lxQGjLbv8mHq0HLWLO9I6MR/kVI6Sz0vx6zoASeHmSQ
         ms3Q==
X-Gm-Message-State: AOJu0Yx3B2CIjvnohx0W+hkG1BKeJNDhKCc8SgCbQKAOZwhPtcnY7e7g
        RR7wD2+dAQWbBKR+tw2mN/NkT4gIQ055YXhSl+bOG7NXv0EC7IMSi5ITQ4ZlWJmR9geBdaVyKCV
        IzhEqu6euA/aQJx7jllrzkQ6h
X-Received: by 2002:a2e:9093:0:b0:2bf:e5dc:aa68 with SMTP id l19-20020a2e9093000000b002bfe5dcaa68mr8167972ljg.3.1698144808826;
        Tue, 24 Oct 2023 03:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6+UwT5yEGXNUvPuTwPIUcgM8GHlIrJ64DEgbjtALnH/OkHpdWanmLDXcDqMv2xU2rWv9gcg==
X-Received: by 2002:a2e:9093:0:b0:2bf:e5dc:aa68 with SMTP id l19-20020a2e9093000000b002bfe5dcaa68mr8167954ljg.3.1698144808405;
        Tue, 24 Oct 2023 03:53:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-180.dyn.eolo.it. [146.241.242.180])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906070e00b00993664a9987sm8086424ejb.103.2023.10.24.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:53:27 -0700 (PDT)
Message-ID: <b0b4054adcb5250ad49e19d8f90c89de802f0125.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: ethernet: renesas: drop SoC names in
 Kconfig
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Oct 2023 12:53:26 +0200
In-Reply-To: <20231022205316.3209-3-wsa+renesas@sang-engineering.com>
References: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
         <20231022205316.3209-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-22 at 22:53 +0200, Wolfram Sang wrote:
> Mentioning SoCs in Kconfig descriptions tends to get stale (e.g. RAVB is
> missing RZV2M) or imprecise (e.g. SH_ETH is not available on all
> R8A779x). Drop them instead of providing vague information. Improve the
> file description a tad while here.

It's not a big deal, but assuming that keeping the SoC list up2date
requires too much effort, I would still keep it, with some additional
wording specifying it's partial and potentially inaccurate.

Such list could be an useful starting point for an integrator looking
for the correct driver for his/her SoC.

Cheers,

Paolo

