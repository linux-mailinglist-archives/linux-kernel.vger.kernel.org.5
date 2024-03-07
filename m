Return-Path: <linux-kernel+bounces-95132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A04874997
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EEBB213E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68D6340C;
	Thu,  7 Mar 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBd2WnFW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E16306D;
	Thu,  7 Mar 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800060; cv=none; b=dgQzx9eFh0eFPc0jTEZM/F6b/R7xwEWu/js03s+jt/h7+8VNOyom+X+tznJ84LjFdNRlnDdNANZIkTU9H/yUz8+dt8lRxVEPv1oYn9uJEqX8D/7btMNIGv0+7nX2P53HmGyzlTiW0IM/QpSQnqYu3j/0Ua2J63ePz4dc7scJCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800060; c=relaxed/simple;
	bh=ulYlFZq32K9jOmqyoqOs/Z5jeTVGLC6Oth42YMlqJT4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:To:Subject:From:
	 Cc:Message-ID:Date; b=IWNRs241cLjG2U9ruDj06vqBLquC5PTbDnRdkBakqBaP7+loThRdCd2mlNlZfD1BMLYrascePq2cjwEjSJqzGZnDUE/cSPShQrb0dbYA3Ih7xDeC1Kosrrm8hyEluY92h0jXjKJ+f26P8IHADS0CbVNHCbdXwmgV5pXSwo8+ydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBd2WnFW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709800059; x=1741336059;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:to:subject:from:cc:message-id:date;
  bh=ulYlFZq32K9jOmqyoqOs/Z5jeTVGLC6Oth42YMlqJT4=;
  b=YBd2WnFWfeeQuqyAPBMXSXaeUksN3MCptiYQ4Lml9rVzBd1VO/nlFnUa
   krRtBkAQ85UPZeF7AZrVAnU01qgbzBELgIiSSupJIwYhhM2ogcaLE4s4D
   ox12NgrQCCcSHaGUia1FFLRQwQW9WNY5LGeWOLDeqCD0WP7NS5zsdvTx5
   YC264dE0McEvnCMop0NFke0Pe8yFwGq67IAFGGxAhK/yt4yxsCdI+3wFx
   KK9pW7RBp3aLjA+D86/UCMvEa2JwLHi9kFKLTRnefAqweELT6Orzq2JUH
   14RfVA5rWp6ac2JSjMXPi2hYWQuB4OA6h3kG2O1/+BuI+NPcq/ka55Wel
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="26930911"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="26930911"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="33192969"
Received: from unknown (HELO localhost) ([10.245.244.162])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 00:27:35 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240307131027.66be2266@canb.auug.org.au>
References: <20240307131027.66be2266@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the drm tree with the drm-intel-fixes tree
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>, Animesh Manna <animesh.manna@intel.com>, Imre Deak <imre.deak@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <170980005216.6042.11359885960417882116@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date: Thu, 07 Mar 2024 10:27:32 +0200

Quoting Stephen Rothwell (2024-03-07 04:10:27)
> Hi all,
>=20
> Today's linux-next merge of the drm tree got a conflict in:
>=20
>   drivers/gpu/drm/i915/display/intel_dp.c
>=20
> between commit:
>=20
>   984318aaf7b6 ("drm/i915/panelreplay: Move out psr_init_dpcd() from init=
_connector()")
>=20
> from the drm-intel-fixes tree and commit:
>=20
>   e60cff453b82 ("drm/i915/dp: Enable DP tunnel BW allocation mode")
>=20
> from the drm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/gpu/drm/i915/display/intel_dp.c
> index 94d2a15d8444,6ece2c563c7a..000000000000
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@@ -5699,9 -5702,13 +5702,16 @@@ intel_dp_detect(struct drm_connector *c
>                 goto out;
>         }
>  =20
> +       ret =3D intel_dp_tunnel_detect(intel_dp, ctx);
> +       if (ret =3D=3D -EDEADLK)
> +               return ret;
> +=20
> +       if (ret =3D=3D 1)
> +               intel_connector->base.epoch_counter++;
> +=20
>  +      if (!intel_dp_is_edp(intel_dp))
>  +              intel_psr_init_dpcd(intel_dp);
>  +

Hi,

This is the right resolution, should be cleared up shortly once the
drm-intel-fixes PR is pulled.

Regards, Joonas

>         intel_dp_detect_dsc_caps(intel_dp, intel_connector);
>  =20
>         intel_dp_configure_mst(intel_dp);

