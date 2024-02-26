Return-Path: <linux-kernel+bounces-81408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D98867593
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78E91C23862
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CC380024;
	Mon, 26 Feb 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6O8T0N9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAB73162;
	Mon, 26 Feb 2024 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951722; cv=none; b=h8ZGGM0uMOmH19Iw6u6rfi9TYWZlacZ13v3BC8LtwXx8IO0G4WhIYBu3WpJiERcMWrTbyS3siUkknAdu8h8qHgiqbWDkIFY/sOPmbnUZpB1SC+hVuLKolFS6yCQdDe0hHISNPSaIUT6fmU8rB6Y5P57QvTPhEl2JJmYchtXOX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951722; c=relaxed/simple;
	bh=KJYqGiy9A+wukcKRPI63mollMcq0daEoFtYsTGBRUzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBvLu0VSIhoRW4t6Dx02+E/wEoRR99XMdav5SBEyZKPnvB2/wmDN5cod4GZAqOSAvDWTQfjbyclKt7MYDL5HO3FkFRTdrpsZ9jXmrTKqAPGGWGUNho2fH8YXs8bXzYU7ItQTUI+AwNudZ+gUeXlqE7kcrEKsJAKZry3hHeN/nH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6O8T0N9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708951721; x=1740487721;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KJYqGiy9A+wukcKRPI63mollMcq0daEoFtYsTGBRUzM=;
  b=N6O8T0N9ntBG7/9HCeoowQwjZtvd+5r3/Dfey0kKHbiFNkz72DrOS9kT
   y3jhjcjKW7DKY77F1zEg7T7TWxjAw9izq2AQNAmwlN7sJEseqjmE1NW/q
   oWyzVLd6RFtdpxk0aUY2jtIUkmpgPH/baJ+pvLPSQOyumrZCxjFsQHqv5
   wG2TM9mNKGnhtmnjHLAJvi47XsuN3dT7OQZweTG+hKyimaPSpVaNZABmo
   Ucko1TuwC8uf5QSxQbDOEWmGyBtsgLCoQxSa6Z/UHeWet3XHJWoOMb5n3
   nMfVlM9XdYCAIGotR7RIB4T5W7U3z5NUnCZGsAkO7QP0/y7jingpsAThp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3780103"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3780103"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 04:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6647948"
Received: from hibeid-mobl.amr.corp.intel.com (HELO localhost) ([10.252.46.254])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 04:48:37 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] docs: submit-checklist: structure by category
In-Reply-To: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
Date: Mon, 26 Feb 2024 14:48:36 +0200
Message-ID: <87o7c3mlwb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 26 Feb 2024, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
> index b1bc2d37bd0a..7d8dba942fe8 100644
> --- a/Documentation/process/submit-checklist.rst
> +++ b/Documentation/process/submit-checklist.rst
> @@ -11,110 +11,121 @@ These are all above and beyond the documentation that is provided in
>  and elsewhere regarding submitting Linux kernel patches.
>  
>  
> +*Review your code:*

If you're adding subheadings, maybe consider making them actual
subheadings instead of just italicizing them.

The top heading should probably be modified to follow the guidelines in
Documentation/doc-guide/sphinx.rst. This should be a separate change.

> +
>  1) If you use a facility then #include the file that defines/declares
>     that facility.  Don't depend on other header files pulling in ones
>     that you use.
>  
> -2) Builds cleanly:
> +2) Check your patch for general style as detailed in
> +   :ref:`Documentation/process/coding-style.rst <codingstyle>`.
>  
> -  a) with applicable or modified ``CONFIG`` options ``=y``, ``=m``, and
> -     ``=n``.  No ``gcc`` warnings/errors, no linker warnings/errors.
> +3) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
> +   comment in the source code that explains the logic of what they are doing
> +   and why.

I think we should just remove all the manually updated bullet
numbering. Either make them bulleted lists with "*" or autonumbered
lists with "#.". See [1]. This should be a separate change.

BR,
Jani.


[1] https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#lists-and-quote-like-blocks


-- 
Jani Nikula, Intel

