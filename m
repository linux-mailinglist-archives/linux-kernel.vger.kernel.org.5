Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405CE7F1035
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjKTKWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:22:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B65EBA;
        Mon, 20 Nov 2023 02:22:08 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK9TTgB009913;
        Mon, 20 Nov 2023 10:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yeOjmECxv3sdcrW5VLH3i4ur1hHQkUm1jZjP46bingU=;
 b=XHvLLl9fmpPPieJPdJi+V7AiBpq3c7bNrQ+eaQ1b146k8qQbP3YQb+tjeWjJbUOLHKVu
 HUUtK27fdR0bCwQmslI3s3KoTwVDeWrE8+hvObKxyk0Dk+XLtMfOWv6wpt/7Da4PM6Lq
 CYXToLjisP3JxeCbVM89WV7J7xJDw+XZlqIcZL/votbC8+VdewrxYzzVr3mWKDNJXM6A
 EIm4Pm/PK2wTGIE++hQVAvvp7Sr/UjR2EaroFVrKMITTnsv20MViTlQzaa2T3QQ327VK
 5XtiJMU8aULR7xsM4q6/lXd1e4/EDwdXstITL3gDKILY104l4v1kCssXVYx8LUgek6dk fg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem9ebpe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:22:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKAM2aM027727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:22:02 GMT
Received: from [10.50.58.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 02:21:59 -0800
Message-ID: <419b0e85-5479-30b0-d6a9-b2697d057c55@quicinc.com>
Date:   Mon, 20 Nov 2023 15:51:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq
 multi ops
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230916140046.7878-1-ansuelsmth@gmail.com>
 <20230916140046.7878-3-ansuelsmth@gmail.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230916140046.7878-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Uw5hDpzZ0rQczi0966v5XZvdnLutJDWx
X-Proofpoint-GUID: Uw5hDpzZ0rQczi0966v5XZvdnLutJDWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_08,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200069
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/2023 7:30 PM, Christian Marangi wrote:
> Some RCG frequency can be reached by multiple configuration.
> 
> Add clk_rcg2_fm_ops ops to support these special RCG configurations.
> 
> These alternative ops will select the frequency using a CEIL policy.
> 
> When the correct frequency is found, the correct config is selected by
> calculating the final rate (by checking the defined parent and values
> in the config that is being checked) and deciding based on the one that
> is less different than the requested one.
> 
> These check are skipped if there is just on config for the requested
> freq.
> 
> qcom_find_freq_multi is added to search the freq with the new struct
> freq_multi_tbl.
> __clk_rcg2_select_conf is used to select the correct conf by simulating
> the final clock.
> If a conf can't be found due to parent not reachable, a WARN is printed
> and -EINVAL is returned.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/clk/qcom/clk-rcg.h  |   1 +
>   drivers/clk/qcom/clk-rcg2.c | 167 ++++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/common.c   |  18 ++++
>   drivers/clk/qcom/common.h   |   2 +
>   4 files changed, 188 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index c81458db6ce4..dc9a77965e68 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -190,6 +190,7 @@ struct clk_rcg2_gfx3d {
>   
>   extern const struct clk_ops clk_rcg2_ops;
>   extern const struct clk_ops clk_rcg2_floor_ops;
> +extern const struct clk_ops clk_rcg2_fm_ops;
>   extern const struct clk_ops clk_rcg2_mux_closest_ops;
>   extern const struct clk_ops clk_edp_pixel_ops;
>   extern const struct clk_ops clk_byte_ops;
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index e22baf3a7112..617e7ff0f6a3 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -266,6 +266,116 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>   	return 0;
>   }
>   
> +static const struct freq_conf *
> +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> +		       unsigned long req_rate)
> +{
> +	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
> +	const struct freq_conf *conf, *best_conf;
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const char *name = clk_hw_get_name(hw);
> +	unsigned long parent_rate, rate;
> +	struct clk_hw *p;
> +	int index, i;
> +
> +	/* Init best_conf to the first conf */
> +	best_conf = f->confs;
> +
> +	/* Exit early if only one config is defined */
> +	if (f->num_confs == 1)
> +		goto exit;
> +
> +	/* Search in each provided config the one that is near the wanted rate */
> +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
> +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> +		if (index < 0)
> +			continue;
> +
> +		p = clk_hw_get_parent_by_index(hw, index);
> +		if (!p)
> +			continue;
> +
> +		parent_rate =  clk_hw_get_rate(p);
> +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> +
> +		if (rate == req_rate) {
> +			best_conf = conf;
> +			goto exit;
> +		}
> +
> +		rate_diff = abs(req_rate - rate);
> +		if (rate_diff < best_rate_diff) {
> +			best_rate_diff = rate_diff;
> +			best_conf = conf;
> +		}
> +	}
> +
> +	/*
> +	 * Very unlikely. Warn if we couldn't find a correct config
> +	 * due to parent not found in every config.
> +	 */
> +	if (unlikely(i == f->num_confs)) {
> +		WARN(1, "%s: can't find a configuration for rate %lu.",
> +		     name, req_rate);
> +		return ERR_PTR(-EINVAL);
> +	}
Hi Christian,

Thanks a lot for the patch!
We have incorporated these changes along with the corresponding clock 
driver changes & tested it on IPQ9574 & IPQ5332 targets.

When setting the clk rate for the nss port clocks, for the requested
frequency the correct config gets selected and the
clk rate is set properly.
We see the WARN getting printed for other frequencies (rate * i where
i=2 to maxdiv) that is requested by the clk_hw_round_rate function.

Upon analysis, we see that the for loop in clk_divider_bestdiv iterates
until the maxdiv value and requests (rate*i) via the clk_hw_round_rate
API to find the bestdiv and best_parent_rate. For frequencies which are
multiples of the requested frequency (rate*i where i=2 to maxdiv), it
seems unlikely to see the WARN being printed.

Can you please help us understand when the WARN is likely to be printed
& Looking forward to your suggestions on how this WARN could
be suppressed in the afore mentioned scenario!

Thanks,
Devi Priya
> +
> +exit:
> +	return best_conf;
> +}
> +
> +static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
> +				       struct clk_rate_request *req)
> +{
> +	unsigned long clk_flags, rate = req->rate;
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const struct freq_conf *conf;
> +	struct clk_hw *p;
> +	int index;
> +
> +	f = qcom_find_freq_multi(f, rate);
> +	if (!f || !f->confs)
> +		return -EINVAL;
> +
> +	conf = __clk_rcg2_select_conf(hw, f, rate);
> +	if (IS_ERR(conf))
> +		return PTR_ERR(conf);
> +	index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> +	if (index < 0)
> +		return index;
> +
> +	clk_flags = clk_hw_get_flags(hw);
> +	p = clk_hw_get_parent_by_index(hw, index);
> +	if (!p)
> +		return -EINVAL;
> +
> +	if (clk_flags & CLK_SET_RATE_PARENT) {
> +		rate = f->freq;
> +		if (conf->pre_div) {
> +			if (!rate)
> +				rate = req->rate;
> +			rate /= 2;
> +			rate *= conf->pre_div + 1;
> +		}
> +
> +		if (conf->n) {
> +			u64 tmp = rate;
> +
> +			tmp = tmp * conf->n;
> +			do_div(tmp, conf->m);
> +			rate = tmp;
> +		}
> +	} else {
> +		rate =  clk_hw_get_rate(p);
> +	}
> +
> +	req->best_parent_hw = p;
> +	req->best_parent_rate = rate;
> +	req->rate = f->freq;
> +
> +	return 0;
> +}
> +
>   static int clk_rcg2_determine_rate(struct clk_hw *hw,
>   				   struct clk_rate_request *req)
>   {
> @@ -282,6 +392,14 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
>   	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
>   }
>   
> +static int clk_rcg2_fm_determine_rate(struct clk_hw *hw,
> +				      struct clk_rate_request *req)
> +{
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +
> +	return _freq_tbl_fm_determine_rate(hw, rcg->freq_multi_tbl, req);
> +}
> +
>   static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
>   				u32 *_cfg)
>   {
> @@ -377,6 +495,30 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>   	return clk_rcg2_configure(rcg, f);
>   }
>   
> +static int __clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate)
> +{
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const struct freq_multi_tbl *f;
> +	const struct freq_conf *conf;
> +	struct freq_tbl f_tbl;
> +
> +	f = qcom_find_freq_multi(rcg->freq_multi_tbl, rate);
> +	if (!f || !f->confs)
> +		return -EINVAL;
> +
> +	conf = __clk_rcg2_select_conf(hw, f, rate);
> +	if (IS_ERR(conf))
> +		return PTR_ERR(conf);
> +
> +	f_tbl.freq = f->freq;
> +	f_tbl.src = conf->src;
> +	f_tbl.pre_div = conf->pre_div;
> +	f_tbl.m = conf->m;
> +	f_tbl.n = conf->n;
> +
> +	return clk_rcg2_configure(rcg, &f_tbl);
> +}
> +
>   static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>   			    unsigned long parent_rate)
>   {
> @@ -389,6 +531,12 @@ static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
>   	return __clk_rcg2_set_rate(hw, rate, FLOOR);
>   }
>   
> +static int clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	return __clk_rcg2_fm_set_rate(hw, rate);
> +}
> +
>   static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
>   		unsigned long rate, unsigned long parent_rate, u8 index)
>   {
> @@ -401,6 +549,12 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
>   	return __clk_rcg2_set_rate(hw, rate, FLOOR);
>   }
>   
> +static int clk_rcg2_fm_set_rate_and_parent(struct clk_hw *hw,
> +		unsigned long rate, unsigned long parent_rate, u8 index)
> +{
> +	return __clk_rcg2_fm_set_rate(hw, rate);
> +}
> +
>   static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
>   {
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> @@ -511,6 +665,19 @@ const struct clk_ops clk_rcg2_floor_ops = {
>   };
>   EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
>   
> +const struct clk_ops clk_rcg2_fm_ops = {
> +	.is_enabled = clk_rcg2_is_enabled,
> +	.get_parent = clk_rcg2_get_parent,
> +	.set_parent = clk_rcg2_set_parent,
> +	.recalc_rate = clk_rcg2_recalc_rate,
> +	.determine_rate = clk_rcg2_fm_determine_rate,
> +	.set_rate = clk_rcg2_fm_set_rate,
> +	.set_rate_and_parent = clk_rcg2_fm_set_rate_and_parent,
> +	.get_duty_cycle = clk_rcg2_get_duty_cycle,
> +	.set_duty_cycle = clk_rcg2_set_duty_cycle,
> +};
> +EXPORT_SYMBOL_GPL(clk_rcg2_fm_ops);
> +
>   const struct clk_ops clk_rcg2_mux_closest_ops = {
>   	.determine_rate = __clk_mux_determine_rate_closest,
>   	.get_parent = clk_rcg2_get_parent,
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..48f81e3a5e80 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -41,6 +41,24 @@ struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
>   }
>   EXPORT_SYMBOL_GPL(qcom_find_freq);
>   
> +const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
> +						  unsigned long rate)
> +{
> +	if (!f)
> +		return NULL;
> +
> +	if (!f->freq)
> +		return f;
> +
> +	for (; f->freq; f++)
> +		if (rate <= f->freq)
> +			return f;
> +
> +	/* Default to our fastest rate */
> +	return f - 1;
> +}
> +EXPORT_SYMBOL_GPL(qcom_find_freq_multi);
> +
>   const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
>   					    unsigned long rate)
>   {
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..2d4a8a837e6c 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -45,6 +45,8 @@ extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
>   					     unsigned long rate);
>   extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
>   						   unsigned long rate);
> +extern const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
> +							 unsigned long rate);
>   extern void
>   qcom_pll_set_fsm_mode(struct regmap *m, u32 reg, u8 bias_count, u8 lock_count);
>   extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
