Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7A7FAA49
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjK0T1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjK0T1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:27:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBE019BA;
        Mon, 27 Nov 2023 11:27:05 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARIqqDq004021;
        Mon, 27 Nov 2023 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=croI6yxCqr3QxoRfDc306jqTkJc9QscPj1bSin8cZQc=;
 b=ttArYMbnjRHfHDTfJLNPi+5suBkXCQf3Uf4u6bmljZwTHN+iB5obTAiFcnmVxPWN4CK6
 xBhtBmN8KwhfnuQi4rHeURWTXKjOwIOLGOKwq1wuL4echoU3ZQCthmDkfMdRsCVJzacy
 vU2zkJvQjG/L+Uyh0pYwfYCU0K8yE7XxY0mbFB3WIoRIEmOagipBDP38nHwHvJDsVuFJ
 8BDqZ4SMNsl1DrOmIi6fRshCZB+usBJ0Ya5GHK/vClBUb+396i6aMAMtVNuugi6eN+Dp
 V8zoWw8pQwDyD41Y/GK3ea6Sig8GVLo8PJyEHHJumlvLu01Ooa4zfWAn8oJl53N4syHL Jg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0s1rtqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 19:26:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARGobmr018622;
        Mon, 27 Nov 2023 19:26:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjtfug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 19:26:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARJQYG88782352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 19:26:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DBF558067;
        Mon, 27 Nov 2023 19:26:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1587E58052;
        Mon, 27 Nov 2023 19:26:34 +0000 (GMT)
Received: from [9.61.156.220] (unknown [9.61.156.220])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 19:26:34 +0000 (GMT)
Message-ID: <986edf2e-10ac-211b-417c-cb2818a7fbe0@linux.ibm.com>
Date:   Mon, 27 Nov 2023 13:26:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/55] media: aspeed: Stop abusing of min_buffers_needed
 field
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-14-benjamin.gaignard@collabora.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20231127165454.166373-14-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1n5XkrcHejoRSO-ioWKsUYlYff7dUNl3
X-Proofpoint-GUID: 1n5XkrcHejoRSO-ioWKsUYlYff7dUNl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_17,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270135
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/23 10:54, Benjamin Gaignard wrote:
> 'min_buffers_needed' is suppose to be used to indicate the number
> of buffers needed by DMA engine to start streaming.
> aspeed doesn't use DMA engine and just want to specify
> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
> That 'min_reqbufs_allocation' field purpose so use it.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> CC: Eddie James <eajames@linux.ibm.com> (maintainer:ASPEED VIDEO ENGINE DRIVER)
> CC: Joel Stanley <joel@jms.id.au> (supporter:ARM/ASPEED MACHINE SUPPORT)
> CC: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ARM/ASPEED MACHINE SUPPORT)
> CC: openbmc@lists.ozlabs.org (moderated list:ASPEED VIDEO ENGINE DRIVER)
> CC: linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
> ---
>   drivers/media/platform/aspeed/aspeed-video.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index d08aa7f73d4f..c28b10808cda 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -2034,7 +2034,7 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
>   	vbq->drv_priv = video;
>   	vbq->buf_struct_size = sizeof(struct aspeed_video_buffer);
>   	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -	vbq->min_buffers_needed = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
> +	vbq->min_reqbufs_allocation = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
>   
>   	rc = vb2_queue_init(vbq);
>   	if (rc) {
