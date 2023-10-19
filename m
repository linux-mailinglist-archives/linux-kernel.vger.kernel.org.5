Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958747D025A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346457AbjJSTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346334AbjJSTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:17:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22314CA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:17:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so14083667a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697743074; x=1698347874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iXwCx1QyFHd74if3jkrD/AR9CcBz0fWjvPdcZXYAff8=;
        b=Toi0ttLYmvjclT5ZlgaAIfgEG8MjTQn/8yv1zMa+Zed2Z+q/ljRrve3teXJcJkLbKX
         dBDmUPlJhZkk36SmSBJr/zLhiK/EMuDRwvfZ+kTKE2tEWxYxqkW+TgZB3dUI+78dSPGT
         im3kUAyetGE8h+7NUcRWBR6HxAR7ete5p5m20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743074; x=1698347874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXwCx1QyFHd74if3jkrD/AR9CcBz0fWjvPdcZXYAff8=;
        b=Q8Ywvz75g0ZEJuIz+P6L+DqcNaiC/wIKm+Dgs/0J4UH302gX9nL9RjEO8nKiRdqHK4
         ZDgv6ULkEf38x6tLP6YnUHojBC5hwrX9nCeXpDAI4zy2+zawffzjRKmxakl9LgOmz8tj
         RNzJK4m0xaEUgubz6PawrqdFS/75F3m1hQLRvVvCPEzs3r7IqzpBa58pUv46mFFgWY2K
         s7vq77jSFIXCxBEQ8msf9VlmBKlCa7x9cUXTj2eLn2C7PI8ylh08Cd+S56F4DrU5gmQi
         sqHCY+SP2SxuubJWUTCC+wsNU68M3mwfAtnn2/EtICT23SmwJopFspEjTcPup+SMwife
         GSIg==
X-Gm-Message-State: AOJu0YzOaPwEAKoGDRoxffL8g4FtoSxPVPcjdo/xdsltCvF1jHCUuF2Y
        C3BUDvJ3OAPVcs6rWFAChDhmyGn99BwjW7mBJTtSyyKN
X-Google-Smtp-Source: AGHT+IFBRZEnjiGZdE8KucZOVD5OMIRwuv91zBsRSHhFhIRBFW35ZseRVteR7BR/6PwJgw0j65xY8A==
X-Received: by 2002:a05:6402:520b:b0:532:cae2:8dfc with SMTP id s11-20020a056402520b00b00532cae28dfcmr2691777edd.5.1697743074420;
        Thu, 19 Oct 2023 12:17:54 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id h28-20020a50cddc000000b0053e589016a7sm111067edj.16.2023.10.19.12.17.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 12:17:54 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9ba081173a3so9157266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:17:53 -0700 (PDT)
X-Received: by 2002:a17:907:3687:b0:9be:aebc:d480 with SMTP id
 bi7-20020a170907368700b009beaebcd480mr2243860ejc.24.1697743073410; Thu, 19
 Oct 2023 12:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231019174735.1177985-1-kuba@kernel.org>
In-Reply-To: <20231019174735.1177985-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 12:17:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
Message-ID: <CAHk-=wh0jmsuetiD_k+M9NHt=ZH=9AyBa-3+MYDfBPMw6tsaOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.6-rc7
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 10:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Happy Nov 1st to you and your surrounding spirits.

Well, it certainly sounds like *somebody* has surrounded himself with spirits.

Of the alcoholic kind.

Just _what_ does the calendar on your wall look like?  Is it maybe
spinning or looks doubled up?

                   Linus
