Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0397F7BD862
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjJIKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjJIKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:19:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC882A3;
        Mon,  9 Oct 2023 03:19:09 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399ABsY2005081;
        Mon, 9 Oct 2023 10:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=u/wEYaoVMDSRX5EwZsNkzHNREQGGUju3+A/F6dL5KMQ=;
 b=C+BuRSuezti4S6hCz2X9YkHiC9ez+BZmSsExhmFM0NzC6cdINcfKDvEHGHt2e7AI3Ru2
 rkBzKTbYmBL2W3CQfRgsEwM9wMu+U/UggxheZmQihLFBZQOTFs/wQzy3wvilh+3CPDY9
 NpUWgqkmaKqzLN1TkTSX1zSy+u8y0aARpuSFjCS6U3R2XX79mfow2E89aZPieI2xqM28
 /n0v8Ja+ntOAqAu/cm+fhVRSkHb1tfJ112vbPu5v3Ubp/5ulYrJG0bg4jmGjTQ8yP+ws
 lOA7ljx/uB/yPd6zW3xhj9QTEXZit9VfUB9OAtzkB8ZHvbk82F+DVwNeqfz0ikDmCqem 7w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh5e24re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 10:18:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399AIVE7017102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 10:18:31 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 03:18:28 -0700
Message-ID: <2145b2d5-cade-eda0-8325-edf09b6f534c@quicinc.com>
Date:   Mon, 9 Oct 2023 15:48:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND] xhci: Keep interrupt disabled in initialization
 until host is running.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, <stable@kernel.org>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        "# 5 . 15" <stable@vger.kernel.org>
References: <1695379724-28628-1-git-send-email-quic_prashk@quicinc.com>
 <2023100753-jargon-resolute-0e55@gregkh>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <2023100753-jargon-resolute-0e55@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nfCD0h4TulTXiaq5B-V2Ue80ZbNZWIbO
X-Proofpoint-ORIG-GUID: nfCD0h4TulTXiaq5B-V2Ue80ZbNZWIbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_08,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=399 mlxscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090084
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07-10-23 04:50 pm, Greg Kroah-Hartman wrote:
> On Fri, Sep 22, 2023 at 04:18:44PM +0530, Prashanth K wrote:
>> From: Hongyu Xie <xy521521@gmail.com>
>>
>> [ Upstream commit 808925075fb750804a60ff0710614466c396db4 ]
> 
> This is not a valid git commit id in Linus's tree, where is it from?
> 
> confused,
> 
> greg k-h

The commit ID is a808925075fb750804a60ff0710614466c396db4. Missed the 
first letter. Sorry fir the confusion. Will Resend the patch with 
updated commit text.

- Prashanth K
