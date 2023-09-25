Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC227AD124
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjIYHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjIYHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C9B8;
        Mon, 25 Sep 2023 00:10:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C41C433C7;
        Mon, 25 Sep 2023 07:10:51 +0000 (UTC)
Message-ID: <936acf18-b961-40e3-b68b-f1c679961d67@xs4all.nl>
Date:   Mon, 25 Sep 2023 09:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] media: qcom: camss: Allow clocks vfeN vfe_liteN
 or vfe_lite
Content-Language: en-US, nl
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
 <20230911131411.196033-12-bryan.odonoghue@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230911131411.196033-12-bryan.odonoghue@linaro.org>
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
> The number of Video Front End - VFE or Image Front End - IFE supported
> with new SoCs can vary both for the full and lite cases.
> 
> For example sdm845 has one vfe_lite and two vfe interfaces with the vfe
> clock called simply "vfe_lite" with no integer postfix. sc8280xp has four
> vfe and four vfe lite blocks.
> 
> At the moment we declare vfe_lite0 and vfe_lite1 for sm8250 but never set
> those clocks because we don't match the strings.
> 
> We need to support the following clock name formats
> 
> - vfeN
> - vfe_liteN
> - vfe_lite
> 
> with N being any reasonably sized integer.
> 
> There are two sites in this code which need to do the same thing,
> constructing and matching strings with the pattern above, so encapsulate
> the logic in one function.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index db8f68819ded9..f3cf387e4907e 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -431,6 +431,20 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
>  	complete(&vfe->reset_complete);
>  }
>  
> +static int vfe_match_clock_names(struct vfe_device *vfe,
> +				 struct camss_clock *clock)
> +{
> +	char vfe_name[6]; /* vfeXX\0 */
> +	char vfe_lite_name[11]; /* vfe_liteXX\0 */
> +
> +	snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
> +	snprintf(vfe_lite_name, sizeof(vfe_lite_name), "vfe_lite%d", vfe->id);
> +
> +	return (!strcmp(clock->name, vfe_name) ||
> +		!strcmp(clock->name, vfe_lite_name) ||
> +		!strcmp(clock->name, "vfe_lite"));
> +}

I'm getting this compiler warning:

drivers/media/platform/qcom/camss/camss-vfe.c: In function 'vfe_match_clock_names':
drivers/media/platform/qcom/camss/camss-vfe.c:483:52: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
  483 |         snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
      |                                                    ^

Since vfe->id is a u8 I would just increase both the vfe_name and vfe_lite_name
sizes by 1.

Regards,

	Hans

> +
>  /*
>   * vfe_set_clock_rates - Calculate and set clock rates on VFE module
>   * @vfe: VFE device
> @@ -454,9 +468,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
>  	for (i = 0; i < vfe->nclocks; i++) {
>  		struct camss_clock *clock = &vfe->clock[i];
>  
> -		if (!strcmp(clock->name, "vfe0") ||
> -		    !strcmp(clock->name, "vfe1") ||
> -		    !strcmp(clock->name, "vfe_lite")) {
> +		if (vfe_match_clock_names(vfe, clock)) {
>  			u64 min_rate = 0;
>  			long rate;
>  
> @@ -537,9 +549,7 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
>  	for (i = 0; i < vfe->nclocks; i++) {
>  		struct camss_clock *clock = &vfe->clock[i];
>  
> -		if (!strcmp(clock->name, "vfe0") ||
> -		    !strcmp(clock->name, "vfe1") ||
> -		    !strcmp(clock->name, "vfe_lite")) {
> +		if (vfe_match_clock_names(vfe, clock)) {
>  			u64 min_rate = 0;
>  			unsigned long rate;
>  

