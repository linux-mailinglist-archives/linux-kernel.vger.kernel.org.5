Return-Path: <linux-kernel+bounces-36826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482DA83A76A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E0828868F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76591AAD7;
	Wed, 24 Jan 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfnGWgUR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D42BAE2;
	Wed, 24 Jan 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094133; cv=none; b=OOKrF4hnLsXex6h/1o660+oDN4A31ShRvLgPaepF9keF9eHP7Ml3gBD6OZk09G3bfjAKWUjTPSAgX6PTmfli+04UunngCwdXVVdu+WZRumknimgtVxJ+T5/fNd56LhNLTndms2vmharJyxK/dSjyNytvwLuVpPLzmPRdweHDFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094133; c=relaxed/simple;
	bh=/DEfx/ggTlSTK4fsO2AMargKWkKOetex3+rtGaqvoN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mHh0GAy7s6nSPLM4GE5k0EkMjO6npy53Ld8PmCOvjw5tx2Tzrl65OxmclsRjQMc5wG7lcQaUMkrxTPpysq++sQcvyN2N6cPikkvSwhLQwvFLJu+0re7wXM0FMSp1VRW+AKugG7oZM4Oy48BX5vRFM8IfSIibXkKu6X85U+s5S1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfnGWgUR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706094132; x=1737630132;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=/DEfx/ggTlSTK4fsO2AMargKWkKOetex3+rtGaqvoN0=;
  b=bfnGWgURe8ygCS2Us9gERHQuYG4WBRV8E410GI1GXBbe7HvCPF4y2SUV
   y9u3Xx71d4oKru54HyjERFtAa2oA1TOGk1HYIBRzgga5ffpncNdCI9SV7
   ynf4zTx8xBhxNTMBKVpXoxqlCDgGi1HPoLv/RdXhwq0tz8sYuj/zmIuA6
   x7GqPj1cp2Rexw+qXlQ+awIBAwaYIkuDA+she/AaXjbcItinohvO9ROnL
   bjiUJHvYkISfuLROO9qxjinBNqpdBsqyKa3UupODhqSGI3J/8uYjbcUt9
   dMxCqxpspi5XbE2DAGpc0nJYNk7R3wktM70tiGsgg9jNHxwfQ3ChkK4e9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8464452"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8464452"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="786382012"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="786382012"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:02:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Hans de Goede <hdegoede@redhat.com>, ibm-acpi-devel@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240106154740.55202-1-colin.i.king@gmail.com>
References: <20240106154740.55202-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] platform/x86: thinkpad_acpi: remove redundant
 assignment to variable i
Message-Id: <170609412156.14220.14891875070775431708.b4-ty@linux.intel.com>
Date: Wed, 24 Jan 2024 13:02:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Sat, 06 Jan 2024 15:47:40 +0000, Colin Ian King wrote:

> The variable i is being initialized with the value 0 that is never
> read, it is being re-assigned 0 again in a for-loop statement later
> on. The initialization is redundant and can be removed.
> 
> The initialization of variable n can also be deferred after the
> sanity check on pointer n and the declaration of all the int variables
> can be combined as a final code clear-up.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: remove redundant assignment to variable i
      commit: 214509e5d61d294193b220f397418e76879f74c0

--
 i.


