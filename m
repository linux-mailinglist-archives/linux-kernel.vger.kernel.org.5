Return-Path: <linux-kernel+bounces-129339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2638968BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8612B2819C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858846EB60;
	Wed,  3 Apr 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noUU45Jj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417086EB44;
	Wed,  3 Apr 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133140; cv=none; b=oP+VtBi6mZtlPlW2EsK87I4a4RqlxUkeRAP+s6UonMxn73+5swq0qV6VUresmVSUe7qSpZm4F/JieHxjgVo6KS86a486mhN/JolIYhcX9ZCDeLSJfoWOxc25pR0iIxU/kyTPbnItBhDp2LDrZlrlA/3+5mB04yYvG0a0ZJFF7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133140; c=relaxed/simple;
	bh=3irQgcRGGnGr2ngoE+aZQpsm8IEoyYQb9EnMQVqgNY8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BrK+YOTBdljMTiGEK9uWjHpnwRsnOx/372UGMK7ZiyKKElXirag+LbFSo72LazCqOOodjzlkgNBuaa9LIznY/LNda1xt+/5S8XuQ+7Ng9vkR0pl9VF/ZPpPr0vgXLOVAafvZDYMoNEGKTUaxEdtavuq+TxXWLj4MXje7negH2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noUU45Jj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712133139; x=1743669139;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3irQgcRGGnGr2ngoE+aZQpsm8IEoyYQb9EnMQVqgNY8=;
  b=noUU45JjCfFF2RoD1TF/OEcohCIpVeR/vjxu06Y9ZUJUMF79Rdw39Gdq
   cGCnkiwRnuTbZ3mEyn/ZrLMN+kUbVh68jZ+fDo42JvpAFmETZyOSr4X4x
   XXrAihfBnCSiaNrFSbTtOTgNVQEWrfY4qrnc/x0ZOEZvPTzVCT/mTp6Mk
   +UJfHoRr9z3vQFoNHlub+/Y6zLcEYSA2r1n/3TYpXpimyIHCPxKTDupB9
   LVFA+v/qgmE6MJAztOPVd4lJmHqzJs7uTc7jv1pH62mS+0RhWqX98/nTw
   t5M1nCJ1zZD5k1nugbkpn4a34hP9VCZmAX2ucSHV/SMUhU3qGZDB2hDRL
   Q==;
X-CSE-ConnectionGUID: +05SAZZdQtesZL/6y/3TZw==
X-CSE-MsgGUID: g1iarW9JQFCfbT6cPSm6WA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7508779"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7508779"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:32:18 -0700
X-CSE-ConnectionGUID: GD69pZG4RvaS21h/jeZDPw==
X-CSE-MsgGUID: 7H9cl30kSnGlqyiHtWEH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="49586652"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:32:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Apr 2024 11:32:12 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] platform/x86: asus-wmi: Add support for MCU
 powersave
In-Reply-To: <20240403002917.2870959-9-luke@ljones.dev>
Message-ID: <6940416f-2705-2b23-b039-5a41bb10900f@linux.intel.com>
References: <20240403002917.2870959-1-luke@ljones.dev> <20240403002917.2870959-9-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1718803634-1712133132=:1449"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1718803634-1712133132=:1449
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Apr 2024, Luke D. Jones wrote:

> Add support for an MCU powersave WMI call. This is intended to set the
> MCU in to a low-power mode when sleeping. This mode can cut sleep power
> use by around half.
>=20
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1718803634-1712133132=:1449--

