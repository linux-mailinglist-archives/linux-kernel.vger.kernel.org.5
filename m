Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7EC75B867
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGTUAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGTUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:00:05 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763EB26AB;
        Thu, 20 Jul 2023 13:00:04 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5634db21a58so838458eaf.0;
        Thu, 20 Jul 2023 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883204; x=1690488004;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f+1BVn3K9BCak1PKcjUIhwm6W2P7+r/CLvcCqHWmMs=;
        b=OM3vNHbiY8QVPdTBrgLW1VcaC9q8mPzhpokDa83fnJxisDFHRpQ+mfvacPfXOTtshR
         8R+AOgAP7zfI+LKYnGXiQLB2jgpHx3xSTniNLCNZu2i4O8DYOa8+mSeiwFkNvX5WycIQ
         msV789gmphtJHXyvT8cSwDMYkB4sS9ur3J8uw1G/aB0cvVkvzcmSR7BlV8LtpaT5JVDv
         jKKG/h4daFr5/PvhmmmgslL2HdXvVnrAd0m+34NOpUgaPbTO5o2yWq3w2QEvTQ3XhyvJ
         f6vH8e4UsyKz1Div2bbs6yUagwqKQMhUJuhOemRZuU4m7Jjrox3fP1eXrdLWIuRkt4fi
         bbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883204; x=1690488004;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f+1BVn3K9BCak1PKcjUIhwm6W2P7+r/CLvcCqHWmMs=;
        b=lfEVHvXq31ojV1iBF55fb/C2lH49l4yWvsalKX+5MYSBU147WVmJYf8XaxuNYmK6tQ
         ik+0kMM+2Cb7CKDHdi7uPHucQFEdXkMkruAY9mbVgvXVC1yYZSVunjnFtWJp5fhN4wrO
         Vq5vUnxMH8b5KWP9xVbanKvlbwOgl0TMQbMcssRcrQMBSyS4Hmi1sw9MZsqFWuzzxs+L
         4/hp5zfBOKZsS6wQ301b22SMsufZXqcq3OL9LaOz9Xh0IG0IZS3hTk6+w995ucxZc7s3
         wpuPA2KgeVy37O4SDmLLXejBfN17HmQQ6+/8MKraJAZVNLuWvyUPNJF8YOslRh+efCMb
         ZYQA==
X-Gm-Message-State: ABy/qLai973HRblgFAvAd9xheQoOLR9RtQXcR+lSHvEMF8+tH/RwKs4g
        tLPeynOjVjV8CPglDMS/vH0=
X-Google-Smtp-Source: APBJJlG3YyBeZKhn1OqLRDoo2EMB6k968+wTv28Em1gxPRPBhWqVKviK8REb1af82OzJiKP2PNMfPA==
X-Received: by 2002:a05:6808:8f0:b0:398:2f92:65ca with SMTP id d16-20020a05680808f000b003982f9265camr388351oic.7.1689883203713;
        Thu, 20 Jul 2023 13:00:03 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id em9-20020a17090b014900b00263a985abc0sm1353998pjb.26.2023.07.20.12.59.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 13:00:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com>
Date:   Fri, 21 Jul 2023 03:59:33 +0800
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        roman.gushchin@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
 <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com>
To:     Eric Dumazet <edumazet@google.com>
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


> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>=20
>> Hi,
>>=20
>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of first =
item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>> and a related discussion [1].
>>=20
>> After reading the whole discussion, it seems like that ptr->field was =
cached by gcc even with the deprecated
>> ACCESS_ONCE(), so my question is:
>>=20
>>        Is that a compiler bug? If so, has this bug been fixed today, =
ten years later?
>>=20
>>        What about READ_ONCE(ptr->field)?
>=20
> Make sure sparse is happy.

It caused a problem without barrier(), and the deprecated ACCESS_ONCE() =
didn=E2=80=99t help:

	https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/

So, my real question is: With READ_ONCE(ptr->field), are there still =
some unusual cases where gcc=20
decides not to reload ptr->field?

>=20
> Do you have a patch for review ?

Possibly next month. :)

>=20
>=20
>>=20
>>=20
>> [1] =
https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glaptop/
>>=20
>> Thanks,
>> Alan

