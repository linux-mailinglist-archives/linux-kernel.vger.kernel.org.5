Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE875C72E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGUMyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGUMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:54:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98A1FD2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:54:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40398ccdaeeso13762521cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689944069; x=1690548869;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=py/BFgmRS4KvWpQnkGKaFJgWYXIsOQByY26EFKRGjhs=;
        b=gEpb7UoxryK77HdI/F6jakyvQpTFKvaYavHFK1+LsFOVyxguE8Fcxu/sKbK7dVo1b7
         qnnCizvtiDvOCmoUK9iReH6sJSBhI5WjGfDDUMHrl65K+jn24p9T0jP/Hldz6QEbGOm1
         W37hvvtQXy7DVWXSpMkzLGTMAiB2CO8hBPeUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689944069; x=1690548869;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=py/BFgmRS4KvWpQnkGKaFJgWYXIsOQByY26EFKRGjhs=;
        b=IJ2RvUaYXqNNaQlEDetQwfd7RaQvsm78nThNKh33Lf0frDT0PVOLzkCj1EhQXVNgQq
         SeYEbEyTJcUeQ/U1mZExO8slVPqKWcvm6OnXbTv8pzygTue/F922MX4O+mKcKijy6keh
         jqH2zWZ6Lq3lQNPY3KhNhAIFW6sRylLxZML5oBTsfs8y/fW275fZmKip/FD5/fm3Timo
         lpg4lkDn9k51I6wiXivxpbFYi8MjBrA4dXcyei4WAQi734hAPLnCfwDx/ajPRqOP9bvH
         PzFMz0yQtI36uBSB2X/atDUQyXxcNvKXDRgUK+hNNJp5MOvGh9Kfd6HFI18hPJQO8I2+
         7pOw==
X-Gm-Message-State: ABy/qLaB4S5zU8Vbu9JH6nEKHGFgK6ffnmtEjAKwOSqih0i10gywDw6W
        5VOKcJrwfz6Bh8bTIlBp8Z3RKw==
X-Google-Smtp-Source: APBJJlHk4xMVwdmRohsI0u8gJGglJgtYLzzbXNqS94S9I8EeGMjOfJkdwblJh+8XT9njVSO8qAeysA==
X-Received: by 2002:ac8:5e0c:0:b0:3ff:3110:bb5e with SMTP id h12-20020ac85e0c000000b003ff3110bb5emr1816763qtx.30.1689944069337;
        Fri, 21 Jul 2023 05:54:29 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.83])
        by smtp.gmail.com with ESMTPSA id v18-20020ac873d2000000b004035b79860dsm1188209qtp.81.2023.07.21.05.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 05:54:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Date:   Fri, 21 Jul 2023 08:54:17 -0400
Message-Id: <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, roman.gushchin@linux.dev
In-Reply-To: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
To:     Alan Huang <mmpgouride@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> wrote:
>=20
> =EF=BB=BF
>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet <edumazet@g=
oogle.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang <mmpgouride@gmail.com=
> wrote:
>>>=20
>>> Hi,
>>>=20
>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of first it=
em in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>> and a related discussion [1].
>>>=20
>>> After reading the whole discussion, it seems like that ptr->field was ca=
ched by gcc even with the deprecated
>>> ACCESS_ONCE(), so my question is:
>>>=20
>>>       Is that a compiler bug? If so, has this bug been fixed today, ten y=
ears later?
>>>=20
>>>       What about READ_ONCE(ptr->field)?
>>=20
>> Make sure sparse is happy.
>=20
> It caused a problem without barrier(), and the deprecated ACCESS_ONCE() di=
dn=E2=80=99t help:
>=20
>    https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>=20
> So, my real question is: With READ_ONCE(ptr->field), are there still some u=
nusual cases where gcc=20
> decides not to reload ptr->field?

I am a bit doubtful there will be strong (any?) interest in replacing the ba=
rrier() with READ_ONCE() without any tangible reason, regardless of whether a=
 gcc issue was fixed.

But hey, if you want to float the idea=E2=80=A6

Thanks,

 - Joel

>=20
>>=20
>> Do you have a patch for review ?
>=20
> Possibly next month. :)
>=20
>>=20
>>=20
>>>=20
>>>=20
>>> [1] https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glapt=
op/
>>>=20
>>> Thanks,
>>> Alan
>=20
