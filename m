Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D823D75317E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjGNFtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjGNFtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:49:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F692123;
        Thu, 13 Jul 2023 22:49:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E3RrXv017354;
        Fri, 14 Jul 2023 05:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YEvKqjFAdJD2n4b5sCv9GE47BLTIESk4XQOBmzcRYyE=;
 b=A/dJt6ihjUQGj39jCNyEL53PYcFem2qpO2HiCZfa+nZeCxLHUFlzhwY/L97j9G15YMHd
 BkxwNiqQJ7sL1Hfq7294rGqFJun1+Zbx5AIFZGqNfIv0IXBwZBspxqJ99ki1CQ+xddFY
 OJI5c97uIUURsDE2dKXjluYyzqLx/+ThhyRX+kJI8I2rb+0O5MzHYhpRbicDF0WX/Y3a
 scUuHZGGXnlMmGHvrAD5ihnuJV3KfFy2e11uE7YAiDaz6DGmg4SbYUcF5NhI8wtYOOoK
 cJs2gb5a5QpsD8gOnWFU3G8GU9Q9zw8lx55xBvHx0mRRypdPwLOdkwY+TojdhPMfX9jO uw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpu90xyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:49:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E5n5QA000314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:49:06 GMT
Received: from [10.201.162.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 22:49:01 -0700
Message-ID: <a69a750a-884b-c60b-9d52-f4ae2cd1b2ea@quicinc.com>
Date:   Fri, 14 Jul 2023 11:18:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH net-next 1/3] net: qrtr: ns: Change servers radix tree to
 xarray
To:     Simon Horman <simon.horman@corigine.com>
CC:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_clew@quicinc.com>
References: <20230712112631.3461793-1-quic_viswanat@quicinc.com>
 <20230712112631.3461793-2-quic_viswanat@quicinc.com>
 <ZLAQCTcRd2uoHE9i@corigine.com>
Content-Language: en-US
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
In-Reply-To: <ZLAQCTcRd2uoHE9i@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: byorVKFOtfZqsdQH2xvNCFhM_ZQFCjny
X-Proofpoint-ORIG-GUID: byorVKFOtfZqsdQH2xvNCFhM_ZQFCjny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=924 clxscore=1011 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140053
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2023 8:24 PM, Simon Horman wrote:
> On Wed, Jul 12, 2023 at 04:56:29PM +0530, Vignesh Viswanathan wrote:
>> There is a use after free scenario while iterating through the servers
>> radix tree despite the ns being a single threaded process. This can
>> happen when the radix tree APIs are not synchronized with the
>> rcu_read_lock() APIs.
>>
>> Convert the radix tree for servers to xarray to take advantage of the
>> built in rcu lock usage provided by xarray.
>>
>> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> A few very minor nits below.

Thanks Simon for the review. Will fix both the comments in V2.

Thanks,
Vignesh
> 
> ...
> 
>> @@ -256,14 +240,17 @@ static struct qrtr_server *server_add(unsigned int service,
>>   		goto err;
>>   
>>   	/* Delete the old server on the same port */
>> -	old = radix_tree_lookup(&node->servers, port);
>> +	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
>>   	if (old) {
>> -		radix_tree_delete(&node->servers, port);
>> -		kfree(old);
>> +		if (xa_is_err(old)) {
>> +			pr_err("failed to add server [0x%x:0x%x] ret:%d\n",
>> +				srv->service, srv->instance, xa_err(old));
> 
> The indentation of the line above is not correct.
> It should be:
> 
> 			pr_err("failed to add server [0x%x:0x%x] ret:%d\n",
> 			       srv->service, srv->instance, xa_err(old));
> 
>> +			goto err;
>> +		} else {
>> +			kfree(old);
>> +		}
>>   	}
>>   
>> -	radix_tree_insert(&node->servers, port, srv);
>> -
>>   	trace_qrtr_ns_server_add(srv->service, srv->instance,
>>   				 srv->node, srv->port);
>>   
> 
> ...
> 
>> @@ -576,13 +518,12 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
>>   static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
>>   			       unsigned int service, unsigned int instance)
>>   {
>> -	struct radix_tree_iter node_iter;
>>   	struct qrtr_server_filter filter;
>> -	struct radix_tree_iter srv_iter;
>>   	struct qrtr_lookup *lookup;
>>   	struct qrtr_node *node;
>> -	void __rcu **node_slot;
>> -	void __rcu **srv_slot;
>> +	struct qrtr_server *srv;
> 
> This breaks reverse xmas tree ordering of local variables.
> The srv line should be directly above rather than below the node line.
> 
>> +	unsigned long node_idx;
>> +	unsigned long srv_idx;
>>   
>>   	/* Accept only local observers */
>>   	if (from->sq_node != qrtr_ns.local_node)
> 
> ...
