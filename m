Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7057AD12D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjIYHMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjIYHMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:12:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C5124;
        Mon, 25 Sep 2023 00:11:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A7FC433C7;
        Mon, 25 Sep 2023 07:11:52 +0000 (UTC)
Message-ID: <1e815d41-719a-4ca1-98e3-872f882ed03e@xs4all.nl>
Date:   Mon, 25 Sep 2023 09:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/17] media: qcom: camss: Comment CSID dt_id field
Content-Language: en-US, nl
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
 <20230911131411.196033-18-bryan.odonoghue@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230911131411.196033-18-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 15:14, Bryan O'Donoghue wrote:
> Digging into the documentation we find that the DT_ID bitfield is used to
> map the six bit DT to a two bit ID code. This value is concatenated to the
> VC bitfield to create a CID value. DT_ID is the two least significant bits
> of CID and VC the most significant bits.
> 
> Originally we set dt_id = vc * 4 in and then subsequently set dt_id = vc.
> 
> commit 3c4ed72a16bc ("media: camss: sm8250: Virtual channels for CSID")
> silently fixed the multiplication by four which would give a better
> value for the generated CID without mentioning what was being done or why.
> 
> Next up I haplessly changed the value back to "dt_id = vc * 4" since there
> didn't appear to be any logic behind it.
> 
> Hans asked what the change was for and I honestly couldn't remember the
> provenance of it, so I dug in.
> 
> Link: https://lore.kernel.org/linux-arm-msm/edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl/
> 
> Add a comment so the next hapless programmer doesn't make this same
> mistake.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-csid-gen2.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> index 6ba2b10326444..cee50fc87e9de 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> @@ -352,6 +352,11 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  		phy_sel = csid->phy.csiphy_id;
>  
>  	if (enable) {
> +		/*
> +		 * A value caled 'CID' gets generated internal to CAMSS logic

caled -> called

> +		 * which is a concatenation of [vc:6 | dt_id:2] hence we reuse

vc:6? Do you mean bit 6 or do you mean the least significant 6 bits?

Regardless, since the vc variable <= 3 (since MSM_CSID_MAX_SRC_STREAMS is 4),
either interpretation makes little sense.

And what does "DT" stand for?

> +		 * the least significant two bits of the VC to 'stuff' the CID value.
> +		 */
>  		u8 dt_id = vc;

If dt_id should be the least significant two bits of vc, shouldn't
this say: "= vc & 3;"? Or, alternatively, have a comment that vc <= 3?

>  
>  		if (tg->enabled) {

Regards,

	Hans
