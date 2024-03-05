Return-Path: <linux-kernel+bounces-91898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9B871818
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4976E1C21687
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD417F7FD;
	Tue,  5 Mar 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHzRd2ND"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2927F7EF;
	Tue,  5 Mar 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626790; cv=none; b=l4gyLpA83jFI8Zxwt1563zJXyYDzPzNzrMiiXLsvw158mCLHx5dph2NtZHi1vd5zZLoS2XyLhvAgI2sJdr1LsRgZYq/MUrEpSBe1Ij6FgaCYad/u2GWzI/3aAqC6fthL5c10ATWh/ZP+6/gW0A5RUDtcsZEQTW2ybWRBQIGTF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626790; c=relaxed/simple;
	bh=Pco44Jn0AoXW3qDgZjVeFTowyTAynlFylgLFzt14dSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ya8gnRCURB8T09jUOO/V8hwpyJqcrL9wZYLfNmAbOZ7bHBhRmD1ymwSpzLFsOq7Ym7F+ve+gUKKyaXKeO7EiqkwRzqqoRVNOOfDcOUaecTAMz/roWOeKOGj66OTME5is5PwQ4QgWEequc/TsrWrYnnedufbRCGbsZPYFaKNy/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHzRd2ND; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709626789; x=1741162789;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Pco44Jn0AoXW3qDgZjVeFTowyTAynlFylgLFzt14dSY=;
  b=DHzRd2NDRdanHxUZORwXhLG0uRP9hSJwTpd6Cvg1u30nbGmhmcFsEXlz
   3R2Z0EqoxyhnMSqD+WTua1vNdqJfsuQHiE57zRv3qxWmQQ+nJGQHAM/h2
   e+F6Y3TQBW1vTWIjPRJMqepVF7p8Zgbcx1olURcC8zcISn/GoF9ayVgdx
   s7DEwHBIDNuit0WkOlym2XmZbk1zzf9tnI7GBCFNumWFH0MCXAnHU8DRc
   oIDUXrAkbNKbroWuUxADhoFeQMjB9XnUy/CwXcvVB9BeNteZsh5zK2aVh
   Qb97XoS87uYljRVBFollG7tp5MjKWChAV5ZRiTC2r3tX+BoK1pwns0ovm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4023529"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4023529"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 00:19:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9261401"
Received: from omakhlou-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.51.143])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 00:19:44 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
 linux-kernel@vger.kernel.org, Naresh
 Kamboju <naresh.kamboju@linaro.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
In-Reply-To: <87cys9pl55.fsf@mail.lhotse>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
 <20240304095512.742348-1-jani.nikula@intel.com> <87bk7u5n9h.fsf@intel.com>
 <87cys9pl55.fsf@mail.lhotse>
Date: Tue, 05 Mar 2024 10:19:41 +0200
Message-ID: <87v8612iqq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 05 Mar 2024, Michael Ellerman <mpe@ellerman.id.au> wrote:
> I prefer Thomas' patch, but I'm fine with either to go in via drm.

Thanks!


-- 
Jani Nikula, Intel

