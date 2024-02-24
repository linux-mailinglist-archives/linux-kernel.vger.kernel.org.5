Return-Path: <linux-kernel+bounces-79755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F25B862643
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E312DB21A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4141238;
	Sat, 24 Feb 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sysophe.eu header.i=@sysophe.eu header.b="mRH73Vp8"
Received: from hygieia.sysophe.eu (hygieia.sysophe.eu [138.201.91.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0D4879B;
	Sat, 24 Feb 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.91.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794501; cv=none; b=piXFt5K4hnFh/bhOjjrp2Q6bruoprkUmZ6hWfuSXlKWBwnrsWx0fdXfUj7zKGEIVfvfG0/UnulkBLWCOIn3sxykBuEC3wzLEU0dnZyGYs346KRZX3nste6sSPXuGrFB2OfqLMAir6TB1xJL6Fe/tuIsbWJeCDFrWjJ2e+DVAYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794501; c=relaxed/simple;
	bh=UmoOY0WXEH/Ir+XdmtPrWmUTuq7p3/sTYgdrJ9Ydluk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GztsuAeadX+LPWsz271N7hNQnxtln3KeFrWx0KS7ZN5snulBeiCMUWqE5CMichAgU/wfhljSjqZaPu2wg2C7dHGZzbFsVV4zC+iuTr/toOoF4fnBznnstwTlGaoBoE+QxuPm/YYnoUvJuVdEa3l0olF+p+CF12QW1WMGbx8rRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysophe.eu; spf=pass smtp.mailfrom=sysophe.eu; dkim=pass (1024-bit key) header.d=sysophe.eu header.i=@sysophe.eu header.b=mRH73Vp8; arc=none smtp.client-ip=138.201.91.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysophe.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysophe.eu
Received: from hemera.lan.sysophe.eu (unknown [IPv6:2001:a18:2cf:c101:a2ce:c8ff:fe62:fc79])
	by smtp.sysophe.eu (Postfix) with ESMTPSA id F0C9C2281C0;
	Sat, 24 Feb 2024 17:59:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sysophe.eu; s=201205;
	t=1708793980; x=1708880380;
	bh=UmoOY0WXEH/Ir+XdmtPrWmUTuq7p3/sTYgdrJ9Ydluk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mRH73Vp8rv5+Cu3wIVme/OOAZW+igNMOmvlrg5R6m5rjG1N1z3Til1PpcnGiTVDY6
	 IXsQM/eMKgiNlMLO9dxnG9k7qqUa9NL/orV7S8/IqaSozX8XjGb6t5IRbMdWcmUb00
	 TDCbzOMZcPRwSZlS8ZWxhKzUfQGax/5Es5M2kwUA=
Date: Sat, 24 Feb 2024 17:59:29 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@sysophe.eu>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron
 <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org
Subject: Re: [PATCH 11/42] drivers/hid: Convert snprintf to sysfs_emit
Message-ID: <20240224175929.6ea8d4f9@hemera.lan.sysophe.eu>
In-Reply-To: <20240116045151.3940401-9-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
	<20240116045151.3940401-1-lizhijian@fujitsu.com>
	<20240116045151.3940401-9-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Li,

While only looking for the snprintf() in your coccinelle analysis you
probably also want to look for sprintf() (see e.g. else clause in
hid-sensor-custom.c and scnprintf() (see picolcd_fb_update_rate_show
in hid-picolcd_fb.c) to replace more s*printf() calls with sysfs_emit*
variants.



diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index d726aaafb146..03074d25d662 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -459,9 +459,9 @@ static ssize_t picolcd_fb_update_rate_show(struct devic=
e *dev,
 		if (ret >=3D PAGE_SIZE)
 			break;
 		else if (i =3D=3D fb_update_rate)
-			ret +=3D scnprintf(buf+ret, PAGE_SIZE-ret, "[%u] ", i);
+			ret +=3D sysfs_emit_at(buf, ret, "[%u] ", i);
 		else
-			ret +=3D scnprintf(buf+ret, PAGE_SIZE-ret, "%u ", i);
+			ret +=3D sysfs_emit_at(buf, ret, "%u ", i);
 	if (ret > 0)
 		buf[min(ret, (size_t)PAGE_SIZE)-1] =3D '\n';
 	return ret;


For hid-picolcd-*.c,
  Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
but preferably with the scnprintf() case is covered too.


Cheers,
Bruno

On Tue, 16 Jan 2024 12:51:20 +0800 Li Zhijian wrote:
> Per Documentation/filesystems/sysfs.rst, show() should only use sysfs_emi=
t()
> or sysfs_emit_at() when formatting the value to be returned to user space.
>=20
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
>=20
> > ./drivers/hid/hid-picolcd_core.c:259:9-17: WARNING: please use sysfs_em=
it
> > ./drivers/hid/hid-picolcd_core.c:304:8-16: WARNING: please use sysfs_em=
it
> > ./drivers/hid/hid-sensor-custom.c:375:10-18: WARNING: please use sysfs_=
emi =20
>=20
> No functional change intended
>=20
> CC: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> CC: Jiri Kosina <jikos@kernel.org>
> CC: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> CC: Jonathan Cameron <jic23@kernel.org>
> CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> CC: linux-input@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/hid/hid-picolcd_core.c  | 6 +++---
>  drivers/hid/hid-sensor-custom.c | 3 +--
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_cor=
e.c
> index bbda231a7ce3..fa46fb6eab3f 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -256,9 +256,9 @@ static ssize_t picolcd_operation_mode_show(struct dev=
ice *dev,
>  	struct picolcd_data *data =3D dev_get_drvdata(dev);
> =20
>  	if (data->status & PICOLCD_BOOTLOADER)
> -		return snprintf(buf, PAGE_SIZE, "[bootloader] lcd\n");
> +		return sysfs_emit(buf, "[bootloader] lcd\n");
>  	else
> -		return snprintf(buf, PAGE_SIZE, "bootloader [lcd]\n");
> +		return sysfs_emit(buf, "bootloader [lcd]\n");
>  }
> =20
>  static ssize_t picolcd_operation_mode_store(struct device *dev,
> @@ -301,7 +301,7 @@ static ssize_t picolcd_operation_mode_delay_show(stru=
ct device *dev,
>  {
>  	struct picolcd_data *data =3D dev_get_drvdata(dev);
> =20
> -	return snprintf(buf, PAGE_SIZE, "%hu\n", data->opmode_delay);
> +	return sysfs_emit(buf, "%hu\n", data->opmode_delay);
>  }
> =20
>  static ssize_t picolcd_operation_mode_delay_store(struct device *dev,
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index d85398721659..4fe8dccf671d 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -372,8 +372,7 @@ static ssize_t show_value(struct device *dev, struct =
device_attribute *attr,
>  				     sizeof(struct hid_custom_usage_desc),
>  				     usage_id_cmp);
>  		if (usage_desc)
> -			return snprintf(buf, PAGE_SIZE, "%s\n",
> -					usage_desc->desc);
> +			return sysfs_emit(buf, "%s\n", usage_desc->desc);
>  		else
>  			return sprintf(buf, "not-specified\n");

Shouldn't the sprintf() in the else clause be replaced as well?

>  	 } else


