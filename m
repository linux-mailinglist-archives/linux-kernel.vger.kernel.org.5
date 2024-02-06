Return-Path: <linux-kernel+bounces-54669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7136384B240
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3702898AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344A12E1EE;
	Tue,  6 Feb 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfEaQ1Lt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCBA83CC8;
	Tue,  6 Feb 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214495; cv=none; b=goBzKDhkdcRx/M3WN+dhe+aXv9h5byNeSecN7xravbRp7n4Fk0lR2+9C/dF23jod4o6BwExhCDfTmkbDOWH8o+PBGvZw8zVFitFD60bSjjKcEsvljlnioaNSflxV26kaR//QWVj04BSgBb10XaI8Amx2l80u5BKKtUV1n3b5O9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214495; c=relaxed/simple;
	bh=kxANQZooDhmBh6B4YpxkoO6gfLK9laRcMJ62kX5uYSU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cEnC2Z0dB7FE4JICBtUohzYweex7cRYiJgVHjvqVn5odQ1+UHK4yYU0NLhMK5ndkB5Ar59bqIxE0h0LZKsirHuWN8r+fGUeSoHe/Ibx2WWBSDzq/gt87ob1gkKHbv2YHAUEg9Mcia/z01KYw5VIhKgKPQ5QWZJRZU8C9Nv2/NlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfEaQ1Lt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707214493; x=1738750493;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=kxANQZooDhmBh6B4YpxkoO6gfLK9laRcMJ62kX5uYSU=;
  b=RfEaQ1Lt2G7tpbtB/IG8ag9pXZInSGIFTz5IZRi3/R/tx4Z/02UnVMQw
   71GylRcoy/Yin1eKU0GCXSF8yAYRVeUAgExLNxSD8hg+sT5NmoExMhC4d
   sAlKCUsE/V2FQbfsYKUZ4lki+x31byTsn/xmU4JL3wmHKEHlaFN0ejzLy
   jUxPNcokTtP0boJ/2VxuFhL+wKkn84w4uD1yoMnx6BqX6nq8fzD6iNh4e
   7VMzCewgr3ctdcLQKIN2rx8cYrxHiTdhKhL9st40tnJirI1Mk31+G5EeB
   mjlhKr7BNwjIQtlz5SHoMDmGyOuE10jR13PaOSFkqtLrjyK7wUc5t+XSh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="597776"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="597776"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:14:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933418973"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="933418973"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:14:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
References: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
Subject: Re: [PATCH 0/2] platform: x86: struct bus_type cleanup
Message-Id: <170721448591.2255.4876189619847737176.b4-ty@linux.intel.com>
Date: Tue, 06 Feb 2024 12:14:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Sun, 04 Feb 2024 11:40:15 -0300, Ricardo B. Marliere wrote:

> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform: x86: wmi: make wmi_bus_type const
      commit: 10fdfd13a35994ac1dcc3003d4046cb1955e66a8
[2/2] platform: x86: ibm_rtl: make rtl_subsys const
      commit: 41b43c75121208a9e4e84fd148f918bddb3f5d1f

--
 i.


