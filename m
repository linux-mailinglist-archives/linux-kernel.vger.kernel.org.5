Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3966B7FB97C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbjK1Lcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjK1Lca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:32:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E11B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701171151;
        bh=RFVMPhKHsjpTRlZPbuzuBAOCwyfifnJ1d4FpP1154EU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CLwe1/YFm/WM2lLbErcJ0vg+CwuXyTOZ1dyLO5bqOccWwXk6z7qsWumdTUgfZJVzi
         iV/Sli4I9lVw5hTRj4MtaxdEY3yHp+HXyD4ixXc+Tbg9RMt37o/0sv4BcJtjQrn11C
         R1IpkGO9x3bg8TWiUdDMwxlC+GW89babr5GoYxGdo/ohsWema+poMKJy0OVtevr1TN
         kfFeZ2plssFkQGxqmVSFDw7KHKLkJHbaApFPPYMkst5KqeUOkfMioI9209N9Xe1gm6
         rbbZmxcouJ2QDChMrK7IyCYFmTrKszsBAbknbNzUf/a7W2lMfeACUyR6cpLeeSCTGv
         q/b0uEUQQJ3EA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SfgKp0PBMz4xPL;
        Tue, 28 Nov 2023 22:32:28 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kunwu Chan <chentao@kylinos.cn>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "npiggin@gmail.com" <npiggin@gmail.com>
Cc:     "kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/mm: Fix null-pointer dereference in
 pgtable_cache_add
In-Reply-To: <9d871364-7baa-4daf-8b0c-3fbfbede6fdb@kylinos.cn>
References: <20231122090026.11728-1-chentao@kylinos.cn>
 <32077b74-7335-4f4d-8858-c53c820150d0@csgroup.eu>
 <9d871364-7baa-4daf-8b0c-3fbfbede6fdb@kylinos.cn>
Date:   Tue, 28 Nov 2023 22:32:21 +1100
Message-ID: <87y1ei2jwa.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunwu Chan <chentao@kylinos.cn> writes:
> Hi Christophe,
>
> Thanks for your reply.
> It's my bad. According your reply, i read the code in=20
> sysfs_do_create_link_sd.There is a null pointer check indeed.
>
> My intention was to check null pointer after memory allocation.
> Whether we can add a comment here for someone like me, the null pointer=20
> check is no need here?

I don't mind there being a NULL check for name.

But the code shouldn't silently return if name can't be allocated.
Notice that if we can't create the cache we *panic*. A failure to
allocate name, which causes us to skip the cache creation, needs to also
panic.

cheers

> On 2023/11/24 23:17, Christophe Leroy wrote:
>>=20
>>=20
>> Le 22/11/2023 =C3=A0 10:00, Kunwu Chan a =C3=A9crit=C2=A0:
>>> [Vous ne recevez pas souvent de courriers de chentao@kylinos.cn. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
>>>
>>> kasprintf() returns a pointer to dynamically allocated memory
>>> which can be NULL upon failure. Ensure the allocation was successful
>>> by checking the pointer validity.
>>=20
>> Are you sure this is needed ? Did you check what happens what name is NU=
LL ?
>>=20
>> If I followed stuff correctly, I end up in function
>> sysfs_do_create_link_sd() which already handles the NULL name case which
>> a big hammer warning.
>>=20
>>>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> ---
>>>    arch/powerpc/mm/init-common.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-commo=
n.c
>>> index 119ef491f797..0884fc601c46 100644
>>> --- a/arch/powerpc/mm/init-common.c
>>> +++ b/arch/powerpc/mm/init-common.c
>>> @@ -139,6 +139,8 @@ void pgtable_cache_add(unsigned int shift)
>>>
>>>           align =3D max_t(unsigned long, align, minalign);
>>>           name =3D kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
>>> +       if (!name)
>>> +               return;
>>>           new =3D kmem_cache_create(name, table_size, align, 0, ctor(sh=
ift));
>>>           if (!new)
>>>                   panic("Could not allocate pgtable cache for order %d"=
, shift);
>>> --
>>> 2.34.1
>>>
