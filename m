Return-Path: <linux-kernel+bounces-39717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD283D54D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3522E1F271FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF742ABC;
	Fri, 26 Jan 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGB82Fq9"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507D11CB9;
	Fri, 26 Jan 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255307; cv=none; b=EGHmDGeN5DTpLF9tJ14S0R0PMMf2P9m204UoWXF1LTslhqrl4T1BnmDHgKVnLSE7f0chKfc3S42tjIAmfHV+0fqcU1FEhgFn5kDu844P/gbnJuPwLtM+LtKkUnmuBXeiopuxAdTqMkOK1j4URYgG/lvvZqDAVLVFhXQTpMVy/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255307; c=relaxed/simple;
	bh=nYaM+eFCc2CUTL1AfV7wPYK+r1bZG5+OH4v+qgvzIGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgMERGEn28bgZmv/5Yc1T49yMS57cAfQe6akDHyR6FGnbVQSIoZNcEBqkgVUxu0m8VKImdGYr/wOyAIoe/I6GikRe0ugVVlQDu2UEIyAu65ubV90ikwoRM1j5va4tRY9Ydlmdynpkg6U3cRU9qJUoomaniX2BKHswPJN8THWyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGB82Fq9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf205dc075so654271fa.2;
        Thu, 25 Jan 2024 23:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706255304; x=1706860104; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nYaM+eFCc2CUTL1AfV7wPYK+r1bZG5+OH4v+qgvzIGQ=;
        b=jGB82Fq9GCLsifxulBLtrdJQQAgit0vmdVtEkQ4yiwvvoZp7P5c6S7jpuW41xJkiLB
         Zjcpc85kMKORX55UjDpdjMgT8p59Hp1hvu3IeHpjJW/LKP68w/1hQT8EAHTZFPx+z1lK
         imaIBoOjmdeEN7lZKKQffCiLp20idLiVQZXz4BZbloxJhE7uF7e37xXpa8kSBsinnThB
         QrUea/oj0elDE1KTw7IDXGxPRLO1JLK8+0ujpzmYAbauu9u+/60iRuGpUJJwUdaBHmyH
         h21IibJV2skoPVeECy925ubaPIOjBAq+3s2x5cHkzQ+8fvRf7lj9p/jav+ou4ikWAZ8F
         7l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706255304; x=1706860104;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYaM+eFCc2CUTL1AfV7wPYK+r1bZG5+OH4v+qgvzIGQ=;
        b=v8XdcvzaqYh1Gcj23GOq3BE0/FMOq7Pi9RApEzsF5i9fWJcf95BzWkhB93d51WJhMX
         j5wFZo7WqkHUO+JuVZhKwEpFKPCvSRzaDf3eGh3opu3ve20kWMFO552RTPIDT3SAnqjF
         Uaq12NKrSd2JA4lNPRu0A2RASbGaziXDW83kaUe1ZHVzgv2zjyTcKnGIXbZK1Zx15RVq
         fnCAG56eAkpzHZz+wTDySS+KCGPJD62pgkpqTQDj/HeOa5lmZuWx2erOgZPcL9AyBaj6
         LG6HOuuf8Ll/Fa6F/WTx2fApNPU74ZnOldLM9wmw7bjK+BD2b2aAml9JGl7qEOvub6G8
         EItg==
X-Gm-Message-State: AOJu0YyAnQ6cIqvHIJMcPVyNr6rVkhWR+ldoxEDAa/IgUJWwt+zlytOK
	ta5MrmBRD0Lo4SuUZ8h4DjZ6TAHBFpbHXs8v7Wwkvc75+fyLDi1h
X-Google-Smtp-Source: AGHT+IEe5J4EYeLJ8Vv/ijVi4P+M0YFf3nSnwunChGQtF21FjqrjDnRudXi7kRj+KYCOKUAaQEeS3w==
X-Received: by 2002:a2e:8715:0:b0:2cf:495a:1396 with SMTP id m21-20020a2e8715000000b002cf495a1396mr185263lji.17.1706255303652;
        Thu, 25 Jan 2024 23:48:23 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id l30-20020a50d6de000000b0055c875c2095sm330324edj.96.2024.01.25.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 23:48:23 -0800 (PST)
Message-ID: <1b42866bb6f05b7d68e9b8304e42359fccdf2bad.camel@gmail.com>
Subject: Re: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, Ibrahim Tilki
 <Ibrahim.Tilki@analog.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, 
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,  "linux@roeck-us.net"
 <linux@roeck-us.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	 <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>
Date: Fri, 26 Jan 2024 08:51:39 +0100
In-Reply-To: <147c92f9-b42b-4a51-a6f9-2d90bfe63aa0@alliedtelesis.co.nz>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
	 <147c92f9-b42b-4a51-a6f9-2d90bfe63aa0@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 02:22 +0000, Chris Packham wrote:
> Hi All,
>=20
> On 4/04/23 03:43, Ibrahim Tilki wrote:
> > changelog:
> > since v5:
> > =C2=A0=C2=A0 - dt-binding: add enum value "2" to aux-voltage-chargable
> > =C2=A0=C2=A0 - dt-binding: remove adi,trickle-diode-enable
> > =C2=A0=C2=A0 - dt-binding: change description of trickle-resistor-ohms
> > =C2=A0=C2=A0 - dt-binding: reorder as in example schema
> > =C2=A0=C2=A0 - parse "wakeup-source" when irq not requested
> > =C2=A0=C2=A0 - remove limitation on max31328 irq and clokout
> > =C2=A0=C2=A0 - remove error and warning messages during trickle charger=
 setup
> >=20
> > since v4:
> > =C2=A0=C2=A0 - dt-binding: remove interrupt names.
> > =C2=A0=C2=A0 - dt-binding: add description for "interrupts" property
> > =C2=A0=C2=A0 - dt-binding: replace deprecated property "trickle-diode-d=
isable"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 by "aux-voltage-chargeable"
> > =C2=A0=C2=A0 - dt-binding: add new property "adi,trickle-diode-enable"
> > =C2=A0=C2=A0 - dt-binding: remove "wakeup-source"
> > =C2=A0=C2=A0 - use clear_bit instead of __clear_bit
> > =C2=A0=C2=A0 - use devm_of_clk_add_hw_provider instead of of_clk_add_pr=
ovider
> > =C2=A0=C2=A0 - use chip_desc pointer as driver data instead of enum.
> >=20
> > since v3:
> > =C2=A0=C2=A0 - add "break" to fix warning: unannotated fall-through
> > =C2=A0=C2=A0=C2=A0=C2=A0 Reported-by: kernel test robot <lkp@intel.com>
> >=20
> > since v2:
> > =C2=A0=C2=A0 - dt-binding: update title and description
> > =C2=A0=C2=A0 - dt-binding: remove last example
> > =C2=A0=C2=A0 - drop watchdog support
> > =C2=A0=C2=A0 - support reading 12Hr format instead of forcing 24hr at p=
robe time
> > =C2=A0=C2=A0 - use "tm_year % 100" instead of range check
> > =C2=A0=C2=A0 - refactor max313xx_init for readability
> >=20
> > Ibrahim Tilki (2):
> > =C2=A0=C2=A0 drivers: rtc: add max313xx series rtc driver
> > =C2=A0=C2=A0 dt-bindings: rtc: add max313xx RTCs
> >=20
> > =C2=A0 .../devicetree/bindings/rtc/adi,max313xx.yaml |=C2=A0 144 +++
> > =C2=A0 drivers/rtc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +
> > =C2=A0 drivers/rtc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > =C2=A0 drivers/rtc/rtc-max313xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1053 +++++++++++++++++
> > =C2=A0 4 files changed, 1209 insertions(+)
> > =C2=A0 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max=
313xx.yaml
> > =C2=A0 create mode 100644 drivers/rtc/rtc-max313xx.c
>=20
> What happened to this series in the end? It kind of went off my radar=20
> and I forgot about it.
>=20
> We've been carrying a version of these changes in our local tree for a=
=20
> while (and using it quite happily I should add).
>=20

Hi Chris,

Also not sure.... In the meantime Ibrahim left ADI so if this is not in sha=
pe to
be merged he won't be able to re-spin. If there's a need for a re-spin, ple=
ase
let me know so I can see internally if there's someone who can continue thi=
s
work. I would do it myself if I had the HW.

- Nuno S=C3=A1

