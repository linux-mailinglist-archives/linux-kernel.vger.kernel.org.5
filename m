Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5641875CCC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGUPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjGUPzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:55:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9C35A0;
        Fri, 21 Jul 2023 08:55:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6862842a028so1405319b3a.0;
        Fri, 21 Jul 2023 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954923; x=1690559723;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9Nkz09J0OWI8g55rIWxy1NKC5S7asE7sS8B85Det4w=;
        b=Tuv9oN/LT9x0NGtgdwqfgzNpbSMdVfxcVtV2YUFxa5Lnf7p0nkDaGoMM0CHpt/4rlb
         c5rQ1zZyK5Tar0Q2eTbyuKQFZAcXfMwZEnIFXeFQ9OSEXLvYNzcPAcrCp5+NohdmF9PX
         5UJdxpqzSEpbqsBN6Vt1opak5tnVfFqfms0JbBvu5xDIGxR0fBAcR5N0GMmHwHFYMkXw
         zxJwds8Rdvcv5MfF7W4sGuArBm4OUYiejAdhd7pKJ1IGZ+n0A1ZUmiCJ/q3dVM4/y1kz
         Lmg93CxUIpdD2+gMb1SQZGmJQLy3vmAaCjITR4AeKMmJ3bC6BpDBvdq9Sx0Wsc5KupGd
         gLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954923; x=1690559723;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9Nkz09J0OWI8g55rIWxy1NKC5S7asE7sS8B85Det4w=;
        b=G/7222/oYsEzMKPO5PX/6CulUYZql34oGBsrgqvLyjQgTlLJGY7aK2vPIlAJyWIA7J
         oSh3UylvpNb+bq4QINcKg2Oew6BFceeqRsSeISa05QrRJnxy7fOGOjoFhM77qUrf59K9
         BEcxVo0k5A5D/tGcO/89ZllSLmJLWkcDIzv2yVDwBRZ+y2SR2Pm2amVDYj6pqtTIFT7e
         1HMQYZI9JFL6UZGOU0LJLwSQTdREo4LzobltBpNvantZm+PkV7QUB4wFu3s4Gpqa30It
         7uBELQeKFPhTXmVb2duxXo00aIbTD643QZPSPevgk3tcEb00Y5S6G4ZRmDD4htdNmy4w
         O7Ew==
X-Gm-Message-State: ABy/qLaSPGPkYccr3uFVJ8d+EwW9Rm+PdPcfYMXs7KMbfqjf8HzD7enB
        EuqLInL9QJaWjmfONmdFELc=
X-Google-Smtp-Source: APBJJlFPtxydAoiHWHkJISTHNoF9Jsw9EbnmsgBFnnI9ZibNZVSsa6Iv55dcnAUzUA0ld3ftX4P6pw==
X-Received: by 2002:a05:6a00:b45:b0:676:20f8:be41 with SMTP id p5-20020a056a000b4500b0067620f8be41mr484404pfo.16.1689954923244;
        Fri, 21 Jul 2023 08:55:23 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id y8-20020a62b508000000b00663b712bfbdsm3145756pfe.57.2023.07.21.08.55.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:55:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <fedf0448966b44d5b9146508265874fd@AcuMS.aculab.com>
Date:   Fri, 21 Jul 2023 23:55:07 +0800
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA8E8B15-A0B4-4EE1-B01E-FB1532103E17@gmail.com>
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
 <fedf0448966b44d5b9146508265874fd@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 19:51=EF=BC=8CDavid Laight =
<David.Laight@ACULAB.COM> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Alan Huang
>> Sent: 20 July 2023 19:54
>>=20
>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of first =
item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>> and a related discussion [1].
>=20
> Hmmm... that was all about the retry loop in ipv4/udp.c
>=20
> AFAICT that retry got deleted by ca065d0c.
>=20
> That also changes the list from hlist_nulls_xxx to hlist_xxx.
> (I'm not sure of the difference)
>=20
> This might be why we're seeing unexpected 'port unreachable' messages?
>=20
> Quite why that has just started happening is another issue.
> Most of the UDP sockets we create aren't 'connected' so I don't
> believe they get moved between hash chains - just deleted.
> The deletion should leave the hash chain intact.

Thanks for the information! :)

>=20
> David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, =
MK1 1PT, UK
> Registration No: 1397386 (Wales)

