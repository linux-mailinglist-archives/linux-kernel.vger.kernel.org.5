Return-Path: <linux-kernel+bounces-107515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A6A87FD87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022CF1C21C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3357F7D4;
	Tue, 19 Mar 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maRJuovT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257D7F7C0;
	Tue, 19 Mar 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851197; cv=none; b=si9x6AeR+1lCYmGYmhbEfPv+5M546iHxrS1Wz8qNloybqfNZduJnZwjUtgQuip4LHTemuy27zK2ep72Km5mjIeWtK3GJCjXm1ElolVt13+SJPzHaLsi8Xkg18vkXftY14yDKzP5Zxy10inigeEepofOZrgU4fIx4T60R10LxgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851197; c=relaxed/simple;
	bh=eKpFl+Eoy4rSTLvE9ONY158gAn1erPt7rr5667NWb+c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e59QyiM9Q4bCclAzxkF4s4TG9YWAfwdRlmKTsHbnl2+P/fX54mqhEBvZ1WDap+1Bp4mubFkJoSLffNVzqPl0PSE7Zw4jThRTSMACYNOgD/GnhAJwdZnFAMlS/iOT/cMPJ5ktLCvUl5v3vHBvFOapYDwc1kAVSeosve/hVXsCbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maRJuovT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710851195; x=1742387195;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eKpFl+Eoy4rSTLvE9ONY158gAn1erPt7rr5667NWb+c=;
  b=maRJuovT1Vy0ZeDJDTa245MEb8uc1jzthiuUpsKyFPxv1Avqu7LUEng+
   cZkqFuS9/wU9bY6A3vaoVseTKv3VbFdJnIm540Pw+GD47vg27rEXTaZ32
   AX+N/dyCLpw6vsCNQTSCVS1ZmDvU1YseS+nmcB3XCuvU1fOb4sbT/00aA
   VF6UX2R+pLy5PIqxrx1dwfMjNUbhedeL0S0cOYbe10pAixi+4ord6GA1B
   GGiiKtq1Ww/+VQ/HrMbRqVXjMPKt1F+1U2P/QArZOlvpCketDN1mD7dcl
   ZQm+BWWXr96IAlaiWooTCEaodOn0zqsxH0VG5Qk8jxPuFPbaldoiPVwoU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5649010"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5649010"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="13790973"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.12])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:26:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Mar 2024 14:26:26 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for Vivobook
 GPU MUX
In-Reply-To: <20240310055312.11293-2-luke@ljones.dev>
Message-ID: <0f35beb8-5453-63cb-0570-752b2693f6ec@linux.intel.com>
References: <20240310055312.11293-1-luke@ljones.dev> <20240310055312.11293-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1561235282-1710851186=:1267"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1561235282-1710851186=:1267
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 10 Mar 2024, Luke D. Jones wrote:

> Adjust existing MUX support to select whichever MUX support is available
> so that ASUS Vivobook MUX can also be used if detected.

This description is a bit on the short side. It wouldn't have hurt to=20
first state that Vivobooks come with a GPU MUX WMI that has a different=20
WMI device ID. I can infer that after reading the diff but the description=
=20
should not require reading the patch.

The code change itself looks fine,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 18 +++++++++++++-----
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 94cc589607b3..2cf695289655 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -268,6 +268,7 @@ struct asus_wmi {
>  =09bool egpu_connect_available;
>  =09bool dgpu_disable_available;
>  =09bool gpu_mux_mode_available;
> +=09u32 gpu_mux_dev;
> =20
>  =09/* Tunables provided by ASUS for gaming laptops */
>  =09bool ppt_pl2_sppt_available;
> @@ -682,7 +683,7 @@ static ssize_t dgpu_disable_store(struct device *dev,
>  =09=09return -EINVAL;
> =20
>  =09if (asus->gpu_mux_mode_available) {
> -=09=09result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_M=
UX);
> +=09=09result =3D asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
>  =09=09if (result < 0)
>  =09=09=09/* An error here may signal greater failure of GPU handling */
>  =09=09=09return result;
> @@ -748,7 +749,7 @@ static ssize_t egpu_enable_store(struct device *dev,
>  =09}
> =20
>  =09if (asus->gpu_mux_mode_available) {
> -=09=09result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_M=
UX);
> +=09=09result =3D asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
>  =09=09if (result < 0) {
>  =09=09=09/* An error here may signal greater failure of GPU handling */
>  =09=09=09pr_warn("Failed to get gpu mux status: %d\n", result);
> @@ -801,7 +802,7 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
>  =09struct asus_wmi *asus =3D dev_get_drvdata(dev);
>  =09int result;
> =20
> -=09result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX)=
;
> +=09result =3D asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
>  =09if (result < 0)
>  =09=09return result;
> =20
> @@ -847,7 +848,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
>  =09=09}
>  =09}
> =20
> -=09err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &resul=
t);
> +=09err =3D asus_wmi_set_devstate(asus->gpu_mux_dev, optimus, &result);
>  =09if (err) {
>  =09=09dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
>  =09=09return err;
> @@ -4507,7 +4508,6 @@ static int asus_wmi_add(struct platform_device *pde=
v)
>  =09asus->egpu_enable_available =3D asus_wmi_dev_is_present(asus, ASUS_WM=
I_DEVID_EGPU);
>  =09asus->egpu_connect_available =3D asus_wmi_dev_is_present(asus, ASUS_W=
MI_DEVID_EGPU_CONNECTED);
>  =09asus->dgpu_disable_available =3D asus_wmi_dev_is_present(asus, ASUS_W=
MI_DEVID_DGPU);
> -=09asus->gpu_mux_mode_available =3D asus_wmi_dev_is_present(asus, ASUS_W=
MI_DEVID_GPU_MUX);
>  =09asus->kbd_rgb_mode_available =3D asus_wmi_dev_is_present(asus, ASUS_W=
MI_DEVID_TUF_RGB_MODE);
>  =09asus->kbd_rgb_state_available =3D asus_wmi_dev_is_present(asus, ASUS_=
WMI_DEVID_TUF_RGB_STATE);
>  =09asus->ppt_pl2_sppt_available =3D asus_wmi_dev_is_present(asus, ASUS_W=
MI_DEVID_PPT_PL2_SPPT);
> @@ -4529,6 +4529,14 @@ static int asus_wmi_add(struct platform_device *pd=
ev)
>  =09=09asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
>  =09}
> =20
> +=09if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX)) {
> +=09=09asus->gpu_mux_mode_available =3D true;
> +=09=09asus->gpu_mux_dev =3D ASUS_WMI_DEVID_GPU_MUX;
> +=09} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO)=
) {
> +=09=09asus->gpu_mux_mode_available =3D true;
> +=09=09asus->gpu_mux_dev =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> +=09}
> +
>  =09err =3D fan_boost_mode_check_present(asus);
>  =09if (err)
>  =09=09goto fail_fan_boost_mode;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index 9cadce10ad9a..b48b024dd844 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -128,6 +128,7 @@
> =20
>  /* gpu mux switch, 0 =3D dGPU, 1 =3D Optimus */
>  #define ASUS_WMI_DEVID_GPU_MUX=09=090x00090016
> +#define ASUS_WMI_DEVID_GPU_MUX_VIVO=090x00090026
> =20
>  /* TUF laptop RGB modes/colours */
>  #define ASUS_WMI_DEVID_TUF_RGB_MODE=090x00100056
>=20
--8323328-1561235282-1710851186=:1267--

