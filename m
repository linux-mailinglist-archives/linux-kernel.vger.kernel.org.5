Return-Path: <linux-kernel+bounces-83265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7A98690FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA50B216BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF913A275;
	Tue, 27 Feb 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJdNs6LS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51413AA20;
	Tue, 27 Feb 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038435; cv=none; b=QeHOzdM6k8P1Q1vDQ74wYfySuxhcViOxFup1GrynS+6L7ilTSFPX86isMyWAMy7B2PU1T5ZB+DUyr6sLlsVq3wK/d1yOTk59ft+56m2taNiMsuLKwGRMFv/6vxEG6KiQ40hQwswTSga056a0fRT/tb5+Ri5fXzA+/hW342kRUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038435; c=relaxed/simple;
	bh=9fNjD41K3hBKyAANYYkPJsBtf97N81Pzxj9XAun8H0c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AH+8r23DdoW2D8RsTnhRaqjE7mwiPnyg23g4fxuifgOmraRxPsQmVBnTkjy6kzW7+oeAyxahYf0v/L8SQpn7Eia6x75D/rnX7dniOXpT+ncmgGluaQ6ZDpOy2Af6o6fNivykcNlrG01BrUnNmx/CmKLeRy4eOahzE1LofV82cHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJdNs6LS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709038434; x=1740574434;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9fNjD41K3hBKyAANYYkPJsBtf97N81Pzxj9XAun8H0c=;
  b=NJdNs6LSyxdrGtfVAqw+kGNs/cF4528uxnUxY4CnzCZyG9mEcRmZD8wq
   zKR8gOb/bwnaf5p/Swi0hyDWySd3+G3IYcvCaflwYcTHop+ema3Eh2rDf
   1btxf7P6w1j1AMKvZ7dg2nuAPZjbk/YF78+Av5fUGHKCneudJkxcrjQrb
   EYDEqNBzGtmzxtH4EFA/cU2cr5HKMhF+aWG9nauneluQ/ophXmpLiSIAU
   7gUOLfxTeQquGutfHwZYrwyxsZgQDXuRMi0PhcQUGyuxPyPpHDY3btHXj
   HEoEcEYw6v1lphxFN7D3zk49fUKxi5uoJMHW2atuF+W6ZWGy7m85yYePx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6323974"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6323974"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:53:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11801003"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:53:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 14:53:47 +0200 (EET)
To: Szilard Fabian <szfabian@bluemarch.art>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    jwoithe@just42.net, Hans de Goede <hdegoede@redhat.com>, W_Armin@gmx.de
Subject: Re: [PATCH v5] platform/x86/fujitsu-laptop: Add battery charge
 control support
In-Reply-To: <20240227120435.429687-2-szfabian@bluemarch.art>
Message-ID: <b797d581-a2a7-b95c-4853-b874667c1df5@linux.intel.com>
References: <20240129163502.161409-2-szfabian@bluemarch.art> <20240129175714.164326-2-szfabian@bluemarch.art> <20240207023031.56805-2-szfabian@bluemarch.art> <20240215203012.228758-2-szfabian@bluemarch.art> <20240227120435.429687-2-szfabian@bluemarch.art>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Feb 2024, Szilard Fabian wrote:

> This patch adds battery charge control support on Fujitsu notebooks
> via the S006 method of the FUJ02E3 ACPI device. With this method it's
> possible to set charge_control_end_threshold between 50 and 100%.
> 
> Tested on Lifebook E5411 and Lifebook U728. Sadly I can't test this
> patch on a dual battery one, but I didn't find any clue about
> independent battery charge control on dual battery Fujitsu notebooks
> either. And by that I mean checking the DSDT table of various Lifebook
> notebooks and reverse engineering FUJ02E3.dll.
> 
> Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
> ---
> v5:
> * add ACPI_BATTERY dependency into Kconfig

Thanks. My intention was that you'd send a new patch on top of what is 
already applied. But it doesn't matter anymore, I took the relevant line 
out of it and squashed it into the original commit.


-- 
 i.


