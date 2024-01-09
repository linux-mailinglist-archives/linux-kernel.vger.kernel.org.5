Return-Path: <linux-kernel+bounces-20712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3468283E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F52287A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB9A364A9;
	Tue,  9 Jan 2024 10:22:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E119364A3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41BAFC15;
	Tue,  9 Jan 2024 02:23:04 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211BC3F73F;
	Tue,  9 Jan 2024 02:22:16 -0800 (PST)
Message-ID: <1dcfd28c-78d8-4790-8c99-27e15989ca40@arm.com>
Date: Tue, 9 Jan 2024 10:22:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] coresight: Move all sysfs code to sysfs file
Content-Language: en-US
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org
Cc: Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231212155407.1429121-1-james.clark@arm.com>
 <20231212155407.1429121-7-james.clark@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231212155407.1429121-7-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2023 15:54, James Clark wrote:
> At the moment the core file contains both sysfs functionality and
> core functionality, while the Perf mode is in a separate file in
> coresight-etm-perf.c
> 
> Many of the functions have ambiguous names like
> coresight_enable_source() which actually only work in relation to the
> sysfs mode. To avoid further confusion, move everything that isn't core
> functionality into the sysfs file and append  _sysfs to the ambiguous
> functions.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

The changes look good to me. One minor comment below.

..

> +struct device_type coresight_dev_type[] = {
> +	{
> +		.name = "sink",
> +		.groups = coresight_sink_groups,
> +	},
> +	{
> +		.name = "link",
> +	},
> +	{
> +		.name = "linksink",
> +		.groups = coresight_sink_groups,
> +	},
> +	{
> +		.name = "source",
> +		.groups = coresight_source_groups,
> +	},
> +	{
> +		.name = "helper",
> +	}
> +};
> +/* Ensure the enum matches the names and groups */
> +static_assert(ARRAY_SIZE(coresight_dev_type) == CORESIGHT_DEV_TYPE_MAX);

As a general cleanup, while you are at it, could we please replace this 
with explicit member initialisers as a follow up patch ?

i.e.,

struct device_typ coresight_dev_type[CORESIGHT_DEV_TYPE_MAX] = {
	[CORESIGHT_DEV_TYPE_SINK] = {
			.name = "sink",
			.groups = coresight_sink_groups,
	},
	[CORESIGHT_DEV_TYPE_LINK] =
..

}

Thanks
Suzuki

