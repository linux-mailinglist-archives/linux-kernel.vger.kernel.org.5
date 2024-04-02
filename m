Return-Path: <linux-kernel+bounces-127577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45217894DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0157D2833D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB050278;
	Tue,  2 Apr 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl3U/pMq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93A4501C;
	Tue,  2 Apr 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047568; cv=none; b=Y5jhffmfXR9KrioEaUAMhSYXAhfZ6J97HErmywm6H4+PPq9TuwrU6Yz1Yo7raZDT3WAJMVD6BrAauY/oJX4O3ha/JKzCvSV6fOvMM0RFLGnRjc6qiuvudDzF/2zuoqEVxp+ZgW7Y9OT3vj79X3/eLnFMoz1kI9yiDY0bhKF43Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047568; c=relaxed/simple;
	bh=Fh4xaBSV/7KMplnOoseILgEOyANlTljnCuikIBL5YzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eo89vudUdm5Tu1Ixde8HtVkfDEA9pvTTH5VX1TPdzJbfAbodK8y7htnYpBqGbqdTmzEIz/4Z78y4/+AuTd5UZb3v2SQiAdRx0JU2ADMkWsp49whXB86At7MiBxqw/to6WLQYGm4kSaedJPhnPHpYt9b75GWErEM0khlS3o3KDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl3U/pMq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712047566; x=1743583566;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Fh4xaBSV/7KMplnOoseILgEOyANlTljnCuikIBL5YzE=;
  b=Wl3U/pMqKxjKP71jo63XFFK4GXgw9YupQZ2KsMyrxad5VB9irM4CAyDC
   KMs1pi/ROhPtT4R25yC6dF2rL6WMjSkjW6RkI7i87B/mHysjgWVqs21GH
   DAJUpSXKsTMiIFfKHfQfZqiYsHDilQf9MYo559K4rwnkZuMQWkSdABHp9
   18XtBsLatiRYXqZj9eSDjT/dpPVwPtU5fQ8tYQ/XROWVQYQzjRWMGWwJ+
   CdH5CF3PkpWEJmgLJzLjEZGyF2+fwQjkVkMzP7tCb8UVuMVSdHZBGoik/
   Tv644hEkqkA0aqfZlUtaFaEuFbfTLzf/B2XWdTnnwviPXOravHIzBFo1I
   A==;
X-CSE-ConnectionGUID: Ox1ritnBS/+7t4Gtg/t/Ag==
X-CSE-MsgGUID: wFDtkneSQeWrcU/ttCVEAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7361897"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7361897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 01:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18067477"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.67.49])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 01:46:05 -0700
Message-ID: <2a3e223f3f248e8b02a8aeb47ab2ab15a6225889.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/6] intel_pstate: Turbo disabled handling rework
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 02 Apr 2024 01:46:04 -0700
In-Reply-To: <13494237.uLZWGnKmhe@kreacher>
References: <13494237.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 18:00 +0100, Rafael J. Wysocki wrote:
> Hi Everyone,
>=20
> This series reworks the handling of disabling turbo in intel_pstate
> on top of the previous series of cleanups
>=20
> https://lore.kernel.org/linux-pm/12409658.O9o76ZdvQC@kreacher/
>=20
> The underlying problem is that disabling turbo is handled quite
> consistently
> in intel_pstate and basically it can get disabled at any time
> (through
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE) without much coordination with
> the
> cpufreq core or anything else.
>=20
> Disabling turbo through the "no_turbo" sysfs attribute is more
> consistent,
> but it has issues too (for example, if turbo is disabled via
> "no_turbo",
> the frequency-invariance code gets notified on the turbo status
> change,
> but the actual maximum frequency of the CPU is only updated if the
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE value changes either, which need
> not
> happen at the same time or even at all).
>=20
> The first patch is not really related to the rest of the series, it's
> just a cleanup and can be applied separately.
>=20
> Patch [2/6] uses the observation that it should be necessary to read
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE after driver initialization to
> remove
> in-flight reads on that MSR and turbo state updates related to them.
>=20
> Patch [3/6] builds on top of the previous one to adjust the
> "no_turbo"
> attribute "store" and "show" callbacks.
>=20
> Patch [4/6] adds READ_ONCE() annotations to global.no_turbo accesses
> and
> makes some related simplifications.
>=20
> Patch [5/6] replaces the cached MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> value in some checks with global.no_turbo for consistency.
>=20
> Patch [6/6] makes all of the code paths where the maximum CPU
> frequency
> can change to do that consistently by using the same set of
> functions.
>=20
> Details are described in the individual patch changelogs.
>=20

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

> Thanks!
>=20
>=20
>=20
>=20


