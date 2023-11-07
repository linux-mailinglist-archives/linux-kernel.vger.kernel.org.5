Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935D57E35B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjKGHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:19:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FC1FC;
        Mon,  6 Nov 2023 23:19:49 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A73pvB7013472;
        Tue, 7 Nov 2023 07:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=u1DxfSI0u6GU0XwgXgfaS4gkCqfJ0FwPigY3T4KxkZQ=;
 b=gMY92RfxZOCObfwGRe2/698AFqathWTcUSO0I2k+IvT4BzHCEWqBJCnYeYeLkmhGWydg
 k37zNjLameuXOOz1CIJPfUOvyDRbBYyVkhj+DhXllF97hHk6NwRfxhM0T93UpTc7q6xs
 Reqt8/Ysi7YopzCcDOY5aqrgRx1MGf2qQPC/ZLuEQ9xiLXvA+HkFIMd2y96ZC3YlDTzi
 hpuWQCRLWhn9b/DmmRiuW6NsFIvT2/IMVZjzSA473+xTLLlC4UUZnPIdUz27K3+hKvs9
 AzAD006q2l/Uts0ENWxzNziFCE4623lcrbwAdmI8psJgT5jljkkq7+sRb7OlyMackhDG 5w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6xduan34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 07:19:17 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A77JGHA030829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 07:19:16 GMT
Received: from [10.253.15.27] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 23:19:14 -0800
Message-ID: <92cc9fd2-eb05-4c2d-ad85-b3f411dece3e@quicinc.com>
Date:   Tue, 7 Nov 2023 15:19:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bus: mhi: host: Add spinlock to protect WP access
 when queueing TREs
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
References: <1694594861-12691-1-git-send-email-quic_qianyu@quicinc.com>
 <1694594861-12691-2-git-send-email-quic_qianyu@quicinc.com>
 <20231106044126.GA2474@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20231106044126.GA2474@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _sUUq1hV39g9h-zZPqlYgM445QL1JcwK
X-Proofpoint-ORIG-GUID: _sUUq1hV39g9h-zZPqlYgM445QL1JcwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=635 priorityscore=1501
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/2023 12:41 PM, Manivannan Sadhasivam wrote:
> On Wed, Sep 13, 2023 at 04:47:40PM +0800, Qiang Yu wrote:
>> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
>>
>> Protect WP accesses such that multiple threads queueing buffers for
>> incoming data do not race and access the same WP twice. Ensure read and
>> write locks for the channel are not taken in succession by dropping the
>> read lock from parse_xfer_event() such that a callback given to client
>> can potentially queue buffers and acquire the write lock in that process.
>> Any queueing of buffers should be done without channel read lock acquired
>> as it can result in multiple locks and a soft lockup.
>>
> This change is doing two things:
>
> 1. Unlocking xfer_cb to prevent potential lockup
> 2. Protecting mhi_gen_tre() against concurrent access
>
> So you should split this into two patches and also add Fixes tag if appropriate.
>
> - Mani
Hi Mani, thanks for review. I split this into two patch and add Fixes tag.
>
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/main.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index dcf627b..13c4b89 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -642,6 +642,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>>   			mhi_del_ring_element(mhi_cntrl, tre_ring);
>>   			local_rp = tre_ring->rp;
>>   
>> +			read_unlock_bh(&mhi_chan->lock);
>>   			/* notify client */
>>   			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>>   
>> @@ -667,6 +668,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>>   					kfree(buf_info->cb_buf);
>>   				}
>>   			}
>> +			read_lock_bh(&mhi_chan->lock);
>>   		}
>>   		break;
>>   	} /* CC_EOT */
>> @@ -1204,6 +1206,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>>   	int eot, eob, chain, bei;
>>   	int ret;
>>   
>> +	/* Protect accesses for reading and incrementing WP */
>> +	write_lock_bh(&mhi_chan->lock);
>> +
>>   	buf_ring = &mhi_chan->buf_ring;
>>   	tre_ring = &mhi_chan->tre_ring;
>>   
>> @@ -1221,8 +1226,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>>   
>>   	if (!info->pre_mapped) {
>>   		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
>> -		if (ret)
>> +		if (ret) {
>> +			write_unlock_bh(&mhi_chan->lock);
>>   			return ret;
>> +		}
>>   	}
>>   
>>   	eob = !!(flags & MHI_EOB);
>> @@ -1239,6 +1246,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>>   	mhi_add_ring_element(mhi_cntrl, tre_ring);
>>   	mhi_add_ring_element(mhi_cntrl, buf_ring);
>>   
>> +	write_unlock_bh(&mhi_chan->lock);
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.7.4
>>
>>
