Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217F37F1773
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjKTPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjKTPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:36:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EC1B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700494593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/pq20FpKEDkMWF6mczv+TQIrPVshe9FhaHWZG9axRE=;
        b=UT0Suq6vgmtCr0te54mrpIoHasaln2j4747ht8e3YnspCrL/ncVw8mxdAkei8foQZffE9O
        OzxWp6ctPyrNo8hYNHYqt6QJ/ItdIRG7jW83hYmotfuW9kHRa+8kNVeDlYpZAIlnSPmYCD
        Pjva+IKduTnDmCrQp0FcI2pGzA3VvXc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-A0p4FXBbN_a9gaC5aRQSVQ-1; Mon, 20 Nov 2023 10:36:31 -0500
X-MC-Unique: A0p4FXBbN_a9gaC5aRQSVQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7789577b4e0so532140585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494590; x=1701099390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/pq20FpKEDkMWF6mczv+TQIrPVshe9FhaHWZG9axRE=;
        b=RvgCztuD+rQGfaQdiBjGR2bIrdnAAXzBu7Q+B+hUB+zKnxb1a9Y7EpamhA+hRbjqNY
         skTmr3rR58uzFq8iPwk0jN95OJncN/4wvHzSb26/kchM1dyagOpR3cYwaV9as+qXxDIe
         7cvKhKxb+dWciLla0rYBt5blIXhZUlTu2GhxLqO5GHwpAdOoSpyo2t2GcyEPsMjbcTNv
         X1bLyte85BfgJ9n4BzwsIEN3XKgPA2laI7TC4hq5j4ZdXWso7RHJ57vJWuRGR6E6qfJO
         YE999UBBqi4NPadPLs1bVAbc5aFrgEnfLSno88uwvmQlx7c6HGDaY0TAzwv0u6LYE3v+
         61tg==
X-Gm-Message-State: AOJu0Yw5bOtFvOQ0C82UJ8t3UeCrfFXp7fTBw1vaYpLAsKmxOUGmNYKt
        tR606JeMJf+NomltCstXj7xIPVZWPdz0AghQXM1AdqrB3fW5v2BLheKQWEejT7M7qZH9FZ+tNYT
        f344AHIZQ65tDzMMWJsr06PS2PurY6spq
X-Received: by 2002:ae9:f007:0:b0:779:cf09:2854 with SMTP id l7-20020ae9f007000000b00779cf092854mr7246784qkg.41.1700494590686;
        Mon, 20 Nov 2023 07:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJU92akWFbNdoe8uj5JJanhTdOw2Ezmo4/fkRHH8F2zU4ZoIjdJM6k0l4TH5jql8hCAuabSw==
X-Received: by 2002:ae9:f007:0:b0:779:cf09:2854 with SMTP id l7-20020ae9f007000000b00779cf092854mr7246762qkg.41.1700494590351;
        Mon, 20 Nov 2023 07:36:30 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id dt17-20020a05620a479100b0076c96e571f3sm2749361qkb.26.2023.11.20.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:36:30 -0800 (PST)
Date:   Mon, 20 Nov 2023 09:36:27 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, devicetree@vger.kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
        quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
        quic_sudaraja@quicinc.com, djakov@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
Message-ID: <4q56egm4g6df4wittfddcipsxhvqkffa6ytd7dz4f55godax6p@3gbobpu2mpzx>
References: <20231118042730.2799-1-quic_c_gdjako@quicinc.com>
 <20231118042730.2799-2-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118042730.2799-2-quic_c_gdjako@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 08:27:25PM -0800, Georgi Djakov wrote:
> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
> of the SMMU-500, that consists of a single TCU (Translation Control
> Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
> being described in the generic SMMU DT schema. Add also bindings for

nit for if you respin: s/Add also/Add/ or similar :)

> the TBUs to describe their properties and resources that needs to be
> managed in order to operate them.
> 
> In this DT schema, the TBUs are modelled as child devices of the TCU
> and each of them is described with it's register space, clocks, power
> domains, interconnects etc.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 25 ++++++
>  .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 89 +++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index aa9e1c0895a5..f7f89be5f7a3 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -231,6 +231,18 @@ properties:
>        enabled for any given device.
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^tbu@[0-9a-f]*":
> +    type: object
> +
>  required:
>    - compatible
>    - reg
> @@ -453,6 +465,19 @@ allOf:
>              - description: Voter clock required for HLOS SMMU access
>              - description: Interface clock required for register access
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,smmu-500
> +    then:
> +      patternProperties:
> +        "^tbu@[0-9a-f]*":
> +          $ref: qcom,qsmmuv500-tbu.yaml
> +          unevaluatedProperties: false
> +      properties:
> +        ranges: true
> +
>    # Disallow clocks for all other platforms with specific compatibles
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> new file mode 100644
> index 000000000000..4dc9d0ca33c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/qcom,qsmmuv500-tbu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TBU (Translation Buffer Unit)
> +
> +maintainers:
> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
> +
> +description:
> +  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
> +  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
> +  debug features to trace and trigger debug transactions. There are multiple TBU
> +  instances distributes with each client core.
> +
> +properties:
> +  $nodename:
> +    pattern: "^tbu@[0-9a-f]+$"
> +
> +  compatible:
> +    const: qcom,qsmmuv500-tbu
> +
> +  reg:
> +    items:
> +      - description: Address and size of the TBU's register space.
> +
> +  reg-names:
> +    items:
> +      - const: base
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  qcom,stream-id-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Stream ID range (address and size) that is assigned by the TBU
> +    items:
> +      minItems: 2
> +      maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interconnects
> +  - qcom,stream-id-range
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    apps_smmu: iommu@15000000 {
> +        compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
> +        reg = <0x15000000 0x80000>;
> +        ranges = <0 0 0 0 0xffffffff>;
> +        #iommu-cells = <2>;
> +        #global-interrupts = <1>;
> +        interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        anoc_1_pcie_tbu: tbu@150e1000 {
> +            compatible = "qcom,qsmmuv500-tbu";
> +            reg = <0x0 0x150e1000 0x0 0x1000>;
> +            reg-names = "base";
> +            clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +            interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
> +                             &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +            power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
> +            qcom,stream-id-range = <0x1c00 0x400>;
> +        };
> +    };
> +
> +...
> 

