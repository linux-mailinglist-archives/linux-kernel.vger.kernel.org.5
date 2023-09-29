Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FD7B2CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjI2HO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjI2HOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:14:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD4199;
        Fri, 29 Sep 2023 00:14:53 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T6w0DL022589;
        Fri, 29 Sep 2023 07:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6YtU+0Lz8uDm5psqIY6d4cyYHrQVb3TayxFojbg2QP4=;
 b=oVjU1KM9yYEiMygGx1ukYbFeCbc6IbIdDxMFXfsqN9QNQ3JiY3zjn8yABIhM6DJ3Y6t1
 pvR3Ing+UVKZyX8lZr4vtRbbpXzaf/rYBaLEW4vaos0I+Wg3WUttYWEqWTROjXjTyDrY
 bXOX5vTPziXrGdFSzAvjXEHH3oKUjr00B2me+acc40NI/GDU3fkbF9tc5NDtcyc2PRDn
 RaTE6A2uLT2xHc/RBKxdfuwU0W41KXjG88rvi3JC81ipIAclmdTbgwJtl3NydQa/nhMR
 FPPKOGihb3xRSgIP9etGjdCrGBez1WfVfQBk016Etrn02kX3hM/NbqkTCIz2b7+zzqOE VQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdfbrs1n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:14:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T7Em8m002698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:14:48 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 00:14:45 -0700
Message-ID: <d5cc2254-6500-c4bb-3284-da397b6b3a5a@quicinc.com>
Date:   Fri, 29 Sep 2023 12:44:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1] misc: fastrpc: Free DMA handles for RPC calls with no
 arguments
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <ekangupt@qti.qualcomm.com>, <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>
References: <1693463029-9311-1-git-send-email-quic_ekangupt@quicinc.com>
 <2023092833-daylong-gecko-eb0e@gregkh>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <2023092833-daylong-gecko-eb0e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4DzaRapbyh3htRjn6VbSj6iseVWXIrJQ
X-Proofpoint-GUID: 4DzaRapbyh3htRjn6VbSj6iseVWXIrJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=644 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290060
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2023 6:35 PM, Greg KH wrote:
> On Thu, Aug 31, 2023 at 11:53:49AM +0530, Ekansh Gupta wrote:
>> The FDs for DMA handles to be freed is updated in fdlist by DSP over
>> a remote call. This holds true even for remote calls with no
>> arguments. To handle this, get_args and put_args are needed to
>> be called for remote calls with no arguments also as fdlist
>> is allocated in get_args and FDs updated in fdlist is freed
>> in put_args.
>>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> 
> What commit id does this fix?  Or is this new functionality?
> 
I'll update the details in the next patch.

-ekansh
> thanks,
> 
> greg k-h
