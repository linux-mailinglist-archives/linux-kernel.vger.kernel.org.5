Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D666576B3E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjHALx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjHALxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:53:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02EAA1;
        Tue,  1 Aug 2023 04:53:24 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371Av7Cr015836;
        Tue, 1 Aug 2023 11:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hobekgFwFVHi8ej+eRyD83a+C/rWmf+8Ggb9eBXK7po=;
 b=EkXt+yM/zPVrb0n3NllZ71jTbccY8i1JLRmcRHJdaoEv9tkahvNRX4p5CRu7lEeylD5+
 wBhAQnBQaCqXgiE3o1y+gSsCNWnlkopaRI8un5d0jHEuz/B+zYIbnNkzMDMXGj8vgBs1
 kOAlldENtlq0SzkHelChwqneTOLBtJLg6Rc9lxxrNSJNj5Ar8+aMqjY6pNdFp5M+c133
 QOWumcmWcbCBXw0nD1E1GVaceHgPbchTyLTnuEUghVYhVHC/RKtMjHQ3iLg7wamWZcN4
 DQIG3ixOH4sFkxIclNtvEnUdlybux8Fd/NKak6DvMVj5SqZOqUNwHU24i38vzy02ZkdI Vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d8gtwyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 11:53:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371BrIE5017287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 11:53:18 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 1 Aug
 2023 04:53:16 -0700
Message-ID: <090974fb-5f42-a14f-00bf-6d9d042067e3@quicinc.com>
Date:   Tue, 1 Aug 2023 17:23:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] usb: common: usb-conn-gpio: Prevent bailing out if
 initial role is none
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "# 5 . 4" <stable@vger.kernel.org>
References: <1690880632-12588-1-git-send-email-quic_prashk@quicinc.com>
 <0c6e3bc3-f71a-08f0-6f04-2580ca776466@collabora.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <0c6e3bc3-f71a-08f0-6f04-2580ca776466@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qLrnDBs-otPpgJ49sZom0MR5lhPr6rmu
X-Proofpoint-GUID: qLrnDBs-otPpgJ49sZom0MR5lhPr6rmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=533
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010107
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01-08-23 04:31 pm, AngeloGioacchino Del Regno wrote:
> Il 01/08/23 11:03, Prashanth K ha scritto:
>> Currently if we bootup a device without cable connected, then
>> usb-conn-gpio won't call set_role() because last_role is same
>> as current role. This happens since last_role gets initialised
>> to zero during the probe.
>>
>> To avoid this, add a new flag initial_detection into struct
>> usb_conn_info, which prevents bailing out during initial
>> detection.
>>
>> Cc: <stable@vger.kernel.org> # 5.4
>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection 
>> detection driver")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> 
> Just noticed that there was a v3, sent the T-b to the v2 erroneously, so:
> 
> MediaTek platforms
> 
> Tested-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
> 
> 
Thanks AgneloGioacchino for testing.

Regards
Prashanth K
