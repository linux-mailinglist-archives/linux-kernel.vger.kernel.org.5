Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBF7CC70C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbjJQPIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbjJQPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:07:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D171C10E5;
        Tue, 17 Oct 2023 08:06:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HEuIj7026852;
        Tue, 17 Oct 2023 15:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KEZdNzYRYywfB4yQ3nv8uljF/lqA7j7dSgwuUTqq8tU=;
 b=b/gRj6lQln4KDYUEX11phbX6fp2gJaQH2n7aDnKgv4/sTKl4QWbzGe9tUDlrjzEQG4h/
 0+irZ3DFFrjBU+Cx+rg5WQ9JVKOiDac5OnPMFUbv2UAP8za+wWNabBb1wP6umfDPdLlu
 VJNUr+Xbbv8iDGoOnwSjEb5F3VeRwlS0wjf3W+5mWNCk517y83HGVBP6zekD+wZbx5cZ
 DEYIk3MpafDrd2LljuWkzvuFUV966qKFeEdvYzK5g7gWICAYFm0v39W+eHRmlk8cJhDT
 0fMfOKYllJYHVSWzJuh4YUCNr81/PmJ8WB9lLI/kAx+p3n781esepVhIgSQ8L+sxYowj ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsnearxnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 15:06:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HF6Zxj020106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 15:06:35 GMT
Received: from [10.216.27.242] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 08:06:32 -0700
Message-ID: <d800dcbf-83dc-4b0f-bdd3-fc0efb5dd771@quicinc.com>
Date:   Tue, 17 Oct 2023 20:36:28 +0530
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
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <2023101739-heftiness-reproach-ef96@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sXMaRW1U0OxJEw7PMKx8dThuQCrxXIu5
X-Proofpoint-ORIG-GUID: sXMaRW1U0OxJEw7PMKx8dThuQCrxXIu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=666 mlxscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/2023 6:50 PM, Greg KH wrote:
> On Tue, Oct 17, 2023 at 02:56:38PM +0530, Ekansh Gupta wrote:
>> For any remote call, driver sends a message to DSP using RPMSG
>> framework. After message is sent, there is a wait on a completion
>> object at driver which is completed when DSP response is received.
>>
>> There is a possibility that a signal is received while waiting
>> causing the wait function to return -ERESTARTSYS. In this case
>> the context should be saved and it should get restored for the
>> next invocation for the thread.
>>
>> Adding changes to support saving and restoring of interrupted
>> fastrpc contexts.
>>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> Change-Id: Ia101acf7c1bf6018635536082bf7ea009093c948
>> ---
>> Changes in v2:
>>    - Fixed missing definition
>>    - Fixes compile time issue
> You forgot to run checkpatch.pl :(

I did run checkpatch.pl and also tried compilation test. checkpatch.pl 
is suggesting 0 errors, 0 warning and compilation also worked without 
any errors. I might have checked on last week's base as there were no 
changes in these files. I'll check the patches with latest version and 
update again if any errors/warnings are observed. Thanks for reviewing 
the patch. -ekansh

