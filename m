Return-Path: <linux-kernel+bounces-78566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD6861521
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5141C22202
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68D81AD1;
	Fri, 23 Feb 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VyJmqqsg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2B29AF;
	Fri, 23 Feb 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700684; cv=none; b=hSiLhTcLL7ckatWIB+gSYq4idV+WoqQoRr4OdTQSeP8rvb5ZOppMlWE2jSN4QHvkshiTK1S11mr4AbQvbRUoSAQ7TR+NWkieo0qVLSdVqJ4UhxWf0rp5Jx5H3vrADiWV0W9gNtLJVYTPvuvFCEbKTYVuaLkqbtZdGsOtX9YYWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700684; c=relaxed/simple;
	bh=5x6pYf9qLTpW8AR7rB7BIZ/ftWmhCe5nScEqQHk3wMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0nlfI9McLxMuFSXlZxCKHMkFFgjLxFP09lDQEQ0E8Z3hW1lYmBfAjy4wuxzgCuYP+Kz1tsz2ezmGbH62JppLtQmWEg61u8WO2s6YpdIqcpogwow+UjXBPci7pU4OurmJLTkHhEduoFiD30QWEttwyxsdJwrTv60DnVBMGJCjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VyJmqqsg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708700676;
	bh=5x6pYf9qLTpW8AR7rB7BIZ/ftWmhCe5nScEqQHk3wMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyJmqqsgpm5U9Y5HtXtI531KmUgmHHitp9i69QI4A+zH5d52EXsfvN55wwYd1KTvP
	 5SL2CNKtxJ29VXhp+eRVRNcg1/MrKgpLyuAnPxl7KRtEvZc+y8lBvVxQT8LYJLF/FR
	 IRnVg9ZGUjzW5p9qC/0LoFwwm58SkAtvIrtZjEFgJ+GQXjqhdMiB1xjSND/T/a9OiH
	 FD0ihu5q66PVpVWD1Fe6rVdSRSU9Se9SwOtuGxtF9A7Wn/gEcyDhXB8vig62Z5ErTY
	 9DS/5EMBwG18wOc0EqHvYkQSoxMutq4GruMj63dhD8Pe1nKj3e05JIgP4qmyGE0UyU
	 /EvO+Rx6WTX+w==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94627378000E;
	Fri, 23 Feb 2024 15:04:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 352031060C95; Fri, 23 Feb 2024 16:04:36 +0100 (CET)
Date: Fri, 23 Feb 2024 16:04:36 +0100
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
Message-ID: <xelebhoitnwguhewahw26xopl5btjo5ezznjjaeb2zfyy2bpcr@7pmclezshwck>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
 <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
 <7c429d2110dbac68d0c82c8fb8bfb742@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxpcrmzfdpf2u4kj"
Content-Disposition: inline
In-Reply-To: <7c429d2110dbac68d0c82c8fb8bfb742@trvn.ru>


--zxpcrmzfdpf2u4kj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2024 at 07:32:17PM +0500, Nikita Travkin wrote:
> >> + This driver provides battery and AC status support for the mentioned
> >=20
> > I did not see any AC status bits?
>=20
> I was referring to whatever ACPI spec calls "AC Adapter" but I guess
> I should have used the word "charger" instead... Will reword this.

But you only register a power-supply device for the battery and not
for the AC adapter/charger. When you write "and AC status support" I
would have expected something similar to this (that's from ACPI AC
adapter driver):

$ cat /sys/class/power_supply/AC/uevent
POWER_SUPPLY_NAME=3DAC
POWER_SUPPLY_TYPE=3DMains
POWER_SUPPLY_ONLINE=3D1

-- Sebastian

--zxpcrmzfdpf2u4kj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXYs+8ACgkQ2O7X88g7
+pp0pQ/+I8r1MIK+6d+62Nhgu1dizPhWY5c5s1DPh3CbJHrAhUlfgaTisBQBldsz
WkzDoOnYEG1lLDSlhsi+0/JbfufNry+gewlCbZ+WR8xPi/R7Zczp94TVvnVixD3e
TJeyAlv4adPN1FJs7YIVnZE8e77xb8VeCTUq0vLXWlFi0hLt4lHyAdZk9ZihokTO
EvKw/1rdVPn1Ztu5EIRZkPfHJvnOlnahTqcV/CEb5Q1W6vq+A4TS8cY1GkJXGGBc
FTDbMPeaYn/VWxIyqKCgatcd1ypqP5mWhm7JdARSe1vMQw2InVyoNjMmG5I1HxBT
ndudYQhftgOiDpeh8QcdfxFOhT5Yp9/rAO/DKm68URKBh3mbb0EZvIk46afZPIls
+DfLtw5FeWNnU5Q0Ak8JY6mFEyqOMLR5IpSUAuHxY4STLsKBDStHBVwYZn0+C4D2
QmNj9IgWAq51SJVKHWOB1afsPP1JPIyDJsHF8jCubdoAOlywd/HyxPlHXpFqxQsA
JxvFM/mGHseeE/Q05UNMApNxdn/+wao1bXF2h1JSpW3VOwOSRdLqFJ4I7HzlGpD9
9uxdqBb/3wRTLsZKIRchIQtbG6j88meODLU7kq4+Yn+UlEVLktfxHFztK5aPfoLy
ngO2wlTKZs6wUAJuGJJidndXx21+4SJloIOhaLRHO2tmhEG6c1U=
=X9fX
-----END PGP SIGNATURE-----

--zxpcrmzfdpf2u4kj--

