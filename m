Return-Path: <linux-kernel+bounces-59868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729984FCC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AD71C22D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430282866;
	Fri,  9 Feb 2024 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbcER6GM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB07F48F;
	Fri,  9 Feb 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506628; cv=none; b=VQ1b4r8Cso1NXgOXu2hl+b8WOKbPeI6VcETqujGYZbnWH/+0LbzHBzjdUqGxE9yaRku/aQ/PD/CzD+pRJveZMpPV4gCqRb4p1SjFJUZ+s1ki+i4/xnek4/STFcpBVKKwhkpFotXwovkgXukYzTEdh+vF8vzjFHtpVgsiOb8PXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506628; c=relaxed/simple;
	bh=WC9tRxWrrOmUk1nUbdcPHKUUN+d2WwGkjgKMha0qJoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G53OOqAcvYiS4lr8EBxgU+yvUWLLTRtbVTvUUMKTrNin9fiTgJZAnNWPZwcgUOpQaV9niszv9hpeWHZhFMHQ1bzoXG4kxheA8p2MEagPtNHMUAfski5ABxIhcD0dtM1ncQXmEVYEIFFCNaX+j83m0xykldCYw5BswZKuabBcv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbcER6GM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707506627; x=1739042627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WC9tRxWrrOmUk1nUbdcPHKUUN+d2WwGkjgKMha0qJoc=;
  b=ZbcER6GMB12IJCFECEDP+DhN/nfiRdaaVJQX2YYIErrhjiaoDfeJ7xhc
   3MioLNIrUx/MwHL+qK2gut8YGs9a4DgPCadutjG3OQGypuriLh8NoVnmv
   vrXGnJRfxt3+JRlA5BEOuggfIzqV0hEcr3d5wr3GtN8KaId58qDQNFluy
   pCMSIyspRDPwyBTCIp1g/kIpYN1/urAD9Q+xD7mWZLHF1c3oXsmYczMGL
   BoqXVfPfIVD/2JJh38l4Fs8EbrbGaIRdZN6e07Mr4mx3789J5cS0tACLE
   AoEtOYXNxiuxx8EeamleGwuZR1r84lnmk0XPEwX+P7JLuTFPZ09+I6/bm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1395672"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1395672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="39452963"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:23:46 -0800
Date: Fri, 9 Feb 2024 11:23:44 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v15-RFC 5/8] x86/resctrl: Add "NODE" as an option for
 resource scope
Message-ID: <ZcZ7wEUzESxUhs-y@agluck-desk3>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-6-tony.luck@intel.com>
 <6628954f-c7e9-4040-9f03-7b5b6a6d082d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6628954f-c7e9-4040-9f03-7b5b6a6d082d@amd.com>

On Fri, Feb 09, 2024 at 09:29:03AM -0600, Moger, Babu wrote:
> Hi Tony,
> 
> This patch probably needs to be merged with with patch 7.

If it just added RESCTRL_NODE to the enum and the switch() I'd
agree (as patch 7 is where RESCTRL_NODE first used). But this
patch also adds the sanity checks on scope where it has to be
a cache level.

Patch 7 is already on the big side (119 lines added to core.c).

If you really think this series needs to cut back the
number of patches, I could move the sanity check pieces
from here to patch 3 (where the enum is introduced) and
just the RESCTRL_NODE bits to patch 7.

-Tony

