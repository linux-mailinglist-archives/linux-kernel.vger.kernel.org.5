Return-Path: <linux-kernel+bounces-47777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5518452AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EE1B25792
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4315AAB2;
	Thu,  1 Feb 2024 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsjYj7+v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691715A499;
	Thu,  1 Feb 2024 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775986; cv=none; b=rJ8fChhKrZO2DgQnu7sg8Jw4qmOpIN8D1nE0LoZbd6YPS9I/8kzXaUTqC7wO51ICRLkGAO2Wv0TUQcUTNkjxxdm0yCXu4Xdoys9/NdseSHipOZkorx8Vi1K5NXaQhhP9wEvrusXmByen82SROYHiOPj1vAXNWqMp9+Jv276nE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775986; c=relaxed/simple;
	bh=XpKiZdYw73rtXNsgKWeaOkuxm+QdTdp3TunoJ61mePs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uCOhOKCiXIOEd513i64cUbhJgXKqCxzY18HwtIGzv2I2kf/lX7sM88VKM8dbWnpvrkoT5/A3rbqbNOhCBq4C5Y9yZoZvh+gMVu5VuYkMgXrdObBfsSUvxrMkRM9XHDAc+RFhWbHR+JX0NnJbModFZL/ZgWgUGRc33CE0us/Wazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsjYj7+v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706775985; x=1738311985;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XpKiZdYw73rtXNsgKWeaOkuxm+QdTdp3TunoJ61mePs=;
  b=nsjYj7+vsXyNJcehqFZzk08MXS7kXSCleunOBfXkpmJ9wErSDCIGenE7
   BunOkfqhDqDoGzlnQ/Qqetp1nkORdxEQV754aJksuhIJc32dk9wCEUoOk
   0OUR96VaVCaSEfYDyAOUTKrxWQdyK2MfFVt7mF6YVmi0nzXL3bGbKSzMZ
   XIc5sYRzQFYZ3ZD57mSe0XnP40xHKxicZoln9bvrlRmz61bfWelIYgRsO
   RxSAiNbw/Gkb8qLYkPP7VH4MyBnPSdTaNojZksxWPQelb2tXusd7SYL2o
   ljq/dy3WJUkj7tBzZaU8NYGJRFzZMnG9RecVNydbHtradBtKDbodZ85AC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22232"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="22232"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 00:26:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="24057"
Received: from lutzwalt-mobl.ger.corp.intel.com (HELO localhost) ([10.246.33.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 00:25:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 1 Feb 2024 10:25:53 +0200 (EET)
To: Maximilian Luz <luzmaximilian@gmail.com>
cc: Guenter Roeck <linux@roeck-us.net>, Ivor Wanders <ivor@iwanders.net>, 
    Hans de Goede <hdegoede@redhat.com>, Jean Delvare <jdelvare@suse.com>, 
    Jonathan Corbet <corbet@lwn.net>, Mark Gross <markgross@kernel.org>, 
    linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/2] platform/surface: aggregator_registry: add entry
 for fan speed
In-Reply-To: <8552a795-9ce4-417a-bc71-593571a6b363@gmail.com>
Message-ID: <6659d49c-4a70-1a92-2a76-ce7144fed50c@linux.intel.com>
References: <20240131005856.10180-1-ivor@iwanders.net> <20240131005856.10180-3-ivor@iwanders.net> <7e392c1e-2cb2-43e4-804e-227551ed2dd7@roeck-us.net> <8552a795-9ce4-417a-bc71-593571a6b363@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jan 2024, Maximilian Luz wrote:

> Am 1/31/2024 um 2:24 PM schrieb Guenter Roeck:
> > On Tue, Jan 30, 2024 at 07:58:56PM -0500, Ivor Wanders wrote:
> > > Add an entry for the fan speed function.
> > > Add this new entry to the Surface Pro 9 group.
> > > 
> > > Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> > > Link: https://github.com/linux-surface/kernel/pull/144
> > > Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> > 
> > I wasn't sure if the Reviewed-by: tag means that I should apply the patch
> > through the hwmon subsystem. If so, please let me know. For now I'll
> > assume that it will be applied through a platform tree.
> 
> I think it would make more sense for it to go through pdx86 (as usual
> for platform/surface). That would avoid any potential merge conflicts
> if we get more changes to the surface_aggregator_registry later on.
> 
> Hans, Ilpo, could you please take this?
> 
> Also I just noticed that Ilpo wasn't CCd, I assume because of an older
> MAINTAINERS list. Ivor, please add him for any next submissions to
> platform/surface.

Okay, thanks for letting me know (I assumed the opposite). I'll take it 
through pdx86.

-- 
 i.


