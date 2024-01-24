Return-Path: <linux-kernel+bounces-36827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A320E83A76D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68D81C246A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4991B598;
	Wed, 24 Jan 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSsWRkXx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB541B267;
	Wed, 24 Jan 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094140; cv=none; b=ZLDxwZVyPkbpgFyfA3896ILTSxhLFTwP8kWmU2PfVAH2e4XbfNf0nHJkQrO8WlYnqwGRN1YmFeNQeNB18DX7YNlxblJOX55WQxQsprMHdkE01F9pEAXV5lxZoHOtvlAHls3lntIxrvY4gzb+sMlsNbW9Ezm8cGRUmmsGNP0Le0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094140; c=relaxed/simple;
	bh=LKYw2sk4L0JmmSc9Can6TifW1pk8Pc9QOQIACGPZh6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nX3b02dHQlc3IGfwwmGbqP+tg7qKwmmwfKXKlF/5OgkB7RfjxNjsdorTQH7OU/NLpIsm6xy0yLd3DxtcJviZ+bhC0o1O6UYJs8zMYY5BGiEPnrPRY4Xw8cPUtWeTqhlg4w3lt7eKuoKx2J9AKtXKhe9GiXpd67Cz9CqlMdA7+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSsWRkXx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706094139; x=1737630139;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=LKYw2sk4L0JmmSc9Can6TifW1pk8Pc9QOQIACGPZh6A=;
  b=dSsWRkXxbwX8hqTuyqAzT1JMEU5zmsj94cDa0srGCeO6W1LcQHM8lzd1
   G2wYcKNO3zIiiCXDQn3EMJlPX5L/ozv1/eihzRBhEAMy3Uj9GG51MZqeN
   XZLMNfdOjmNuKkzYFqnlCLMmB4188ItjH5Dj/JAytq9YjaEETjZm/D76U
   NXXqjbEQPBjR8iW4oTM+B4HvjCwNswbMkmxJk5ShTvbrApzT2DvqK4Oz6
   cHRINvvqBvrgMGjbTNDf0JebdWfGDetl3Pq8JaksbUVvJoH0aNy9n//sH
   Sa8iPjteI9GPJ5qeBUiE8xsQWhGLSxY4Hib4DeeICDDajcE1jeS6Gv6sK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15334909"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15334909"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1937407"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:02:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Henry Shi <henryshi2018@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <a58bffb7-0a8b-4195-b273-f65a188ace7b@moroto.mountain>
References: <a58bffb7-0a8b-4195-b273-f65a188ace7b@moroto.mountain>
Subject: Re: [PATCH v2] platform/x86: silicom-platform: clean up a check
Message-Id: <170609413027.14220.15014847734859906524.b4-ty@linux.intel.com>
Date: Wed, 24 Jan 2024 13:02:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 12 Jan 2024 09:56:25 +0300, Dan Carpenter wrote:

> The error message in this code can't be reached because value is either
> zero or non-zero.  There isn't a third option.  Really, it's nicer to
> write this as a one liner.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: silicom-platform: clean up a check
      commit: 890a48ca7b05406c538505a92148de7ab0d50591

--
 i.


