Return-Path: <linux-kernel+bounces-89152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCE86EB43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D812828CDA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C75823B;
	Fri,  1 Mar 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MADJW/jh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BC5810A;
	Fri,  1 Mar 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328845; cv=none; b=iEJT9BTIxGNPLMojCFuM7764u/4GjbNxdiH0PEZIcNePPeak1bBgFllty8kofxMNnLh362f6DtEH2nNG3GvGS1GNRdSkPleVwV1t42C30Y/bd1I/yOaLhL5hjkiDR2+3N1v4JG6Xger0A6b+0KaZl+KZ6TDdt7hcuOldqX8ZPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328845; c=relaxed/simple;
	bh=fmzH+mIOkDmds9+eATlKSe8d+juA8+VlJyocy1nJWyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krkW/kPsAxBJlZ2/IwMioC48aqDiL384vNRZ+dIMC7lbAyH16ErRijjx+dzbz/8tzy+7LrwzIDStfb2vqdR4dFcBLRk1XjtSwTDGU8MhHfY27TMdvpNf0wKfq/qClbn8nMoO9wKDeO0F5S7566uY7BVvvlELlFczTigqWcVqp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MADJW/jh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709328843; x=1740864843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmzH+mIOkDmds9+eATlKSe8d+juA8+VlJyocy1nJWyA=;
  b=MADJW/jh6Sgjh7ljNQvFzvS5VY8hu4p1WAZUGE4TLTZApHC3859P17Gz
   PWrIGV89EjAqk9QP9B1RqdxRS2zQp7qY6FPqjTTxPymPqrIcyMmO5Q2Rt
   Q2AalUTE/QqCJ891ogLZZ1XSCtmdRSNrKI6sIJnTvf8HR2heX1b3Pi3qE
   zvzR8BvTI/bzMDXvV45273wYd8nQsiIB0FP6PXTWbAHA6rY1DZTqaGFEd
   ydTVqJDI6cQ5hqpzUhahNCjojp1k7qQAL+2Ajf0/ZqG/GgabE+g7K1ARc
   3sSncHITGifd6ggHCPgWypeXtPFwJNeusNgT207E/DMq6GnOww6kNMYUz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3751066"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3751066"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 13:34:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8459173"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 13:34:02 -0800
Date: Fri, 1 Mar 2024 13:34:00 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 02/20] perf jevents: Add idle metric for Intel models
Message-ID: <ZeJJyCmXO9GxpDiF@tassilo>
References: <20240229001806.4158429-1-irogers@google.com>
 <20240229001806.4158429-3-irogers@google.com>
 <ZeIVQhfDMP7_bSJ8@tassilo>
 <CAP-5=fWpXHXd8Dd39o_KEcVaBkQKk=aXjYSVTWCitaY6Xm-T4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWpXHXd8Dd39o_KEcVaBkQKk=aXjYSVTWCitaY6Xm-T4A@mail.gmail.com>

> 
> I see some of the gains as:
>  - metrics that are human intelligible,
>  - metrics for models that are no longer being updated,
>  - removing copy-paste of metrics like tsx and smi across each model's
> metric json (less lines-of-code),
>  - validation of events in a metric expression being in the event json
> for a model,
>  - removal of forward porting metrics to a new model if the event
> names of the new model line up with those of previous,
>  - in this patch kit there are metrics added that don't currently
> exist (more metrics should be better for users - yes there can always
> be bugs).

But then we have two ways to do things, and we already have a lot 
of problems with regressions from complexity and a growing
bug backlog that nobody fixes. 

Multiple ways to do basic operations seems just a recipe for
more and more fragmentation and similar problems.

The JSON format is certainly not perfect and has its share 
of issues, but at least it's a standard now that is supported
by many vendors and creating new standards just because
you don't like some minor aspects doesn't seem like 
a good approach. I'm sure the next person will come around
why wants Ruby metrics and the third would prefer to write
them in Rust. Who knows where it will stop.

Also in my experience this python stuff is unreliable because
half the people who build perf forget to install the python
libraries. Json at least works always.

Incrementional improvements are usually the way to do these
things.

-Andi

