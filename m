Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35BC80A3C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573740AbjLHMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjLHMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:47:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B8BE1997;
        Fri,  8 Dec 2023 04:47:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DE6D1063;
        Fri,  8 Dec 2023 04:47:54 -0800 (PST)
Received: from bogus (unknown [10.57.42.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4BCE3F762;
        Fri,  8 Dec 2023 04:47:04 -0800 (PST)
Date:   Fri, 8 Dec 2023 12:45:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <20231208124503.unhka7c6ihzrrwhu@bogus>
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-2-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111014933.1934562-2-davidai@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 05:49:29PM -0800, David Dai wrote:
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
>  .../cpufreq/qemu,cpufreq-virtual.yaml         | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
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

Are these register controls described somewhere ? The reason I ask is we
should be able to have single implementation of this virtual cpufreq
irrespective of the firmware used(DT vs ACPI) IMO.

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
>

I think using OPP with absolute frequencies seems not appropriate here.
Why can't these fetched from the registers and have some abstract values
instead ?

> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      cpufreq@1040000 {
> +        compatible = "qemu,virtual-cpufreq";
> +        reg = <0x1040000 0x10>;

So just 16bytes for 2 CPU system ? How does the register layout look like ?
I assume just 4 x 32bit registers: 2 for reading and 2 for setting the
frequencies ?

--
Regards,
Sudeep
