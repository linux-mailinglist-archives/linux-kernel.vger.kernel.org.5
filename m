Return-Path: <linux-kernel+bounces-39789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2897D83D61A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA904286016
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A1E12CDA4;
	Fri, 26 Jan 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvFncENm"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0B14271;
	Fri, 26 Jan 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258915; cv=none; b=tOvMYCD5aQNY8n+983xP6gKnojQqJotYPHChPM9hS75Zt4au44mwqWttmYYAa90am9n8iDTeCC7KEpLGt3nAVR19enc4UhPnGE0E310dqyvoYAtod743s5XnAIkbGMwTwPD27XpHcC3nAW97Q3Nv395sMcvZ1YHK810ZeYfO3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258915; c=relaxed/simple;
	bh=A7lMnjB+Aaj8pkHbSGZqjInOm+WxB4FCR3WUWFKf5CI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWXH32pWAzlFs6+po4w+ySQJi4Ago0kIICMHHvBWbwPbTdgUXHkYmlPK5QDl54V4WnTeWm9v7gfmKE1iY9G8ImUc0Wj8xWgJFHWgDCzsjoK/ezMenUL+ZNrWNsa/5wZAwXwx8zKjufq9+L2eQj8K6pKKCZeovAkcWoduAIf3dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvFncENm; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706258913; x=1737794913;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=A7lMnjB+Aaj8pkHbSGZqjInOm+WxB4FCR3WUWFKf5CI=;
  b=TvFncENmPi4g/aElWfCYaxATw4JdHNonQtbWeZ2wCKzXZys1NzgzVU0g
   Y3MBcMNMgrSlX5jSupPISuVt7mospmKAMpzAdBXZHsktBGfRS4kBOwMXO
   dn0KxkT3SBTE0RRet/htyvRdi2MF386SB1S/onQ8OZAiUal3bmC5ZZ3U3
   yI5N2vU/HlAcxvuHmeBDttQGtEk/BfcO7OvZPAflqzkr6En+sSDvSAaqE
   b+qywHYH+evtOfsTmXeJuvctMl3m9mrdOyf3/vygcJFPdfZqMeE3ier1S
   q0WSM60Bk+TL3Suk1rV1xT4sYiziaKadrZTR+Ik4/Ev31Hv0VSLVcpPw/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466698840"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466698840"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 00:48:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960153916"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960153916"
Received: from clillies-mobl1.ger.corp.intel.com (HELO [10.249.254.111]) ([10.249.254.111])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 00:48:30 -0800
Message-ID: <da82b69db55c414699429a81150d20ff52032304.camel@linux.intel.com>
Subject: Re: linux-next: build warning after merge of the drm tree
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dave Airlie <airlied@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Badal Nilawar
 <badal.nilawar@intel.com>, DRI <dri-devel@lists.freedesktop.org>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>
Date: Fri, 26 Jan 2024 09:48:27 +0100
In-Reply-To: <20240125113345.291118ff@canb.auug.org.au>
References: <20240105174745.78b94cb5@canb.auug.org.au>
	 <20240125113345.291118ff@canb.auug.org.au>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 11:33 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Fri, 5 Jan 2024 17:47:45 +1100 Stephen Rothwell
> <sfr@canb.auug.org.au> wrote:
> >=20
> > After merging the drm tree, today's linux-next build (htmldocs)
> > produced
> > this warning:
> >=20
> > Warning: /sys/devices/.../hwmon/hwmon<i>/curr1_crit is defined 2
> > times:=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:35=
=C2=A0
> > Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon:52
> > Warning: /sys/devices/.../hwmon/hwmon<i>/energy1_input is defined 2
> > times:=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:54=
=C2=A0
> > Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon:65
> > Warning: /sys/devices/.../hwmon/hwmon<i>/in0_input is defined 2
> > times:=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:46=
=C2=A0
> > Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon:0
> > Warning: /sys/devices/.../hwmon/hwmon<i>/power1_crit is defined 2
> > times:=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:22=
=C2=A0
> > Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon:39
> > Warning: /sys/devices/.../hwmon/hwmon<i>/power1_max is defined 2
> > times:=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon:0=C2=
=A0
> > Documentation/ABI/testing/sysfs-driver-intel-i915-hwmon:8
> > Warning: /sys/devices/.../hwmon/hwmon<i>/power1_max_interval is
> > defined 2 times:=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-xe-
> > hwmon:62=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-i915-
> > hwmon:30
> > Warning: /sys/devices/.../hwmon/hwmon<i>/power1_rated_max is
> > defined 2 times:=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-xe-
> > hwmon:14=C2=A0 Documentation/ABI/testing/sysfs-driver-intel-i915-
> > hwmon:22
> >=20
> > Introduced by commits
> >=20
> > =C2=A0 fb1b70607f73 ("drm/xe/hwmon: Expose power attributes")
> > =C2=A0 92d44a422d0d ("drm/xe/hwmon: Expose card reactive critical
> > power")
> > =C2=A0 fbcdc9d3bf58 ("drm/xe/hwmon: Expose input voltage attribute")
> > =C2=A0 71d0a32524f9 ("drm/xe/hwmon: Expose hwmon energy attribute")
> > =C2=A0 4446fcf220ce ("drm/xe/hwmon: Expose power1_max_interval")
>=20
> I am still getting these warnings.
>=20

We're looking at fixing those.

Thanks,
Thomas



