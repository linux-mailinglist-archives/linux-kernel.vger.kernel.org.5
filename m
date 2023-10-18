Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0C7CD36D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjJRFMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJRFMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:12:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14DB0;
        Tue, 17 Oct 2023 22:12:11 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I4kI5D025553;
        Wed, 18 Oct 2023 05:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0g6yWnGi+kL/V+tl/8EBYh5Ghj1WRK7FcRlbWuHraF4=;
 b=id8tDVWu/HxjEUVoPMvoe2JlMYtUwQ1Di9Vfd66Dd99PJsrvEvx6K/h6lFD9gUaHMLgw
 72UCvW2vMuuJB07XHOAHtWRxHCBmvSycMWN1SL2Orh3kNvwuc8zMSoQw2adjiUF4hL12
 PgI734UjQYh2OgvznL8sVPKifbqaupjQ+e3n5VL2hnGrNwCFAgk3vsveA3uqdqvSKBKR
 75nXYwZ6ZhPSz03cbxfhd5IUz7Gd6dj70VBfq7DDK0FbVysE1c9clssFiWFhpT+gQWEj
 4gZKzLsI5g9jq5r8KdV5nSFVtBqP+axZzz2dygE83O0emwdMi1uueT+lQlzgR7aN5AeG Sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsv0v1s27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 05:12:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I5C8we003320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 05:12:08 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 22:12:05 -0700
Message-ID: <02114b35-5e71-4f97-ba2c-9277103347d5@quicinc.com>
Date:   Wed, 18 Oct 2023 10:42:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] misc: fastrpc: Add support to save and restore
 interrupted
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <ekangupt@qti.qualcomm.com>, <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>
References: <1697534799-5124-1-git-send-email-quic_ekangupt@quicinc.com>
 <1697534799-5124-5-git-send-email-quic_ekangupt@quicinc.com>
 <2023101739-heftiness-reproach-ef96@gregkh>
 <d800dcbf-83dc-4b0f-bdd3-fc0efb5dd771@quicinc.com>
 <2023101743-discern-plunging-83e4@gregkh>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <2023101743-discern-plunging-83e4@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vtfq0fXBlyGm1r7yVkKnnK5hVsxCH6HA
X-Proofpoint-GUID: vtfq0fXBlyGm1r7yVkKnnK5hVsxCH6HA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=690
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/2023 9:40 PM, Greg KH wrote:
> On Tue, Oct 17, 2023 at 08:36:28PM +0530, Ekansh Gupta wrote:
>> On 10/17/2023 6:50 PM, Greg KH wrote:
>>> On Tue, Oct 17, 2023 at 02:56:38PM +0530, Ekansh Gupta wrote:
>>>> For any remote call, driver sends a message to DSP using RPMSG
>>>> framework. After message is sent, there is a wait on a completion
>>>> object at driver which is completed when DSP response is received.
>>>>
>>>> There is a possibility that a signal is received while waiting
>>>> causing the wait function to return -ERESTARTSYS. In this case
>>>> the context should be saved and it should get restored for the
>>>> next invocation for the thread.
>>>>
>>>> Adding changes to support saving and restoring of interrupted
>>>> fastrpc contexts.
>>>>
>>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>>> Change-Id: Ia101acf7c1bf6018635536082bf7ea009093c948
>>>> ---
>>>> Changes in v2:
>>>>     - Fixed missing definition
>>>>     - Fixes compile time issue
>>> You forgot to run checkpatch.pl :(
>> I did run checkpatch.pl and also tried compilation test. checkpatch.pl is
>> suggesting 0 errors, 0 warning and compilation also worked without any
>> errors. I might have checked on last week's base as there were no changes in
>> these files. I'll check the patches with latest version and update again if
>> any errors/warnings are observed. Thanks for reviewing the patch. -ekansh
> The "Change-Id:" should not be there, and I thought checkpatch would
> catch that.  If not, no big deal, you should have :)

Thanks for pointing this out, Greg. I'll update this with a new patch.

>
