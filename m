Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04877F8D20
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjKYScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjKYSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:31:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728B127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:32:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDEAC433C8;
        Sat, 25 Nov 2023 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700937124;
        bh=QELuRHVQ8QvisUNbMPPKmMoHXkay24CtnhYonlpSLP0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=YofFKFHmpJ/tyt1h7P2riHKi3FBCJkChIECWBNF4my74A8npLFWoj4QQs8iFAw95D
         5qSc32zakdyAo5d+johcJcp8LWT/x8qOoWetDUzRhjgOkIx6ZU8BAguLERFd7aZsdg
         pQNzdsaJINbJuqIuNraH90cST6iBBRCFkVjfzLkkT99gw9bQ1Fow5ZE+kMScMQnzbr
         V8I7OfuHLChiKoVjtyY4DFwQ9XG08vQrIDL5R8QQEcgMd/FTarWRwPQ5l3LCXUpNcc
         lY5wfIbF2bhNtlSeraugQkynPhuAjPPU5yoz+yVQEndX0enjYMaIvITF/JNYi2ylRM
         pk9sU9S5rdjag==
Date:   Sat, 25 Nov 2023 10:31:56 -0800
From:   Kees Cook <kees@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [BUG] Boot crash on v6.7-rc2
User-Agent: K-9 Mail for Android
In-Reply-To: <d7294586-04a4-49f7-8f5f-2dd66c8b4cde@embeddedor.com>
References: <20231124102458.GB1503258@e124191.cambridge.arm.com> <7086f60f-9f74-4118-a10c-d98b9c6cc8eb@embeddedor.com> <d7294586-04a4-49f7-8f5f-2dd66c8b4cde@embeddedor.com>
Message-ID: <05D345C3-BAFB-4658-8F78-4BC674A764DB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 25, 2023 9:54:28 AM PST, "Gustavo A=2E R=2E Silva" <gustavo@em=
beddedor=2Ecom> wrote:
>
>
>On 11/24/23 09:28, Gustavo A=2E R=2E Silva wrote:
>>=20
>>=20
>> On 11/24/23 04:24, Joey Gouly wrote:
>>> Hi all,
>>>=20
>>> I just hit a boot crash on v6=2E7-rc2 (arm64, FVP model):
>>=20
>> [=2E=2E]
>>=20
>>> Checking `struct neighbour`:
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0struct neighbour {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct neighbour __rcu=C2=
=A0=C2=A0=C2=A0 *next;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct neigh_table=C2=A0=C2=
=A0=C2=A0 *tbl;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=2E=2E fields =2E=2E
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 primary_key[0];
>>> =C2=A0=C2=A0=C2=A0=C2=A0} __randomize_layout;
>>>=20
>>> Due to the `__randomize_layout`, `primary_key` field is being placed b=
efore `tbl` (actually it's the same address since it's a 0 length array)=2E=
 That means the memcpy() corrupts the tbl pointer=2E
>>>=20
>>> I think I just got unlucky with my CONFIG_RANDSTRUCT seed (I can provi=
de it if needed), it doesn't look as if it's a new issue=2E
>>=20
>> It seems the issue is caused by this change that was recently added to =
-rc2:
>>=20
>> commit 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true fle=
xible arrays")
>>=20
>> Previously, one-element and zero-length arrays were treated as true fle=
xible arrays
>> (however, they are "fake" flex arrays), and __randomize_layout would le=
ave them
>> untouched at the end of the struct; the same for proper C99 flex-array =
members=2E But
>> after the commit above, that's no longer the case: Only C99 flex-array =
members will
>> behave correctly (remaining untouched at end of the struct), and the ot=
her two types
>> of arrays will be randomized=2E
>
>mmh=2E=2E=2E it seems that commit 1ee60356c2dc only prevents one-element =
arrays from being
>treated as flex arrays, while the code should still keep zero-length arra=
ys untouched:
>
>        if (typesize =3D=3D NULL_TREE && TYPE_DOMAIN(fieldtype) !=3D NULL=
_TREE &&
>            TYPE_MAX_VALUE(TYPE_DOMAIN(fieldtype)) =3D=3D NULL_TREE)
>                return true;
>
>-       if (typesize !=3D NULL_TREE &&
>-           (TREE_CONSTANT(typesize) && (!tree_to_uhwi(typesize) ||
>-            tree_to_uhwi(typesize) =3D=3D tree_to_uhwi(elemsize))))
>-               return true;
>-

This should be both the 0 and 1 checks=2E I think the original fix is corr=
ect: switch to a true flex array=2E

>
>Sorry about the confusion=2E
>
>>=20
>>>=20
>>> I couldn't reproduce directly on v6=2E6 (the offsets for `tbl` and `pr=
imary_key` didn't overlap)=2E
>>> However I tried changing the zero-length-array to a flexible one:
>>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0 DECLARE_FLEX_ARRAY(u8, pri=
mary_key);
>>> =C2=A0=C2=A0=C2=A0=C2=A0+=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 primary_key[0];

Was this line supposed to be "-"?

>>>=20
>>> Then the field offsets ended up overlapping, and I also got the same c=
rash on v6=2E6=2E
>>=20
>> The right approach is to transform the zero-length array into a C99 fle=
x-array member,
>> like this:
>>=20
>> diff --git a/include/net/neighbour=2Eh b/include/net/neighbour=2Eh
>> index 07022bb0d44d=2E=2E0d28172193fa 100644
>> --- a/include/net/neighbour=2Eh
>> +++ b/include/net/neighbour=2Eh
>> @@ -162,7 +162,7 @@ struct neighbour {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rcu_head=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct net_device=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *dev;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdevice_tracker=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_tracker;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 primary_key[0];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 primary_key[];
>>  =C2=A0} __randomize_layout;
>>=20
>>  =C2=A0struct neigh_ops {
>
>In any case, I think we still should convert [0] to [ ]=2E

I would expect the above to fix the problem=2E If it doesn't I'll need to =
take a closer look at the plugin=2E=2E=2E

-Kees

--=20
Kees Cook
