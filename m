Return-Path: <linux-kernel+bounces-100950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1223879FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878F21F22832
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF324AED9;
	Tue, 12 Mar 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWJXU5lY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DB50261;
	Tue, 12 Mar 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287906; cv=none; b=iq3AQbQNI5RtUNJmDoRF6t7S/ecjfsKrAzJx7kT0jAk2Or2m3/2YKldY+z3YYB5fa6lBEE8zCGRmAQbFKSFjRGnEKW5lHZ7jygN0K15PSt78FARFIxf/+cFxRXwkVJ8ZxkWUhdanh+s1CmTmvAlb8BiXo9G68s/aBO/x5OrtogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287906; c=relaxed/simple;
	bh=qjWayyyQhCi250zU2Opae+utKD9GihjjAv/L830N2jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYdB6MrT3ohyD1dBlz0II5OtyRjiNqt/xTni5BqljeNxqkF/yMjZmhX18nvGEWZNYHR0vwUeehMtLrTcIIWCcB1C0Q7pRPF/v0uBA8gpVBzm7TVZmWiVTRZ8C3G5ciszUE9SfmB/i+G6cT6hqCSN7HPHvpxiYHHGW5SlUHAzVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWJXU5lY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710287905; x=1741823905;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qjWayyyQhCi250zU2Opae+utKD9GihjjAv/L830N2jU=;
  b=aWJXU5lYanpvQ71dv+cqLCA67RXnr5PPDLDVuEPrm0W+HaX+9jebbaDz
   CPRQxtuViBbO9U6VF15BajtARYGX8tLVkYCnNxlBi54DipMI5ss+Wjjxc
   SZqbNghZOJsEyUem3SxeRgXqj3UdnDuCt8A0MV0ub5uWhPApCJr3OtTDG
   jmMl6U9GDBska5zBdjRBCcUp80GMFLLXVfp44Hhmubw10CGGUXE54Rkji
   NyaqjJ1v/wIEr1x8S8GGvgfT90G4mEk6rjCISHB/rpubhPy/T8H3Hd3rl
   WDe5QIy13ts+a0WWWvwV6a61663qD2ybB/3XV7zfqbyTZvH+4NF29yfus
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8848662"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8848662"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 16:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42717198"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2024 16:58:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id D6244301066; Tue, 12 Mar 2024 16:58:22 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>,  Ian Rogers <irogers@google.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Adrian Hunter <adrian.hunter@intel.com>,  Kan Liang
 <kan.liang@linux.intel.com>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Perry Taylor <perry.taylor@intel.com>,
  Samantha Alt <samantha.alt@intel.com>,  Caleb Biggers
 <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v4 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
In-Reply-To: <20240312234921.812685-2-weilin.wang@intel.com> (weilin wang's
	message of "Tue, 12 Mar 2024 19:49:16 -0400")
References: <20240312234921.812685-1-weilin.wang@intel.com>
	<20240312234921.812685-2-weilin.wang@intel.com>
Date: Tue, 12 Mar 2024 16:58:22 -0700
Message-ID: <87plvzm28x.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

weilin.wang@intel.com writes:
> +
> +			new_event->tpebs_name = strdup(id);
> +			*p = '\0';
> +			name = malloc(strlen(id) + 2);
> +			if (!name)
> +				return -ENOMEM;
> +
> +			at = strchr(id, '@');
> +			if (at != NULL) {
> +				*at = '/';
> +				at = strchr(id, '@');
> +				*at = '/';
> +				strcpy(name, id);
> +				strcat(name, "p");
> +			} else {
> +				strcpy(name, id);
> +				strcat(name, ":p");


This seems like a buffer overflow because :p is 3 bytes including 0,
but you only allocate + 2.
You should really use safe string primitives, then you would have
noticed the truncation.

-Andi

