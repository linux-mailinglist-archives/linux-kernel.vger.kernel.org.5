Return-Path: <linux-kernel+bounces-30524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFF831FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575E51F22A90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C752E632;
	Thu, 18 Jan 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mP15p4j2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D72D047;
	Thu, 18 Jan 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607393; cv=none; b=r7tpzH2kn+JozTJf4UlCdnqQWW7e+8r01+ocGXyxQunZnr7gthpYPRRGLEbpswk1FW+R1vpLJcMc/dG0JyM4yI6fFnDx6fM1j8bh63VXkoxBGC9E5eYiB2BfGdqlUN4wlEzvrCKBRUNQ8psLx8rFYmKzXhCYiOyQxsYIN8quhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607393; c=relaxed/simple;
	bh=qC7rVu4d4X6CFOL5AfnpNvtfarjj5/gjD7TRFQSpuqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWxnZcN4Km/QK9PM8AgTgRPvLE4GkRfcPi/cOcDDo7rJTx3DlOov4FBxz+7RXCshnuH/UAAYnUfFXIc8i7R7BOIhWEeh+dIXxfEgME9P5OO4nCvptSQrJAk7hHnMKQkqyOyblOUi61Rf3IQccxWWs/O6f+LRsHhaHHf84v0hdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mP15p4j2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705607391; x=1737143391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qC7rVu4d4X6CFOL5AfnpNvtfarjj5/gjD7TRFQSpuqI=;
  b=mP15p4j2rhz/xpSZhnUMkrbfISTwDTHPsBbVPnq+t6Ku2w7xERJ2RxCi
   s6kkECT6d5VEJdEvNiY1dYtY4j2TfeO29iCYLM32xFGI6+SbEEeIynilw
   1KaMqYPF7nxtg20QcDfUkBUU05iTKb2o0uB3iMJtN+iouhnXEeVsa9ngr
   YNoL/w9j6wR08iUDevYtQLrWOql+Zw5GFZlU36EN8/HJz+RecxrginNGS
   kb2vREGLcHVP/sDqdumAe4XxU84mefOiVlfW5yvVcF3Sm2XwjUVmRT+Ug
   IPPPoS9k72QAFCrrdc0kGGmws/FMF3kIqSsdPS/O9PYcxFgIcIZ7u+7uC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7247319"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="7247319"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 11:49:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="411148"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.39.77])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 11:49:47 -0800
Message-ID: <5766b575-e2db-4a56-9808-31a64bc72402@intel.com>
Date: Thu, 18 Jan 2024 21:49:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] perf: script: add field 'insn_disam' to display
 mnemonic instructions
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
References: <20240118041224.2799393-1-changbin.du@huawei.com>
 <20240118041224.2799393-4-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240118041224.2799393-4-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/01/24 06:12, Changbin Du wrote:
> In addition to the 'insn' field, this adds a new field 'insn_disam' to
> display mnemonic instructions instead of the raw code.

'disam' seems an unusual abbreviation, and the 'insn' part seems a bit
redundant.  Could this be just 'disasm' instead of 'insn_disam'?

