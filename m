Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A83877BD67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHNPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHNPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:49:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA46DDD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:49:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso3001933b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692028150; x=1692632950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYiTF3LUp//kvce+GMZR6GgGsS/cIG7u9YAsbVgnE+s=;
        b=FoBT58iuObS+7FtaiTCVYKf0gb58OCOL9TQyNx59olDICau3OkAaiZU3R11DH8AgqS
         WY5Z38rWUcf6/SrYBiQiDZ61rdcYGQwl3hJSHu//WPlfKoq4w8iJJbdMElqGbrG3CTmv
         ZwdTCCcv30/xj3GL5qzO6V50yEhhPKbmVI7jmOtqDUEnDtWvRY1I1F6WI2S2TdJTDPdb
         ijBLvH1T3EysM8lHMQknd56GY02j9mJo0At4XDe6rI76hAMhKldgwwcSzL/XKKlvcLhR
         LaYBbrftKSEkz9EsS2FCgItLbXecNjouDuYzTtVEUSIQqQIbJUdgeHZHB39x/6g7u58q
         xXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028150; x=1692632950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYiTF3LUp//kvce+GMZR6GgGsS/cIG7u9YAsbVgnE+s=;
        b=Br0HJ+kXPOSsiKFJNJtWHK9LYllyfqzv+fHIh9xthf1LZCERg/n/sVCU0Z1TEshXlo
         FHiTvw2J7GC1+XX4HbXXjy7NOn1oP4c+wB0hbnIC4oAd1LNIak9nT+XrIJnqDvotscCx
         /lJ7L3BNdcAdstTXJQAqiNKlLdkpJ53tMYWwY8/1mnm1gBR59ww2/pZllW4QEhyewUHP
         UmRrImwhSbyphBuHZij72R4t7X/ItpJ1YAfkLL2cZX+0l6sXWX+N8qqLQy+0rGWhScwT
         GSWrdhGdynRjoBhVmhTr+mO+IaP0ZFK6ZnAIdt04AdQR76MS9stftQ+x9tACnh6w6g2e
         szGA==
X-Gm-Message-State: AOJu0YwUe7nT+C2v+jrh6q1JIuhV/Y4nh80KV9OdDkD2DG4FlBmmGXkZ
        FdfPQ57P+KH01qvo9+VAOsiXQw==
X-Google-Smtp-Source: AGHT+IHDRkUwKePnso/znzWYdzs8w4Ckkub/nNx11D5ZuAZF7ZXCNDr91URmH2E26oA10zI+aZPFCQ==
X-Received: by 2002:a05:6a20:8406:b0:140:ef2a:9b75 with SMTP id c6-20020a056a20840600b00140ef2a9b75mr11090240pzd.61.1692028150113;
        Mon, 14 Aug 2023 08:49:10 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id l4-20020a639844000000b00565b8e0798csm2462389pgo.57.2023.08.14.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:49:09 -0700 (PDT)
Date:   Mon, 14 Aug 2023 08:49:07 -0700
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
Subject: Re: [PATCH net-next 2/3] [PATCH 2/3] netem: allow using a seeded
 PRNG for generating random losses
Message-ID: <20230814084907.18c339c2@hermes.local>
In-Reply-To: <20230814023147.1389074-3-francois.michel@uclouvain.be>
References: <20230814023147.1389074-1-francois.michel@uclouvain.be>
        <20230814023147.1389074-3-francois.michel@uclouvain.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 04:31:39 +0200
Francois Michel <francois.michel@uclouvain.be> wrote:

> +/* netem_get_random_u32 - polls a new random 32-bits integer from
> + * the prng.
> + * Uses a deterministic seeded prng if p->deterministic_rng is true.
> + * Uses get_random_u32() underneath if p is NULL or if p->deterministic_=
rng
> + * is false.
> + */
> +static u32 netem_get_random_u32(struct prng *p)

Overall I am fine with this patch, but the function name is getting excessi=
vely
long. It is a local function, so no need for netem_ prefix.

Checking for p =3D=3D NULL is redundant, all callers are passing a valid po=
inter.

For logical consistency, put the new wrapper before init_crandom() and afte=
r netem_skb_cb().

Since this is not security related, the change could also be simplified to =
just
always prandom_u32_state() and initialize the state on first use with eithe=
r=20
get_random or provided seed.  This would also simplify the code around stor=
ing
original seed and boolean.

Reminds me of the quote attributed to Mark Twain:
=E2=80=9CI apologize for such a long letter - I didn't have time to write a=
 short one.=E2=80=9D
