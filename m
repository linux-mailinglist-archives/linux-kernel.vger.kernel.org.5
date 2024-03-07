Return-Path: <linux-kernel+bounces-95599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD28875000
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4443F1F2318F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317EE12C7FB;
	Thu,  7 Mar 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gChZSXYM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478B1D680;
	Thu,  7 Mar 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818291; cv=none; b=Uj1VV7E7PJ/sDK8JzzoWacna2grh89xylAuMCe3oJtkDsQvRXYEqGoeojaU60KpxoI9aBN+nzoxHtAXkVEQCqclSWea79XC0xwWaKUE8qqeMbVdxjhdVaK2v7MSPW64qCQDXwCwBmlnCH5rpp8aHugwdDVs+eZ9puXfX66SP0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818291; c=relaxed/simple;
	bh=vI+QvVtiqtRlJH5TQ020Wm2Cx4t+Oc5iC4A/iLWKhrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBafxczo0DywhxDV8Pq/9f5BMzOZy2Wu8Ezzz7TRwlu2t6FBkSagHxvRM7XNftm/tqmVN37gzR40O5acT87E63NtsGbXdD5OG2e1azHHvNcH7kezrdhkUDa7Gv38F6SWcUQKgm93eosZlp6TPVG7Pe1QswrDwP4VlnvkqKxROiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gChZSXYM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc09556599so7811725ad.1;
        Thu, 07 Mar 2024 05:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709818289; x=1710423089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu5jHGN23CR+6gfGrBm60h2lIXXTAwpxHU4qL8HSxTM=;
        b=gChZSXYMClcZ39rCBFOZ8Mm9Ujm+GL6mz+JF+RE7FQ75Qhd9rlABrcSNpiCCmUX8OH
         TjiWBYQBw+z/fbxgFie14prcF6MBU+5FbKWPW504JtinOTM/1Q0UJ6J7o0ZTbhION3QO
         Edr/RHbVoWa/7xBpvyDpTo2S9QNxa3+Qa+HnB2UQPdFBmcYnATifGnYjlvZeKPSaHe8G
         rLge6Un0M4PtFb1OkZsyMODXtuZdtc6qdA0rwVSPX2kKUMVtFnJC32ftppYJODhDhrsc
         K4nOAkbaEVvMlXUpELX+mcXvt0PL0C4K36kA04ayWqUnVuyeTujlkBk69vgJxvVCq6+y
         7W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818289; x=1710423089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu5jHGN23CR+6gfGrBm60h2lIXXTAwpxHU4qL8HSxTM=;
        b=g/RMNTxaBQ9SjjXuBzR2s/gnW9j30YGPzuCXqAaCWJfPrIU50YL2n7WMOpy3aJ5Lnd
         thBJSBsh2WqcggOSrdTj0RPYVRyj8zcqbR9nDtIA1K2wRHZTtBo2Dal5PyUWg0yNHsbg
         a4jV9YD5mzTixYTko83aMY/OA1wAUVxaDoGewucz/wqrosQnRQeBwjh5pectWxLmy2fW
         u+0wO7CmLuNASAqLjqBnsJCJ79cAU+omAS6sdRPPqdNWvcaaPEJhZTuF6peYLFstmPI2
         fyDS+KhmokWLHaGS+49Ky743/QoHAPhJDLupS7z6eFGQFYX41Cv8X257ggIRqNMFdVsE
         /huQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKnKIH2nruI8bZxumLzGwduJRfRhAnsr6z67Qb2mOZwUlfpHCVeAZVbsO6NBIyOKU9NecR2EsaXCYHJQzm1XdQj16dM1dju78P2yS3qap4bd++1G9pB/VU5gPoZ8eucJjN4RcJ+nK4fYn1HkW0wvsc1zdCMs/ZYC9Wt9DVy8/lhVYAnEoTI82higse
X-Gm-Message-State: AOJu0YxvCv+OLrsYgc3mRmbTRFw1Ec+zIaOVDaC+oPHXexhf/6Y2gaLM
	qF5UUnb7rQQFzyXl6c1MYQRvYqS1SUYOmmtmvxvrT9gE+5gIrF+l87cvcAAHF6oCTdrfp1dbkQq
	RZLDaC9juAUBlN9zoVafWtDb92zs=
X-Google-Smtp-Source: AGHT+IEK7l6FfAHTkxBdGa0tA5qydpzfCH3ClijLcpozLPeH8dLk9bdt/6q9LL5YA48v4gr9VcIBYzazorjxzP6vkyU=
X-Received: by 2002:a17:90b:78a:b0:29a:d7ba:2c99 with SMTP id
 l10-20020a17090b078a00b0029ad7ba2c99mr16727101pjz.10.1709818288784; Thu, 07
 Mar 2024 05:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-3-aford173@gmail.com>
 <39aead3b-b809-4c9c-8a5d-c0be2b36ea47@imgtec.com> <CAHCN7xJnKNdsrs+UMvPqdkN+j8v+8UaoH=zargcKRi7dw0GLNA@mail.gmail.com>
 <d959159dac0effce1a80986bc87e18ffd24773b9.camel@imgtec.com> <f5eb761e9ec30927657ed02a55e3b91abede90fe.camel@imgtec.com>
In-Reply-To: <f5eb761e9ec30927657ed02a55e3b91abede90fe.camel@imgtec.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 7 Mar 2024 07:31:17 -0600
Message-ID: <CAHCN7xKLbAbdm490+Sk_mZP_WQWtMM8Qmg7WBmdZ3JqpcTPfcg@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: renesas: r8a774a1: Enable GPU
To: Frank Binns <Frank.Binns@imgtec.com>
Cc: Matt Coster <Matt.Coster@imgtec.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "robh@kernel.org" <robh@kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"aford@beaconembedded.com" <aford@beaconembedded.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 6:37=E2=80=AFAM Frank Binns <Frank.Binns@imgtec.com>=
 wrote:
>
> On Thu, 2024-03-07 at 12:26 +0000, Frank Binns wrote:
> > On Tue, 2024-02-27 at 05:50 -0600, Adam Ford wrote:
> > > On Tue, Feb 27, 2024 at 3:31=E2=80=AFAM Matt Coster <Matt.Coster@imgt=
ec.com> wrote:
> > > > Hi Adam,
> > > >
> > > > Thanks for these patches! I'll just reply to this one patch, but my
> > > > comments apply to them all.
> > > >
> > > > On 27/02/2024 03:45, Adam Ford wrote:
> > > > > The GPU on the RZ/G2M is a Rogue GX6250 which uses firmware
> > > > > rogue_4.45.2.58_v1.fw available from Imagination.
> > > > >
> > > > > When enumerated, it appears as:
> > > > >   powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.=
2.58_v1.fw
> > > > >   powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
> > > >
> > > > These messages are printed after verifying the firmware blob=E2=80=
=99s headers,
> > > > *before* attempting to upload it to the device. Just because they a=
ppear
> > > > in dmesg does *not* imply the device is functional beyond the handf=
ul of
> > > > register reads in pvr_load_gpu_id().
> > > >
> > > > Since Mesa does not yet have support for this GPU, there=E2=80=99s =
not a lot
> > > > that can be done to actually test these bindings.
> > > >
> > > > When we added upstream support for the first GPU (the AXE core in T=
I=E2=80=99s
> > > > AM62), we opted to wait until userspace was sufficiently progressed=
 to
> > > > the point it could be used for testing. This thought process still
> > > > applies when adding new GPUs.
> > > >
> > > > Our main concern is that adding bindings for GPUs implies a level o=
f
> > > > support that cannot be tested. That in turn may make it challenging=
 to
> > > > justify UAPI changes if/when they=E2=80=99re needed to actually mak=
e these GPUs
> > > > functional.
> > >
> > > I wrongly assumed that when the firmware was ready, there was some
> > > preliminary functionality, but it sounds like we need to work for
> > > Series6XT support to be added to the driver.  I only used the AXE
> > > compatible since it appeared to the be the only one and the existing
> > > binding document stated "model/revision is fully discoverable" which =
I
> > > interpreted to mean that the AXE compatible was sufficient.
> >
> > The comment is related to there being a few models/revisions of AXE [1]=
[2][3],
> > which we can distinguish between by reading a register.
> >
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm=
64/boot/dts/renesas/r8a774a1.dtsi
> > > > > index a8a44fe5e83b..8923d9624b39 100644
> > > > > --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > > > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > > > @@ -2352,6 +2352,16 @@ gic: interrupt-controller@f1010000 {
> > > > >                       resets =3D <&cpg 408>;
> > > > >               };
> > > > >
> > > > > +             gpu: gpu@fd000000 {
> > > > > +                     compatible =3D "renesas,r8a774a1-gpu", "img=
,img-axe";
> > > >
> > > > The GX6250 is *not* an AXE core - it shouldn=E2=80=99t be listed as=
 compatible
> > > > with one. For prior art, see [1] where we added support for the MT8=
173
> > > > found in Elm Chromebooks R13 (also a Series6XT GPU).
> > > >
> > > > > +                     reg =3D <0 0xfd000000 0 0x20000>;
> > > > > +                     clocks =3D <&cpg CPG_MOD 112>;
> > > > > +                     clock-names =3D "core";
> > > >
> > > > Series6XT cores have three clocks (see [1] again). I don=E2=80=99t =
have a
> > > > Renesas TRM to hand =E2=80=93 do you know if their docs go into det=
ail on the
> > > > GPU integration?
> > > >
> > > > > +                     interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_=
HIGH>;
> > > > > +                     power-domains =3D <&sysc R8A774A1_PD_3DG_B>=
;
> > > > > +                     resets =3D <&cpg 112>;
> > > > > +             };
> > > > > +
> > > > >               pciec0: pcie@fe000000 {
> > > > >                       compatible =3D "renesas,pcie-r8a774a1",
> > > > >                                    "renesas,pcie-rcar-gen3";
> > > >
> > > > As you probably expect by this point, I have to nack this series fo=
r
> > > > now. I appreciate your effort here and I=E2=80=99ll be happy to hel=
p you land
> > >
> > > I get that.  I wasn't sure if I should have even pushed this, but I
> > > wanted to get a little traction, because I know there are people like
> > > myself who want to use the 3D in the Renesas boards, but don't want t=
o
> > > use the closed-source blobs tied to EULA and NDA documents.
> > >
> > > > these once Mesa gains some form of usable support to allow testing.
> > >
> > > Is there a way for your group to add me to the CC list when future
> > > updates are submitted?  I'd like to follow this and resubmit when it'=
s
> > > ready.
> >
> > Sure, we'll keep you updated as things progress.
> >
>
> Oh, I forgot to add, in the meantime, would you find it useful for us to =
create
> a Series6XT branch on GitLab where we can include these patches? We can c=
reate a
> corresponding Mesa branch that we'll update as we progress support for GX=
6250.
> This should make it easier for you (and others) to test and hopefully mak=
e it
> easier for others to contribute while we work to get support into a good =
state.

That works for me.  Do you want me to make any changes to the series?
I know there was some discussion about the number of clocks for the
Renesas variants.

adam
>
> > Thanks
> > Frank
> >
> > [1] https://www.imaginationtech.com/product/img-axe-1-16m/
> > [2] https://www.imaginationtech.com/product/img-axe-1-16/
> > [3] https://www.imaginationtech.com/product/img-axe-2-16/
> >
> > > > Cheers,
> > > > Matt
> > > >
> > > > [1]: https://gitlab.freedesktop.org/imagination/linux/-/blob/b3506b=
8bc45ed6d4005eb32a994df0e33d6613f1/arch/arm64/boot/dts/mediatek/mt8173.dtsi=
#L993-1006

