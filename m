Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF67AB3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjIVOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjIVOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:44:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7335DC6;
        Fri, 22 Sep 2023 07:44:12 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MEBvdu025832;
        Fri, 22 Sep 2023 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LbFeoloWRxRrwi9BvqCwJ3WHW3JbWo1zCUDcGy9w4i8=;
 b=PDl2TtNwP9vcGPNS2zIcEmknyPJHYcGx+264sOsxdMWRLKArd9ZfJqVWjgwr5FwAQysh
 5ZDHLk5vXxat30e1VL8TQ8ZqwIrev4KZv4I/lV49oBHTLMlH34CeKjnWoV2y9kqrJVQd
 +0okmgiGF0MX6+5wF07xLO5ej3qlO9Br1doHuzQjTbATtilF8Nt7c/gBn7tzfGbPay+W
 VY2n91QTuSIGEuQtG7j6Dzxp7l7ickzHJnGwv05RMIKrVkKmZSa0AcgT29h2eSitoemn
 UuaBCVK2YCWmg5+cllZ0kR67kGvuQ8gp42MuxulIppSRav0vJvKnP32PiLF77oWNDW0f Aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u9ha169-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 14:44:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MEi58N026898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 14:44:05 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 07:44:04 -0700
Message-ID: <af4fc816-d75b-997d-6d37-a774f5eb96ae@quicinc.com>
Date:   Fri, 22 Sep 2023 08:44:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
 <1694594861-12691-2-git-send-email-quic_qianyu@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1694594861-12691-2-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hweOo_-hxqLmD1dGwUGyMy4GAL7LCy1l
X-Proofpoint-ORIG-GUID: hweOo_-hxqLmD1dGwUGyMy4GAL7LCy1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 mlxlogscore=814 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220126
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2023 2:47 AM, Qiang Yu wrote:
> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> Protect WP accesses such that multiple threads queueing buffers for
> incoming data do not race and access the same WP twice. Ensure read and
> write locks for the channel are not taken in succession by dropping the
> read lock from parse_xfer_event() such that a callback given to client
> can potentially queue buffers and acquire the write lock in that process.
> Any queueing of buffers should be done without channel read lock acquired
> as it can result in multiple locks and a soft lockup.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>   drivers/bus/mhi/host/main.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index dcf627b..13c4b89 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -642,6 +642,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>   			mhi_del_ring_element(mhi_cntrl, tre_ring);
>   			local_rp = tre_ring->rp;
>   
> +			read_unlock_bh(&mhi_chan->lock);

This doesn't work due to the write_lock_irqsave(&mhi_chan->lock, flags); 
on line 591.

I really don't like that we are unlocking the mhi_chan while still using 
it.  It opens up a window where the mhi_chan state can be updated 
between here and the client using the callback to queue a buf.

Perhaps we need a new lock that just protects the wp, and needs to be 
only grabbed while mhi_chan->lock is held?

>   			/* notify client */
>   			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>   
> @@ -667,6 +668,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>   					kfree(buf_info->cb_buf);
>   				}
>   			}
> +			read_lock_bh(&mhi_chan->lock);
>   		}
>   		break;
>   	} /* CC_EOT */
> @@ -1204,6 +1206,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>   	int eot, eob, chain, bei;
>   	int ret;
>   
> +	/* Protect accesses for reading and incrementing WP */
> +	write_lock_bh(&mhi_chan->lock);
> +
>   	buf_ring = &mhi_chan->buf_ring;
>   	tre_ring = &mhi_chan->tre_ring;
>   
> @@ -1221,8 +1226,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>   
>   	if (!info->pre_mapped) {
>   		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
> -		if (ret)
> +		if (ret) {
> +			write_unlock_bh(&mhi_chan->lock);
>   			return ret;
> +		}
>   	}
>   
>   	eob = !!(flags & MHI_EOB);
> @@ -1239,6 +1246,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>   	mhi_add_ring_element(mhi_cntrl, tre_ring);
>   	mhi_add_ring_element(mhi_cntrl, buf_ring);
>   
> +	write_unlock_bh(&mhi_chan->lock);
> +
>   	return 0;
>   }
>   

