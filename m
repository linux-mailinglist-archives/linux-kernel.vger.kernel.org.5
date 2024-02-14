Return-Path: <linux-kernel+bounces-65038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0F854707
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E8B1F245E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533117565;
	Wed, 14 Feb 2024 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7Jd4Qxk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB428171C1;
	Wed, 14 Feb 2024 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906115; cv=none; b=XPgacamYKolUR5CtA0brTeE+WJWrvhALBYxFWPlWb0LgmEWUvspYFLGMHJxbZlfOND8fIjrBo5jTF3See1Ky0XVxMYIETiuzxyGHxJha3SmoJ0kcAFDmA0lrG4U9ebC9KRr9XGtm4KilTev2KmUxSTGWjFYeAULM8j8DL4bon18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906115; c=relaxed/simple;
	bh=U0LCMLBdsb/HGPUgFB6ys8ddfeTbC73CP7gQKzf0Y3w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PJHpyyz8TnNIjN696vrNZG3Jng2bMDqDVUhQc4lKAZ9AKWyAreGceDzhVcxGx+bb0q+s5LvJEIushYggK/941DPBKFJnoYt3DDTt1/b5XBjeOLelnrdlHIJTKLRquaGF8oDY+kPuknycRTvTZP5Kh7GET4ZH2iJKCbrwcKlid80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7Jd4Qxk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707906113; x=1739442113;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=U0LCMLBdsb/HGPUgFB6ys8ddfeTbC73CP7gQKzf0Y3w=;
  b=U7Jd4QxkD2O5NGYvMZpYbPO6n+EW8xn8/XLX0fJSbPS1NBa/CXgXd6uo
   wFjNpVPyOunuKlHF9sdzLpsXWAlrvoF8kV0BJcy0wtVOk2Tp7V5BcywxJ
   27FPHGq/sEYZCl2BAtFOXZfH6UcV2qxvqkXT30LEbxnmYMvGJwF0h2tlB
   vOQrf+Hsc2VH9DEinp7zQaZtQsF8BfMJeSI7YmAakVRi3l/F8PfWV9Jf/
   ug+qb+/ZqZ1FwmiKNNp/b6EaK79cYdsQnJ6eibzJ3rJhish/1IufyVHr/
   xNJDlEoCjGMH+p/mbNVDG+zwdN+g9WIg/OiruuweBogxs6DW+LCHvi4tc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5719373"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5719373"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7808923"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.229])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:21:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Feb 2024 12:16:02 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, vsankar@lenovo.com
Subject: Re: [PATCH 1/2] platform/x86: thinkpad_acpi: Simplify thermal mode
 checking
In-Reply-To: <20240214052959.8550-1-vishnuocv@gmail.com>
Message-ID: <05276532-52eb-3b7d-4578-c596bc1d79c4@linux.intel.com>
References: <20240214052959.8550-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1973336468-1707905081=:7959"
Content-ID: <6fa90c8f-3c00-25e4-8f33-2768e20495e7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1973336468-1707905081=:7959
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <802be201-439b-532b-2b2b-6a298600f2f6@linux.intel.com>

On Wed, 14 Feb 2024, Vishnu Sankar wrote:

Thanks for doing this, it's major improvement to readability already as
is, and even more of after the second patch!!

> Add a thermal_read_mode_check helper function to make the code

thermal_read_mode_check()

remove "function" as it's obvious.

> simpler during init.
> This helps particularly when the new TPEC_12 mode is added in
> the next patch.

Flow the paragraph normally without the premature line break.

> Suggested-by: Ilpo Jarvinen <ilpo.jarvinen@intel.com>

This is not my email address, please use

Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 136 +++++++++++++--------------
>  1 file changed, 66 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index c4895e9bc714..2428c8bd0fa2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -6147,6 +6147,71 @@ struct ibm_thermal_sensors_struct {
>  static enum thermal_access_mode thermal_read_mode;
>  static bool thermal_use_labels;
> =20
> +/* Function to check thermal read mode */
> +static enum thermal_access_mode thermal_read_mode_check(void)
> +{
> +=09u8 t, ta1, ta2, ver =3D 0;
> +=09int i;
> +
> +=09if (thinkpad_id.ec_model) {
> +=09=09/*
> +=09=09 * Direct EC access mode: sensors at registers
> +=09=09 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for

While this comment is touches, lets make minor improvements to it.

Remove the double space, they are not needed in kernel comments.

> +=09=09 * non-implemented, thermal sensors return 0x80 when
> +=09=09 * not available

Please add the missing .

Perhaps add an empty line here to break the comment into two paragraphs?

> +=09=09 * The above rule is unfortunately flawed. This has been seen with
> +=09=09 * 0xC2 (power supply ID) causing thermal control problems.
> +=09=09 * The EC version can be determined by offset 0xEF and at least fo=
r
> +=09=09 * version 3 the Lenovo firmware team confirmed that registers 0xC=
0-0xC7
> +=09=09 * are not thermal registers.

Please reflow the entire comment to 80 chars.

> +=09=09 */
> +=09=09if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
> +=09=09=09pr_warn("Thinkpad ACPI EC unable to access EC version\n");
> +
> +=09=09ta1 =3D ta2 =3D 0;
> +=09=09for (i =3D 0; i < 8; i++) {
> +=09=09=09if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
> +=09=09=09=09ta1 |=3D t;
> +=09=09=09} else {
> +=09=09=09=09ta1 =3D 0;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09=09if (ver < 3) {
> +=09=09=09=09if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
> +=09=09=09=09=09ta2 |=3D t;
> +=09=09=09=09} else {
> +=09=09=09=09=09ta1 =3D 0;
> +=09=09=09=09=09break;
> +=09=09=09=09}
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (ta1 =3D=3D 0) {
> +=09=09=09pr_err("ThinkPad ACPI EC access misbehaving, disabling thermal =
sensors access\n");
> +=09=09=09return TPACPI_THERMAL_NONE;
> +=09=09}
> +
> +=09=09if (ver >=3D 3) {
> +=09=09=09thermal_use_labels =3D true;
> +=09=09=09return TPACPI_THERMAL_TPEC_8;
> +=09=09}
> +
> +=09=09return (ta2 !=3D 0) ? TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC=
_8;
> +=09}
> +
> +=09if (acpi_evalf(ec_handle, NULL, "TMP7", "qv")) {
> +=09=09if (tpacpi_is_ibm() &&
> +=09=09    acpi_evalf(ec_handle, NULL, "UPDT", "qv"))

Put this to single line and retain the braces please (I know it will be=20
>80 char but nothing important is lost).

> +=09=09=09/* 600e/x, 770e, 770x */
> +=09=09=09return TPACPI_THERMAL_ACPI_UPDT;
> +=09=09/* IBM/LENOVO DSDT EC.TMPx access, max 8 sensors */
> +=09=09return TPACPI_THERMAL_ACPI_TMP07;
> +=09}
> +
> +=09/* temperatures not supported on 570, G4x, R30, R31, R32 */
> +=09return TPACPI_THERMAL_NONE;
> +}
> +
>  /* idx is zero-based */
>  static int thermal_get_sensor(int idx, s32 *value)
>  {
> @@ -6375,78 +6440,9 @@ static const struct attribute_group temp_label_att=
r_group =3D {
> =20
>  static int __init thermal_init(struct ibm_init_struct *iibm)
>  {
> -=09u8 t, ta1, ta2, ver =3D 0;
> -=09int i;
> -=09int acpi_tmp7;
> -
>  =09vdbg_printk(TPACPI_DBG_INIT, "initializing thermal subdriver\n");
> =20
> -=09acpi_tmp7 =3D acpi_evalf(ec_handle, NULL, "TMP7", "qv");
> -
> -=09if (thinkpad_id.ec_model) {
> -=09=09/*
> -=09=09 * Direct EC access mode: sensors at registers
> -=09=09 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
> -=09=09 * non-implemented, thermal sensors return 0x80 when
> -=09=09 * not available
> -=09=09 * The above rule is unfortunately flawed. This has been seen with
> -=09=09 * 0xC2 (power supply ID) causing thermal control problems.
> -=09=09 * The EC version can be determined by offset 0xEF and at least fo=
r
> -=09=09 * version 3 the Lenovo firmware team confirmed that registers 0xC=
0-0xC7
> -=09=09 * are not thermal registers.
> -=09=09 */
> -=09=09if (!acpi_ec_read(TP_EC_FUNCREV, &ver))
> -=09=09=09pr_warn("Thinkpad ACPI EC unable to access EC version\n");
> -
> -=09=09ta1 =3D ta2 =3D 0;
> -=09=09for (i =3D 0; i < 8; i++) {
> -=09=09=09if (acpi_ec_read(TP_EC_THERMAL_TMP0 + i, &t)) {
> -=09=09=09=09ta1 |=3D t;
> -=09=09=09} else {
> -=09=09=09=09ta1 =3D 0;
> -=09=09=09=09break;
> -=09=09=09}
> -=09=09=09if (ver < 3) {
> -=09=09=09=09if (acpi_ec_read(TP_EC_THERMAL_TMP8 + i, &t)) {
> -=09=09=09=09=09ta2 |=3D t;
> -=09=09=09=09} else {
> -=09=09=09=09=09ta1 =3D 0;
> -=09=09=09=09=09break;
> -=09=09=09=09}
> -=09=09=09}
> -=09=09}
> -=09=09if (ta1 =3D=3D 0) {
> -=09=09=09/* This is sheer paranoia, but we handle it anyway */
> -=09=09=09if (acpi_tmp7) {
> -=09=09=09=09pr_err("ThinkPad ACPI EC access misbehaving, falling back to=
 ACPI TMPx access mode\n");
> -=09=09=09=09thermal_read_mode =3D TPACPI_THERMAL_ACPI_TMP07;

Eh, where did this go in the new helper?

--=20
 i.

> -=09=09=09} else {
> -=09=09=09=09pr_err("ThinkPad ACPI EC access misbehaving, disabling therm=
al sensors access\n");
> -=09=09=09=09thermal_read_mode =3D TPACPI_THERMAL_NONE;
> -=09=09=09}
> -=09=09} else {
> -=09=09=09if (ver >=3D 3) {
> -=09=09=09=09thermal_read_mode =3D TPACPI_THERMAL_TPEC_8;
> -=09=09=09=09thermal_use_labels =3D true;
> -=09=09=09} else {
> -=09=09=09=09thermal_read_mode =3D
> -=09=09=09=09=09(ta2 !=3D 0) ?
> -=09=09=09=09=09TPACPI_THERMAL_TPEC_16 : TPACPI_THERMAL_TPEC_8;
> -=09=09=09}
> -=09=09}
> -=09} else if (acpi_tmp7) {
> -=09=09if (tpacpi_is_ibm() &&
> -=09=09    acpi_evalf(ec_handle, NULL, "UPDT", "qv")) {
> -=09=09=09/* 600e/x, 770e, 770x */
> -=09=09=09thermal_read_mode =3D TPACPI_THERMAL_ACPI_UPDT;
> -=09=09} else {
> -=09=09=09/* IBM/LENOVO DSDT EC.TMPx access, max 8 sensors */
> -=09=09=09thermal_read_mode =3D TPACPI_THERMAL_ACPI_TMP07;
> -=09=09}
> -=09} else {
> -=09=09/* temperatures not supported on 570, G4x, R30, R31, R32 */
> -=09=09thermal_read_mode =3D TPACPI_THERMAL_NONE;
> -=09}
> +=09thermal_read_mode =3D thermal_read_mode_check();
> =20
>  =09vdbg_printk(TPACPI_DBG_INIT, "thermal is %s, mode %d\n",
>  =09=09str_supported(thermal_read_mode !=3D TPACPI_THERMAL_NONE),
>=20
--8323328-1973336468-1707905081=:7959--

