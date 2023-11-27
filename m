Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA08C7F9ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjK0HMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjK0HMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:12:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362FF12F;
        Sun, 26 Nov 2023 23:12:45 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6KJLx032081;
        Mon, 27 Nov 2023 07:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Q2cevitLQJMwXLFs8IRoxaS/CwlcSC8j44PxM5Vgrg0=;
 b=MZeQPEUTtRixwS/Wfv8PJtZEsJBAuks6Q+6j3Xx+efJ/1qUrIdHWf+5nUGiXiyjBg9On
 icwnv70BT3y509DdnTJjlsrUuxebFWipyqa14QR4Qhx66N4LkTUnhL4iohKuzdjej2eR
 edS+Cyikr1uzqHsRYQW7YC1dc6fCf2EKkPKvYYRBwXJLZVLq7gUJmPXW7ObuVKp3nIO8
 Q4lAMR/xe5XdL3u6APOfIcSpd04A6U9BdvrX2jsHZBVEEMTwLmeyEbADYmggly0Wc8Up
 DEDehmSkDqo/t+B9+r+495OIAJutOkvIOaiwCIFXqXTYhOKGguqTDbLJOyczmnWeaps0 BQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ukpdh2apw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 07:12:35 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR7CZwP022665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 07:12:35 GMT
Received: from [10.253.15.56] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 26 Nov
 2023 23:12:33 -0800
Message-ID: <66d37188-f5e0-4f8a-b190-9b3865876cdd@quicinc.com>
Date:   Mon, 27 Nov 2023 15:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] bus: mhi: host: Drop chan lock before queuing
 buffers
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1699939661-7385-1-git-send-email-quic_qianyu@quicinc.com>
 <1699939661-7385-3-git-send-email-quic_qianyu@quicinc.com>
 <20231124100403.GA4536@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20231124100403.GA4536@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -TW-WKks9taKS224oOzF6AEO2RmaUwbT
X-Proofpoint-ORIG-GUID: -TW-WKks9taKS224oOzF6AEO2RmaUwbT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_05,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=754
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/24/2023 6:04 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 14, 2023 at 01:27:39PM +0800, Qiang Yu wrote:
>> Ensure read and write locks for the channel are not taken in succession by
>> dropping the read lock from parse_xfer_event() such that a callback given
>> to client can potentially queue buffers and acquire the write lock in that
>> process. Any queueing of buffers should be done without channel read lock
>> acquired as it can result in multiple locks and a soft lockup.
>>
> Is this patch trying to fix an existing issue in client drivers or a potential
> issue in the future drivers?
>
> Even if you take care of disabled channels, "mhi_event->lock" acquired during
> mhi_mark_stale_events() can cause deadlock, since event lock is already held by
> mhi_ev_task().
>
> I'd prefer not to open the window unless this patch is fixing a real issue.
>
> - Mani
In [PATCH v4 1/4] bus: mhi: host: Add spinlock to protect WP access when 
queueing
TREs,  we add 
write_lock_bh(&mhi_chan->lock)/write_unlock_bh(&mhi_chan->lock)
in mhi_gen_tre, which may be invoked as part of mhi_queue in client xfer 
callback,
so we have to use read_unlock_bh(&mhi_chan->lock) here to avoid 
acquiring mhi_chan->lock
twice.

Sorry for confusing you. Do you think we need to sqush this two patch 
into one?
>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index 6c6d253..c4215b0 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -642,6 +642,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>>   			mhi_del_ring_element(mhi_cntrl, tre_ring);
>>   			local_rp = tre_ring->rp;
>>   
>> +			read_unlock_bh(&mhi_chan->lock);
>> +
>>   			/* notify client */
>>   			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>>   
>> @@ -667,6 +669,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>>   					kfree(buf_info->cb_buf);
>>   				}
>>   			}
>> +
>> +			read_lock_bh(&mhi_chan->lock);
>>   		}
>>   		break;
>>   	} /* CC_EOT */
>> -- 
>> 2.7.4
>>
>>
