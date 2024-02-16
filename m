Return-Path: <linux-kernel+bounces-68604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F6857D06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D46DB24520
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08A1292ED;
	Fri, 16 Feb 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8zrdQEl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6F7868D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088406; cv=none; b=QL51fuU36K9V7AAQV1dIu60BxvLW0hfTJA33afhpCIpEPI15yVCgtgD4/IErzZy64TmCIIJ0vzz/DeviudiGgkqglSqGjB2NhTe42Jr+KbpaatF5VBmILuJEJoWO+55ZOO9qTkco4K/f3Fdb8PBCGS7xVLD/aptKmBUK/YxruZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088406; c=relaxed/simple;
	bh=V3FWZW7fon/5hW4D4VPYIT+5GMH0y8BeWvF+fEq3D0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbcSMreBsxpVmM7oV/JIlgDGZf5f85WNJI+y+yfyKcJHolkFPxZ8ynGmU6OL3uRWkmnHzotB4RdPd8cT27yNeQP/r0aYVtyArra9DLeqyWQRmsbQ3PnvKse5Jd1uJsD7etl2PrIh/hpoe8EO8K8ILOUvntyiERkVV8cOxdjGYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8zrdQEl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708088405; x=1739624405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3FWZW7fon/5hW4D4VPYIT+5GMH0y8BeWvF+fEq3D0o=;
  b=a8zrdQEl2QcYe6Sgs0/UKj0AWj1xyHun5mJsbsv+hh1f2mjYY154rDIi
   zuoRWr2x8Ot/H8u7v9pV8wWtiMzLLYGcwwYIcEJm+o1cW4MyPPMxa9FkU
   OG9CjAtdvnRWoc7ZkkLeIyaY+kv/quNKsiFi8l9JeSseju9aqc1G+rhV4
   rsQpvZ+nTBW8PqHBdL5WkYCS9UTlw0i5iOC9lTcsP8fijChhAftTmL8cM
   aHeGUt2S/I2A6yfwN5PvlQjN8a3i4lRuv4dX+adPfQN4Vyw59DsDRp9yU
   K7DVGFjqxqc40ibgRIcjoftW44/lnlG+kSjoyIU2GYyszSAHCnQ22AXuj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="6042003"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="6042003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 05:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="935845521"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="935845521"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2024 04:59:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EB57B524; Fri, 16 Feb 2024 14:59:56 +0200 (EET)
Date: Fri, 16 Feb 2024 14:59:56 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, debug@rivosinc.com, 
	broonie@kernel.org, keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org, 
	peterz@infradead.org, hpa@zytor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] thp: Add thp_get_unmapped_area_vmflags()
Message-ID: <bfvjvaeuan5ojbfleq425lajj4vfgcomgubksqpxlvqdo2g5o3@44nolzrcuea2>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-5-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215231332.1556787-5-rick.p.edgecombe@intel.com>

On Thu, Feb 15, 2024 at 03:13:28PM -0800, Rick Edgecombe wrote:
> +unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
> +		unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +	return thp_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags, 0);
>  }
>  EXPORT_SYMBOL_GPL(thp_get_unmapped_area);

Again, static inline should be fine.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

