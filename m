Return-Path: <linux-kernel+bounces-117521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B2188AC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E479A30435F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78876129A63;
	Mon, 25 Mar 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y99h71vE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346601292E4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385716; cv=none; b=WALWryJRxubVG97O1nOaxSDXj40Woz1eDQv4sHv4w3HuYazrJQh2QVpEzLHpwPPi/Y7X6eOkoM974tYJyKLQxWzcHcVyhsDbjOvjmgV8hJUoy2imWNYlh469X9ZZpS9UfgQcF96npYSC1/3ta5Fq+JmEQKu6Izsm9L97AOWQKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385716; c=relaxed/simple;
	bh=Yx67Ga5sL8d9XRVjjkCBVm7AaweJymA+Yhv8VHylsEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/vTG7MtIdpfmd1/uoGLHH45DMaCTMu4tTI+yXbbMXyU0mf7zN7lXo/MR3f2RZZ07HvQMs76pdMjXQAhmzZlEOantHtPdgTlxv1qHDQmKdiTHkQcsIhXCfKPma2j3GlAG+V0Zuh33km/WR+BVNS/WyU7ybzjx0BjGyjW3gtoNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y99h71vE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711385715; x=1742921715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Yx67Ga5sL8d9XRVjjkCBVm7AaweJymA+Yhv8VHylsEw=;
  b=Y99h71vEvaURs20s0BhaEQOeFFf+YOXHkIh4cAodPSOigh7LNgxbAG3h
   gJ5LtvQ5DKjhseakkJ7xiHiTKFWPxb89NOaQKEyFk1wxjGhcLd1RNtw/U
   odVB0/2idZvEhuMRaV6DbGtvIb3HkJZeAd7Ju7KZjHGYwZXPXZou3ZbI9
   ts7hta/oLUAeRCeRXh8u+SiSZhEOSGhlJuYHkYnGXag7A3tMP0Df5y0Pp
   7Umtv/9qLGjBPxYfX25r1Qc1JdWffxnfxpQmMEVfeRlORdg9gwl33vUtN
   JeAaZFuA+KvUYkMrxEwfYj4X4+VQws+yIhIFPaiKMHmWSF4MeqAWwEMhz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6611893"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6611893"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="827784760"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="827784760"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 25 Mar 2024 09:54:45 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 25 Mar 2024 18:54:44 +0200
Date: Mon, 25 Mar 2024 18:54:44 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
Message-ID: <ZgGsVBnpme-syWCG@intel.com>
References: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
 <87jzmqjir5.fsf@intel.com>
 <20240227105356.GBZd2_RL9hjC_LupZB@fat_crate.local>
 <87h6hujhrz.fsf@intel.com>
 <20240325163342.GEZgGnZpROSN4euuLb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325163342.GEZgGnZpROSN4euuLb@fat_crate.local>
X-Patchwork-Hint: comment

On Mon, Mar 25, 2024 at 05:33:42PM +0100, Borislav Petkov wrote:
> On Tue, Feb 27, 2024 at 12:58:08PM +0200, Jani Nikula wrote:
> > Let's see what Ville says, but in the end bisection might be the
> > quickest way to find the regression. Though I understand it can be
> > tedious for you personally.
> 
> That still fires with 6.-9-rc1. Does Ville have any suggestions or
> should I bisect?

Sorry, completely missed this. The culprit is going to be
commit 1de63528e728 ("drm/i915: Perform vblank evasion around legacy
cursor updates")

I'll cook up a fix.

-- 
Ville Syrjälä
Intel

