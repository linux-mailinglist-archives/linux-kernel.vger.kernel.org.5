Return-Path: <linux-kernel+bounces-133721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A389A7BC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65DEB20F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8B374FB;
	Sat,  6 Apr 2024 00:00:15 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58560139F;
	Sat,  6 Apr 2024 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361614; cv=none; b=J8ukGKjJMuctvYSZiv1aLg5zjZa0DRsImJfug8TunxvxhRwcKLZUC0RSVMEdHEdr9imWB6HDNXu4FAvNnxsTFubxYeNVCPPROy+lfzYHEKH5yhzbcdQk6SbAJ5nPrsNDI3LOVXd9XOEHPSLewlJEtsRS1rfrtFy3LrGUuo3yYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361614; c=relaxed/simple;
	bh=3aPCaNK+jTu0FyoSDeQk7ne6TPziRcZYI+G6aXKvcRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A2AHJLb0rC6TpNdCw154fcqH+y+XrtuKVXVBGzrJt3WSrguyUMO9U/GpaThn0ZGnJJxSZ1zCZ7amvPtUbtgd18wvc4uff6w+UIkQeu/FePAxM70I9XiDv8XzVryiZSZ3CjMeSjNpBO8uvbJBiKsj1bPWQW/aFJCmd3NVjWEXQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F985.0000000066109083.0025D529; Sat, 06 Apr 2024 02:00:03 +0200
Message-ID: <0d78bced4d012fc30f0ad70091559d04fa7b13b9.camel@irl.hu>
Subject: Re: [PATCH v4 1/3] ACPI: platform-profile: add
 platform_profile_cycle()
From: Gergo Koteles <soyer@irl.hu>
To: =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
  linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 06 Apr 2024 02:00:02 +0200
In-Reply-To: <g_07w0jkBp9IeComzpK26YHPB1QZNjN_amEZ2bTG6xrOMMltvaav0Rd9Oh4a0nlzPsW2guvvUHkNQrfzSdFGbJhKDB0SHgUJB4belZNrapI=@protonmail.com>
References: <cover.1712282976.git.soyer@irl.hu>
	 <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
	 <g_07w0jkBp9IeComzpK26YHPB1QZNjN_amEZ2bTG6xrOMMltvaav0Rd9Oh4a0nlzPsW2guvvUHkNQrfzSdFGbJhKDB0SHgUJB4belZNrapI=@protonmail.com>
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

Hi Barnab=C3=A1s,

On Fri, 2024-04-05 at 16:34 +0000, Barnab=C3=A1s P=C5=91cze wrote:
> > +	next =3D ffs(cur_profile->choices[0] >> (profile + 1)) + profile;
> > +
> > +	/* current profile is the highest, select the lowest */
> > +	if (next =3D=3D profile)
> > +		next =3D ffs(cur_profile->choices[0]) - 1;
>=20
> I think you can use `find_next_bit()` or similar instead.
>=20

Thanks, it looks much better with find_next_bit_wrap.

>=20
Best regards,
Gergo


