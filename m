Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B767609BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGYFtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjGYFtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:49:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A11BD3;
        Mon, 24 Jul 2023 22:49:12 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P3chZQ015944;
        Tue, 25 Jul 2023 05:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=N10CMOeBn2Dea+qimtcML/z48MsjuJ3i9QYQDygLgYA=;
 b=SBrRdxwdP9zPP1yiIr3hHy97qnJVVqZMnauF0MyWQKsrn9A8DXNLER/r+OjMPplxIbKC
 CcLJxTPu7J57HER68b/Ji4f8+9Q7Fpir7ZhzXi8JjGOuyno2ZBOVcBajghdP+NV5//72
 SsecZNrFG1WvyGPvKJrXKOMoLIQw7SVJ1h2QJm4QrEG5EGhnBRFn8DUcbR+AjX3K09Hj
 +mSw3Cb72dT7TLlbDy7U9+i0dWcUd99xDkruYBSPnGi7byEg2jHAZyvf+1bRb6Zfm8BU
 RouhuEYMfqkINYY2653ylgLrdOf67+IM3Y62yHVqKoRskzLiTFOsMzu40+Ycg0TV8NPi Ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1s1jswp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:49:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P5n5KY011942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:49:05 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 22:49:02 -0700
Date:   Tue, 25 Jul 2023 11:18:58 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mike Tipton <quic_mdtipton@quicinc.com>
CC:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_okukatla@quicinc.com>,
        <quic_viveka@quicinc.com>
Subject: Re: [PATCH 2/3] interconnect: Reintroduce icc_get()
Message-ID: <c68630ee-9f94-40ec-adb1-a899dc22ca1b@quicinc.com>
References: <20230725012859.18474-1-quic_mdtipton@quicinc.com>
 <20230725012859.18474-3-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230725012859.18474-3-quic_mdtipton@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bJGnT5l6HhHVWeYwliyVY_wJT0QQvlOT
X-Proofpoint-ORIG-GUID: bJGnT5l6HhHVWeYwliyVY_wJT0QQvlOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=880 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:28:58PM -0700, Mike Tipton wrote:
> The original icc_get() that took integer node IDs was removed due to
> lack of users. Reintroduce a new version that takes string node names,
> which is needed for the debugfs client.
> 
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
>  drivers/interconnect/core.c  | 64 ++++++++++++++++++++++++++++++++++++
>  include/linux/interconnect.h |  6 ++++
>  2 files changed, 70 insertions(+)

[...]

> +/**
> + * icc_get() - get a path handle between two endpoints
> + * @dev: device pointer for the consumer device
> + * @src: source node name
> + * @dst: destination node name
> + *
> + * This function will search for a path between two endpoints and return an
> + * icc_path handle on success. Use icc_put() to release constraints when they
> + * are not needed anymore.
> + *
> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
> + * when the API is disabled.
> + */
> +struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
> +{
> +	struct icc_node *src_node, *dst_node;
> +	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> +
> +	mutex_lock(&icc_lock);
> +
> +	src_node = node_find_by_name(src);
> +	if (!src_node) {
> +		dev_err(dev, "%s: invalid src=%s\n", __func__, src);
> +		goto out;
> +	}
> +
> +	dst_node = node_find_by_name(dst);
> +	if (!dst_node) {
> +		dev_err(dev, "%s: invalid dst=%s\n", __func__, dst);
> +		goto out;
> +	}
> +
> +	path = path_find(dev, src_node, dst_node);
> +	if (IS_ERR(path)) {
> +		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> +		goto out;
> +	}
> +
> +	path->name = kasprintf(GFP_KERNEL, "%s-%s", src_node->name, dst_node->name);
> +	if (!path->name) {
> +		kfree(path);
> +		path = ERR_PTR(-ENOMEM);
> +	}
> +out:
> +	mutex_unlock(&icc_lock);
> +	return path;
> +}
> +EXPORT_SYMBOL_GPL(icc_get);
> +
>  /**
>   * icc_set_tag() - set an optional tag on a path
>   * @path: the path we want to tag
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 97ac253df62c..39a98ddfdfd4 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -40,6 +40,7 @@ struct icc_bulk_data {
>  
>  #if IS_ENABLED(CONFIG_INTERCONNECT)
>  
> +struct icc_path *icc_get(struct device *dev, const char *src, const char *dst);
>  struct icc_path *of_icc_get(struct device *dev, const char *name);
>  struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
>  int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
> @@ -59,6 +60,11 @@ void icc_bulk_disable(int num_paths, const struct icc_bulk_data *paths);
>  
>  #else
>  
> +struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
> +{
> +	return NULL;
> +}
> +

Is this API meant to be public()? As you pointed out, it was removed
recently as there were no users. Since debugfs client is part of ICC
frarmwork, should it be made private?

Thanks,
Pavan
