Return-Path: <linux-kernel+bounces-8716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBBB81BB62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB262811B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF855E47;
	Thu, 21 Dec 2023 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnHjE07U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AEF53A1D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C32DC433C9;
	Thu, 21 Dec 2023 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703174140;
	bh=oYeU6vuYtU1xXqhDf4oLE8y9AeEh1sjx1Oz8lnC92vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mnHjE07UhFwc1hEL4I5XEOg7CsoeSyJveoyJZMzxO2vop/iaZvDtejcVqxhqQ7qQG
	 R1yDpgSBLVtz+Fz7Mgfzwzkn9qIEoGy0Xwrcj4qbRAgykP0v4dZxZ6lfk7lBlyOrzJ
	 C/Swfws8TeaOWJ5qiOB6eHcB1/Cu3P8MFUs6VNr5d03x50BvM/wxY3Imj+UYfeAtiD
	 FCKO9sN7DZq2EEpgHj015kRSdDB4PoIAbQw9Vb3pJJGoZobisBwGqDztuxhVqFfisG
	 dY/7Vmj1h/dAARIi4V2oycBQ24VshUH8Q3josZz9l0A/Ef6BT+B0L2saEKBzHoA2nO
	 Jf1XPqpG/Phiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B1233403EF; Thu, 21 Dec 2023 12:55:37 -0300 (-03)
Date: Thu, 21 Dec 2023 12:55:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: kajoljain <kjain@linux.ibm.com>,
	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf vendor events: Remove UTF-8 characters from cmn.json
Message-ID: <ZYRf-ZYIifg8InFJ@kernel.org>
References: <1703138593-50486-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1703138593-50486-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 21, 2023 at 02:03:13PM +0800, Jing Zhang escreveu:
> cmn.json contains UTF-8 characters in brief description which
> could break the perf build on some distros.
> 
> Fix this issue by removing the UTF-8 characters from cmn.json.
> 
> without the fix:
> $find tools/perf/pmu-events/ -name "*.json" | xargs file -i | grep -v us-ascii
> tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json:                   application/json; charset=utf-8
> 
> with the fix:
> $file -i tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json: text/plain; charset=us-ascii

Thanks, applied!

- Arnaldo
 
> Fixes: 0b4de7bdf46c5215 ("perf jevents: Add support for Arm CMN PMU aliasing")
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.com>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> index 428605c..5ec157c 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
> @@ -107,7 +107,7 @@
>  		"EventName": "hnf_qos_hh_retry",
>  		"EventidCode": "0xe",
>  		"NodeType": "0x5",
> -		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN‑F.",
> +		"BriefDescription": "Counts number of times a HighHigh priority request is protocolretried at the HN-F.",
>  		"Unit": "arm_cmn",
>  		"Compat": "(434|436|43c|43a).*"
>  	},
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo

