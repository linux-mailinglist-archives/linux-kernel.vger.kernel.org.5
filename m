Return-Path: <linux-kernel+bounces-154097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06758AD75D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D8A1F22A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26621105;
	Mon, 22 Apr 2024 22:40:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F167625;
	Mon, 22 Apr 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825618; cv=none; b=UFh3BFaTjilzQE9qbjCxRq0TAOSSCy/VH5bhhRXCpAR+8aA1NM0Q75aKeym1HjAP9cZcG2tWW18882/PYJGa/l/DwVUl63mTDRhCAPRH9YGKES4huFpKLBjNNXCUTESxemles82f+U5TrA7+R2rFVgw9qJ7WSp19BtRp8cuegi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825618; c=relaxed/simple;
	bh=YYWQ72Ji1mlYlNcfWfkUgczygjka+1APIsmWDrb2QZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQn9igh81PocHHyzcISPx2fNw1atWnT1ZEkXCxINA4pxo6un3kQj+E6+rQF5UbHbGK4Qz03YIIpOxFfDTbUx7nefy4x2sJoLWkNkw2Ou+aXPLHz1K7r8/nbPtjT4j4QU2NNc7OTvC2IJPj9mqIcpqm8YbB0uwRCJzQ3uZRAZA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F569339;
	Mon, 22 Apr 2024 15:40:42 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ABA13F7BD;
	Mon, 22 Apr 2024 15:40:12 -0700 (PDT)
Date: Mon, 22 Apr 2024 23:39:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 kernel test robot <lkp@intel.com>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sun50i: Fix build warning around snprint()
Message-ID: <20240422233958.0e2d992c@minigeek.lan>
In-Reply-To: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
References: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 09:01:09 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

Hi,

> The Sun50i driver generates a warning with W=1:
> 
> warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
> 
> Fix it by allocating a big enough array to print an integer.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404191715.LDwMm2gP-lkp@intel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

For the records: as it stands right now, "speed" will always be smaller
than 10 at the moment, but it's indeed better to play safe here.
So the fix makes sense to me and fixes the issue:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 30e5c337611c..cd50cea16a87 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -19,8 +19,6 @@
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  
> -#define MAX_NAME_LEN	7
> -
>  #define NVMEM_MASK	0x7
>  #define NVMEM_SHIFT	5
>  
> @@ -208,7 +206,7 @@ static int sun50i_cpufreq_get_efuse(void)
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  {
>  	int *opp_tokens;
> -	char name[MAX_NAME_LEN];
> +	char name[] = "speedXXXXXXXXXXX"; /* Integers can take 11 chars max */
>  	unsigned int cpu, supported_hw;
>  	struct dev_pm_opp_config config = {};
>  	int speed;
> @@ -235,7 +233,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  		config.supported_hw_count = 1;
>  	}
>  
> -	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> +	snprintf(name, sizeof(name), "speed%d", speed);
>  	config.prop_name = name;
>  
>  	for_each_possible_cpu(cpu) {


