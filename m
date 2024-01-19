Return-Path: <linux-kernel+bounces-31620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4E833103
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E15AB23B71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BCA58AA3;
	Fri, 19 Jan 2024 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJFzAItI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580FC57884;
	Fri, 19 Jan 2024 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704906; cv=none; b=e91cnW/OynQTXKDN0RSvkKeYHg8NA3SIUQ74bOOa/axw24HPwkwiQuJ0XZaE8VZazbWFgABpnMMJaMB5OCQl5fKUiAQx5o8AfTfMBkv5fKSt4U8plNmMBoziFMLQIBkZKEM16cZWs4YvixyZF+32Lio5S5cQU/ylaIUp3Dwu8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704906; c=relaxed/simple;
	bh=FCIf4jjmsCjm0WrvfocICE7muDXMamDKBfgKtLjKjoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDJlE7UuvY3dQSwif67J2bhfqmSl0MD93CPCvUBYktE2h4E3oMEcOZHTBwzk72hgawOMT/GVAWYFT+eTfhOKXfBNFbX6386o+BkPzHRuugo8gBDudgHmCZdGZGtpc8tpfF81XhjU9a8Mf0zgMx3YzUQIM9c8t1DvFx7Hc8+ufOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJFzAItI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705704904; x=1737240904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FCIf4jjmsCjm0WrvfocICE7muDXMamDKBfgKtLjKjoo=;
  b=YJFzAItI7X9yBUy/NKhHvf13iCjNWMBNUcBdBI8wnoCYYyAZQZ/v9ofl
   +pYhObx2R/WL2n0sisfgIfaPlodtrKLLcfA4QEsMbzb5DYmdYQo5UkHp+
   AczG+E0vRTnBwAU58oVSMYyagYH0w6cjJWGkZ5Vr/uwm/KwSCxd2MYlQ7
   zdtSgRXQpFXjZv315Rukd9yZGazqp64FGIs7AHue5F3IHfyniF+frCoWF
   38PcnLxlZorgVWbBldeFp77kerwykZ/kHMU23/W+KGVGs3hs7JweT5ASa
   HDNQHh/TYoa40Wuftr+yZqpbqh38I0noMFk21Em8VN23nZ291HAh6F3JZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="14383183"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="14383183"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 14:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="683998"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 14:55:03 -0800
Date: Fri, 19 Jan 2024 14:55:01 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ben Gainey <Ben.Gainey@arm.com>
Cc: "irogers@google.com" <irogers@google.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	James Clark <James.Clark@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/1] Support PERF_SAMPLE_READ with inherit_stat
Message-ID: <Zar9xXlPmCM2vtAk@tassilo>
References: <20240119163924.2801678-1-ben.gainey@arm.com>
 <87a5p1kyif.fsf@linux.intel.com>
 <e69ffb457b761763c30e2d63ffd8a38606dbadd3.camel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69ffb457b761763c30e2d63ffd8a38606dbadd3.camel@arm.com>

> I had considered that, but given currently this perf_event_attr
> configuration is not allowed, I assumed that it would require existing
> tools to add support which would in effect be an opt-in. Of course,
> adding a new flag to be explicit would be trivial enough if required.

That's fair. Makes sense.

> That said, the binary format for the mmap records / read() etc does not
> change so using an unmodified tool to parse the data file will give bad
> results. Therefore any workflow where "modified recording tool" can be
> combined with "older / unmodified parsing tool" will break. Not sure of
> the best way to handle this... presumably whenever a change is made to
> the perf record format, any workflow that allows old parsers to read
> new format data without version checks could fail? Admittedly this is a
> "looks the same but isn't" change so harder for tools devs to spot. Any
> suggestions?

For perf itself we can find something. It does a couple of checks, like
reserved bits in the perf_event_attr. For the general case of other
parsers it's unclear. I suppose could increment the magic identifier
to PERFILE3

-Andi

