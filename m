Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73037AE2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjIZA1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZA12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:27:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468C109;
        Mon, 25 Sep 2023 17:27:22 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q0MBkU001131;
        Tue, 26 Sep 2023 00:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9HyKE05hsD4scaPHRxwA8ZmAgqW0L3LESL3Jf+4nGUA=;
 b=mr0Ih29OO9Lwaj3nz+KU7OWvsG6MgsgpdDPw2AMIhbyz+Qtp3AroWowlI18jAp4leCi7
 azrafe6xrTMg81ioxVStwm5X4pJS/zGeLhZ0NgsvnaTtkxzf0Oz2aMxuChYmGZlJBZEU
 5dmTqBepK5FX11Si2e+rYqNgRaIdg9UP+usqtBLhqh6a4S171FZF4t71r4avaeRhrhsF
 d0DnUeFopsZ47OOGVXrj5PKnE/WNAzmPIYhAfad/U45L4W4jgSn55bDivFo93bYkiFUw
 H0/I7R2QgitQk9JvQAifz3Nf+vyWGRLGBDEQpPy/gU4SbiAfLziBiKUIm0iZW1GUe2CH LQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb3hftn9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 00:27:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q0RJLg028342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 00:27:19 GMT
Received: from [10.48.244.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 17:27:18 -0700
Message-ID: <ed6a9fe3-9197-4ffd-9fd4-c1a959b7fdc9@quicinc.com>
Date:   Mon, 25 Sep 2023 17:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless 1/2] ath: dfs_pattern_detector: Fix a memory
 initialization issue
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <kernel-janitors@vger.kernel.org>, <kvalo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <quic_kvalo@quicinc.com>
References: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
 <c82d9d47-9c4b-4af9-a1e8-7c975b53fe30@quicinc.com>
 <b3be8653-ea3f-bc3a-c38e-e3ec290695ea@wanadoo.fr>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <b3be8653-ea3f-bc3a-c38e-e3ec290695ea@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3e_5SmQphfSeRoerxyRnW8mHobQUOtZy
X-Proofpoint-ORIG-GUID: 3e_5SmQphfSeRoerxyRnW8mHobQUOtZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_19,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=728 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/2023 1:54 PM, Christophe JAILLET wrote:
> Le 25/09/2023 à 20:46, Jeff Johnson a écrit :
>> On 9/23/2023 11:57 PM, Christophe JAILLET wrote:
>>> -    cd->detectors = kmalloc_array(dpd->num_radar_types,
>>> +    cd->detectors = kcalloc(dpd->num_radar_types,
>>>                         sizeof(*cd->detectors), GFP_ATOMIC);
>>
>> nit: align descendant on (
> 
> Agreed, but as the code is removed in patch 2/2, I thought that having a 
> smaller diff was a better option.
> 
> Let me know if I should resend the serie.

nevermind, don't bother

