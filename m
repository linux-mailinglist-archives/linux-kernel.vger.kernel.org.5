Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399D7CE09B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjJRPBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:01:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB47BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:01:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40837124e1cso75685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697641261; x=1698246061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk+MM8czq8tgZOqn2VBLd0vJ/2zm2P/1DV6ZL3LXnqE=;
        b=aAV69AUYEaScpeEE4dqzuh1sZIvqWOPFIphoLC8aRoiaT8GrEqautZKWObyyzrjvRn
         UrWfntfBBY3PlHLKvBFHO236zsWpGT0Femg6Be9eC6TBUmHlc8t7TsbecToKqBPscogd
         H7YSZJhIi4H8Wh+WVhIHRnoHT1pyU3L88I+Ovu9kOn+vcuc2Cvl83DFithEHOu3j2/ie
         DUth8KVwby4BnASthE5KHIb82K53Ao4D1hIy7LXlZU1GmVhymlbIi/WqfyirYlE/rSD2
         wG5mrjVNMVoqqThc3pyQ2u8OD4SWfUDDQTp9C2QuSJZFGbHKt1Tss4cVXcpUFYiVcm24
         aREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641261; x=1698246061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk+MM8czq8tgZOqn2VBLd0vJ/2zm2P/1DV6ZL3LXnqE=;
        b=jyP91GzeYtjzy9aO4LtHL/P8rgvFU+sfIA20HhUZ6m8SwbG1CrluXUYzp9C2t3jUTw
         QaB9O0Vcehvo02iRieWfFiMV04qUjs2GofyAZFRJ9hqdHBhY9t1MRG6kWV9Lhoe8vh/y
         6iu7a2I1/gGROcX6HYHUWurd9xfq3LY51ubtmgtlEAw/IPvxvU8QwYfosS7l/kXCVwtr
         9+DOAbUGKfu/SPeAE9RhrEj5i/c/8a6dy8ubPtZbFgI/h2+3Mt/FocgAI06BABtsFldG
         cJ3GavkADFT3DRB2+403nP1Ge2zXyVqpd9OivsNKe+HGpGOxmS/xjnrwIOg2t3dgk4KG
         vrOw==
X-Gm-Message-State: AOJu0YySmfugbNCvN+On8TJuWeTixiD8Gf4P8EhkIZk4T8CNecBukXS/
        MwytAuKNpyNtYZbvWHicsTyFArs6Qb3sJ7H7/gRYrg==
X-Google-Smtp-Source: AGHT+IFWwSb1RVFY6lDcXkgSyswXKbEpQdqRJL3k+/d4+rZy2CE3vpR2U4Gis3Ebw3YUMony2CiNFuWPAhLI9dg3x/Q=
X-Received: by 2002:a1c:790b:0:b0:405:38d1:e146 with SMTP id
 l11-20020a1c790b000000b0040538d1e146mr135173wme.4.1697641261203; Wed, 18 Oct
 2023 08:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231016125934.1970789-1-vschneid@redhat.com> <CANn89i+pQ3j+rb2SjFWjCU7BEges3TADDes5+csEr1JJamtzPQ@mail.gmail.com>
 <xhsmhil74m10c.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhil74m10c.mognet@vschneid.remote.csb>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 18 Oct 2023 17:00:46 +0200
Message-ID: <CANn89iJUicsEdbp7qrsaSUg8jQ=dBUr0nK296LxXp5rnPrw8cA@mail.gmail.com>
Subject: Re: [RFC PATCH] tcp/dcpp: Un-pin tw_timer
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 4:57=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:

>
> Looks reasonable to me, I'll go write v2.
>
> Thanks for the help!

Sure thing !

BTW, we also use TIMER_PINNED for req->rsk_timer, are you working on it too=
 ?
