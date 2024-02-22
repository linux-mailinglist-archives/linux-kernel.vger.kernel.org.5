Return-Path: <linux-kernel+bounces-76508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A485F819
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD0C1F25280
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA39060BA4;
	Thu, 22 Feb 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxjsYAIP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B72BB1B;
	Thu, 22 Feb 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604687; cv=none; b=aZ1ubA5i+q4JC/vNgpKfWMvsalJErXS+5oYUbLrfH6EDTGVNsSM/lannvOYsBEv7qEEnRKAjRrreMhee8vcr1T78clJtJdHnCE+/w8rjB1HCl7fKGnlsDtA30od6pS9AuBDlsXL3YB29DhtsdfRVWMETzK8qABRzLCQyj3fmElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604687; c=relaxed/simple;
	bh=vepoCvUA87NndiRWHPhBF1/XeR6TA9jZpkQrmwbjNUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erLHIVhOOD8msiT/s+bWX/+RWZ4oNfCMeFdUGEssWjZKPUJH9nHkvHuMLEq8yfTOk8JwFIklsoJouhDAqJacNpROhWPUwjQJi92u4Ps3wBHSJjuZiiUlw2ZQ5PMHCuzpv5EYUx6d2gBLvsedx6gAhsoi7jVYrbepxzuSdViGefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxjsYAIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72B5C433C7;
	Thu, 22 Feb 2024 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604686;
	bh=vepoCvUA87NndiRWHPhBF1/XeR6TA9jZpkQrmwbjNUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxjsYAIPU0mncAH7vf7kcWpQARm8xbPVWHRkKQqPfZ3aujv4lELoWzaa/Wo9KXyc8
	 g+dlCFRr9WSdoulAVmAb3VYjUVmDU10iRtdRT3GjulsF2J8FJRGdXcFGJONp5WA6iN
	 03Zxb91VTkWK2KFjpEdxxaohbUWzZD5OygXgwt1evDdGRsi523YqCRspx4Xzb33/+q
	 Hk1qrKY1AmFEkipAgn6xZ3lnkgyKx4Zc+MeYcfy9hylgZQ90uvg1xtUyFV89I5iG/g
	 z2tQDcrBw2wUiE7/WoGATr/LL18XqyzDHCciq3ySsPXiKeygxbO4ulfkltG5fmgFwp
	 FBe53I2NoMv3g==
Date: Thu, 22 Feb 2024 12:24:38 +0000
From: Will Deacon <will@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, linux-imx@nxp.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 5/6] perf: imx_perf: limit counter ID from user space
 and optimize counter usage
Message-ID: <20240222122438.GD8308@willie-the-truck>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-5-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055811.3035741-5-xu.yang_2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 01:58:10PM +0800, Xu Yang wrote:
> The user can pass any counter ID to perf app. However, current pmu driver
> doesn't judge the validity of the counter ID. This will add necessary
> check for counter ID from user space. Besides, this pmu has 10 counters
> except cycle counter which can be used to count reference events and
> counter specific evnets. This will also add supports to auto allocate
> counter if the user doesn't pass it the perf. Then, the usage of counter
> will be optimized.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - limit counter ID from user to 0-10
>  - combine dynamic and static allocation of counter
> Changes in v3:
>  - no changes
> Changes in v4:
>  - rename ddr_perf_is_specific_event()
>  - use macro definitions to parse config attr
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 72 +++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 94041f06c152..e71496809c52 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -51,6 +51,7 @@
>  
>  #define NUM_COUNTERS		11
>  #define CYCLES_COUNTER		0
> +#define CYCLES_EVENT_ID		0
>  
>  #define CONFIG_EVENT_MASK	0x00FF
>  #define CONFIG_EVENT_OFFSET	0
> @@ -240,6 +241,19 @@ static struct attribute *ddr_perf_events_attrs[] = {
>  	NULL,
>  };
>  
> +/*
> + * An event is either reference evnet or counter specific event.
> + * For counter specific event, the event count will only be incremented
> + * on the corresponding counter.
> + */
> +static bool ddr_perf_is_counter_specific_event(int event)
> +{
> +	if (event >= 64 && event <= 73)
> +		return true;
> +	else
> +		return false;

Just collapse this to 'return event >= 64 && event <= 73;'

Will

