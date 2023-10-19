Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E897CFD50
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346044AbjJSOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJSOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:50:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4B130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:50:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JDsd0r006181;
        Thu, 19 Oct 2023 14:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3z+iPXfGADScFtU5UfRP/yHI0/gR1dwx3595GUeN6NY=;
 b=lXB9sgBPB20UZu01JHRujaWCBVCOqRWxclo4LHYeyWiEa/hPrl9N2Z8qlv0rwd7B6S9n
 JRle4FXxjB8CavN/nlNazKl/SUgu5bM+Mh678VQevq0iUaC0BnKhTHADtLldk/2uv8cs
 lP1yO1UiMk+k+k+YogYFpxasmLQhDkZg3z34LwZo8DcboYTMxmK9YTUCoqjVmgDou1j0
 7gXQkQfBE96vf6He9j7nUUBaQoJACkphHYxjvsqBaSO0loIH2JupgOT7vCpRJE9VTWT8
 0A0YAl8zC0d8Kpk/LwCkGHK6vIwDoCyz5TJFs1GBVXI/kxtqCvsw8tGTZLxbt3jyXVlO eg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tth2f2sru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 14:50:52 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JEop3g004602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 14:50:51 GMT
Received: from [10.216.55.27] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 19 Oct
 2023 07:50:49 -0700
Message-ID: <bf387609-7e5d-fbe4-a6a1-ade759adb881@quicinc.com>
Date:   Thu, 19 Oct 2023 20:20:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <russell.h.weight@intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
 <ZSXQnEf5VxOUZ/4g@bombadil.infradead.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZSXQnEf5VxOUZ/4g@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XObX6cU0H93AsRksm1vPqcd4-m6S2CiV
X-Proofpoint-GUID: XObX6cU0H93AsRksm1vPqcd4-m6S2CiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=848 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190127
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 4:00 AM, Luis Chamberlain wrote:
> 
> Seems like you just have to fix the 0-day build issues.

V3 was posted a day after that.


https://lore.kernel.org/lkml/1696482420-1329-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh
> 
>    Luis
