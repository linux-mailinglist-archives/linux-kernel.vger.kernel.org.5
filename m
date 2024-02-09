Return-Path: <linux-kernel+bounces-59859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87984FCA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E71F28E00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5A486AC5;
	Fri,  9 Feb 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dou+h7Xa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960384A3F;
	Fri,  9 Feb 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505569; cv=none; b=jqsBduOePoAbT1HQt/+kFB822UhG4OkDEb9uRikrGWF8MMRxQ9g5kG1XgqLlkLVrpgG+/ulXzqhOaQfNEgTrNRLmh5c5sFpEtToF94vyCZZiUVb/rqtBW/bLSkc50ebEIVX9QZqS+3KoHrKpPI7jvapPn47eIq8Wq/g6yG3Ak7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505569; c=relaxed/simple;
	bh=bIcHkUcTe01Z5+BZ75l+ELTY5lq3c2PvPuqRwnGgQCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVa3vadgQZ4mXrioGhm/4R88GeaAOLSg19DYuGkWgN1Xm9nwh6nwzoPv0rWmoNv5OtpY5bs9iwyj3xVF/ho090gqNkFciqssBN4FgwxpMVfO0HNXWBSIW7PucV85J2lUbfB70u08U4zPSTjoT091JrBXwmKKvNW/ezwQfk1puFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dou+h7Xa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707505567; x=1739041567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bIcHkUcTe01Z5+BZ75l+ELTY5lq3c2PvPuqRwnGgQCE=;
  b=Dou+h7XaUfVq85I8jvsINrBxFTjTtn3dBxHZ9UtmYu6ZUODOvXgiK5Ag
   7845lbCm/pJTuq9l5RUQZuP/34xICs9d5QmE1zk6wjSQ+fvB0rcdDNy1k
   EvgSealaP9zhE7DYvD7UwqCnOa4RyjK/IwRIyXCLIuwfzcHm5F8sMYfbJ
   oZy4kJmXc9G02teg0r1gNwPQEXc/PKaYbOikzQ6PjwmwpmsrRZsbmoiA8
   7ypyMCrXxkCIXx21b0CrYnxwKQVZjDyaq2cVx8v9uHIyzJPNRs3Cg7dA4
   Se+xWq+bcqA1rR5UfdrXeVVsx9jT4ThW59khtcZGIGnzbuN1OY1USAy2y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1392489"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1392489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6661661"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:06:05 -0800
Date: Fri, 9 Feb 2024 11:06:05 -0800
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
Subject: Re: [PATCH v15-RFC 4/8] x86/resctrl: Add helper function to look up
 domain_id from scope
Message-ID: <ZcZ3nVgWPpPBi1QA@agluck-desk3>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-5-tony.luck@intel.com>
 <ef4b6a21-a477-42f0-950c-246b5cc48f47@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef4b6a21-a477-42f0-950c-246b5cc48f47@amd.com>

On Fri, Feb 09, 2024 at 09:28:52AM -0600, Moger, Babu wrote:
> > +	if (id < 0) {
> > +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> > +			     cpu, r->scope, r->name);
> 
> Will it be good to move pr_warn_once inside get_domain_id_from_scope
> instead of repeating during every call?

Yes. Will move from here to get_domain_id_from_scope().

> > +	if (id < 0) {
> > +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> > +			     cpu, r->scope, r->name);
> 
> Same comment as above. Will it be good to move pr_warn_once inside
> get_domain_id_from_scope ?

Moved this one too.

Thanks

-Tony

