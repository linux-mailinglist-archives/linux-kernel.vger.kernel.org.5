Return-Path: <linux-kernel+bounces-829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F18146C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86141C23133
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2DD24B50;
	Fri, 15 Dec 2023 11:24:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3D524A03;
	Fri, 15 Dec 2023 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04A98C15;
	Fri, 15 Dec 2023 03:25:05 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401273F738;
	Fri, 15 Dec 2023 03:24:17 -0800 (PST)
Message-ID: <f3b32f5f-edd4-e8ba-ae8f-e84ea698cc64@arm.com>
Date: Fri, 15 Dec 2023 11:24:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 8/8] coresight-tpdm: Add msr register support for CMB
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-9-git-send-email-quic_taozha@quicinc.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <1700533494-19276-9-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/11/2023 02:24, Tao Zhang wrote:
> Add the nodes for CMB subunit MSR(mux select register) support.
> CMB MSRs(mux select registers) is to separate mux,arbitration,
> ,interleaving,data packing control from stream filtering control.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../testing/sysfs-bus-coresight-devices-tpdm  |  8 ++
>  drivers/hwtracing/coresight/coresight-tpdm.c  | 86 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h  | 16 +++-
>  3 files changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index e0b77107be13..914f3fd81525 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -249,3 +249,11 @@ Description:
>  		Accepts only one of the 2 values -  0 or 1.
>  		0 : Disable the timestamp of all trace packets.
>  		1 : Enable the timestamp of all trace packets.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_msr/msr[0:31]
> +Date:		September 2023
> +KernelVersion	6.7

This probably needs bumping now. Maybe 6.9?

