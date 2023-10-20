Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C084E7D1865
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjJTVqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjJTVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:46:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F510F9;
        Fri, 20 Oct 2023 14:46:40 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KLSoP4021504;
        Fri, 20 Oct 2023 21:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9VYrZNyRJxcuHF8g0qEMMo0m1W1VPJCd0bidkFmQh2k=;
 b=XDPn1M8WWiVukLohTuy+cFedkhFpcXRQpOrdszpWKNAuzkBzQ+I8kh4H3gA3T28wuKNM
 /pRLw2u6gqHLWmLJRJrUHmeR/1FMFBKOaMZW7up/tFht+jlAUGHz8cSU6IUBxe6rtC7x
 9EkUEtiek6oCcIXQnlnFcRx+jgrPC9hfaQXy3MalfSaDT9UhUFRLJmP8aeYQIXlJdftm
 7PDTfizIFMrChxHS6vNst37+bBVx4ineGzwvj7iWvetYPev7FUJd7NstvbLnyYmIhl6x
 oMp9lTAXZYUddd+duVrR+59W1d1I3rj6rs6JD33LLCesz0NtbC48wHhlHS2cD4Xa8SMU sQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwr36fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 21:46:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39KLkYKY022595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 21:46:34 GMT
Received: from [10.48.241.70] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 14:46:34 -0700
Message-ID: <060a8bd0-6470-4d75-a5bb-e012c3e7cb3d@quicinc.com>
Date:   Fri, 20 Oct 2023 14:46:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] [brcmfmac] Add support for encoding/decoding 6g
 chanspecs
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Daniel Berlin <dberlin@dberlin.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <linux-kernel@vger.kernel.org>
References: <cover.1697650207.git.dberlin@dberlin.org>
 <0b95944fcf047b3ec83cecb0c65ca24de43810fd.1697650207.git.dberlin@dberlin.org>
 <d55c968a-d953-67d7-cdff-f856422607f5@broadcom.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <d55c968a-d953-67d7-cdff-f856422607f5@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tsVGui_6M6OCbHfNXcwqjRTpoaV_Qs4Y
X-Proofpoint-ORIG-GUID: tsVGui_6M6OCbHfNXcwqjRTpoaV_Qs4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=748 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2023 2:57 AM, Arend van Spriel wrote:
> On 10/19/2023 3:42 AM, Daniel Berlin wrote:
>> This patch adds support for 6G chanspecs, as part of adding 6G and
>> 802.11ax support.

In ath drivers we are actively discouraging the use of "G" since 1) that 
is not the SI unit for gigahertz, and 2) it conflicts with the use of 
that term in cellular communication where it refers to the generation of 
technology. So I'd recommend using GHz in descriptions/comments and 
GHZ/ghz in identifiers.

Side note: in USA, Comcast have started promoting their network as 
"10G". In their case they're referring to 10 Gbps speeds. They are being 
called out for misleading consumers with that terminology.
<https://arstechnica.com/tech-policy/2023/10/comcast-should-stop-advertising-slower-speeds-as-10g-industry-group-says/>
