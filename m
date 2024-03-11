Return-Path: <linux-kernel+bounces-98786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A45877F66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DAEB21112
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D93BBCC;
	Mon, 11 Mar 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0tinbnP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5B3B2BE;
	Mon, 11 Mar 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158452; cv=none; b=tNWR66tFIplzHiFG9qVkvZTAOjyTN6CLXDI/SBFARtC9q0UGqmsMOq0/haoEc4Q0m+0n6CeJqGm2vGi7yucq2Ku6WGKix01uSOjjZnPjhQ8Dee3HkTippQgb9Y6Vl04pfwlJcoU8AZpuh7syen7NRe8oelzwXjEW77cyssSRjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158452; c=relaxed/simple;
	bh=JkOFvAVwz2RAoKfuXnMx7Lun02+Nk3oUs8jAMl68RiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HjOh0sfVzHLVmZ9lI66BbVoJzXaFX9GUhMDbM5OrFwjOr/ZJpB49KirO5SlQVGV7VEswHLn+reDzZuL5AnyadxmiBG7Y0Zpq9NIEWjta8QQnuhE1yhQmAmuDHn7sq/VCTYiBobAkw9zJtRQTYKgaY/aCZWYfMPdJ7Rbghl9pjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0tinbnP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710158451; x=1741694451;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=JkOFvAVwz2RAoKfuXnMx7Lun02+Nk3oUs8jAMl68RiQ=;
  b=h0tinbnPw6v88EPuc4M/3+CxRHVrK3XOzGBEVjSLUxOfuzxa/OEi9G9q
   HdwKZ1Y34N6s8bZSCfzyGUw+jcUeJmaeYs8s9pJ9vemZStJegfp0avXCN
   bV8oa7fX9QJ1qU2VKj3IFCYGrzHKqLhiA43jBz+Aa69GEVFl22Wawb0F7
   vE1ujZG1fXUoFNJZsYpuGyXkMTg1wF+mLBzKQ9WlDUBRkfSF2LJV0o69I
   xzp8oP7Itg+raB0d4rdOYhsGVk6oddpdihAKoEgmCceRDDKwXZRF8F3z+
   x1QDPUluVVwdc6CkMouXJZiJveBeYuqcsscZLb2JeKYcRgJWRze0iEGgs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15454309"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15454309"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11143784"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:00:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org
In-Reply-To: <20240307133601.103521-1-e.velu@criteo.com>
References: <20240307133601.103521-1-e.velu@criteo.com>
Subject: Re: [PATCH] doc/arch/x86/amd/hsmp: Updating urls
Message-Id: <171015844082.2407.9314247833035238689.b4-ty@linux.intel.com>
Date: Mon, 11 Mar 2024 14:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Thu, 07 Mar 2024 14:35:59 +0100, Erwan Velu wrote:

> When reading this page, some links were broken.
> This commit updates links to get documentation actually pointing the
> intended content.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] doc/arch/x86/amd/hsmp: Updating urls
      commit: dfea6b10ed15aeec6456e704e08e45fc7c947a9d

--
 i.


