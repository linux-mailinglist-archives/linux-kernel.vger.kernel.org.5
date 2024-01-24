Return-Path: <linux-kernel+bounces-36828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9183A772
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A17228E170
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6771AAD3;
	Wed, 24 Jan 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixJuk2sR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488981AAD2;
	Wed, 24 Jan 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094158; cv=none; b=fJoYOd3dXAjQ0J4/NhBpqwfQwFv/+p8mLha9hbhuKBchsliHqda0JEM9iLgaW1fV7sNrez4ycOZy0apf1PEYbMzZ3j4Pw/l0gn+ddfHfOc+ilGSr5udzZFcMKG19uyXW+e34tWriV72q3/f0gQ1/CqsoMbK9HWG4T/fPL3wfoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094158; c=relaxed/simple;
	bh=tu7GFTZtwYK50NIjK2sN48Nx0wqpRW7rtLaLQmL8r6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I4DTW8nBmDXeonPHhn8Tb2dWD5LOl5rdduNw/EO20sDkd2WqlBDIBRj2sEU2qKZ1IuUbVmsb37S7GifdYWVDGM5lynCSk+F7XMH7FuqDnrDhXZpl/XHxB3IZS1WQS8sc3nCn5kDRfVtDt79I7gbTVDQWrg288ZvXSqRr9IGyO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixJuk2sR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706094158; x=1737630158;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=tu7GFTZtwYK50NIjK2sN48Nx0wqpRW7rtLaLQmL8r6I=;
  b=ixJuk2sRe7ISydeoMatBmZiMWst+/pmw1eslBc8a7AkyW2DHD/ELiblR
   5BwdGYCTN7GrEzHYzLIVk/p+lGtrlkaZ3lOaptDgl0ExJmsN9JRSmySfe
   yLqt3syz/WKioTBR/RvgjHjsNGKx+krDI1JmVXwRlHnVMcdWzo9GVHqaz
   MqC4CIsqiiZ1un0VwI5t7XLQwDc5AiNtvrNMYNVMmUpBSnEfuGpi0c3DE
   y1u61EsH8yoAGcSu8zOmAKJfjOo7j7MecGBGdGZGDgDao6YTP6Eqvc9fs
   MktN7RkI97CB/vQdYxDVprbD0xHEo02yxvnxHtugQLTvoa55z4d9Jz2cZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8464565"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8464565"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="786382057"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="786382057"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:02:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: corbet@lwn.net, hdegoede@redhat.com, 
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240120232949.317337-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20240120232949.317337-1-mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH] platform/x86: Support for mode FN key
Message-Id: <170609414851.14220.467201747237298262.b4-ty@linux.intel.com>
Date: Wed, 24 Jan 2024 13:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Sat, 20 Jan 2024 18:29:34 -0500, Mark Pearson wrote:

> New Thinkpads have added a 'Mode' Function key that on Windows allows
> you to choose the active profile (low-power, balanced, performance)
> 
> Added suppoort for this hotkey (F8), and have it cycle through the
> options available.
> 
> Tested on X1 Carbon G12.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: Support for mode FN key
      commit: 0959afbafaf8791a9810fba2c55a64dfdcc3b66e

--
 i.


