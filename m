Return-Path: <linux-kernel+bounces-98787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C7877F69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836D9282C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FAA3BB4D;
	Mon, 11 Mar 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuBKlrdk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22153C478;
	Mon, 11 Mar 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158460; cv=none; b=Qn9CP6mDxVSzZ1joeAVBSs/mxUtWV1v5IUO5uybcY/RBtnrqlsq76I1P0UzCGogFmiJfa+cQx1/Ck7OCmNSbYG8cHBdG+wNzWuDj9h4mN6JLKYw8+cP84UScJ+eLfIrj1PGxREUytEP1KsMdLoHaxYBxyR0Bs3pNTlglDpih//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158460; c=relaxed/simple;
	bh=jjTcu17GjqoJuwQ1kOcrgE+fdyyPlsWnZLhNo2WNBmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MKCHZ/CQGsoPUu3ioIZutFR9LHOVhc3XIj9wXdaiFmxAFEeGpvxBkY416Q3FtJmvAAhZRbDk96UIYhBRbJ7fcRoLJfhD/wPrzmKRvlmfsZhSbCG+Twf0mTltwNzVvqYlhi8Jje1U0u452+JJJWFaGexSRiHfGuxqhQhZJJci5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuBKlrdk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710158459; x=1741694459;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jjTcu17GjqoJuwQ1kOcrgE+fdyyPlsWnZLhNo2WNBmk=;
  b=NuBKlrdkeprnnMGWPyPuIS9KUWdqAREXsmuQqcYD3rfburymNHfnukZ4
   9kYhYbpo99OLSzdtoxy4ilm7wgah6J4SNj0nYP4ZUORE3X84ZkrCyKJEX
   xFjhBj6SkG43A7iOHTbUga31kTTNajFOty5t4J3pTjH6/M8cBhHh6Fbzz
   9CsSgVIik2fPmfS+1gVXufN3RDC5yVG5Yc+TSbPpsupIM673z6edh+c5X
   ewYEr0pp6IL8nSap1dEGuAI+hzQ3DH4k5WB7k8gL75QSd9komloAW6ADz
   C8xpNyu0HFBU4Hym4gJ0Ck+A1hEj+U64vhI7dopTWSJoiLT6udRMT9POp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15454329"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15454329"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11143822"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:00:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com, 
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308053255.224496-1-kai.heng.feng@canonical.com>
References: <20240308053255.224496-1-kai.heng.feng@canonical.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Consider device is absent when
 the read is ~0
Message-Id: <171015844966.2407.11609442666514555548.b4-ty@linux.intel.com>
Date: Mon, 11 Mar 2024 14:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 08 Mar 2024 13:32:55 +0800, Kai-Heng Feng wrote:

> AAEON PICO-TGU4 board doesn't have any LED but there are bogus LED
> controls under /sys/class/leds:
> $ ls /sys/class/leds
> asus::kbd_backlight asus::lightbar  platform::micmute
> 
> The reason is that the ~0 read from asus_wmi_get_devstate() is treated
> as a valid state, in truth it means the device is absent.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: asus-wmi: Consider device is absent when the read is ~0
      commit: 3f44cda7c36276f75d1ddcd2d52eb2d412e30cd0

--
 i.


