Return-Path: <linux-kernel+bounces-33104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4CE836494
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA01F24A60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28F3D0A9;
	Mon, 22 Jan 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oj/oztOT"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094D3D386;
	Mon, 22 Jan 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930907; cv=none; b=rkOssgSeW9jNxMYtWvm2FQj4vvugO2AMTciYhUu/tPkxPoI2w2soan9iuo4llhpjU0ZGQ+gwi0JuUPQto8og5epN5LiP4lr9C+r+SedVCr9UTchebYZ0fhAXSjaY2NF0MIlMu0vVwRs/wLVnMzm9fBDU6RnJIziVCJB5F0buDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930907; c=relaxed/simple;
	bh=AsuLOZLavbor6sjRqmZR5gb66ksuaGhNQsXZjpeKpX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpbYi3qQ5YzzyRG/hqi0rUjuSXlSnj5Kq7VtnI2CAQz7XavTEtaY1wKw9E7BDgwGC6T2/S1OZbiWrX7lnGC3E8DbpQaw+7aVt/aJuoNF9wZatumaxM74Z3rxlx9AtKFXxjEf3fkJMiKFjKQ9ctbwEFOfB8dnellF17AEsI7QBQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oj/oztOT; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705930906; x=1737466906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AsuLOZLavbor6sjRqmZR5gb66ksuaGhNQsXZjpeKpX4=;
  b=Oj/oztOTipz8e1QC/knPLDOWThC2qgwBTh4KqdGhMF/twDmrCLBWkdIN
   I4cwNu+yKVaMwlTjt1ewdXYqy2HGgT9mjvUq8c8hdutBUSEK4lOWMGZx1
   lwly5Is81od6cNZSlzLswTaYq2aneDaN0OnqzimwbrekAhi5eotu3egNf
   VNf5V/WG7aEK6QpuZL4aVTPpX/PR/cBgIHel6A7hhi3/xb3FFUU1UgHYR
   jAcc/7JAVW5K2cNBe717WhdULcJ1mXK/8cKVLwhcgqU3vxNog3qKexijt
   oIUOswLk7ExKgIZ41fdHzobru8tGhF8Tb9avJAXZbxPM0E48vXczEwgbA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="400856591"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="400856591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 05:41:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="19989404"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 05:41:44 -0800
Date: Mon, 22 Jan 2024 05:41:42 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Changbin Du <changbin.du@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4 3/5] perf: script: add field 'disasm' to display
 mnemonic instructions
Message-ID: <Za5wluB2NckwNF0S@tassilo>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-4-changbin.du@huawei.com>
 <e840bd05-a9e0-4463-8597-b67c7627809b@intel.com>
 <20240120074009.zmywqj6irtedivqk@M910t>
 <e8e5ea25-326b-4565-b0e8-1583b09dba65@intel.com>
 <20240122104646.oqa7jnmd6ed2dzdw@M910t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122104646.oqa7jnmd6ed2dzdw@M910t>

> > >>
> > > Updated as:
> > > 
> > > 	When doing instruction trace decoding, insn, disasm and insnlen give the
> > > 	instruction bytes, disassembled instructions and the instruction length
> > > 	of the current instruction respectively.
> > 
> > I wondered about mentioning that disasm needs perf to be compiled with
> > disassembler support, but with a permissive license it seems likely
> > that libcapstone support would generally be built into perf, so that
> > should be fine.
> > 
> Yes, libcapstone has a permissive license. It's available on most Linux distros.

What I've seen in the past is that people who build perf from source
often miss installing all the build the dependencies because perf continues
without an error. Make sure that if that happens and someone uses the option
there is a clear message that points to the build process.

-Andi

