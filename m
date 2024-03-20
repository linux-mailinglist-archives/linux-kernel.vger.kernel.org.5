Return-Path: <linux-kernel+bounces-108264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E4880882
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B20F1C2262B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD298749F;
	Wed, 20 Mar 2024 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUf3Yv0M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DD747F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894151; cv=none; b=gmjgYljaL8Wy/VQ0+pNTc4CSBIAXUDD1A5RmqeGR+ZtiPREAW1HJuGH6kqq5NQGL4DN1BljZLKuKjjMmhbjzagHK/B5FALMECnjhprtklQUd1SEyK2ZifHqdQlEO2EXtN27kMzXsBZQeX66JpePKiE+ddCL+fYZrRZEzsNzr53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894151; c=relaxed/simple;
	bh=OQ2zoF0NkLdYuN00535nmlIn30QQ6dlbSE3CedNUijE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy+G6pl9YADgr5DBI37w46oNkZFHYSr0oE8f7399zv6MVqykqbikDWDGHHHODFO8guTI40CJLWOl57AhDvjedhEPz4YDYokhkT8WrzxPHz5Mi6LE+ekAaLutRNu0AuuIDd4E32iwFjZro9VMnbV5bcttxUekvqTm/53/WDEhlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUf3Yv0M; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710894150; x=1742430150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OQ2zoF0NkLdYuN00535nmlIn30QQ6dlbSE3CedNUijE=;
  b=jUf3Yv0M5KlCVpXSDLCqfW146ReRt4ln3SMSbR+fnX7SqB6ysd0rczYn
   IPL1AM3vtEpLJrsUKTpraC/oyQCVLpWdg4U2RBjPWVNXp/Izu/b1v3bi2
   wAiOICOlNdgq1Usxyjq/FP0smz93BOEw64CdRPztpiT0YkGlDGQx2g1Nw
   jYfYMSTNXjI0ht62QJCEDVeLYX9dI7c9bUiJcg8hMx6cHYW4ot0kxNGS9
   cCBEhMOv3iQ3hIVWd4Ja9aVwv1laumCeUyumFpL+HNNFVKPG0PTDY5UNT
   2DhfHVH5RHkkk8vOHZ8xkwBlvO2HJg9nAfThLVTle1S04i9h0SLxDFMyN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17202674"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="17202674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="937062666"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="937062666"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2024 17:22:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8F63F7F1; Wed, 20 Mar 2024 02:22:25 +0200 (EET)
Date: Wed, 20 Mar 2024 02:22:25 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, 
	bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, 
	peterz@infradead.org, thomas.lendacky@amd.com
Subject: Re: [PATCH] x86/coco: Update comment of CC_ATTR_GUEST_MEM_ENCRYPT to
 include TDX guest
Message-ID: <yeccimxym65c7c7pwwwyvednydhj54dbrcpa6nqobc27kud32u@rgivuknucjus>
References: <20240319213729.81708-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319213729.81708-1-kai.huang@intel.com>

On Tue, Mar 19, 2024 at 09:37:29PM +0000, Kai Huang wrote:
> TDX guest also reports CC_ATTR_GUEST_STATE_ENCRYPT as true, but the
> comment of this attribute does not reflect this.
> 
> Update the comment to reflect the fact.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Acked-by: Kiriil A. Shutemov <kirill.shutemov@linux.intel.com>

Alternatively, we can just drop all these "Examples include ...". The same
info can easily can be derived from code.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

