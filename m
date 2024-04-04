Return-Path: <linux-kernel+bounces-131680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2118898ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDD9282568
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77951129A78;
	Thu,  4 Apr 2024 15:10:43 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12681D551;
	Thu,  4 Apr 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243443; cv=none; b=nIH9l7cCWoxcdA9rOGC7KCq3aY3dS1bxHJNJYi3MYV6Yrc5/frQRUCdXx4TgNDZaMwasSgoQHJAZgNT+Y1sPk/PKIOgpdgUaib4dhnBXF/E8+rLrCGEUvKk1CYnQoNKsX8vF4QWN35sllUjY9mQRQ8y4JRzOQdn6nha99+kfd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243443; c=relaxed/simple;
	bh=vaEH/7UI3i+pPAefwLuVf+TqLBvLn9fh0xIiqmLVADw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fFgx0Z8MKofK+08151HGzoRZKJS38IPCqNx5/X2ihq9Tz6KW/sb3ACj6tOW4HxXKrm1l9e1MRUZ8cGVrvQUpCct1eEPyBfSGm9WCj1eHojvKqfSeqr8i5PIUaObSq9CBslXTGqCzfduF/yrugfrrf97mXYkHNMR/10B/oXoMrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006EF1D.00000000660EC1BA.002595F8; Thu, 04 Apr 2024 17:05:30 +0200
Message-ID: <b5ad9ab4e1785266fbf9f9b9e68b41bec95e5820.camel@irl.hu>
Subject: Re: [PATCH v3] platform/x86: ideapad-laptop: switch platform
 profiles using thermal management key
From: Gergo Koteles <soyer@irl.hu>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
  Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Apr 2024 17:05:29 +0200
In-Reply-To: <45f12590-4f79-4875-a497-cbb1ac3deb38@linaro.org>
References:
	  <7c358ad8dd6de7889fa887954145a181501ac362.1712236099.git.soyer@irl.hu>
	 <45f12590-4f79-4875-a497-cbb1ac3deb38@linaro.org>
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

On Thu, 2024-04-04 at 15:27 +0200, Daniel Lezcano wrote:
> > Cycling is done through modulo.
> >=20
> > Quick and dirty example:
> >=20
> > static int profiles[] =3D {
> > 	PLATFORM_PROFILE_LOW_POWER,
> > 	PLATFORM_PROFILE_BALANCED,
> > 	PLATFORM_PROFILE_PERFORMANCE
> > };
> >=20
> > static int current_profile_index =3D 0;
> >=20
> > static void dytc_profile_cycle(struct ideapad_private *priv)
> > {
> > 	current_profile_index++
> >=20
> > 	current_profile_index =3D
> > 		current_profile_index % ARRAY_SIZE(profiles);
> >=20
> > 	dytc_profile_set(&priv->dytc->pprof,
> > 			profiles[current_profile_index]);
> >=20
> > 	platform_profile_notify();
> > }
> >=20

Thanks for your suggestions. I thought about it.
It would make this module complicated, but something like this fits
well in the platform_profile module.
I will implement the cycle there in v4.

Best regards,
Gergo


