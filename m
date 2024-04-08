Return-Path: <linux-kernel+bounces-135901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA189CCDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B30DB22E4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E7146A74;
	Mon,  8 Apr 2024 20:13:07 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13F146A65;
	Mon,  8 Apr 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607187; cv=none; b=bgWWTgIkRfdmbhLSgA7WX4T7q8ytVZLPQW2L/Hy6CbNeOwU8a1JEtFtV4Vr9MpV1er8TYI/27BrqsKcavHzBJKUlm8RE6j/si6rarIFUjaGR5FZ+csC7N4zNvTSgholcUtQEWoW2AwInMV2ySmyQrZUYzWQ0L5JljVXJO9etRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607187; c=relaxed/simple;
	bh=tfLVnov28inMOXr94rGhXSFffQYW23uzyFBDUBbpJyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TVjwmEe9EI8xO3DzmoYoDj4r5UqluNghsg83eUa+ZvkP5RelABiXQ7nCBzpxrV331QRBeUWTApbOVqgE7LBkNAyHtRaeL2hPMHKWFdAz/S5OYLWdd9o2A2QMqlU+F9d4DVM8ncyYnc+/Kl80Pc3VwZagMrgWCiGgCICOxwIwJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000007076B.0000000066144FCE.00264A80; Mon, 08 Apr 2024 22:13:02 +0200
Message-ID: <b925c84615d3edadb1a9c351dd93f84e6e0dce94.camel@irl.hu>
Subject: Re: [PATCH v5 1/3] ACPI: platform-profile: add
 platform_profile_cycle()
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
  Ike Panhc <ike.pan@canonical.com>,
  Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
  Daniel Lezcano <daniel.lezcano@linaro.org>,
  =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 08 Apr 2024 22:13:01 +0200
In-Reply-To: <4e37511c-7570-4ea5-bdf9-6bdd62c63575@redhat.com>
References: <cover.1712360639.git.soyer@irl.hu>
	 <afd975d98708921f67a269aaf031a1dd1be1220d.1712360639.git.soyer@irl.hu>
	 <4e37511c-7570-4ea5-bdf9-6bdd62c63575@redhat.com>
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

Hi Hans,

On Mon, 2024-04-08 at 18:41 +0200, Hans de Goede wrote:
> > +	next =3D find_next_bit_wrap(cur_profile->choices,
> > +				  ARRAY_SIZE(profile_names), profile + 1);
> > +
> > +	if (WARN_ON(next =3D=3D ARRAY_SIZE(profile_names))) {
>=20
> Other code in drivers/acpi/platform_profile.c uses PLATFORM_PROFILE_LAST
> instead of ARRAY_SIZE(profile_names) (these are guaranteed to be equal)
> please switch to using PLATFORM_PROFILE_LAST for consistency.
>=20

Thanks for the review. I changed these in v6.


Best regards,
Gergo


