Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD47B66A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjJCKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjJCKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:44:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E9CAAC;
        Tue,  3 Oct 2023 03:44:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C27DDC15;
        Tue,  3 Oct 2023 03:44:46 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69413F5A1;
        Tue,  3 Oct 2023 03:44:06 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:44:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: arm: Add new compatible for smc/hvc
 transport for SCMI
Message-ID: <20231003104404.o7yxg3y7dn7uhrq4@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-4-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911194359.27547-4-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:43:58PM -0700, Nikunj Kela wrote:
> Introduce compatible "qcom,scmi-hvc-shmem" for SCMI smc/hvc
> transport channel for Qualcomm virtual platforms.
> The compatible mandates a shared memory channel.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 8d54ea768d38..4090240f45b1 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -45,6 +45,9 @@ properties:
>        - description: SCMI compliant firmware with OP-TEE transport
>          items:
>            - const: linaro,scmi-optee
> +      - description: SCMI compliant firmware with Qualcomm hvc/shmem transport
> +        items:
> +          - const: qcom,scmi-hvc-shmem

Can it be simply "qcom,scmi-smc" for 2 reasons ?
1. We don't support SMC/HVC without shmem, so what is your argument to add
   '-shmem' in the compatible here ?
2. The exact conduit(SMC/HVC) used is detected runtime, so I prefer to keep
  '-smc' instead of '-hvc' in the compatible just to avoid giving an illusion
  that HVC is the conduit chosen here based on the compatible. It can be true
  for other reason but I don't want to mislead here by using HVC.
>
>    interrupts:
>      description:
> @@ -320,6 +323,15 @@ allOf:
>        required:
>          - linaro,optee-channel-id
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,scmi-hvc-shmem
> +    then:
> +      required:
> +        - shmem
> +
>  examples:
>    - |
>      firmware {
> -- 
> 2.17.1
> 

-- 
Regards,
Sudeep
