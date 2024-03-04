Return-Path: <linux-kernel+bounces-90627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E224870270
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC14AB24F48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCD3D997;
	Mon,  4 Mar 2024 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiJ97jRe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5CB3D98D;
	Mon,  4 Mar 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558219; cv=none; b=RsOFDo6+lQZ3Xlme6fzr1oOQfs3IJjUw/sV4MmaW/P1+meqKZ2Jqqw1sG6mBkWj4UgaUR85YYeoKwis56bxRYLL8d59jWEDQ+bb8HxaRHxGHAp3zUZpQFeHvniu9jz1yt2NwMy9YgQhOax85Jb9ufAQ8Qf9mqJi6vumjwgMmX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558219; c=relaxed/simple;
	bh=W4lBqw00P3FvFXSsoaw8jTteZwviH/G+XWaTcDwLzPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VvrCa0wmDUwJWSOy53yfwlPWNLfzs++CXlmUryQ1SKpeOkvQCQE1gQzoGE644Q5gi9RBolHa3uBepniPkeNfGgn2mwhWBtGU3cLhxdX78r61GIlSBSI2jjB4Hy5nPWVoQoJmEp1nPfg8cxkcn82xn3fhapJ+Horw79gVuZwCLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiJ97jRe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558218; x=1741094218;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=W4lBqw00P3FvFXSsoaw8jTteZwviH/G+XWaTcDwLzPs=;
  b=aiJ97jRe97/s/LC5cpDyeWxdo10z008PqLuaw4ffUgog8Dnq6Q80rrB+
   VhzsH/lpgMdOlGRyb9Sp8qrjY1NFtc5dQGAbP06mQQJ6a0eKQjHMLOeDt
   jUpa6+4Jz4vZjzxlwytuuseWq9ecYQ9XcKVk0bUavOaDP6fX2BTHu2IQ5
   +PuUJSBQ7JUEobZAugdrTVdbLA13oDTf9sflcNkLR0QOK/eM+4DE11ksT
   ydlzB6VE+yefJBgMNapbJUqu1NMlrL3TdXxZWOrAUCItexmGL4hEvRkIK
   QjokBa6YGAMZX9vUiqeENAz/di3q0fs0NI0ZlCxa2ezhHksq7dwHtJ03k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4625122"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4625122"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8905063"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:16:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Lee, Chun-Yi" <jlee@suse.com>, Hans de Goede <hdegoede@redhat.com>, 
 SungHwan Jung <onenowy@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240220080416.6395-1-onenowy@gmail.com>
References: <20240220080416.6395-1-onenowy@gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Add predator_v4 module
 parameter
Message-Id: <170955821057.5357.2481545747290291775.b4-ty@linux.intel.com>
Date: Mon, 04 Mar 2024 15:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Tue, 20 Feb 2024 17:04:16 +0900, SungHwan Jung wrote:

> This parameter allows predator laptop users to test and use features
> (mode button, platform profile, fan speed monitoring) without
> adding model names to acer_quirks and compiling kernel.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: acer-wmi: Add predator_v4 module parameter
      commit: f4b63facc3a7da2de322ae4b53350b4b7152abd5

--
 i.


