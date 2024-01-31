Return-Path: <linux-kernel+bounces-46233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8B843CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970631F31528
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974869D11;
	Wed, 31 Jan 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSOF1Aos"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931E69DFE;
	Wed, 31 Jan 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696974; cv=none; b=jP7XyT/kA/g7DIE7dtIVL5AueSXa9lRk4ZDkqebZwq+iX3gyGGqTJsHDtyBOBxxhpodov6wppFfKlZl6ZYVwehLDrw/VlAC4bfKhVTJjL1EJzBG5sSD6h9McESzM/UxXZgyTIlK3n+J1zziBi/IZA4XHv/qezRuLxxnOrMhKUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696974; c=relaxed/simple;
	bh=LE1BklAJaxUiwuPDcPFSOxdV235Kq5Wz9kIwQqJjkd4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HS7UFpIgTqxZb648vaW2u621GTwUUuP55bW1q88EkvHLM/LWimBddp/4aggpKIz/OslEchWucw0H/Hz5KbWpyJcft7hMtHq4SaeWkl91RQ6anh6Z85dBDdAHe83qw6bHXcU8FdCAfPzXoZpYOpgFiWWFgrQdUCCrwNKaFJdl4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSOF1Aos; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706696973; x=1738232973;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LE1BklAJaxUiwuPDcPFSOxdV235Kq5Wz9kIwQqJjkd4=;
  b=BSOF1AosRtkxr2N2krNgQ9FWvctD+nC3OefI7U0PPrmiIlpkO9YMtA8U
   MYQ0MoCrQAIfHyCxRNqFyhhsvKHM8PsO+q7jsnyN0qb27OxNIzQgu2UQN
   ynAUiPTPu+31kybpPnzCOWL4V2KfikzeDkfQdZBNeZG3bGzU7Z6ehru2D
   E32ARRFVHRaz5Lg8jiY7SS/AkCGSIWnGBtxAcWQU9s8IFrqRxHzQMdVVK
   PD5WMdj4zBkaEytzhNiMW5aFI7OyABYpt7pbedeA6TKAF6gTAB8SR79gY
   SH7+pDl0zLU5OTjRZLC0L6gfMpH1U+jWgPk8/Ijeat2kGRRY2rbWXnMIJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25038780"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="25038780"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:29:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4041441"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:29:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Jan 2024 12:29:24 +0200 (EET)
To: Ashok Raj <ashok.raj@intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org, 
    Jithu Joseph <jithu.joseph@intel.com>, rostedt@goodmis.org, 
    tony.luck@intel.com, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, patches@lists.linux.dev, 
    pengfei.xu@intel.com
Subject: Re: [PATCH 0/5] Miscelleanous fixes and improvements to Infield
 Scan
In-Reply-To: <20240125082254.424859-1-ashok.raj@intel.com>
Message-ID: <8e9097cf-51f9-a151-bfa5-1580a4166607@linux.intel.com>
References: <20240125082254.424859-1-ashok.raj@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Jan 2024, Ashok Raj wrote:

> Hi Hans,
> 
> This series has some bug fixes and improvements for Infield Scan.
> 
> Patch1 - fixes a bug in the driver that didn't release_firmware() in the
> 	 error path.
> 
> Patch2, 3 - Added some improved tracing.
> 
> Patch4 - Moves the rendezvous to function entry
> Patch5 - Adds entry rendezvous for IFS.
> 
> Cheers,
> Ashok
> 
> 
> Ashok Raj (4):
>   platform/x86/intel/ifs: Trace on all HT threads when executing a test
>   platform/x86/intel/ifs: Add current batch number to trace output
>   platform/x86/intel/ifs: Replace the exit rendezvous with an entry rendezvous for ARRAY_BIST
>   platform/x86/intel/ifs: Add an entry rendezvous for SAF

Patches 2-5 applied to review-ilpo.

-- 
 i.


