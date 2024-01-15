Return-Path: <linux-kernel+bounces-26257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F682DD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C65D1F229E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72E17BBE;
	Mon, 15 Jan 2024 16:28:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4120E3;
	Mon, 15 Jan 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01582F4;
	Mon, 15 Jan 2024 08:29:04 -0800 (PST)
Received: from [10.57.8.58] (unknown [10.57.8.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CE913F5A1;
	Mon, 15 Jan 2024 08:28:15 -0800 (PST)
Message-ID: <f2e94d3b-bf2e-492f-a72d-f7978125d7d4@arm.com>
Date: Mon, 15 Jan 2024 16:28:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>,
 Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pavan Kondeti <quic_pkondeti@quicinc.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
 kernel-team@android.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-2-davidai@google.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231111014933.1934562-2-davidai@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2023 01:49, David Dai wrote:
> Adding bindings to represent a virtual cpufreq device.
> 
> Virtual machines may expose MMIO regions for a virtual cpufreq device
> for guests to read frequency information or to request frequency
> selection. The virtual cpufreq device has an individual controller for
> each frequency domain.
> 
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---
>   .../cpufreq/qemu,cpufreq-virtual.yaml         | 99 +++++++++++++++++++
>   1 file changed, 99 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
> new file mode 100644
> index 000000000000..16606cf1fd1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/qemu,cpufreq-virtual.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtual CPUFreq
> +
> +maintainers:
> +  - David Dai <davidai@google.com>
> +  - Saravana Kannan <saravanak@google.com>
> +
> +description:
> +  Virtual CPUFreq is a virtualized driver in guest kernels that sends frequency
> +  selection of its vCPUs as a hint to the host through MMIO regions. Each vCPU
> +  is associated with a frequency domain which can be shared with other vCPUs.
> +  Each frequency domain has its own set of registers for frequency controls.
> +
> +properties:
> +  compatible:
> +    const: qemu,virtual-cpufreq
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Address and size of region containing frequency controls for each of the
> +      frequency domains. Regions for each frequency domain is placed
> +      contiugously and contain registers for controlling DVFS(Dynamic Frequency
> +      and Voltage) characteristics. The size of the region is proportional to
> +      total number of frequency domains.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // This example shows a two CPU configuration with a frequency domain
> +    // for each CPU.
> +    cpus {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cpu@0 {
> +        compatible = "arm,armv8";
> +        device_type = "cpu";
> +        reg = <0x0>;
> +        operating-points-v2 = <&opp_table0>;
> +      };
> +
> +      cpu@1 {
> +        compatible = "arm,armv8";
> +        device_type = "cpu";
> +        reg = <0x0>;
> +        operating-points-v2 = <&opp_table1>;
> +      };
> +    };
> +
> +    opp_table0: opp-table-0 {
> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp1098000000 {
> +        opp-hz = /bits/ 64 <1098000000>;
> +        opp-level = <1>;
> +      };
> +
> +      opp1197000000 {
> +        opp-hz = /bits/ 64 <1197000000>;
> +        opp-level = <2>;
> +      };
> +    };
> +
> +    opp_table1: opp-table-1 {
> +      compatible = "operating-points-v2";
> +      opp-shared;
> +
> +      opp1106000000 {
> +        opp-hz = /bits/ 64 <1106000000>;
> +        opp-level = <1>;
> +      };
> +
> +      opp1277000000 {
> +        opp-hz = /bits/ 64 <1277000000>;
> +        opp-level = <2>;
> +      };
> +    };

NIT: If my understanding is correct, it might be worth re-iterating that 
these OPPs should mirror the host frequency domain this vCPU is pinned to.

Also, since VM migration has been mentioned elsewhere in this thread, am 
I right in saying that you can't change these OPPs after registration? 
So, even if one wants to migrate, one has to migrate to an SoC with the 
same frequency domains anyway, otherwise the OPPs in the VM are entirely 
bogus?

> +
> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      cpufreq@1040000 {
> +        compatible = "qemu,virtual-cpufreq";
> +        reg = <0x1040000 0x10>;
> +      };
> +    };

