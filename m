Return-Path: <linux-kernel+bounces-46231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77552843CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9D31C29CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0269D0B;
	Wed, 31 Jan 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaENHsNO"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEB6996C;
	Wed, 31 Jan 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696932; cv=none; b=sYzhhPlHjkuYvlcWu4gwMG4yOT9L1cV3bzCQnBcwEfOZrHMq9TmYeDt8jsb5pl8ECk5ChoeR1VRFF3mLatBYhvegQU54muClvRMFcq3Pl3Ij9IDap3nWuQ+yGTLMWMThTQdT/Te/NZkvTF+suAFntkMf0Lv123fE0IhtoKCluJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696932; c=relaxed/simple;
	bh=oiTZCszNyvv56h86jVlqMPQSrAP5+7D+gYSOYBwymIk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xft9mtM3H6gCkaOxMzRIBuejzgfZtMCcxYBhAJRo2E47vCsfNCZoWcTKAZb8uLLNlfz2jjtDdMBeYMth08TIFCftzco8eGUpiKCIMBbkpzajbAvuu37iPT7ctykAm4tBuv6UC7lDEOgDU82Hd8p3MoVtXxCWpzz45wqZCUNAgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaENHsNO; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706696929; x=1738232929;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=oiTZCszNyvv56h86jVlqMPQSrAP5+7D+gYSOYBwymIk=;
  b=PaENHsNOL7ULwZbS/JBFnKrYBT0MlGDZleAuPC6guk6XBM6p3JlubJvB
   4ulBNLFlEb5qaKttgxwR3FE1yaSJrYRj/gB+OSYgRQU9vViRON/yn+a3Z
   dTo6eburlkd+HfTlLaot6qq1jLS7HBUUByfTl2PfWUW1xdaCuRDraR6wo
   c05ZYDBZfQCwnhBC/DnzE6sMA4ah7hZwXuSRFCpfwln8dOPdhCE0PByzu
   RrGYA0i9NVV95/dYS2FGZ5i00wNDCpJTnNsopHJ/kcYbkMBMjsdtxdzjI
   DGiKK225H7T95BOcTqKvmQhsryFdF6NkIjGZKMPGGKbn4eMB35Aj//Tse
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402412109"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="402412109"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858771597"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858771597"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:28:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jithu Joseph <jithu.joseph@intel.com>, Ashok Raj <ashok.raj@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240125130328.11253-1-ilpo.jarvinen@linux.intel.com>
References: <20240125130328.11253-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/1] platform/x86/intel/ifs: Remove unnecessary ret
 init
Message-Id: <170669691631.3904.4606713749233897647.b4-ty@linux.intel.com>
Date: Wed, 31 Jan 2024 12:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 25 Jan 2024 15:03:28 +0200, Ilpo Järvinen wrote:

> ret variable is assigned unconditionally in ifs_load_firmware(), thus
> remove the unnecessary initialization of it.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/ifs: Remove unnecessary ret init
      commit: 682c259a849610c7864cc75d52415c782c78653a

--
 i.


