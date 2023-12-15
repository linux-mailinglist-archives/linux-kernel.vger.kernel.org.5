Return-Path: <linux-kernel+bounces-1497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DA1814F65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BF81C20490
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FD30121;
	Fri, 15 Dec 2023 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7jBICLH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEA47F43;
	Fri, 15 Dec 2023 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702663167; x=1734199167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zY5lsj0RdaD+POtkmhf7nc2oTysOFdihQoh7/DfRjSk=;
  b=J7jBICLHXhzHgVJ9/8nyEHbU+zaBZvOjrbeLb/vDZJ7a7Emt7iPtEqcs
   BORoJQHd1WvY3RVuUvAhJOGgp8nDhoxN5WIKSLiEx9rdNHvm+kaL9ksYp
   2X+lebtvDkPAaMvJwz19g6UFaoNm125Qo9jfaVnikGRtmipke7UIxjeUm
   X4arjRsIRb03J5iWRGaomo2qJ3HFKopBvdNFGXN5UreHFfyK78RudkVbS
   K/IG7teebAb3p1X6MycQCpUDYovI2boWLHkSTnRN9gVYhUNmHgWIknhQz
   iK2XD1fLqnWk2c1JWO2ergTtmtG732D14JBnfQOG7ozolSOQxbVf5WPSu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="426437676"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="426437676"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:59:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="845201088"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="845201088"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:59:25 -0800
Received: from [10.209.148.184] (kliang2-mobl1.ccr.corp.intel.com [10.209.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 04AB1580DAA;
	Fri, 15 Dec 2023 09:59:23 -0800 (PST)
Message-ID: <4658ca16-9749-434e-9296-3893aa2a34da@linux.intel.com>
Date: Fri, 15 Dec 2023 12:59:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <ZXxyanyZgWBTOnoK@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZXxyanyZgWBTOnoK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023-12-15 10:36 a.m., Arnaldo Carvalho de Melo wrote:
> Kan, I also noticed that the name of the event is:
> 
> 1K cpu_atom/cycles:P/                                                   
>                                                                         
>                                               ◆
> 11K cpu_core/cycles:P/
> 
> If I try to use that on the command line:
> 
> root@number:~# perf top -e cpu_atom/cycles:P/
> event syntax error: 'cpu_atom/cycles:P/'
>                               \___ Bad event or PMU
> 
> Unable to find PMU or event on a PMU of 'cpu_atom'
> 
> Initial error:
> event syntax error: 'cpu_atom/cycles:P/'
>                               \___ unknown term 'cycles:P' for pmu 
> 'cpu_atom'
> 
> valid terms: 
> event,pc,edge,offcore_rsp,ldlat,inv,umask,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
> Run
>  'perf list' for a list of valid events
> 
>  Usage: perf top [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list 
> available events
> root@number:~#
> 
> It should be:
> 
>   "cpu_atom/cycles/P"

The issue also impacts the perf record and report as well.

#perf record true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (16 samples) ]

#perf report --header-only | grep event
# event : name = cpu_atom/cycles:P/, , id = { 7360, 7361, 7362, 7363,
7364, 7365, 7366, 7367, 7368, 7369 }, type = 0 (PERF_TYPE_HARDWARE),
size = 136, config = 0xa00000000, { sample_period, sample_freq } = 3000,
sample_type = IP|TID|TIME|PERIOD|IDENTIFIER, read_format = ID|LOST,
disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3,
sample_id_all = 1
# event : name = cpu_core/cycles:P/, , id = { 7370, 7371, 7372, 7373,
7374, 7375, 7376, 7377, 7378, 7379, 7380, 7381 }, type = 0
(PERF_TYPE_HARDWARE), size = 136, config = 0x400000000, { sample_period,
sample_freq } = 3000, sample_type = IP|TID|TIME|PERIOD|IDENTIFIER,
read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1,
enable_on_exec = 1, precise_ip = 3, sample_id_all = 1

I think we should move all the modifiers after the "/". The below patch
can fix it.

https://lore.kernel.org/lkml/20231215175455.1300261-1-kan.liang@linux.intel.com/

Thanks,
Kan

