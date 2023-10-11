Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340FC7C5FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjJKV7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJKV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:59:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6459E;
        Wed, 11 Oct 2023 14:59:24 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BIxBgK009576;
        Wed, 11 Oct 2023 21:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OgrDYYwCOL/ieAwAtOQYeAM72138+c5Elgd6rcII/+U=;
 b=Jv/A/sBu/SnbZdcd0z3AQYUnKwzjj40Pq2dfCf5DR6qn6uAbZP1IqJOH30lFE47Q1cF2
 zGhVy02WB4Rv2AoduwfAaXMLX3LCXVsIgjSQlZSjRuB+z+35UHHS4pgSiTTW/bK+YvAo
 GbNQBJzNnVC2oVo2ccxCSPCSbfyTLLrv29dLMBnlinQnoXXTf157pkIJxm1GE1KcrUqd
 lJjpJhyU9QTHpuO8qWKeeN0K5tq+TF38wIU+Hutkar5sFsOgG6R4H7pTXHdEXKoo/+Wk
 DK1gEObFJAOnir1svtvDmpC7H5iYWiBoOQGSJT60Cgu4lKalHOtqdJ73bBiKDpZWISi3 XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tngtpapdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 21:59:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39BLwrOg018902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 21:58:53 GMT
Received: from [10.71.115.198] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 11 Oct
 2023 14:58:53 -0700
Message-ID: <2c91a35a-43ea-4e20-4065-e30cdaf1931f@quicinc.com>
Date:   Wed, 11 Oct 2023 14:58:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] usb: host: xhci: Avoid XHCI resume delay if SSUSB
 device is not present
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230919224327.29974-1-quic_wcheng@quicinc.com>
 <5f491814-c105-64e3-93c0-5fff89160ac1@quicinc.com>
 <2023101111-acquire-dosage-65c1@gregkh>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <2023101111-acquire-dosage-65c1@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Kcr5DhnmzyabB757p4zmeXZ4_crNGPj9
X-Proofpoint-GUID: Kcr5DhnmzyabB757p4zmeXZ4_crNGPj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_17,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=501
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110194
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 10/11/2023 2:24 AM, Greg KH wrote:
> On Tue, Oct 10, 2023 at 12:01:05PM -0700, Wesley Cheng wrote:
>> Friendly ping to see if there are any updates/feedback on this patch?
> 
> Please do not top-post.
> 
> Anyway, did you not see my bot's response to this patch?  If so, why did
> you ignore it, that's why we didn't do anything with it...
> 

Got it, I was mainly just checking to see if the new way of determining 
if there is a SSUSB device connected is the way we want to implement it, 
since I changed to using the ports_suspended bitmask.  I'll send a new 
revision with the changelist.

Thanks
Wesley Cheng
