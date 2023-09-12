Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89E79D3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjILOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjILOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:32:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F0115;
        Tue, 12 Sep 2023 07:32:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CDo0Kr006822;
        Tue, 12 Sep 2023 14:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0MXVxIMxcRyFzQm0Xx9I9lFxvozA1Kor5DCnR3zK4y4=;
 b=dnIejVxKqnp5xXncE0ZUNMrPRJv22cT/c11yDNbXVdyszxMCppyB8N5RirZ6tC8iPHUD
 LHSLfapwGWs2HALaDDWDCjObRbv/E1tGuqq6q/Xt57XkjMyAPpGJ2G4VSjDChyzFSpfK
 2Va2Q+BRSJUpMNnoguOtMqQOgKeP+jB/vHNJ8wyiRckhQWlztB7ILUIym+6MXrD9npJy
 lCQ47sH67DrNqhqZ3cTNsApcyarKadFzl2pCg5Q+CL2SOyZACG6gxi6Wp7c071QnQu47
 75jEFl+0bzN6YXYc1pGOK5LeN3eAtyEviZA/dBt6nRrt8/GEiZ/uWNqqBzYh+GoH0BiB Vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2qefggng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 14:32:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CEWHCd014452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 14:32:17 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 12 Sep
 2023 07:32:11 -0700
Message-ID: <5e80e600-b523-476a-81bd-93d2c517b7b6@quicinc.com>
Date:   Tue, 12 Sep 2023 20:02:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mtd: rawnand: qcom: Unmap the right resource upon
 probe failure
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_charante@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_pkondeti@quicinc.com>
References: <20230912115903.1007-1-quic_bibekkum@quicinc.com>
 <20230912142847.4610c0a0@xps-13>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20230912142847.4610c0a0@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UUqJCj4RTDMBGTqI3ChIGIYPOVlEBR2D
X-Proofpoint-ORIG-GUID: UUqJCj4RTDMBGTqI3ChIGIYPOVlEBR2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=473 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 5:58 PM, Miquel Raynal wrote:
>> We currently provide the physical address of the DMA region
>> rather than the output of dma_map_resource() which is obviously wrong.
>>
>> Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
> Cc: stable?
Cc: stable@vger.kernel.org
