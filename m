Return-Path: <linux-kernel+bounces-152942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541A8AC665
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC11B207C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001264F207;
	Mon, 22 Apr 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZU3Z+wU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1C4DA11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773465; cv=none; b=jpvRA7E5qZqp/HH+enPIi+tAGWcUChv/STZpBJ5ZGzTY13Tw/IbFn/fDcaJQ7c+TqQ6l0A3rcuDIMKY8G8GAoBaFqe+2M94Eae8uqCHFCXpqJJnsYhOgzvzKHbGQV8koEphZ4CQ1gUTFq0mBV1EXzZ1jzwnT/b0T0xXUthPXNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773465; c=relaxed/simple;
	bh=e9GKbiHtBRjjqYKrxUrMGm5SH2rgrO2zZWgczq/P31k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2CBXMTwVfeoE2PQqLqWj5wymBZxpTMD1K4hiFhn8jl/xY0L+BlKUiPLdalxLTYmFQmWDj2TH3EAJLR8HYSzzINbBXI1AKJiZa7DTh1VBYAbamHkZ/iuiBor0n5aaNKHkEM+xpDQNBZ64JhybJfBHl90QfRiXXHgE9fJ2OvnqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eZU3Z+wU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55e17f5d8dso27901366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713773461; x=1714378261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9QX8CooDHp78Imo/EPyC0WcDTvF78Bq5sAeBhgkAFM=;
        b=eZU3Z+wUST+x1NdU+N9jwhw5DEPr7jaBRmYNKmbnPqO77XLTo1tVwVXCu9IZdhhPiR
         tV0nYJvyiDZIhUiwQyy0iiqHi7t546xJPPixTXJob4MnyEVoo03ksp9hyEX2fBD4wyPf
         +Pra6zyvHPHTKTgPmLoqQ5EDYNqrzMA8/FTq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773461; x=1714378261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9QX8CooDHp78Imo/EPyC0WcDTvF78Bq5sAeBhgkAFM=;
        b=hphhVCLYYAYD+nG5OXSYXBSkTH60y+6M8bHPQtbR6gpPZy/xsR5WwzvN0kOY070HeR
         85NJiTKObrk97vl7qsOr1Y7I3VZnQHxnrhHv+/4zSlv4idvHfrov/7HCisib7PlLt7nc
         BRlTw1Vkrcm0UTmTU3IsoVfIVhFUfsi91OHQNV0ISV4DJbHauoagUnV0jyiq4t+jAJTN
         wfG73GpvN1b69zVbwnfVZwBC1mMPJDoJbkTwmbssI8Hw//ATesKWL1VSWnjJAkdQYoXK
         1HF5GxVYiq9II4w3Z6LVDJFKSaf1NoneDh1PCZrxUDKoFWbxqH1fDmP/rW2OrR44OlJc
         E+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIQ3/6Xh7A71YjpuGBM3g8Nf/tm8fUwcECxyjAlr7NzCMJyVdd2gEx2laEkpDAjyvo3Cv4lBZQ7q8oSA9mbRis4SXTesekfck/wyk0
X-Gm-Message-State: AOJu0YzfHf6SmJU1ujKFteQ/17Ao+RDxeOOyJSbaZiSNPmPBPZIob4yr
	0W/ZuTBfFbyOjduX+3mkVjiUlQR8RdK/hT53162JC5WyR6svJxinbt5/XcKbA743IHuv5MH1PEg
	=
X-Google-Smtp-Source: AGHT+IHPspeNQJIiwHM3NLMc55KG0SX5SILqVlxSYpJQylHW9qNRSv59K+OeJS5EqZpevYKax3LLew==
X-Received: by 2002:a17:907:2d9f:b0:a56:cb24:fbb9 with SMTP id gt31-20020a1709072d9f00b00a56cb24fbb9mr374370ejc.20.1713773461025;
        Mon, 22 Apr 2024 01:11:01 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906a10800b00a4e253c8735sm5456829ejy.52.2024.04.22.01.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:11:00 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4702457ccbso454722866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:11:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIZDvUafywQQrEnKnkAv6KA9BfK+OO9Ox0M153V1anEpHVaAF/Imleh20k9Vjr1IK3/3gItu5Mq4WRLRnPu2k6+Vhvw7YXC/ZdBORs
X-Received: by 2002:a17:907:9624:b0:a52:2a36:38bf with SMTP id
 gb36-20020a170907962400b00a522a3638bfmr6898017ejc.55.1713773460150; Mon, 22
 Apr 2024 01:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
 <cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano>
In-Reply-To: <cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 22 Apr 2024 16:10:23 +0800
X-Gmail-Original-Message-ID: <CAHc4DNJ0prAQOw89Hvw8n9KhY+8xB3D77pJvoPfU-X7ZFDYu7Q@mail.gmail.com>
Message-ID: <CAHc4DNJ0prAQOw89Hvw8n9KhY+8xB3D77pJvoPfU-X7ZFDYu7Q@mail.gmail.com>
Subject: Re: [PATCH v3] power: supply: sbs-battery: Handle unsupported PROP_TIME_TO_EMPTY_NOW
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@collabora.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 12:03=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Thu, Apr 18, 2024 at 01:34:23PM -0400, N=C3=ADcolas F. R. A. Prado wro=
te:
> > Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> > specification as required, it seems that not all batteries implement it=
.
> > On platforms with such batteries, reading the property will cause an
> > error to be printed:
> >
> > power_supply sbs-8-000b: driver failed to report `time_to_empty_now' pr=
operty: -5
> >
> > This not only pollutes the log, distracting from real problems on the
> > device, but also prevents the uevent file from being read since it
> > contains all properties, including the faulty one.
> >
> > The following table summarizes the findings for a handful of platforms:
> >
> > Platform                                Status  Manufacturer    Model
> > -----------------------------------------------------------------------=
-
> > mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG=
0
> > mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> > mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> > mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> > mt8173-elm-hana                         OK      Sunwoda         L18D3PG=
1
> > sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> > sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047=
XL
> > rk3399-gru-kevin                        OK      SDI             4352D51
> >
> > Detect if this is one of the quirky batteries during presence update, s=
o
> > that hot-plugging works as expected, and if so report -ENODATA for
> > POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, which removes it from uevent and
> > prevents throwing errors.
> >
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
>
> Hi,
>
> I'm coming back with more information after some more testing has been do=
ne.
>
> Most importantly, in the meantime, a parallel investigation uncovered tha=
t the
> time_to_empty_now issue was actually in the EC firmware:
> https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/54657=
47
>
> So the other faulty properties (which I'll mention below) could also be d=
ue to
> the EC firmware. These are the EC firmware version for the platforms with
> additional issues:
> * RW version:    juniper_v2.0.2509-9101a0730
> * RW version:    lazor_v2.0.6519-9923041f79
>
> Hsin-Te, do you have information on whether it's an EC issue in this case=
 as
> well?
>
> The following table shows all the faulty properties per platform:
>
> Platform                               Manufacturer  Model      Faulty pr=
operties
> -------------------------------------------------------------------------=
--------
> mt8186-corsola-steelix-sku131072       BYD           L22B3PG0   -
> mt8195-cherry-tomato-r2                PANASON       AP16L5J    time_to_e=
mpty_now
> mt8192-asurada-spherion-r0             PANASON       AP15O5L    time_to_e=
mpty_now
> mt8183-kukui-jacuzzi-juniper-sku16     LGC KT0       AP16L8J    time_to_e=
mpty_now
>                                                                 capacity_=
error_margin
>                                                                 constant_=
charge_current_max
>                                                                 constant_=
charge_voltage_max
>                                                                 current_a=
vg
>                                                                 technolog=
y
>                                                                 manufactu=
re_year
>                                                                 manufactu=
re_month
>                                                                 manufactu=
re_day
>                                                                 SPEC_INFO
> mt8173-elm-hana                        Sunwoda       L18D3PG1   -
> sc7180-trogdor-lazor-limozeen-nots-r5  Murata        AP18C4K    time_to_e=
mpty_now
>                                                                 capacity_=
error_margin
>                                                                 constant_=
charge_current_max
>                                                                 constant_=
charge_voltage_max
>                                                                 current_a=
vg
> sc7180-trogdor-kingoftown              333-AC-0D-A   GG02047XL  time_to_e=
mpty_now
> rk3399-gru-kevin                       SDI           4352D51    -
>
> If it turns out to not be an EC issue for the properties other than the
> time_to_empty_now, then quirks will need to be added for them. As for SPE=
C_INFO
> it's fine to keep it the way it is, as it already fails gracefully by fal=
ling
> back to disabled PEC. However it does mean sbs_update_quirks() would need=
 to be
> moved up in sbs_update_presence(), or it will never run when SPEC_INFO fa=
ils.
>
> Also, the battery vendor for limozeen is actually "Murata ", with a trail=
ing
> space...
>
> While at it, I also tested whether PEC was broken on all platforms (which=
 have
> the SBS battery behind the EC I2C tunnel) to see if it could have any rel=
ation
> with the faulty properties:
>
>                                                                 PEC
> Platform                               Manufacturer  Model      Status
> ------------------------------------------------------------------------
> mt8186-corsola-steelix-sku131072       BYD           L22B3PG0   NOT SUPPO=
RTED
> mt8195-cherry-tomato-r2                PANASON       AP16L5J    NOT SUPPO=
RTED
> mt8192-asurada-spherion-r0             PANASON       AP15O5L    NOT SUPPO=
RTED
> mt8183-kukui-jacuzzi-juniper-sku16     LGC KT0       AP16L8J    NOT SUPPO=
RTED
> mt8173-elm-hana                        Sunwoda       L18D3PG1   BROKEN
> sc7180-trogdor-lazor-limozeen-nots-r5  Murata        AP18C4K    NOT SUPPO=
RTED
> sc7180-trogdor-kingoftown              333-AC-0D-A   GG02047XL  NOT SUPPO=
RTED
> rk3399-gru-kevin                       SDI           4352D51    BROKEN
>
> Where on the platforms marked BROKEN all properties would fail like so:
> power_supply sbs-9-000b: driver failed to report `status' property: -74
>
> Those platforms indeed had PEC enabled:
> <6>[   18.109211] sbs-battery 9-000b: PEC: enabled
>
> and I verified the reported SBS version was SBS_VERSION_1_1_WITH_PEC.
>
> Meanwhile, all the other platforms, marked NOT SUPPORTED, didn't actually=
 have
> PEC enabled:
> <6>[   14.563070] sbs-battery 8-000b: PEC: disabled
>
> which I verified was due to version SBS_VERSION_1_0 being reported (excep=
t for
> jacuzzi, which fails to report a version).
>
> So all platforms that had batteries that support PEC, have broken PEC, bu=
t most
> don't support it. In any case there doesn't seem to be a correlation with=
 the
> properties that the batteries support, so it looks to be an orthogonal is=
sue.
>
> Thanks,
> N=C3=ADcolas

It looks like the firmware version of juniper is too old. Could you
update the firmware and test it again?
Also, Could you provide the error you get from lazor?

Regards,
Hsin-Te

