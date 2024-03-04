Return-Path: <linux-kernel+bounces-90642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBD8702A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F300B23985
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05643D982;
	Mon,  4 Mar 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFDvsmgs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACBD3E483;
	Mon,  4 Mar 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558782; cv=none; b=MifjlY2MxH4rtzeUPclDDlPnKnx5XJeaUkjiMtO1CIsEZtmE+HiVSYAi5xS6clKy+0APakWrUoZcNuNo0lOg216U08t0fGGb7ktWcsVZC0djV5zsVR2Vwwg5TjwsTeRm/n71srs9KNFHtHBysp0MUQtQlCDdiQx7kaKNmZ4qyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558782; c=relaxed/simple;
	bh=qe2k0nYrlf1Lva6jJWOnpQ9vdVzVZst19ij+LTDda0A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WOZajhItdJOajp4kzAbHPao6KFChnl4pjJAIXX0AZj3dcIgI3vodQVmi05y1TO5IkwmDAa3tX5h+F0XZ5edwOPk6gStTDhCD93MmjAaxXd1P8hNVd26SZivhl4JP9uXbCijZ9r9fWRzTo/r/7O/ULsNqosOFTYmsR5AiCKOI7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFDvsmgs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558780; x=1741094780;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qe2k0nYrlf1Lva6jJWOnpQ9vdVzVZst19ij+LTDda0A=;
  b=fFDvsmgs/krvJukX9jJlUKaUxBqMvIhTobSxzmfsaU49vE2aN+J6qAwK
   z4KhFbBavar2j/fJVUW9YIZr9rk/PAjS1FLZb/q0lu+lOhbxg1cjbvEaH
   JFqSxHT0ck7OSuxMoq0IlSH7ZzKgeQ7l18fTSTcSUJ3hsrYrIWih3tRFc
   8CnsETKPiekKoLJajWgLaHc0rpWgn8OQlhW4GnO66Axnkhj4tDxGiKs8A
   hLN1bQ7C6k2HNBoSe+G17q33ljT680Q6VEOg2Zv5isOIWq0tMnFsppjdp
   yITP0dpHkNYTYicRk9u2jHetHJygWf7prkOIAo+ukVX7cbbjjyQ+4tH45
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3912332"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3912332"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:26:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9065025"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:26:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Mar 2024 15:26:12 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    linux-kernel@vger.kernel.org, hdegoede@redhat.com, 
    ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V2 3/9] platform/x86/intel/sdsi: Add in-band BIOS lock
 support
In-Reply-To: <20240228000016.1685518-4-david.e.box@linux.intel.com>
Message-ID: <4502a46c-cd1f-f030-f0e0-5ed717a38a02@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com> <20240228000016.1685518-4-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-531824783-1709558772=:986"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-531824783-1709558772=:986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Feb 2024, David E. Box wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.=
com>
>=20
> As per SDSi in-band interface specification, sec titled "BIOS lock for
> in-band provisioning", when IB_LOCK bit is set in control qword, the
> SDSI agent is only allowed to perform the read flow, but not allowed to
> provision license blob or license key. So add check for it in
> sdsi_provision().
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>=20
> V2 - Move sdsi_ib_locked() check after overflow check
>=20
>  drivers/platform/x86/intel/sdsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/int=
el/sdsi.c
> index d80c2dc0ce71..bb3eaf5eb382 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -67,6 +67,7 @@
>  #define CTRL_OWNER=09=09=09GENMASK(5, 4)
>  #define CTRL_COMPLETE=09=09=09BIT(6)
>  #define CTRL_READY=09=09=09BIT(7)
> +#define CTRL_INBAND_LOCK=09=09BIT(32)
>  #define CTRL_STATUS=09=09=09GENMASK(15, 8)
>  #define CTRL_PACKET_SIZE=09=09GENMASK(31, 16)
>  #define CTRL_MSG_SIZE=09=09=09GENMASK(63, 48)
> @@ -346,6 +347,11 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, st=
ruct sdsi_mbox_info *info, s
>  =09return sdsi_mbox_cmd_read(priv, info, data_size);
>  }
> =20
> +static bool sdsi_ib_locked(struct sdsi_priv *priv)
> +{
> +=09return !!FIELD_GET(CTRL_INBAND_LOCK, readq(priv->control_addr));
> +}
> +
>  static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t =
count,
>  =09=09=09      enum sdsi_command command)
>  {
> @@ -355,6 +361,10 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv=
, char *buf, size_t count,
>  =09if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
>  =09=09return -EOVERFLOW;
> =20
> +=09/* Make sure In-band lock is not set */
> +=09if (sdsi_ib_locked(priv))
> +=09=09return -EPERM;
> +

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-531824783-1709558772=:986--

