Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D827D5E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjJXWgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbjJXWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:36:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF5CB10DE;
        Tue, 24 Oct 2023 15:26:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C5FB2F4;
        Tue, 24 Oct 2023 15:27:07 -0700 (PDT)
Received: from [10.57.5.249] (unknown [10.57.5.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22CAF3F762;
        Tue, 24 Oct 2023 15:26:23 -0700 (PDT)
Message-ID: <56bbb2ad-5cea-46ad-83be-d6d7fd9bbfde@arm.com>
Date:   Tue, 24 Oct 2023 23:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
To:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        will@kernel.org, joro@8bytes.org, devicetree@vger.kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com,
        quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
        djakov@kernel.org
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-2-quic_c_gdjako@quicinc.com>
 <20231024184248.GA252155-robh@kernel.org>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231024184248.GA252155-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-24 19:42, Rob Herring wrote:
> On Wed, Oct 18, 2023 at 07:19:18PM -0700, Georgi Djakov wrote:
>> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
>> of the ARM SMMU-500, that consists of a single TCU (Translation Control
>> Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
>> being described in the ARM SMMU DT schema. Add also bindings for the
>> TBUs so that we can describe their properties.
> 
> Arm SMMU-500 is an implementation, too. Is QCom's a modified
> implementation or you are just the first to want to control TBU
> resources?

It's very very modified. The stock MMU-500 has very few 
microarchitectural registers[1], they all live within the regular SMMU 
address space, are all Secure-only by default, and don't do anything 
like the shenanigans here.

That said, looking at patch #3, I don't really understand why we need 
any of this stuff upstream... AFAICS it's doing an insane amount of work 
to use complicated imp-def debug functionality to duplicate things that 
the main driver can already do far more efficiently. Sure, in general it 
seems like it could potentially be useful stuff for bringing up and 
debugging a new driver, but the Linux SMMUv2 driver is mature and 
frankly already closer to being obsolete than to being new...

[ digression since I can't be bothered to split this discussion by 
replying separately to patch #3: ]

I mean, just looking at qsmmuv500_iova_to_phys(), you do realise that 
that's going to be called potentially multiple times by iommu-dma for 
*every* dma_sync and dma_unmap call and really wants to be fast, right? 
This brings to mind all the work I did a couple of years back[2] because 
strict TLB invalidation on unmap was considered too slow for certain 
devices on QCom platforms by ChromeOS, yet what this achieves looks like 
it could easily be up to an order of magnitude slower again :(

> You need to split this into what could be any SMMU-500 implementation
> and what is truly QCom specific (i.e. modified). Unlike some licensed IP
> that's a free-for-all on DT resources, Arm IP has public specs so we
> don't have to guess.
> 
>> In this DT schema, the TBUs are modelled as a child devices of the TCU
>> and each of them is described with it's own resources such as clocks,
>> power domains, interconnects etc.
>>
>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>> ---
>>   .../devicetree/bindings/iommu/arm,smmu.yaml   | 13 ++++
>>   .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 67 +++++++++++++++++++
>>   2 files changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index cf29ab10501c..afc323b4bbc5 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -230,6 +230,19 @@ properties:
>>         enabled for any given device.
>>       $ref: /schemas/types.yaml#/definitions/phandle
>>   
>> +  '#address-cells':
>> +    const: 2
>> +
>> +  '#size-cells':
>> +    const: 2
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^tbu@[0-9a-f]+$":
>> +    $ref: qcom,qsmmuv500-tbu.yaml
> 
> Generic SMMU binding includes something QCom specific. That's not right.
> 
> 
>> +    description: The SMMU may include Translation Buffer Units (TBU) as subnodes
>> +
>>   required:
>>     - compatible
>>     - reg
>> diff --git a/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
>> new file mode 100644
>> index 000000000000..4baba7397e90
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iommu/qcom,qsmmuv500-tbu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm TBU (Translation Buffer Unit)
>> +
>> +maintainers:
>> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
>> +
>> +description:
>> +  TBU nodes represent Translation Buffer Units in an ARM SMMU. Each TBU node
>> +  should be a child node of the SMMU in the device tree.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qsmmuv500-tbu
>> +
>> +  reg:
>> +    items:
>> +      - description: Address and size of the TBU's register space.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: base
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interconnects:
>> +    maxItems: 1

What does this interconnect represent? MMU-500 TBUs don't access memory 
themselves[3], they only have an internal AXI Stream interface to the 
TCU to request translations.

Thanks,
Robin.

[1] 
https://developer.arm.com/documentation/ddi0517/f/programmers-model/memory-model
[2] 
https://lore.kernel.org/all/d652966348c78457c38bf18daf369272a4ebc2c9.1628682049.git.robin.murphy@arm.com/
[3] Yeah yeah, other than the special case of TBU0 issuing pagetable 
walks on behalf of the TCU when it's not configured with its own 
dedicated PTW interface, I know :P

>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  qcom,stream-id-range:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: Stream ID range (address and size) that is assigned by the TBU
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interconnects
>> +  - qcom,stream-id-range
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +
>> +    tbu@150e1000 {
>> +        compatible = "qcom,qsmmuv500-tbu";
>> +        reg = <0x150e1000 0x1000>;
>> +        reg-names = "base";
>> +        clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
>> +        power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
>> +        interconnects = <&system_noc MASTER_GNOC_SNOC 0 &config_noc SLAVE_IMEM_CFG 0>;
>> +        qcom,stream-id-range = <0x1c00 0x400>;
>> +    };
>> +
>> +...
