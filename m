Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6137B2CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjI2HXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjI2HXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:23:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DEF1A7;
        Fri, 29 Sep 2023 00:23:13 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7IwHe007287;
        Fri, 29 Sep 2023 07:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7PhJ/1snztbIAvJzVIeW/P7/Qyzopbj/fqKd87GFOjI=;
 b=JvWkNCdmW0gayqaeAt12E5fXacPwzAndTdKfTynixTBsBHnFWCZyPPwQV3k+pkhypmmX
 3qrN/PDXTwurSuVV2FTK1VHtweOjk9VLjEaP6d8UraQR2W2XEyfbSdArbaLxtQnrDuFX
 EeDwN2RGhebG7NxjrD4VUq5aDtQD4ZJP2f5vkaBKhcbIkSxj9Pi3vpySh6FvYf1hh/Th
 v+m+trK24qBinMSePRJFHl41Hehs0m943rMTHwIv/yyVc1zWr1X+uIXPjGvmqrk59a7g
 jj4njaoE/HDfESOZMFuPJoj2dZWHly+L2zH4KqowAAe8RGs7/3WxDrnY/sKWUZ7m622x Lw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td3ggav1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:23:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T7N8RC026214
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:23:08 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 00:23:06 -0700
Message-ID: <6e9200a1-cf3c-27ca-ceef-7d9b70297530@quicinc.com>
Date:   Fri, 29 Sep 2023 12:53:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] misc: fastrpc: Reset metadata buffer to avoid
 incorrect free
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <ekangupt@qti.qualcomm.com>, <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>
References: <1693463723-16937-1-git-send-email-quic_ekangupt@quicinc.com>
 <2023092840-balmy-proved-e337@gregkh>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <2023092840-balmy-proved-e337@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TRkRo4syH3r5Z65fY3-QKNzkUsm3-fWc
X-Proofpoint-ORIG-GUID: TRkRo4syH3r5Z65fY3-QKNzkUsm3-fWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=806
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309290061
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2023 6:38 PM, Greg KH wrote:
> On Thu, Aug 31, 2023 at 12:05:23PM +0530, Ekansh Gupta wrote:
>> Metadata buffer is allocated during get_args for any remote call.
>> This buffer carries buffers, fdlists and other payload information
>> for the call. If the buffer is not reset, put_args might find some
>> garbage FDs in the fdlist which might have an existing mapping in
>> the list. This could result in improper freeing of FD map when DSP
>> might still be using the buffer. Added change to reset the metadata
>> buffer after allocation.
>>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> 
> What commit id does this fix?
> 
> And you sent 3 patches, but not in a list, what order are they to be
> applied in?
> 
Thanks for reviewing the patches, Greg. I'll send the 3 patches as a 
patch series for better understanding.

-ekansh
> thanks,
> 
> greg k-h
