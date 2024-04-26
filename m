Return-Path: <linux-kernel+bounces-160307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755938B3BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9A7289223
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6635149C73;
	Fri, 26 Apr 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+OVeYhH"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3D824B3;
	Fri, 26 Apr 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145747; cv=none; b=b7HskuRARzoWCb3QKWn9ynA+y3lyZnx9Rnu/FDt3J8+WWapfaei26p5UGr9TnAA+Jad2MWqemlM7qGMnItw/xFARZgmEpbdXTbfnnpOPZDUuPo+YJYcuKFCK0pmvgiT6gzWKaOd1ah2bIVgRiURpz8YTLBhMnMf8zbfJH3oQBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145747; c=relaxed/simple;
	bh=PQFovyCgZ9xdjLJHGbiokcmeJN3T4Q8WKOtc8qPH+4w=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=SW+olKANlPe4onBDWPVm8UsN5+K7rIzHA/xHCJ4A+g8YaXItLTVarGwPpj6McnuPXL5PnBz9kDAxVnsItl0c7zE/iONsMt3tBOLJ9K8FFpc0LtWa0qepckl3aJtlgrjR+dqM9UcKqxuCsQMzCm8rngKjDv9AhSE9JOwQijoGux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+OVeYhH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57225322312so3294370a12.1;
        Fri, 26 Apr 2024 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145744; x=1714750544; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9I5S2+S0bvqZ7UVU6beR6Uqu4fLT1g89R1N7x2rc2tw=;
        b=Z+OVeYhHLawY2kEMLGkP4Il+9i+/a9bTfqQwOoiqKLA67vuJvC9tF/COQgilTtzTZf
         5kzXv4u8KbK9554cnM8vmnaU4sT96YWAAHpmSIdeUGuUZeFkQQOEk2D2I54PDEXcDTzy
         0zi4NMjZaZORSFSPqVjcklbbLcLKZkkn4g7+Fol32PTaZChcnt+1oclaVq/CN78EKtL2
         HaCdolRaEPa15chHa2AyO2Tvv35ZPpkWe7joykbTJs3aTjo2ZM8XL3QI8uDrF9hT3SHE
         EPaZyXDfPxrvFT0rMtj0YlTMwCtGj1LkCzPMbdXu4xA2WIPCaoj0K4yaV2YXVrRIkMRz
         1epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145744; x=1714750544;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9I5S2+S0bvqZ7UVU6beR6Uqu4fLT1g89R1N7x2rc2tw=;
        b=IbU6ZhpJSt37iaU48NQfr9KJ5yMFe+q8v+dCnaJHkBvtNeOwfeStxnGSP/DoIsuPVj
         WCsNAHXrZb9wWprIHVOiTl50849lwk+pL2Ny0dBzqXyR2x8Zz4xVlRGcH2UP+36PepJA
         N+AnEz9hFVH6u3qlQRW0pojiSKAbQrUtphWOHmI3D77w75/kPn/syLnvR4pvO4gdlV66
         A1ixOFk06femA6kLpZeTXxsg847FZqAtniLDvgJTh52ckuru4CVCwKpxMsx7i5pm1aox
         4M2ZIXYzqCt+1oLZMv+oFPhPPndZfU+08XU2KSg3wNkCy1KBgc1uh6WTlbtoaEa8IO1D
         BIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt11JoPmqLOezfxBPzvSLR2+YcNsfwbPfGWBKyAwyIko7qOKKaEpMXfawOn7xx2qzhQxmT813IN/o1Rpil81VpPqeQgk8q8+2YDq/A3h+0kEWKgHPYgVC1wUEdoPV6XL0tU3NXROygXqea/AEPvpm86QSv9q/WH0Gp8dLKSoLUqf8Fr4oYLeqCm4f/fmfsei4PrRd0LIQeMAfAy+BDCxM+Gotn
X-Gm-Message-State: AOJu0Yw3ljw0NScEPSmtOClTd/B62P5xaiDY7669B2dMQRzfSCiIQIDW
	f4mceXAbV4P3EjtDyTJsSy2DpsCs5h0XWQ6ZRaJxDHXvNqf9fPzT
X-Google-Smtp-Source: AGHT+IF2wr8JiWj649TyQijnZJdEN1UK94JbX5L5JoJn/TCKNcaGYJRv/EOu+cxV7gOiqcJ3+t0WFw==
X-Received: by 2002:a50:9b5b:0:b0:56b:ed78:f58 with SMTP id a27-20020a509b5b000000b0056bed780f58mr1969434edj.33.1714145743428;
        Fri, 26 Apr 2024 08:35:43 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fd25-20020a056402389900b00572678527e6sm30568edb.59.2024.04.26.08.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 08:35:43 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=8db9efe2193992169f1855e727000475caf92fc020254d3d8060c6c4c68a;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 26 Apr 2024 17:35:42 +0200
Message-Id: <D0U5YAWTAEXO.1GLSZDY2XKKRV@gmail.com>
Subject: Re: (subset) [PATCH v7 0/5] Add Tegra Security Engine driver
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Thierry Reding" <thierry.reding@gmail.com>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <jonathanh@nvidia.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <mperttunen@nvidia.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <dri-devel@lists.freedesktop.org>,
 "Akhil R" <akhilrajeev@nvidia.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240403100039.33146-1-akhilrajeev@nvidia.com>
 <171414552137.2298337.4837480787385115790.b4-ty@nvidia.com>
In-Reply-To: <171414552137.2298337.4837480787385115790.b4-ty@nvidia.com>

--8db9efe2193992169f1855e727000475caf92fc020254d3d8060c6c4c68a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 26, 2024 at 5:32 PM CEST, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
>
> On Wed, 03 Apr 2024 15:30:34 +0530, Akhil R wrote:
> > Add support for Tegra Security Engine which can accelerates various
> > crypto algorithms. The Engine has two separate instances within for
> > AES and HASH algorithms respectively.
> >=20
> > The driver registers two crypto engines - one for AES and another for
> > HASH algorithms and these operate independently and both uses the host1=
x
> > bus. Additionally, it provides  hardware-assisted key protection for up=
 to
> > 15 symmetric keys which it can use for the cipher operations.
> >=20
> > [...]
>
> Applied, thanks!
>
> [4/5] arm64: defconfig: Enable Tegra Security Engine
>       commit: 4d4d3fe6b3cc2a0b2a334a08bb9c64ba1dcbbea4

For the record, I've also applied patch 5/5 but it didn't apply cleanly
and so b4 didn't track it properly.

Thanks,
Thierry

--8db9efe2193992169f1855e727000475caf92fc020254d3d8060c6c4c68a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYryc4ACgkQ3SOs138+
s6EV+g//fbg/7yejJ9Q0Vzf2k0pRHwe88E8Ih0sg9lYjOErhooz3HfGkb3TxbFDD
DJEoSBRHEdja4WUZ2x3uCjvuw3S7tF/w8LU6goDRnS92uGuPkgt0O+rtoSmaKLfi
MIZRVkJWtBVbrH9/6Vlvf9TRFq1xCzOunVqByMjFskeZKYxCEHEcfbbDPKfyqwR4
GChoZzcUc826b1heCZUU+E/fU1WeHBXruo2i3KRtUVQKHwjdjZ+FffLyuUZ3z6RU
xcqW8hG/PFsMJGDutWJkl5vw9o1ULHv0utkaXJ1zYBIu61pG+SqZpOw7TfAmQ8st
N7Ga6sf9++3Cmt7b7cR8+0waqdW1pYAVv+jw+c/GYM40n3C8owhSPbQjE5rxxxTS
7Wy5tvSsURjKsBXOlELeJL9ANI6/nreSrLXVBXfOeBx/+2o6tiyOhOnmW+Asml6u
PfZvMxj+BW48UETZX/01o0ABmPE+Xibb70igRKdJG/UznWpw/U8wyZcnu65Ac+9a
R5BMswVYYGJ+iaTCsrJJekr6Oam+LeIei+CQ9sigKEVAN8efZHSY/KbVicLPxFwJ
QJGOiGl2xuqejC5v6BCmdtMWh3KImuH3gHafe8v98aCc7p5Y1S4q8nBHF0iiti6L
cZk85PnTaqxFH47Dk/GlyBwCPGm2klmKQN5r85nGVFLUx1Z38yc=
=AFyx
-----END PGP SIGNATURE-----

--8db9efe2193992169f1855e727000475caf92fc020254d3d8060c6c4c68a--

