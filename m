Return-Path: <linux-kernel+bounces-63450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF6B852FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFDA1F2784B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D94376F7;
	Tue, 13 Feb 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVhoF9a/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B4374C1;
	Tue, 13 Feb 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824460; cv=none; b=J/1mL4DLLT0uaA8M2zsZ2AduM6rMGwSVr1kDH05Xa6hxlTD2AjEeGf2vAX/nRWdJqs1UPJ+gfb8s5hdttGkm4aehontu04YJtsDXHIbNKaP61Qt5yExVaUcHe+4+fVRKxLfETjO5NFHFBEJtskG+afr4zbFMNRTSpUV4wYgabjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824460; c=relaxed/simple;
	bh=cAEOJQ0iVAmTq4TMQkM/F2qB7/WnkhIygmoxAcjPA3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i/ERbz3Sp0y9fh5w7qIT4fMzaKXxslNVcz71k8EQuhOjWp/rmS5iJvOVszWz/OhxTAH2zpACFcu/kTDmddypaRVnJGxNyX9dyRAa3L/l6I/UsszBJzEFmbPVHqxoEM2VUNPwflSdFbPezh+zQNxPnLRcznqpYJ5d51YJmRoZTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVhoF9a/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707824459; x=1739360459;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=cAEOJQ0iVAmTq4TMQkM/F2qB7/WnkhIygmoxAcjPA3Y=;
  b=EVhoF9a/lab6/iL//mGKibBfz+e55ifClqX2pFCBgg+zALaVP848x/YN
   0EHbC2wX6IWcNjLaarWvAggA7at6SasU3l2gQfWx/Oaykpt9+S1bpbDBx
   OWYRYC+LlqA/F5tyMT4ADDl+NzICYM9DZct46epbK1sANB9gW0cOfxj/x
   2V+N5vDLFOJoEBUyxTNbLeu6pI29Q54Vj1UKdZi3Kh1My68/SP/f6OZXi
   +MJGwvBsIgEqoDTm0nuGPMtvy+/nLiMs8zTjN3PJCcsRKPurQWCaj55LA
   mRLg3fuJ3Vg5h0jtnwSm/uZGCJMM91S7muLxAcly5wSDq3lCDjlFAAHUb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1948832"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1948832"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="40330058"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.103])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:40:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212185016.5494-1-W_Armin@gmx.de>
References: <20240212185016.5494-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2] platform/x86: wmi: Make input buffer madatory when
 evaulating methods
Message-Id: <170782445006.2452.5996713889135628313.b4-ty@linux.intel.com>
Date: Tue, 13 Feb 2024 13:40:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Mon, 12 Feb 2024 19:50:16 +0100, Armin Wolf wrote:

> The ACPI-WMI specification declares in the section "ACPI Control Method
> Naming Conventions and Functionality for Windows 2000 Instrumentation"
> that a WMxx control method takes 3 arguments: instance, method id and
> argument buffer.
> This is also the case even when the underlying WMI method does not
> have any input arguments.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: wmi: Make input buffer madatory when evaulating methods
      commit: 5b559e8ab01c8d7a92478f8143ba844161292203

--
 i.


