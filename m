Return-Path: <linux-kernel+bounces-155315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A78AE8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6362895D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2C4136E16;
	Tue, 23 Apr 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsH2SCwT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AE135414;
	Tue, 23 Apr 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880509; cv=none; b=N1om/TrlQeyARk6HCWz7X2/i9S6WvnGNlvS4uQEpmKq4Z++1jG/+Ypx1byjV8oSU2fpdbuvqgiM9YqOOTXA9jHI57CPN9YZz2MP36OyQ0w/sEMxkpMWT2FD6N09D1QvXUueDk1yEiD4qWqS91rgzNILnLwwt+CifO+HlgVi9JI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880509; c=relaxed/simple;
	bh=+PK+oBMAJmxbGUBApziMyZiWq0jsi78ILrJZcvOsOnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBcQA1t0lXInJfFn2si/wuS2g8XXkuYJ5qmN6N+Ojfxkp7OPz/bdOp2LdwwlYUO6AMQPzbX8qNecYo747eEZQMGEJTxZcA6UHAE994M/mg/y4f0IU0P0dDf1FdwkipDhAiuKVVbsff1+DFH142jOZC76F5wBHvclB+7nil2ELg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsH2SCwT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880508; x=1745416508;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+PK+oBMAJmxbGUBApziMyZiWq0jsi78ILrJZcvOsOnE=;
  b=ZsH2SCwTat5aO6q/5aMjwjKny69oxyszUdq1DarTrVKEw7x4YWfOnzxJ
   niVszDwxBEyLueuazl0RfQx3Rna5XJ+bLSrFXyGMmUfehXxR6IMS/P8K1
   u0+mdl0Y+gQYyrHY+tU4zLPekOsknwTeJ7CFCLdAKirTa6DPmK9SxgdFg
   EsAvQ0p0PA5FDv7LUKC+s6dXe6Dk+pn2gKA7/hJgthAJAAHgTvZNdXrmJ
   VPiUZVgZxPbothEt1Dw5MOGBbp/olRj81g3cmAbQJOR85sbrC+hG9EmPA
   rygmlb5tGuyOpfYnbIN9HzOSehKXcTsIvN8/D7zrt/TWLFenn0iSofvGu
   Q==;
X-CSE-ConnectionGUID: SKXPCBWbR/yPRAFT0e0SLQ==
X-CSE-MsgGUID: wJSunp/URciO7/tcdS9ReQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9316054"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9316054"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:55:07 -0700
X-CSE-ConnectionGUID: CgQsHSIARYiUxxj7DuaRlw==
X-CSE-MsgGUID: p59mQK6vSwqt7bn3zuLksA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24427031"
Received: from fpirou-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.46.117])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:55:03 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Geert Uytterhoeven
 <geert+renesas@glider.be>
Subject: Re: [PATCH] drm: move DRM-related CONFIG options into DRM submenu
In-Reply-To: <081ae10b-0a64-48fc-9be9-540e67900527@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240423102443.453261-1-masahiroy@kernel.org>
 <081ae10b-0a64-48fc-9be9-540e67900527@app.fastmail.com>
Date: Tue, 23 Apr 2024 16:55:00 +0300
Message-ID: <875xw8rxor.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Apr 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Tue, Apr 23, 2024, at 12:24, Masahiro Yamada wrote:
>> When you create a submenu using the 'menu' syntax, there is no
>> ambiguity about the end of the submenu because the code between
>> 'menu' and 'endmenu' becomes the submenu.
>>
> ...
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I think this is a useful cleanup.

Yeah, thanks for the good explanation!

However, it won't apply to current drm trees.

BR,
Jani.


-- 
Jani Nikula, Intel

