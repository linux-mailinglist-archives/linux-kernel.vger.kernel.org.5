Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA967DCB20
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbjJaKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjJaKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:48:20 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF541E6;
        Tue, 31 Oct 2023 03:48:17 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C881E4055E;
        Tue, 31 Oct 2023 15:48:14 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698749294; bh=Mkhz0SblRAMbcKfkHKYfn8ake4BUqbVzbi0S7Q0czu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6/qD/SBZZrjFgFEk40CRRYUmbDXV2jbdG+qypw+PWJ5bJBXyLXu/guSEMne0zgX8
         9oNE3DL+mP1+xu1mJGjD3l6c7pu1JgfffTC6jyURpVHFtzAEY7YasvzIooBIWhneBt
         mE76zKxrFlk4ONk1D/eKgpEk2k5aNpmp5XVV36SHehwX5Ixlg/C4foia4RYvdJVh9l
         0ZAE5Ix+U87QmNo5jinYe6V6s1alaO5f3ov5suNAjcVyrXc14InClY+h3B674L6Pzg
         Y0neFqooRI1HSjx0e6jtNpTGSzWyfIaYx1LBZOn43/jMtc5uxcxD+wohXXB8gRfpmZ
         0w7zNS0MPVTBA==
MIME-Version: 1.0
Date:   Tue, 31 Oct 2023 15:48:14 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: acer-aspire1: Correct audio codec
 definition
In-Reply-To: <7d4140bb-9cc6-4686-8794-9388c7ab0792@linaro.org>
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-2-5ff3cf8b5701@trvn.ru>
 <3a423cb7-cdf1-433a-a848-8636917640bb@linaro.org>
 <eda1c91bd2dce76e633dd82ad3105355@trvn.ru>
 <7d4140bb-9cc6-4686-8794-9388c7ab0792@linaro.org>
Message-ID: <66fa9aff9a7c4b3bbd980f90aed5a62e@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 31.10.2023 15:06:
> On 31.10.2023 08:20, Nikita Travkin wrote:
>> Konrad Dybcio писал(а) 31.10.2023 02:48:
>>> On 27.10.2023 16:42, Nikita Travkin wrote:
>>>> When initially added, a mistake was made in the definition of the codec.
>>>>
>>>> Despite the fact that the DMIC line is connected on the side of the
>>>> codec chip, and relevant passive components, including 0-ohm resistors
>>>> connecting the dmics, are present, the dmic line is still cut in
>>>> another place on the board, which was overlooked.
>>>>
>>>> Correct this by replacing the dmic configuration with a comment
>>>> describing this hardware detail.
>>>>
>>>> While at it, also add missing regulators definitions. This is not a
>>>> functional change as all the relevant regulators were already added via
>>>> the other rail supplies.
>>>>
>>>> Fixes: 4a9f8f8f2ada ("arm64: dts: qcom: Add Acer Aspire 1")
>>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 17 +++++++++++++++--
>>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>>> index cfde8cd47107..00b442696618 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>>>> @@ -209,9 +209,22 @@ alc5682: codec@1a {
>>>>  		AVDD-supply = <&vreg_l15a_1p8>;
>>>>  		MICVDD-supply = <&reg_codec_3p3>;
>>>>  		VBAT-supply = <&reg_codec_3p3>;
>>>> +		DBVDD-supply = <&vreg_l15a_1p8>;
>>>> +		LDO1-IN-supply = <&vreg_l15a_1p8>;
>>>> +
>>>> +		/*
>>>> +		 * NOTE: The board has a path from this codec to the
>>>> +		 * DMIC microphones in the lid, however some of the option
>>>> +		 * resistors are absent and the microphones are connected
>>>> +		 * to the SoC instead.
>>> Would that not also require more DT changes and maybe UCM?
>>
>> I don't think I had any other descriptions to support the dmic in
>> the initial set (first audio support for this board is 3/3 here)
>> and there is no upstream UCM yet - I will probably hold it off until
>> I get vamacro and dmic on it working.
> I was told that VAMACRO is "the easiest thing possible to get going"
> (paraphrasing), did you go through something like this sequence [1]?
> 

The problem is that no one introduced it for sc7180 - it's not
in the dtsi. And so isn't the lpass-tlmm I'd need...

So the set of due changes per my understanding is like:

 - Add va-macro to sc7180 (need new compatible/fallback)
 - Add relevant clocks for it (seems to be firmware backed, so easy?)
 - Add lpass-tlmm (it seems like we add a new driver for each soc
   even if they are same? Are they same?)
 - Add va macro dma dais to the asoc boardfile (trivial)
 - Finally, add the dmic to the board dts and enable in the UCM
   (also trivial)

So I decided to follow the "release early, release often" and
only introduce partial sound for now, following it up with
all above later.

> https://git.linaro.org/people/srinivas.kandagatla/alsa-ucm-conf.git/tree/ucm2/codecs/qcom-lpass/va-macro/DMIC0EnableSeq.conf?h=x13s&id=244979b03f5b9284e6a68eae6f9995f6ac735be8

Thanks, this is useful to have, I was indeed looking at
x13s for dmic/vamacro example after I realized my board
tricked me and it's not how trogdor does it...

Nikita
