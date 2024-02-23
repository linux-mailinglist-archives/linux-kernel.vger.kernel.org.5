Return-Path: <linux-kernel+bounces-79264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD9861FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F6C1F23ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7824B2B;
	Fri, 23 Feb 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KDiQaAq1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C91119B;
	Fri, 23 Feb 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727560; cv=none; b=hPKTGyp9TTFIlorEqLeq4lHOJ5RvYGWezT5ICmEyFMCU2zS5ZS/FybDQ/390fwDaZdf+Fg1WHUKIBvcaFhpTIX7yjgHFK9wxlz02epxXfNuMibG6LWiH7Z9PuoJ9Tbi2JxTbh4KbgiV3YhY2Xag/eBYMuWoa/L5OqsRcB/5LyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727560; c=relaxed/simple;
	bh=PSs1k4yhOaJo0FhDXl1IC/61LVXaUjlUC3glDlqHR+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO0i7LcyLgV2PN8k2kNf4G+io1RPmdLHzF9IQ04Xf4avyN9+QBeeFErwQIGmPER7ymxqGw0jIhKNKwYLczls4FHS8lLrIeYYHldIDDpTwGnDsuTfF/ykp1n6ur4A+slfNXuSIVZNewnS19oNZkHtA31iBJmC8M6pHSnOMKnURUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KDiQaAq1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708727554;
	bh=PSs1k4yhOaJo0FhDXl1IC/61LVXaUjlUC3glDlqHR+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDiQaAq1lyRcjhTQW47KCHDEbmn5dw4W0sqCeown0uhw6TzmHSV93fpjvZU7swVkI
	 +KXHOAjYoD/aE5QDrVnCfbI2k1hOSE7EDK9EM59hbVqhXqYj0345NiO/75as3pQJdr
	 zGONe1b+drG4lF1T8vkB/mewsMfc8XJmd0VKY1POhpnut9rDJ/qF5uGj96+k5eBxFY
	 G4Bu1fgzzbHkFsPjhWljBjV+hgUPexoljU9qGO9YTfzrHmjqq33JMir2C46wM/em+E
	 X+6cxY3dC5gCPfR8z5zl72ZmyVpfxeTZTNUGUJPVxKHVMLZ741ADY3cO42YAMTllGK
	 ADnx4v9lvELjA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB97C3780627;
	Fri, 23 Feb 2024 22:32:34 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4818D1060C95; Fri, 23 Feb 2024 23:32:34 +0100 (CET)
Date: Fri, 23 Feb 2024 23:32:34 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] power: supply: Add Acer Aspire 1 embedded
 controller driver
Message-ID: <wr4awfmyip3fe5y4xpv6xajigsvc4qftawonkolrtsamr3pumb@aio2ishg3o7c>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
 <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
 <7c429d2110dbac68d0c82c8fb8bfb742@trvn.ru>
 <xelebhoitnwguhewahw26xopl5btjo5ezznjjaeb2zfyy2bpcr@7pmclezshwck>
 <6e3fb1080c54cfc38dc3c3e79e32a53d@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3dnrs6dj67zatrw"
Content-Disposition: inline
In-Reply-To: <6e3fb1080c54cfc38dc3c3e79e32a53d@trvn.ru>


--x3dnrs6dj67zatrw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2024 at 08:34:29PM +0500, Nikita Travkin wrote:
> Sebastian Reichel =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 23.02.2024 20:04:
> > On Fri, Feb 23, 2024 at 07:32:17PM +0500, Nikita Travkin wrote:
> >> >> + This driver provides battery and AC status support for the mentio=
ned
> >> > I did not see any AC status bits?
> >>
> >> I was referring to whatever ACPI spec calls "AC Adapter" but I guess
> >> I should have used the word "charger" instead... Will reword this.
> >=20
> > But you only register a power-supply device for the battery and not
> > for the AC adapter/charger. When you write "and AC status support" I
> > would have expected something similar to this (that's from ACPI AC
> > adapter driver):
> >=20
> > $ cat /sys/class/power_supply/AC/uevent
> > POWER_SUPPLY_NAME=3DAC
> > POWER_SUPPLY_TYPE=3DMains
> > POWER_SUPPLY_ONLINE=3D1
>=20
> Ah, I see... Yeah looking at it one more time, I mistakenly assumed the
> acpi ac code uses the same data fields as the battery but seems like it
> reads the single online flag from a different place. I don't think there
> is really a point on implementing that field since we can still easily
> track the battery charging/discharging status so I will probably omit it
> for now. Will reword the help text to not mention charger/ac adapter.

If you have the information easily available, it's a good plan to
expose it.

Without a charger reporting online status at least the kernel's
power_supply_is_system_supplied() will return false (which is e.g.
used by AMD GPU driver to select power profile).

Generic userspace (i.e. upower) probably behaves similar, since
battery status is not the same as AC connceted. A system might
not charge the battery but still run from AC itself.

-- Sebastian

--x3dnrs6dj67zatrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXZHPcACgkQ2O7X88g7
+ppExA/6Ay7wM3uN5mNgDtWxq1XLrsykjXSgSsYKJzByjQuageupwDlF6Rx6lKXQ
X8UjL4r8YlEaGyce2L8uYaoH9KN0ge45v/CiEKZo2PJyCBpQGW8rbO1rNlZampi+
y2jSurRj8aUrbgToM0Q2tiZQWU3CLJzu0TsFZ0/7sfgEzaEzFurQ0k3nvTNYARLN
ayqnP6NIDb18AFwToW5jdoe8c+MweBK4XhjNNZeiFAsnCe4LgKSjr0aHdeGwJh1F
AGffLuHnc/TSWecDaKQG8NaZV9KIjzYHZwULTWFQwvIaFnMSNFJLyaZX91NGV4Sc
R7HZVdSm/3Q60PvKQ9ZkseRbLSHHRJQTvj8akX5sLfD4L7CMe19tPqcaDB50jIUi
VJdqCrq9lZLJVfbJDKVysLHfTNHBrm948FxOdFgd/chETFCDODrRJZ+W96+rb7uC
m/CoGtow7mSP1Tm183JktlamMk7c+D2qj2xF6mfRJMIT1816qA7hfZNB6YQyky++
pw8kRos46RCCOrhRInZqJGy5DBz3JDZqqMWJFDQYdxQaZM0m7J2PST/auCUhK14v
Uo8bjWdbR7BBFLB5FXAGONH/bdihhnD8er1H5LIDzPmxv8ASQxC924BEozSya/4J
aEox1XhdHHsQpCByVX7kL2afGt574rkvnyOwT9WLf8RA2KCjROg=
=gazE
-----END PGP SIGNATURE-----

--x3dnrs6dj67zatrw--

