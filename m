Return-Path: <linux-kernel+bounces-8846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6681BD30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B931F252C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A262804;
	Thu, 21 Dec 2023 17:26:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7759910;
	Thu, 21 Dec 2023 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B423A2F4;
	Thu, 21 Dec 2023 09:27:34 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED1B3F5A1;
	Thu, 21 Dec 2023 09:26:47 -0800 (PST)
Date: Thu, 21 Dec 2023 17:26:44 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: aou@eecs.berkeley.edu, conor+dt@kernel.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com,
 rafael@kernel.org, robh+dt@kernel.org, samuel@sholland.org,
 sfr@canb.auug.org.au, tiny.windzz@gmail.com, viresh.kumar@linaro.org,
 wens@csie.org
Subject: Re: [RFC PATCH v2 2/3] cpufreq: sun50i: Add support for D1's speed
 bin decoding
Message-ID: <20231221172644.21cf3817@donnerap.manchester.arm.com>
In-Reply-To: <20231221171107.85991-1-fusibrandon13@gmail.com>
References: <20231221124957.27fa9922@donnerap.manchester.arm.com>
	<20231221171107.85991-1-fusibrandon13@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 18:11:07 +0100
Brandon Cheo Fusi <fusibrandon13@gmail.com> wrote:

Hi Brandon,

> On Thu, Dec 21, 2023 at 1:50=E2=80=AFPM Andre Przywara <andre.przywara@ar=
m.com> wrote:
> >
> > On Thu, 21 Dec 2023 11:10:12 +0100
> > Brandon Cheo Fusi <fusibrandon13@gmail.com> wrote:
> >
> > Hi Brandon,
> >
> > thanks for the quick turnaround, and for splitting this code up, that
> > makes reasoning about this much easier!
> > =20
> > > Adds support for decoding the efuse value read from D1 efuse speed
> > > bins, and factors out equivalent code for sun50i.
> > >
> > > The algorithm is gotten from
> > >
> > > https://github.com/Tina-Linux/linux-5.4/blob/master/drivers/cpufreq/s=
un50i-cpufreq-nvmem.c#L293-L338
> > >
> > > and maps an efuse value to either 0 or 1, with 1 meaning stable at
> > > a lower supply voltage for the same clock frequency.
> > >
> > > Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > ---
> > >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 34 ++++++++++++++++++++++++=
++
> > >  1 file changed, 34 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq=
/sun50i-cpufreq-nvmem.c
> > > index fc509fc49..b1cb95308 100644
> > > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > @@ -29,6 +29,33 @@ struct sunxi_cpufreq_data {
> > >       u32 (*efuse_xlate)(u32 *speedbin, size_t len);
> > >  };
> > >
> > > +static u32 sun20i_efuse_xlate(u32 *speedbin, size_t len) =20
> >
> > I feel like this prototype can be shortened to:
> >
> > static u32 sun20i_efuse_xlate(u32 speedbin)
> >
> > See below.
> > =20
> > > +{
> > > +     u32 ret, efuse_value =3D 0;
> > > +     int i;
> > > +
> > > +     for (i =3D 0; i < len; i++)
> > > +             efuse_value |=3D ((u32)speedbin[i] << (i * 8)); =20
> >
> > The cast is not needed. Looking deeper into the original code you linked
> > to, cell_value[] there is an array of u8, so they assemble a little end=
ian
> > 32-bit integer from *up to* four 8-bit values read from the nvmem.
> >
> > So I think this code here is wrong, len is the size of the nvmem cells
> > holding the bin identifier, in *bytes*, so the idea here is to just read
> > the (lowest) 16 bits (in the D1 case, cf. "reg =3D <0x00 0x2>;" in the =
next
> > patch) from this nvmem cell. Here you are combining two 32-bit words in=
to =20
>=20
> This is true. Not sure though what the 'in the D1 case...' bit means.

In the next patch you introduce the nvmem DT property, and set the length
part to "0x2". So for the D1 we will always read two bytes.

> > efuse_value.
> >
> > So I think this whole part above is actually not necessary: we are
> > expecting maximum 32 bits, and nvmem_cell_read() should take care of
> > masking off unrequested bits, so we get the correct value back already.=
 So
> > can you try to remove the loop above, and use ...
> > =20
> > > +
> > > +     switch (efuse_value) { =20
> >
> >         switch (*speedbin & 0xffff) {
> > =20
>=20
> Shouldn't the bytes in *speedbin be reversed?=20

I believe they are stored as a little endian 16-bit integer in the fuses.
I haven't tried a BE kernel, but I think the NVMEM framework takes care of
that.
If you dump the values as returned by nvmem_cell_read(), we would know for
sure.

> > here instead? Or drop the pointer at all, and just use one u32 value, s=
ee
> > the above prototype.
> > =20
>=20
> I was uncomfortable dropping the len parameter, because then each
> platform's efuse_xlate would ignore the number of valid bytes actually
> read.

Well, I am not sure either, but neither the H6, nor the H616 or the D1
apparently really need that: they all use either 4 or 2 bytes to encode
the speed bin. And since the routines are SoC specific anyway, and the
first 32-bit word of the buffer filled by nvmem_cell_read() should always
be valid (and be it 0), I think there is little need to check that.
I ported the H616 code over, and it looks somewhat similar to the D1 (with
different numbers, though): it's (ab)using some die revision code (the
first two bytes in the SID) to derive the speed bin. The H6 had a
dedicated bin fuse.

So iff we are going to see a SoC needing to check the length, we can always
introduce that later: it's just an internal function.
But for now I'd like to keep it simple.

Cheers,
Andre

>=20
> > Cheers,
> > Andre
> >
> > P.S. This is just a "peephole review" of this patch, I haven't got arou=
nd
> > to look at this whole scheme in whole yet, to see if we actually need t=
his
> > or can simplify this or clean it up.
> >
> > =20
> > > +     case 0x5e00:
> > > +             /* QFN package */
> > > +             ret =3D 0;
> > > +             break;
> > > +     case 0x5c00:
> > > +     case 0x7400:
> > > +             /* QFN package */
> > > +             ret =3D 1;
> > > +             break;
> > > +     case 0x5000:
> > > +     default:
> > > +             /* BGA package */
> > > +             ret =3D 0;
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  static u32 sun50i_efuse_xlate(u32 *speedbin, size_t len)
> > >  {
> > >       u32 efuse_value =3D 0;
> > > @@ -46,6 +73,10 @@ static u32 sun50i_efuse_xlate(u32 *speedbin, size_=
t len)
> > >               return 0;
> > >  }
> > >
> > > +struct sunxi_cpufreq_data sun20i_cpufreq_data =3D {
> > > +     .efuse_xlate =3D sun20i_efuse_xlate,
> > > +};
> > > +
> > >  struct sunxi_cpufreq_data sun50i_cpufreq_data =3D {
> > >       .efuse_xlate =3D sun50i_efuse_xlate,
> > >  };
> > > @@ -54,6 +85,9 @@ static const struct of_device_id cpu_opp_match_list=
[] =3D {
> > >       { .compatible =3D "allwinner,sun50i-h6-operating-points",
> > >         .data =3D &sun50i_cpufreq_data,
> > >       },
> > > +     { .compatible =3D "allwinner,sun20i-d1-operating-points",
> > > +       .data =3D &sun20i_cpufreq_data,
> > > +     },
> > >       {}
> > >  };
> > > =20
> > =20
>=20
> Thank you for reviewing.
> Brandon.
>=20


