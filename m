Return-Path: <linux-kernel+bounces-128849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281D896083
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63218287D36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5562B1109;
	Wed,  3 Apr 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="lRVZqSD+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="clzF2kFJ"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D653635;
	Wed,  3 Apr 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103007; cv=none; b=hfC6oDGUU9t+VKSNHiuqxws4KnfdJwFp0gZh3kHOnM/7/wId0lvQImcEYyw5tnm3V2+VWzxShu827BgsoRoo65RUmDHjA8eM4pJy2o+M9gC/09uNVLlk8Yc6/Bo3jYztrQjpy6iQKLu6JxOIAmY6AbaVY3ccJsVkDEntB76NkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103007; c=relaxed/simple;
	bh=NWTYbgj84aSXH8c2vB0NZyKdb9P/11YTqUctL5sXQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMg8/pBO6Qo1gGmZMu7VT6/WaErUHu8qcA9E1V+2Gg81vH5iR/Scx7zDooi8ycnVYICOQs8i/mJGgL5bG93t+oA7ZMUMBKPYsQTxJTIWmBQiSChnExlwuOmmWfUmJqjz5ZR3i3rXyeaKvLr4It2wQgV9IZu8glFlIk3Xg3b4KOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=lRVZqSD+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=clzF2kFJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 977EF11400EF;
	Tue,  2 Apr 2024 20:10:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 20:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712103004;
	 x=1712189404; bh=XfyaUGyBhBfXhWq9WDJJ4hLODydb5vyZB4n7KWoqrDM=; b=
	lRVZqSD+f8li0k2KUaMMh6pk1gmn7OG7Bxs2VkJSmdRbkmecGiDMvrj9Q9c1fbQ+
	sjmnx3e0bScpzN3Rllv7FfhXBd+tHjxKvCI6Gnv8TlCiIMCnrKy7Pj9TLdMsbF3Z
	AgpGj5DkmkFaXRwlqTflCvL9lxa9LLXAGeq5o4UuXP3/i7zeXgYm8H7kYoTSqaiL
	YQmBw7OsYlJYm7MzfE7BNq9gDYUZMZ4aaMdm8brds1naTKLnH7oGdwdpPkbpnxxT
	PAH3q0+pA5pqXb2Pqd+TduzF+dvnb/HNOtRymp6YKZW6CtigDXa2LQ9vulTKKCy/
	ToBisyldul2xuEsDtnb39w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712103004; x=
	1712189404; bh=XfyaUGyBhBfXhWq9WDJJ4hLODydb5vyZB4n7KWoqrDM=; b=c
	lzF2kFJOG/s8Z+GBfpJ5uMndgW3kXcXQSePHexZJEjkm/Nuk3rW3JIYNprkBKLDD
	s+kaDpMCYvCs16dP5vSN9qNOl+dkuaUWCcbTOTCkM7rDq0OmPSNSbL8UrF2AOLmR
	QQmaO0+DHRq1nAKA6YbHih4Zjo8nZQp6ohGknCzHjdEz1EZGGPgUi/BeKioRWhaS
	k7SnOlaiv75I4GK7EdBiL7N+uYmSdnyRSrPOM2ZfMsrLIiej/Bl8OCOdzzjwY7Ln
	9w4S7SL6z9eW/tc0g1YRlVylYPyA49nVeRyaGI6RS+MU5cmSY+htIE6tHnGoJtO6
	UoT5J0bWSbRlNF0anJfIg==
X-ME-Sender: <xms:XJ4MZnD1UcU3n4po3hFfCnmafCE50JQBLXZbtknyNAoVt2XjseUh6Q>
    <xme:XJ4MZtg8nlH4Rdwf5HuSn5uI7L_zzXxzyllimYxyFaG4gHgssGbs4bYqv8ROKZDex
    BwPldfHqyhqx-KbZsA>
X-ME-Received: <xmr:XJ4MZilQikmEJvLHBhz-95Lj3zTD9JFZjf_r78DOJXnmpsWOqPKnbQ-ns1IBuKo8Hz9OOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    ephfeugfegvdeitdefgeevvdelgedutdejueefkeffieevueduhedtueektdffjeeunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:XJ4MZpxjmEyTaKUqwJY9F9-eSXKKtPvaiB4WQTYgOVVEnE79i2O13w>
    <xmx:XJ4MZsRVdN4Dlqo0B292kj9WiYVz3k85q2cx88y2ImL-NB4fBQ5FDA>
    <xmx:XJ4MZsY4Lca4zxbjoMIhfqQt8UDkBtzT_CMurHdjgHE9s4BjzEYHkg>
    <xmx:XJ4MZtShaH-JuFj9AtD9t6aQ7gUJMD1rpfi-yCSCvBzR5JeLnKaDKQ>
    <xmx:XJ4MZhJC0V2SUijlcDcN35pvqqeH911XF5H3gWraYXjv6wySsOtHK1tq>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 20:10:02 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v2 5/9] platform/x86: asus-wmi: store a min default for ppt
 options
Date: Wed, 03 Apr 2024 13:09:59 +1300
Message-ID: <4555327.yiUUSuA9gR@fedora>
In-Reply-To: <89b0c0ea-30ce-28c6-19d2-ebd113b17935@linux.intel.com>
References:
 <20240402022607.34625-1-luke@ljones.dev>
 <20240402022607.34625-6-luke@ljones.dev>
 <89b0c0ea-30ce-28c6-19d2-ebd113b17935@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 2 April 2024 11:49:50=E2=80=AFPM NZDT Ilpo J=C3=A4rvinen wrote:
> On Tue, 2 Apr 2024, Luke D. Jones wrote:
> > Laptops with any of the ppt or nv tunables default to the minimum setti=
ng
> > on boot so we can safely assume a stored value is correct.
> >=20
> > This patch adds storing of those values in the local struct, and enables
> > reading of those values back. To prevent creating a series of byte holes
> > in the struct the "<name>_available" bool is removed and
> > `asus_sysfs_is_visible()` uses the `ASUS_WMI_DEVID_<name>` directly.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >=20
> >  drivers/platform/x86/asus-wmi.c | 127 +++++++++++++++++++++++++-------
> >  1 file changed, 99 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c
> > b/drivers/platform/x86/asus-wmi.c index b795f9c1941f..c80afa385532 1006=
44
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -262,13 +262,13 @@ struct asus_wmi {
> >=20
> >  	u32 gpu_mux_dev;
> >  =09
> >  	/* Tunables provided by ASUS for gaming laptops */
> >=20
> > -	bool ppt_pl2_sppt_available;
> > -	bool ppt_pl1_spl_available;
> > -	bool ppt_apu_sppt_available;
> > -	bool ppt_plat_sppt_available;
> > -	bool ppt_fppt_available;
> > -	bool nv_dyn_boost_available;
> > -	bool nv_temp_tgt_available;
> > +	u32 ppt_pl2_sppt;
> > +	u32 ppt_pl1_spl;
> > +	u32 ppt_apu_sppt;
> > +	u32 ppt_platform_sppt;
> > +	u32 ppt_fppt;
> > +	u32 nv_dynamic_boost;
> > +	u32 nv_temp_target;
> >=20
> >  	u32 kbd_rgb_dev;
> >  	bool kbd_rgb_state_available;
> >=20
> > @@ -1020,11 +1020,21 @@ static ssize_t ppt_pl2_sppt_store(struct device
> > *dev,>=20
> >  		return -EIO;
> >  =09
> >  	}
> >=20
> > +	asus->ppt_pl2_sppt =3D value;
> >=20
> >  	sysfs_notify(&asus->platform_device->dev.kobj, NULL,=20
"ppt_pl2_sppt");
> >  =09
> >  	return count;
> > =20
> >  }
> >=20
> > -static DEVICE_ATTR_WO(ppt_pl2_sppt);
> > +
> > +static ssize_t ppt_pl2_sppt_show(struct device *dev,
> > +				       struct device_attribute=20
*attr,
> > +				       char *buf)
> > +{
> > +	struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > +
> > +	return sysfs_emit(buf, "%d\n", asus->ppt_pl2_sppt);
>=20
> Use %u for u32 values. This applies to all sysfs_emits in this patch.

Thought checkpatch or the compiler would catch that. Done.

I've added your reviewed tag due to the simplicity of the change requested.=
 I=20
hope this was okay.





