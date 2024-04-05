Return-Path: <linux-kernel+bounces-133192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C8089A02A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21EC1C223FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010EE16F822;
	Fri,  5 Apr 2024 14:48:54 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83C16D9D5;
	Fri,  5 Apr 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328533; cv=none; b=CivB5u6HaGyoZ1XlLNUvNR4/ml0KYE6cIXUvmpy438GQ7kivX999GvQbnDmnlKhgZWZgWcAKUwDBunYrzKwAxWCm2Fzm4kbl2Kat3EdEDQgvjzQV89a8KXO25vEF41mflumCEbnM/gnMEpe0gK7ItbX2GYk+iPzH6m8XNxi8eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328533; c=relaxed/simple;
	bh=pDZ7GGq8ciXMnPm7K6+Woob0Fc+oq+L2M++ZSsq1Lg0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGQV/VAR/bWixX4NrxMLeNR+EOYjWIB0iiZEuaONwQ4/YBMYYwTROeRgHVdPKiyXrhs/ht8WFnDnXoNdmeN6RIPrJOsuqAizyXQjxxPzXSzpBO9GEM4ZgFsiiygq4+ZwdFnsWu2Vv9oaQTN44MZJeKoBa09LQ7m8dr3rjYAWbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F7E5.0000000066100F51.0025C4B2; Fri, 05 Apr 2024 16:48:49 +0200
Message-ID: <bf8771c31f282ae31009a1ef5737c03849deebc2.camel@irl.hu>
Subject: Re: [PATCH v4 1/3] ACPI: platform-profile: add
 platform_profile_cycle()
From: Gergo Koteles <soyer@irl.hu>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
  Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Apr 2024 16:48:48 +0200
In-Reply-To: <87d38d4c-14e2-4c64-baba-c9b8bd694339@linaro.org>
References: <cover.1712282976.git.soyer@irl.hu>
	 <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
	 <87d38d4c-14e2-4c64-baba-c9b8bd694339@linaro.org>
Autocrypt: addr=soyer@irl.hu; prefer-encrypt=mutual;
 keydata=mDMEZgeDQBYJKwYBBAHaRw8BAQdAD5oxV6MHkjzSfQL2O8VsPW3rSUeCHfbx/a6Yfj3NUnS0HEdlcmdvIEtvdGVsZXMgPHNveWVyQGlybC5odT6ImQQTFgoAQRYhBLSYvEYEgjzzEMQCqgtEJzXf/1IRBQJmB4NAAhsDBQkFo5qABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEAtEJzXf/1IRmdYA/0bE1BX7zOGKBgCa1DwzH2UHXawSKLpptADvI/ao6OOtAP4+wYgpR0kWR28lhmkRTpzG/+8GiMWsT60SV2bz9B7sCbg4BGYHg0ASCisGAQQBl1UBBQEBB0CPo8ow/E97WYtaek9EsLXvsvwpBsjWLq5mMOgJL/ukCwMBCAeIfgQYFgoAJhYhBLSYvEYEgjzzEMQCqgtEJzXf/1IRBQJmB4NAAhsMBQkFo5qAAAoJEAtEJzXf/1IRklEA/ipTfAI/onzNwZIp9sCdnt0bLhR5Oz8RD/FpbrJV1v7eAP0c/C6NQPDPWbQpobBR0pf1eTjWXjjr1fj2jxSvWbMRCw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Daniel,

On Fri, 2024-04-05 at 08:48 +0200, Daniel Lezcano wrote:
> Hi Gergo,
>=20
> please Cc people who commented your changes.

Thanks for this info, next time :)

> > +int platform_profile_cycle(void)
> > +{
> > +	enum platform_profile_option profile;
> > +	enum platform_profile_option next;
> > +	int err;
> > +
> > +	err =3D mutex_lock_interruptible(&profile_lock);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!cur_profile) {
> > +		mutex_unlock(&profile_lock);
> > +		return -ENODEV;
> > +	}
> > +
> > +	err =3D cur_profile->profile_get(cur_profile, &profile);
> > +	if (err) {
> > +		mutex_unlock(&profile_lock);
> > +		return err;
> > +	}
> > +
> > +	next =3D ffs(cur_profile->choices[0] >> (profile + 1)) + profile;
> > +
> > +	/* current profile is the highest, select the lowest */
> > +	if (next =3D=3D profile)
> > +		next =3D ffs(cur_profile->choices[0]) - 1;
> > +
> > +	if (WARN_ON((next < 0) || (next >=3D ARRAY_SIZE(profile_names)))) {
> > +		mutex_unlock(&profile_lock);
> > +		return -EINVAL;
> > +	}
>=20
> Why do you need to do this?
>=20

Many platform drivers use the platform profile module. They support
different sets of profiles, not all. They sets the corresponding bits
in the choices variable.

like this:
set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);

The platform_profile_cycle() cycles through the enabled profiles.

Best regards,
Gergo

> That can be simplified by:
>=20
> 	[ ... ]
>=20
> 	err =3D cur_profile->profile_get(cur_profile, &profile);
> 	if (err)
> 		goto out;
>=20
> 	profile =3D (profile + 1) % ARRAY_SIZE(profile_names);
>=20
> 	err =3D cur_profile->profile_set(cur_profile, next);
> out:
> 	mutex_unlock(&profile_lock);
> =09
> 	[ ... ]
>=20
> > +	err =3D cur_profile->profile_set(cur_profile, next);
> > +	mutex_unlock(&profile_lock);
> > +
> > +	if (!err)
> > +		sysfs_notify(acpi_kobj, NULL, "platform_profile");
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(platform_profile_cycle);
> > +
> >   int platform_profile_register(struct platform_profile_handler *pprof)
> >   {
> >   	int err;
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_=
profile.h
> > index e5cbb6841f3a..f5492ed413f3 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -36,6 +36,7 @@ struct platform_profile_handler {
> >  =20
> >   int platform_profile_register(struct platform_profile_handler *pprof)=
;
> >   int platform_profile_remove(void);
> > +int platform_profile_cycle(void);
> >   void platform_profile_notify(void);
> >  =20
> >   #endif  /*_PLATFORM_PROFILE_H_*/
>=20


