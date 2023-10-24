Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7A7D5EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbjJXX0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJXX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:26:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE5D7A;
        Tue, 24 Oct 2023 16:26:03 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ONE801029059;
        Tue, 24 Oct 2023 23:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KF/sioqecxgO04pRTAgBIgZOc1rxb55qNAe0z+fj6eE=;
 b=YiaAcUmCRdh2U40IOFijvgdOU72kFpBuXhBTzKVd0gbHILFCEmhp+A3j2rXHsyhMJ7ut
 bH+c4+Zx5DOpdGOnfxgrLA1xN3gk0U1jVS0gODHUzPqI6OCC3xS2kIWiqlQyXgw6KXOD
 ZrtSMmdmsK7lXBDig7KvvuC2jKS36Hmk+4Ijbv5E45ciImTvBx+9tHSwWewjmyVnMOvk
 jZkGLY6Z/LtkuoRiXZtPwGM6gjIZbD/tuXSKQReWOuBooc4TuLO/BlNXRTanPJXCu83W
 qfz+vqSucoKIdL66Hiw7N4TnvgTqJUyww3ZKmTde8Wx/K/U2OgtV45tRAK56MG5lpvFJ EQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxn4359h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 23:25:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39ONPbXF019087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 23:25:37 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 16:25:36 -0700
Message-ID: <57a56da6-a86f-4bc3-beb6-8ef6dbbbb3bd@quicinc.com>
Date:   Tue, 24 Oct 2023 16:25:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     Kalle Valo <kvalo@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
 <87wmvcxjdy.fsf@kernel.org>
 <90328e09-5e48-4bd0-ac67-62a104b6eb76@quicinc.com>
 <202310241442.0E90AB9@keescook>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202310241442.0E90AB9@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E5cqTcCi23vb5xL7JXuTCYBb15h8lk9O
X-Proofpoint-ORIG-GUID: E5cqTcCi23vb5xL7JXuTCYBb15h8lk9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_22,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=362 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 2:43 PM, Kees Cook wrote:
> On Tue, Oct 24, 2023 at 07:11:51AM -0700, Jeff Johnson wrote:
>> On 10/24/2023 6:03 AM, Kalle Valo wrote:
>>> What about using just memcpy() to make it clear it's not really a proper
>>> string:
>>>
>>> arvif->u.ap.ssid_len = 4;
>>> memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);
>>>
>>
>> In the "changed & BSS_CHANGED_SSID" case that comes soon after this we just
>> set the length and use memcpy without clearing the rest of the buffer, so
>> doing the same here, as you suggest, would be consistent.
> 
> Ah, please ignore my other email asking about memcpy safety -- I'm
> reading threads backwards.  :)
> 
And I'm replying without first reading through my mail queue
