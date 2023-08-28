Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD778A872
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjH1JDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjH1JCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:02:55 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E25B9;
        Mon, 28 Aug 2023 02:02:52 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 350A086458;
        Mon, 28 Aug 2023 11:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693213370;
        bh=RdzTUO3th0izOpoG5BBLTviGdACVKkyCwADBPUxpTus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GTnh4Lsvu4FOcre4AgYJLINGFPOi6TpZ5Vxl4WR0XRnDaf+Bhip6qe1lSb2H1vQDH
         5DPga4jlrvKFG/U3O9qJMsG5TLp2XLAG3c8K608XqwA7YvC1DODBxrtnuuZjFnRoPn
         S1yXhtxMA+9Sx57Psme4ICUi7bRWDtSE4k+4B/PslK2huUalrrPKzFTvq2ttjSjzlo
         K5h7AmSkudOYunhZV7FVLv82cT9fT51VQK83tpMga5yyMOPi/MqW6+BL5yGNuPXHry
         YIKlGD4uOLLYxFaKhc0G1XnjTduEj7b1Xyb889ucQiEypLYQXUqV2fh1belDZYIqRs
         gEiUkM4sinZdg==
Date:   Mon, 28 Aug 2023 11:02:42 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     <Tristram.Ha@microchip.com>
Cc:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <bigeasy@linutronix.de>,
        <pabeni@redhat.com>, <koverskeid@gmail.com>,
        <matthieu.baerts@tessares.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230828110242.1ceb41a5@wsk>
In-Reply-To: <BYAPR11MB355805618F510948EAE18278ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20230825153111.228768-1-lukma@denx.de>
        <BYAPR11MB355805618F510948EAE18278ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mhBX9ugI8ZzUAr/PytQiphs";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mhBX9ugI8ZzUAr/PytQiphs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tristram,

> > -       /* And leave the HSR tag. */
> > +        * And leave the HSR tag.
> > +        *
> > +        * The HSRv1 supervisory frame encapsulates the v0 frame
> > +        * with EtherType of 0x88FB
> > +        */
> >         if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
> > -               pull_size =3D sizeof(struct ethhdr);
> > +               if (hsr->prot_version =3D=3D HSR_V1)
> > +                       /* In the above step the DA, SA and
> > EtherType
> > +                        * (0x892F - HSRv1) bytes has been removed.
> > +                        *
> > +                        * As the HSRv1 has the HSR header added,
> > one need
> > +                        * to remove path_and_LSDU_size and
> > sequence_nr fields.
> > +                        *
> > +                        */
> > +                       pull_size =3D 4;
> > +               else
> > +                       pull_size =3D sizeof(struct hsr_tag);
> > +
> >                 skb_pull(skb, pull_size);
> >                 total_pull_size +=3D pull_size;
> >         }
> > @@ -313,6 +328,19 @@ void hsr_handle_sup_frame(struct
> > hsr_frame_info *frame) total_pull_size +=3D pull_size;
> >=20
> >         /* get HSR sup payload */
> > +       if (hsr->prot_version =3D=3D HSR_V1) {
> > +               /* In the HSRv1 supervisor frame, when
> > +                * one with EtherType =3D 0x88FB is extracted, the
> > Node A
> > +                * MAC address is preceded with type and length
> > elements of TLV
> > +                * data field.
> > +                *
> > +                * It needs to be removed to get the remote peer
> > MAC address.
> > +                */
> > +               pull_size =3D sizeof(struct hsr_sup_tlv);
> > +               skb_pull(skb, pull_size);
> > +               total_pull_size +=3D pull_size;
> > +       }
> > +
> >         hsr_sp =3D (struct hsr_sup_payload *)skb->data; =20
>=20
> I thought the fix is simply this:
>=20
> 	if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
> -		pull_size =3D sizeof(struct ethhdr);
> +		pull_size =3D sizeof(struct hsr_tag);
> 		skb_pull(skb, pull_size);
> 		total_pull_size +=3D pull_size;
> 	}
>=20
> -	pull_size =3D sizeof(struct hsr_tag);
> +	pull_size =3D sizeof(struct hsr_sup_tag);
>=20
> Note the sizes of hsr_tag and hsr_sup_tag are the same: 6 bytes.
> The code in 5.15 before this refactored code uses those structures.
> When using v0 the EtherType uses the PRP tag instead of the HSR tag so
> the HSR related code is not executed.
>=20

This would not be enough it seems. Please find below skb->data dump
when entering hsr_handle_sup_frame() [0]:

SKB_I100000000: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f 00 34
SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000040: 00 00                                         =20

With the newest kernel (before applying this patch) in [1] we do remove:
01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f (which is equal to
sizeof(struct ethhdr) =3D 6 + 6 + 2 B =3D 14 B)

So we do have:

							  00 34
SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000040: 00 00

And we need to remove rest of the HSR v1 tag (4 Bytes).

Then we do have:

SKB_I100000010:       88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000040: 00 00

The 0x88FB is the PRP/HSRv0 supervisory frame ETH type, so the tag
needs to be removed (6 Bytes) and then we do have TYPE (0x17) and
Length (0x06), which indicate the other HSR host IP address.

When I do apply your proposed changes we would have the DA and SA
MAC addresses removed implicitly (as the struct hsr_tag and hsr_sup_tag
are 6 bytes in size) and we end up with frame starting with HSR v1 tag -
i.e.:

SKB_I100000000:                                     89 2f 00 34
SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000040: 00 00                                         =20


Hence mine question - is my setup or understanding wrong (as the PRP
supervisory frame is encapsulated in HSR v1 frame)?=20

I do use the same kernel on two KSZ9477-EVB boards with Port[12]
connected together to work with HSR. I also to explicitly force the HSR
driver to use v1 of HSR (by default v0 is enforced).





If you don't mind - I would also like to ask a question regarding the
node_db for HSR.

Why the output of:

# cat /sys/kernel/debug/hsr/hsr0/node_table                =20
Node Table entries for (HSR) device
MAC-Address-A,    MAC-Address-B,    time_in[A], time_in[B],=20
00:10:a1:94:77:30 00:00:00:00:00:00    1689193,    1689199,

Address-B port, DAN-H
 	0,        1

Has the MAC-Address-B equal to 00:00:00:00:00:00 ?

As I do have the same MAC addresses for both HSR ports (to facilitate
frame duplication in KSZ9477 IC removal) I would expect to have this MAC
address set to 00:10:a1:94:77:30 as well...

Is this expected? Or is there any other issue to fix?


Thanks in advance for your help and support :-)

Links:

[0] -
https://elixir.bootlin.com/linux/v6.5-rc7/source/net/hsr/hsr_framereg.c#L281

[1] -
https://elixir.bootlin.com/linux/v6.5-rc7/source/net/hsr/hsr_framereg.c#L290

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/mhBX9ugI8ZzUAr/PytQiphs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTsYrIACgkQAR8vZIA0
zr28vwgAkOuipkzk75zF4tVTE/iInSc/IircK9VM/SI6EdQc/HpVoTlPAa0rMsFh
k6VmBG0/kB4yLvojVegUr765qNiVDmrmXxXa74BvfSvKyU2YkvofqeSa7wwgAPxR
XgPqubQnPfhz4M0z01CTqMh/GCAzzrXs874KgdEpSqrfodR29X2bMxboZtZHvQN7
FLOgNjukpoDMWyg6EjqtdWrGKDGR4YZEaI3UwE8rDizJ8wURiV/5zJMvjazovRzz
DrkOzjwDn4x5GkNA2hmHjpKg8pwKovlqweeXmjdDovD3vWkMiO021z8ntUFRMdU9
nGyOnq365aFFcs95lptzJI9EpC1bjQ==
=fxwQ
-----END PGP SIGNATURE-----

--Sig_/mhBX9ugI8ZzUAr/PytQiphs--
