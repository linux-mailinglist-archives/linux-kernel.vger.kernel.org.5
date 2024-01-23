Return-Path: <linux-kernel+bounces-35977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E66839967
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B291C222C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2D811F5;
	Tue, 23 Jan 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvkCVxj9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DF50A64
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037441; cv=none; b=Sly/OunXPb/UGnr/qD2lHfCHteE4s2D3WUYNhV18d1FdXZlIOVfFeg1z6nTUKk9pTzZ54DNWQB6VzteLEilRuPL83arxxPxXyGug2cJD4LPUp7tpbOEZPZxlFvpA5XJ1AGQGd2vHEwNnqekxB3Q+48DoZnVcEE1dnIFik4dHgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037441; c=relaxed/simple;
	bh=a4D7Gvm3E3IKOqSNk13QoOG/5s/jLnUCyPtJuWQkTL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehFCkLhFDWKfEg6Cu1EAVV+zTgBPZKAqamJ1WrQvn5vxlD6Tm0BEs4untGxKp/1dn6FeoCfdyiolWDvngeW+MTYClFhg2RTPex3iSZTARR0/jqLNOeJ6MF9Iy7wHt4hqAhxZkVXskKNl1M4EEihN/hbw72qE9r2FmmqNJgMmnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvkCVxj9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706037439; x=1737573439;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=a4D7Gvm3E3IKOqSNk13QoOG/5s/jLnUCyPtJuWQkTL0=;
  b=gvkCVxj9S93K6KWDy9/NLLI7dA/iLRha2eroai1V+pe68wY1jx1EvG/g
   Z3oy20/owy8fEjbl8ZyllGMITV5He323KoSb1nqjE+1HAU+MjWdr1QWA9
   +eW/tnPfN8JXVPYufitZ0v18nOOd76yoIJH6JiV9vlDRALfp2RAZWRlOO
   3Atp3AfWdu5/Oy4AcgMEHSWYhF6QCljaMW7NrmVoHqlh2oCpFEtvC7nl6
   wh/MIug1ryldTf9mdsUd2/mPMyYcfj4RpxV2qxlbSMUcLUIVMGldi1eDX
   eF8g2Rvmqk4dkTunMKdBHoGJLf8G/lWIpZWaIdur31kvqe4k9bt1B0kWn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15143551"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="15143551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 11:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929429114"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="929429114"
Received: from pzsolt-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.40.183])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 11:17:15 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 chenhuacai@kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Thorsten
 Leemhuis <regressions@leemhuis.info>, Thomas Zimmermann
 <tzimmermann@suse.de>, Jaak Ristioja <jaak@ristioja.ee>, Huacai Chen
 <chenhuacai@loongson.cn>
Subject: Re: [PATCH] Revert "drivers/firmware: Move sysfb_init() from
 device_initcall to subsys_initcall_sync"
In-Reply-To: <874jf4nmgp.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240123120937.27736-1-tzimmermann@suse.de>
 <874jf4nmgp.fsf@intel.com>
Date: Tue, 23 Jan 2024 21:17:13 +0200
Message-ID: <871qa7n9l2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Jan 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Tue, 23 Jan 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> This reverts commit 60aebc9559492cea6a9625f514a8041717e3a2e4.
>>
>> Commit 60aebc9559492cea ("drivers/firmware: Move sysfb_init() from
>> device_initcall to subsys_initcall_sync") messes up initialization order
>> of the graphics drivers and leads to blank displays on some systems. So
>> revert the commit.
>>
>> To make the display drivers fully independent from initialization
>> order requires to track framebuffer memory by device and independently
>> from the loaded drivers. The kernel currently lacks the infrastructure
>> to do so.
>>
>> Reported-by: Jaak Ristioja <jaak@ristioja.ee>
>> Closes: https://lore.kernel.org/dri-devel/ZUnNi3q3yB3zZfTl@P70.localdomain/T/#t
>> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
>> Closes: https://lore.kernel.org/dri-devel/20231108024613.2898921-1-chenhuacai@loongson.cn/
>> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10133
>
> FWIW,
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
>
> but would be great to get a Tested-by from Jaak or from the gitlab issue
> reporter.

The revert works for the gitlab issue reporter.

BR,
Jani.



-- 
Jani Nikula, Intel

