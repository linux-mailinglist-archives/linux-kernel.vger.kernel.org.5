Return-Path: <linux-kernel+bounces-86543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3EB86C6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2895D1C21224
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88B651B3;
	Thu, 29 Feb 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyQi1zYZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7F64A8A;
	Thu, 29 Feb 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202354; cv=none; b=XuDVt9NAIjo3YMaRmI45eihXHraapkew2UrtjziDWtI9vkE6XRoa9Rk8UbJtVaPsOhli06HTewEmXV8s/dJ+RLf7mBrAfM2E5YUfbXLT8Em5az3vQRv2yypFZXX+VDV1IOdPMdgXCVfQs8WmMqSn41XSNe/i4m/HqMGIAX3DsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202354; c=relaxed/simple;
	bh=BZOzxkLaNwJzyuWMx5kdxPnNkLL7LABOOFE1Vzr+SB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JFFGpM0PEURtldhjh3+1B36GeMr8mX3o0Z3nYJMts+xJq4T0jjsZcA0eluSnMnpvYetbXb+MfyoL2zZwNO2MYURJAz+PzLfctKtI5/2XOTY5u58f1EPfdp5h1aWoMTlDpWx+//KKvznTo0RZUvGEn9X2fBlEdgGc+G+dAib1azQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyQi1zYZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709202353; x=1740738353;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BZOzxkLaNwJzyuWMx5kdxPnNkLL7LABOOFE1Vzr+SB4=;
  b=iyQi1zYZ42f43Ljn2az1KeblEJTEekiREoJE3zWqfInP1FySP7MQRlTJ
   qOXAnSd55kxvvnBp19T9c2T0njxYkI8dIKAO98U/TMmozsOx6/LILGJ0K
   EMXhZV+tg/Rl6tJWFD8zpA+6C2AiV9Ox60PEk2IvEBW6/c2/g95Oj8iOk
   tjRkU2jLUk4l0P6t3IHp15bXr10Lt4YqlSbSEv3iyyF+IUgg9N4xslF3y
   C8vfTQIDdKt+wI2QZHlWwApbP48vEY1iQzbkJh70h4w3VPNu5+r242Ufc
   isRRiO/4ouzRWmFsjxahYSFnhr3ly82B0IdHMcucWzwIxhfUyzcXDB7kw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3786392"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3786392"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="30961090"
Received: from smatua-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.143])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:25:49 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 0/3] docs: submit-checklist: structure by category
In-Reply-To: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
Date: Thu, 29 Feb 2024 12:25:46 +0200
Message-ID: <87plwf8t3p.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 29 Feb 2024, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> from Jani Nikula:
>   - turn categories into subheadings
>   - use common heading adornment
>   - change to bullet or autonumbered lists
>   - propose those changes as separate additional patches

I was hoping these cleanups would've come *first*, but up to Jon to
decide if that really matters.

BR,
Jani.


-- 
Jani Nikula, Intel

