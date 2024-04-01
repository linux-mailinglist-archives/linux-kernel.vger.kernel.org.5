Return-Path: <linux-kernel+bounces-126799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B4893CD6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88110283033
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC544655F;
	Mon,  1 Apr 2024 15:25:45 +0000 (UTC)
Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD104644C;
	Mon,  1 Apr 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985145; cv=none; b=VyWf1djRzsEbsvrnnOvb83/rvN5pDbiHjfOVq9DhBfxQ5qQ1mwaFCxpzvn/+zaf23V69fxpJxJT1y4YB/lvOdPW3zZhLFtEYmXI5x4NRa4lbwgwxUyWfQ0CI9IX6w4LrZRce+krwAgRjXtVnb0Gu0Ew79kDG74e62oUVNlGnDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985145; c=relaxed/simple;
	bh=OeNqEg970RTZFsUUtlkvbwTO3+NJJk6oGB2hi48PVx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVvBleHsU9Ic8D8oVLdwx31a7G1qlSEx2/nF+3EnyEwwXIl41bcXODXqwO0ua3N/pHrUWUe91e+XPS8r5x5YWHordoIZg1a09XJjbPPJRuF1C3VltuwW+I+hStckNlW1as/zKp18sjGurawfVUcEWpXz2Hn27hYXq4baG6+Ocbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inka.de; spf=pass smtp.mailfrom=inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inka.de
Received: from mail.berkhan-weisser.de ([2a03:4000:54:b9a::4])
	by mail.inka.de with esmtpsa 
	id 1rrJXW-00Ar1s-Fc; Mon, 01 Apr 2024 17:25:38 +0200
Received: from 127.0.0.1 (helo=localhost.localdomain)
	by mail.berkhan-weisser.de with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <Enrik.Berkhan@inka.de>)
	id 1rrJXW-003wrk-16;
	Mon, 01 Apr 2024 17:25:38 +0200
Message-ID: <590320d523ace70d3b1fc86735849229040b8886.camel@inka.de>
Subject: Re: [PATCH] platform/x86/intel/hid: Ignore power button release in
 wakeup mode
From: Enrik Berkhan <Enrik.Berkhan@inka.de>
To: Alex Hung <alexhung@gmail.com>, David McFarland <corngood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Mon, 01 Apr 2024 17:25:22 +0200
In-Reply-To: <20240401133919.4304-1-Enrik.Berkhan@inka.de>
References: <20240401133919.4304-1-Enrik.Berkhan@inka.de>
Autocrypt: addr=Enrik.Berkhan@inka.de; prefer-encrypt=mutual;
 keydata=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
 Dh1pYX8125Sys26JeDfnh3bnI=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Mon, 2024-04-01 at 15:39 +0200, Enrik Berkhan wrote:
> Since commit 0c4cae1bc00d ("PM: hibernate: Avoid missing wakeup
> events
> during hibernation"), the return value of
> hibernation_platform_enter() is
> used. This will, for example, cancel every hibernation attempt if a
> wakeup
> event is registered during the (long) preparation time needed before
> entering platform hibernate mode.

Oops, too late, already obsoleted by
https://lore.kernel.org/all/20240318191153.6978-2-corngood@gmail.com/#t

Cheers,
Enrik


-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEbLyQBMI0qAWiF6l31AjqSkbLPKQFAmYK0eIACgkQ1AjqSkbL
PKTuzwwAhPy9c5/GuTHkaZJhhWcz5VHjbuY9rvywiI3nswEC/Pkav97wIL2IN8jW
9x4+VGJWCv3q/TlNauaD3T6WaPyulTNI9zcFmIY3Adm73+TEQ3OITmZMTJEv3BPC
tgXbs+v0Iuu9G1twpNOrtpQ6aWvwtZJugAN4UOEk+Avx2OIYTc6zoRLTTV+0PMsy
0GlQ3jEQDpB//0ZroP0t9duGtqOIEa6xGfCMOf0ccyyydeVvXjRQOGZ+ZkZ81Egp
fWnc0KRb5gzNAgLa4wzksOtu6sBDtXj1jBcrbqwzOuTfr+KBgebfbalHNExPAVxJ
6DYaZ3yPBL81EaUu/QSGFwOodphtkjGvfkGonvtX/bQOSxXEhwAe4wvWeeE0wncN
um6YVw+QoBKaIxXEV+jtjkelMazAopf6jp6EDEoqmcfPS17oag2Hkg05oooJNSNc
PizbNmYZv6imykUpM8vC9nX54jup9t9MKbNdcMRcU/ReRdhLKm6au4qjWTSxfXXp
ll4euik0
=3D0GKA
-----END PGP SIGNATURE-----

