Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDEF77E490
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbjHPPC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbjHPPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:02:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A55272D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:02:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc63ef9959so55767575ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692198152; x=1692802952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3ovHL4vsZpaBC0Teekk8Hm69hMzF6WHsF7ZTf9695s=;
        b=FVdpCXCQ/oguFtjMTqentpBSc8qPydSSGGSMI0rcBbdAZDj6ljjYr21rGjjOzOcdd3
         F0f+nuAu+nq5gFMzsOL9z6+WBzQR6nevKgr98Nbqf+oJ6qoZ4zyKC9yBLTi7eAvnRjjk
         dRvaXZvyTPl0c1Ae1EfKx9hXP8fQjKEwHTTmKHeM9JjbWdyyzVfiKVO27HAH2RBwWrMS
         +QieW1785dbCpNrBM356U5zpCO5/iGCuHlSyLmLCKEk3UwFVlQ8zgbS1YDlVNTmREsfq
         il7tSuVRSG7KE2JD080SyfRPw1eHQD2YXCx/ktC7jZjr8uO9YyRVpJr36yociuvCHMyt
         f4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692198152; x=1692802952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3ovHL4vsZpaBC0Teekk8Hm69hMzF6WHsF7ZTf9695s=;
        b=AuLnfNWy2hTYdFuEZyupjyvgxG8Ya1mTHyvU8gMt1QTv/5yF29MGy98xAz4rbthpE0
         JbgMcUmIf+MZ3hQk8xHkX2M6Ko1hx33SnadlGE1BcHHsQqwadBgb5A5wYXzaWQ8MakiG
         j2NgLo9h4YtJXvEF5+mBn5HOg2T++5L6l2nTahQoRIyq/xZEwvlWO9hhoMlok6aRyo20
         NHkw0SqM4GrvDtJzq0vFML1VoinogodST/YosXSCoAHc3eQOQA+TUM5Q0BpHTJImH1rv
         hVKPWaFRkQ4vwF2xssOWzA/w8sB5K6nJ0S2eghD7cQn/nVFR95Id87Q+BImOFLAnpaEq
         Ubqg==
X-Gm-Message-State: AOJu0Yw2ZVPgAKHK/Ze2aB62qtal0tqwzQ0DTfonEzPuHHRgDxqRUhHg
        EOwncq4GG4AGg6wtJflEkOuwlg==
X-Google-Smtp-Source: AGHT+IFd8wPbgHCjMzOL8CkDvee20k8jdoTIdoknxF2Ky/fYUUuSYv9RKBVjvMD/hlTvX6o0gLlN5Q==
X-Received: by 2002:a17:902:db0e:b0:1b9:de75:d5bb with SMTP id m14-20020a170902db0e00b001b9de75d5bbmr2660626plx.7.1692198151771;
        Wed, 16 Aug 2023 08:02:31 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001b9df74ba5asm8815352plg.210.2023.08.16.08.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:02:31 -0700 (PDT)
Date:   Wed, 16 Aug 2023 08:02:29 -0700
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
Message-ID: <20230816080229.7d128695@hermes.local>
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

For series.
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
