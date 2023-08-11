Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2676877968B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjHKR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHKR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:57:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E62706;
        Fri, 11 Aug 2023 10:57:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BHL3np010291;
        Fri, 11 Aug 2023 17:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=VG9HAoPdDf0rgn3ZaYB79uTRMqhZLj9P0o3J+gWUuyU=;
 b=o/vf0x6Kf2Yge7YSHzIdu0E5f43eXhbX4Hh89J2XBh8kCNn2dTnBtfYy8VLT25wzsX4M
 XkO10JaxurTzbez0ZVUVHjp0diTGNkZPyl5PHkGsWi0HKo5wzmsWzy7HOPD7Hhy0cd/G
 vqak7SME/nl4mvlH3mQdmdCbK9UbKxmdMxnA0/1Dkd4/+P14A9QKFy7yjJEeIcAjp8Lm
 jWC2VA1oCa5S+6xlAqRrGyIgJ1tmvTKlra6fQ/M+HZoCJrif/ZCyJnBOoJDgJ8x78u8D
 Px1RhzM9pRg/2Ijq8nG5+PG3PpZ64g2sZCpChvuM1zy3koawMenf8Rq/9YZypUOFjafM UQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sdsaf02b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:56:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BHuqMA006014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 17:56:52 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 10:56:52 -0700
Date:   Fri, 11 Aug 2023 10:56:51 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] interconnect: qcom: bcm-voter: Improve enable_mask
 handling
Message-ID: <20230811175651.GA10861@hu-mdtipton-lv.qualcomm.com>
References: <20230811-topic-icc_fix_1he-v1-0-5c96ccef3399@linaro.org>
 <20230811-topic-icc_fix_1he-v1-1-5c96ccef3399@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811-topic-icc_fix_1he-v1-1-5c96ccef3399@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MmpJ0lfQqsfeIDEETmuZyasO0OshYKUr
X-Proofpoint-GUID: MmpJ0lfQqsfeIDEETmuZyasO0OshYKUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:55:07PM +0200, Konrad Dybcio wrote:
> We don't need all the complex arithmetic for BCMs utilizing enable_mask,
> as all we need to do is to determine whether there's any user (or
> keepalive) asking for it to be on.
> 
> Separate the logic for such BCMs for a small speed boost.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/bcm-voter.c | 40 +++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index d5f2a6b5376b..82433f35717f 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -58,6 +58,33 @@ static u64 bcm_div(u64 num, u32 base)
>  	return num;
>  }
>  
> +/* BCMs with enable_mask use one-hot-encoding for on/off signaling */
> +static void bcm_aggregate_1he(struct qcom_icc_bcm *bcm)

Suggest renaming this to bcm_aggregate_mask(). It's not actually a
one-hot encoding. Certain mask-based BCMs can have more than a single
bit set in their mask. Most will only have one, but some will have more.
Especially once QCOM_ICC_TAG_PERF_MODE is ported over. This tag sets an
additional bit in the ACV mask, but only when clients explicitly vote
for it, as opposed to always setting just the default ACV bit.

> +{
> +	struct qcom_icc_node *node;
> +	int bucket, i;
> +
> +	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
> +		for (i = 0; i < bcm->num_nodes; i++) {
> +			node = bcm->nodes[i];
> +
> +			/* If any vote in this bucket exists, keep the BCM enabled */
> +			if (node->sum_avg[bucket] || node->max_peak[bucket]) {
> +				bcm->vote_x[bucket] = 0;
> +				bcm->vote_y[bucket] = bcm->enable_mask;
> +				break;
> +			}

This will leave stale masks in vote_y after all clients have removed
their votes. The bcm->vote_x and bcm->vote_y arrays aren't cleared
before calling the aggregate functions. The original bcm_aggregate()
aggregates in zero-initialized local buffers before assigning the result
to bcm. Here, you could just assign vote_x and vote_y to 0 in the outer
bucket loop.

> +		}
> +	}
> +
> +	if (bcm->keepalive) {
> +		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
> +		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
> +		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
> +		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
> +	}
> +}
> +
>  static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>  {
>  	struct qcom_icc_node *node;
> @@ -83,11 +110,6 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>  
>  		temp = agg_peak[bucket] * bcm->vote_scale;
>  		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
> -
> -		if (bcm->enable_mask && (bcm->vote_x[bucket] || bcm->vote_y[bucket])) {
> -			bcm->vote_x[bucket] = 0;
> -			bcm->vote_y[bucket] = bcm->enable_mask;
> -		}
>  	}
>  
>  	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
> @@ -260,8 +282,12 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
>  		return 0;
>  
>  	mutex_lock(&voter->lock);
> -	list_for_each_entry(bcm, &voter->commit_list, list)
> -		bcm_aggregate(bcm);
> +	list_for_each_entry(bcm, &voter->commit_list, list) {
> +		if (bcm->enable_mask)
> +			bcm_aggregate_1he(bcm);
> +		else
> +			bcm_aggregate(bcm);
> +	}
>  
>  	/*
>  	 * Pre sort the BCMs based on VCD for ease of generating a command list
> 
> -- 
> 2.41.0
> 
