Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89221791AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344356AbjIDPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjIDPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:54:32 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF711AD;
        Mon,  4 Sep 2023 08:54:28 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 30AC0864A7;
        Mon,  4 Sep 2023 17:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693842865;
        bh=HozMjki3oM19mafVH5SYTU51DHR6X/5RgVhqM7+19UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G0DUyBbbP223QWAsmOCFWOTxBvur3HMN6+hL3MVT4+H72V03cslk2e10vGU97x0ML
         1UaRlBC4U/h8pygEj6hW2SnwLnBPh31ijj6tuSHWxlwkWYDhG33ni6gGulCIVTv2UI
         JEnyFxq1GwhojHLOwNGRn0qZup794Y3XE6yoZwxpOeRANnNXXXvCI9zldtfTN1zXoQ
         4OTOAYyZ5S1PcSgtqbS9Xm/1yDBelsoNqAcSKpHHD5ipK7sTg7TOBcf94c0kra7e+b
         HP+8fplyeLWD/wBYOdrE/78JY0DlvTCQkuXrH0H7c6caSziiVvpaaQDrnAK4NREGAg
         TVxnuXLaIzAZA==
Date:   Mon, 4 Sep 2023 17:54:19 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     <Tristram.Ha@microchip.com>
Cc:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <bigeasy@linutronix.de>,
        <pabeni@redhat.com>, <koverskeid@gmail.com>,
        <matthieu.baerts@tessares.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230904175419.7bed196b@wsk>
In-Reply-To: <20230828110242.1ceb41a5@wsk>
References: <20230825153111.228768-1-lukma@denx.de>
        <BYAPR11MB355805618F510948EAE18278ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230828110242.1ceb41a5@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/42s.ujm3.Jt7SKSfvHSE/vV";
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

--Sig_/42s.ujm3.Jt7SKSfvHSE/vV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tristram,

> Hi Tristram,
>=20
> > > -       /* And leave the HSR tag. */
> > > +        * And leave the HSR tag.
> > > +        *
> > > +        * The HSRv1 supervisory frame encapsulates the v0 frame
> > > +        * with EtherType of 0x88FB
> > > +        */
> > >         if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
> > > -               pull_size =3D sizeof(struct ethhdr);
> > > +               if (hsr->prot_version =3D=3D HSR_V1)
> > > +                       /* In the above step the DA, SA and
> > > EtherType
> > > +                        * (0x892F - HSRv1) bytes has been
> > > removed.
> > > +                        *
> > > +                        * As the HSRv1 has the HSR header added,
> > > one need
> > > +                        * to remove path_and_LSDU_size and
> > > sequence_nr fields.
> > > +                        *
> > > +                        */
> > > +                       pull_size =3D 4;
> > > +               else
> > > +                       pull_size =3D sizeof(struct hsr_tag);
> > > +
> > >                 skb_pull(skb, pull_size);
> > >                 total_pull_size +=3D pull_size;
> > >         }
> > > @@ -313,6 +328,19 @@ void hsr_handle_sup_frame(struct
> > > hsr_frame_info *frame) total_pull_size +=3D pull_size;
> > >=20
> > >         /* get HSR sup payload */
> > > +       if (hsr->prot_version =3D=3D HSR_V1) {
> > > +               /* In the HSRv1 supervisor frame, when
> > > +                * one with EtherType =3D 0x88FB is extracted, the
> > > Node A
> > > +                * MAC address is preceded with type and length
> > > elements of TLV
> > > +                * data field.
> > > +                *
> > > +                * It needs to be removed to get the remote peer
> > > MAC address.
> > > +                */
> > > +               pull_size =3D sizeof(struct hsr_sup_tlv);
> > > +               skb_pull(skb, pull_size);
> > > +               total_pull_size +=3D pull_size;
> > > +       }
> > > +
> > >         hsr_sp =3D (struct hsr_sup_payload *)skb->data;   =20
> >=20
> > I thought the fix is simply this:
> >=20
> > 	if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
> > -		pull_size =3D sizeof(struct ethhdr);
> > +		pull_size =3D sizeof(struct hsr_tag);
> > 		skb_pull(skb, pull_size);
> > 		total_pull_size +=3D pull_size;
> > 	}
> >=20
> > -	pull_size =3D sizeof(struct hsr_tag);
> > +	pull_size =3D sizeof(struct hsr_sup_tag);
> >=20
> > Note the sizes of hsr_tag and hsr_sup_tag are the same: 6 bytes.
> > The code in 5.15 before this refactored code uses those structures.
> > When using v0 the EtherType uses the PRP tag instead of the HSR tag
> > so the HSR related code is not executed.
> >  =20
>=20
> This would not be enough it seems. Please find below skb->data dump
> when entering hsr_handle_sup_frame() [0]:
>=20
> SKB_I100000000: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f 00 34
> SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
> SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000040: 00 00                                         =20
>=20
> With the newest kernel (before applying this patch) in [1] we do
> remove: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f (which is equal to
> sizeof(struct ethhdr) =3D 6 + 6 + 2 B =3D 14 B)
>=20
> So we do have:
>=20
> 							  00 34
> SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
> SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000040: 00 00
>=20
> And we need to remove rest of the HSR v1 tag (4 Bytes).
>=20
> Then we do have:
>=20
> SKB_I100000010:       88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
> SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000040: 00 00
>=20
> The 0x88FB is the PRP/HSRv0 supervisory frame ETH type, so the tag
> needs to be removed (6 Bytes) and then we do have TYPE (0x17) and
> Length (0x06), which indicate the other HSR host IP address.
>=20
> When I do apply your proposed changes we would have the DA and SA
> MAC addresses removed implicitly (as the struct hsr_tag and
> hsr_sup_tag are 6 bytes in size) and we end up with frame starting
> with HSR v1 tag - i.e.:
>=20
> SKB_I100000000:                                     89 2f 00 34
> SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
> SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> SKB_I100000040: 00 00                                         =20
>=20
>=20
> Hence mine question - is my setup or understanding wrong (as the PRP
> supervisory frame is encapsulated in HSR v1 frame)?=20
>=20
> I do use the same kernel on two KSZ9477-EVB boards with Port[12]
> connected together to work with HSR. I also to explicitly force the
> HSR driver to use v1 of HSR (by default v0 is enforced).
>=20
>=20

As I've double checked with tshark - the supervision frame format is
different for HSR v0 and v1:

HSR v0:
    [Protocols in frame:eth:ethertype:hsr_prp_supervision]

HSR v1:
    [Protocols in frame: eth:ethertype:hsr:hsr_prp_supervision]

In v0 the ":hsr:" is missing, hence the error.

>=20
>=20
>=20
> If you don't mind - I would also like to ask a question regarding the
> node_db for HSR.
>=20
> Why the output of:
>=20
> # cat /sys/kernel/debug/hsr/hsr0/node_table                =20
> Node Table entries for (HSR) device
> MAC-Address-A,    MAC-Address-B,    time_in[A], time_in[B],=20
> 00:10:a1:94:77:30 00:00:00:00:00:00    1689193,    1689199,
>=20
> Address-B port, DAN-H
>  	0,        1
>=20
> Has the MAC-Address-B equal to 00:00:00:00:00:00 ?
>=20
> As I do have the same MAC addresses for both HSR ports (to facilitate
> frame duplication in KSZ9477 IC removal) I would expect to have this
> MAC address set to 00:10:a1:94:77:30 as well...
>=20
> Is this expected? Or is there any other issue to fix?

I think that this is caused by how KSZ9477 works with HSR core.

The HSR core is responsible for setting tag for frame. It sets the
"Lane ID" part of HSR tag to 0 as it relies on HSR frames duplication
in KSZ9477:

    Type: High-availability Seamless Redundancy (IEC62439 Part 3)
    (0x892f)=20
    High-availability Seamless Redundancy (IEC62439 Part 3
    Chapter 5) 0000 .... .... .... =3D Path: 0
    000. .... .... .... =3D Network id: 0
    ...0 .... .... .... =3D Lane id: Lane A (0)
    .... 0000 0011 0100 =3D LSDU size: 52 [correct]

As KSZ9477 duplicates (clones) frames without any modification, only
frames for Lane id =3D 0 are sent. Hence the MAC-Address-B is always
equal to 00:00:00:00:00:00 as no supervisory frames are received with
Lane B id.

This however, may be different in other HSR switch IC's - especially in
those, which insert the HSR header to frames - as they know to which
HSR "lane" (egress port) the frame is delivered.


>=20
>=20
> Thanks in advance for your help and support :-)
>=20
> Links:
>=20
> [0] -
> https://elixir.bootlin.com/linux/v6.5-rc7/source/net/hsr/hsr_framereg.c#L=
281
>=20
> [1] -
> https://elixir.bootlin.com/linux/v6.5-rc7/source/net/hsr/hsr_framereg.c#L=
290
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/42s.ujm3.Jt7SKSfvHSE/vV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT1/asACgkQAR8vZIA0
zr0X2gf+KthME30q2w8Et13tnE65uAPP+p8ks1e1L+plbogP3ZFKHnZjKNtfnUB2
Gs8ymAxSEROmRaqTvfYkxwHUekstuenHeLuScwwy4WjXFNAubhkiTGbBeboARJf0
EMJALL9FWkYPWsa3ZqWR7bBkv7FS4oYW7e4SUXP57lFcpKi6N7Elr3iJD1v2lkxq
+Nz5CAzyOuM8FMSb9PwgtKGWWLauoFd4nSRVPJPCG+qiIHYwI97dr/xtqYfsJRKY
kuEmt0gU9oKjUYSWMtqLzFs9hdiZW2tob3F9vWYdakt/r38H/BdgIJr3WNlN+Gyt
xGgdEZFawN1uure9tfAIpmxxhfk7Qg==
=Li7K
-----END PGP SIGNATURE-----

--Sig_/42s.ujm3.Jt7SKSfvHSE/vV--
