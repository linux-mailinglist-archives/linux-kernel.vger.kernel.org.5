Return-Path: <linux-kernel+bounces-31504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDB3832F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3F3B229A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA953E05;
	Fri, 19 Jan 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNuW1dmK"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A45466C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690097; cv=none; b=VnAoDUzweb2HBb24NW6DR1io9BrFnKg4TggL2yAR5X25WtTYrBAWvp6FE3uyaQF96F+LXfJrA+aj/nzjKGIK/08GpvLp8xGj6lIKomCmvcKJ//i5dDiU/v3W2IM0gIoXWUJ5yeb9h8sYrmrfA8nX3T9mydYP9QZG1uMYc+3IJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690097; c=relaxed/simple;
	bh=XbeNDItrlEZaR8vvIWca8FAYWCvy8z5P9degCxsFhgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmtmM9iY+KvUx3GfM0iBjJ6rBAGyEz57sELxzZnMF7E27C/COUzrWpIHlqF4PMieWTJ2hJMkhU9WhoAJ6+WwEPp0J1bj1LP+SJbz+PubgecxwdFxYBpyrQnSKlqf959AxjeT6xfn+4vdB1phuEl4o1B5Ps3z0lG9FopWHGaz5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNuW1dmK; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705690096; x=1737226096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XbeNDItrlEZaR8vvIWca8FAYWCvy8z5P9degCxsFhgA=;
  b=jNuW1dmKAGx7FS94MfnR6srDqfuJgFyJY49K/+n6DbYiP7M52o87Z7fC
   SH1JdZcIo1MLijYT0VO3NG8YQsk9oAUCrX/kxqsNRN2ULb6acLp4uDBek
   epJQfqT49d1ZF/wytQXBEnPbmFkQn7BRE8mNhImTXXlfIpZAkdboRGFJj
   feEeZGVv1mbnKmrbkJR6GCkfvV0+Qq7NvXAFsbqMRngcmN1wQ8fAwtGbB
   tAoCda6bI+HOvuFUi2My5x2amL/CJBKMqS1I1EUENjLZElJhmec4JaOln
   et5UG+VV+Dg2wVDjFBopePxm3D7hocAQYFDQwr22cHX5QgO2PgBtxQZ9t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="391251940"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="391251940"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="734674"
Received: from guptapa-mobl1.amr.corp.intel.com (HELO windy) ([10.125.112.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:48:15 -0800
Date: Fri, 19 Jan 2024 07:36:09 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: kirill.shutemov@linux.intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com, rick.p.edgecombe@intel.com,
	sohil.mehta@intel.com, alexander.shishkin@intel.com
Subject: Re: [PATCH] x86/lam: Disable ADDRESS_MASKING in most cases
Message-ID: <20240119153609.hijuaoqu7wcptyh2@windy>
References: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
 <20240119045828.xcypcr32cpovqptg@box.shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119045828.xcypcr32cpovqptg@box.shutemov.name>

On Fri, Jan 19, 2024 at 07:58:28AM +0300, kirill.shutemov@linux.intel.com wrote:
> On Thu, Jan 18, 2024 at 06:35:47PM -0800, Pawan Gupta wrote:
> > Intel feature Linear Address Masking (LAM) has a weakness related to
> > transient execution as described in the SLAM paper[1]. Unless Linear
> > Address Space Separation (LASS) is enabled this weakness may be
> > exploitable.
> > 
> > Until kernel adds support for LASS[2], only allow LAM for COMPILE_TEST,
> > or when speculation mitigations have been disabled at compile time,
> > otherwise keep LAM disabled.
> > 
> 
> It worth adding that there's no HW on market that supports LAM, so nobody
> affected by the issue.

Right.

> > [1] SLAM: https://download.vusec.net/papers/slam_sp24.pdf
> > [2] LASS: https://lore.kernel.org/lkml/20230609183632.48706-1-alexander.shishkin@linux.intel.com/
> > 
> > Cc: stable@vger.kernel.org # v6.4+
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks.

