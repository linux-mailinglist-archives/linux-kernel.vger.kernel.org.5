Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C275906A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGSIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGSIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:36:59 -0400
X-Greylist: delayed 3655 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 01:36:50 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D34FC199D;
        Wed, 19 Jul 2023 01:36:49 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 8635A140782;
        Wed, 19 Jul 2023 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1689755808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=szebvr8rm/LIv+nRzDJ1uLoC1Kd+I0dsTf9m8x2UGQw=;
        b=mYCe+wgRSoslw8AKoMKMQyzO2rAt4huTsmSeBr63QzwhwNN1PSx0Fxo+2ks+3gG5Bu4vYr
        SAOBRqGO76eMcjdyp3UasMzzDEB0kt7saxp5LSJ4Vss4LgqU3gxFg7bz4QcXS4MmAX0nsk
        w4d0RfKFhpG6wtjFEJ2d34neyhx5eV4=
Message-ID: <b8cc0229-d663-3527-b320-51a48b4af5b5@postmarketos.org>
Date:   Wed, 19 Jul 2023 11:36:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm630: remove refs to nonexistent
 clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230719073520.2644966-1-alexeymin@postmarketos.org>
 <9e38d2f5-6da4-089e-1c70-a89069708909@linaro.org>
Content-Language: en-US
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <9e38d2f5-6da4-089e-1c70-a89069708909@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2023 10:39, Krzysztof Kozlowski wrote:
> On 19/07/2023 09:35, Alexey Minnekhanov wrote:
>> Since commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
>> interconnect bus clocks") rpmcc-sdm660 no longer provides
>> RPM_SMD_AGGR2_NOC_CLK and RPM_SMD_AGGR2_NOC_A_CLK clocks.
>> Remove them to fix various probe failures and get devices
>> booting again.
> 
> So that commit broke DTS?
> 

Yes, this is my understanding of the situation.
The commit in subject [1] is only in linux-next for a few days, so it 
broke booting only on 6.5-rc (rc2 currently). Konrad said: "these clocks 
references were API abuses; referencing the bus clocks was circumventing 
the interconnect layer. That loophole is now gone and the abusers are 
now apparent"

> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check`
> 

If DT schema for interconnect requires bus clocks to be specified, I 
don't even know what to put there now. Can we change schema?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d6edc31f3a68d8d0636e0cfcd9eced7460ad32f4

-- 
Regards,
Alexey Minnekhanov
postmarketOS developer
