Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5887CCDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbjJQUWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:22:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04699E;
        Tue, 17 Oct 2023 13:22:05 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HIBKkw026527;
        Tue, 17 Oct 2023 20:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/qf3pasEzmjys+cMl5PwEBlVeKLc105W8ndPVPmEegU=;
 b=ezxgBamU3b5h403v98h6ggxdCUu8eVPvT5YQkTgXYC+FcaQVxEZbPrFVF7hxhHbM5UEr
 BBBt9X2NO+1qMNZT7/56eipjtfC44l/5cnQ/Y6JXeRAJ5aeoYag02yGmE3jj21SXtR2O
 954NDLmFS0aYWTh4lC3ETDr53ekAYvaGTFU1rDQGpE8FgdTGMMgOGVM2s5jdZiLG4pzx
 /EahPVdBPutYkiGME/CMJFK16EIDQgBWs4TkJqMeaZ6iPyeK3alJCSlyqn4pKFE6Nj8z
 tsMWHKsBlWjMXqyxQcTrfMcR2sLY+CQTCy9nSgp834yUQZ9Cvfmt2bJ9/sSfHEa17gCw VA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ts85fukf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:21:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HKLsOM032450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:21:54 GMT
Received: from [10.111.183.229] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 13:21:53 -0700
Message-ID: <ac17b30f-3c3c-4384-a8a9-1b2c9d92ec3e@quicinc.com>
Date:   Tue, 17 Oct 2023 13:21:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: wilc1000: use vmm_table as array in wilc struct
Content-Language: en-US
To:     =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>,
        Michael Walle <mwalle@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        <stable@vger.kernel.org>
References: <20231017-wilc1000_tx_oops-v3-1-b2155f1f7bee@bootlin.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231017-wilc1000_tx_oops-v3-1-b2155f1f7bee@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _NdsBOsBRAUb3_eFgsyulir8muyyx9GT
X-Proofpoint-GUID: _NdsBOsBRAUb3_eFgsyulir8muyyx9GT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxlogscore=583
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2023 1:43 AM, Alexis Lothoré wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Enabling KASAN and running some iperf tests raises some memory issues with
> vmm_table:
> 
> BUG: KASAN: slab-out-of-bounds in wilc_wlan_handle_txq+0x6ac/0xdb4
> Write of size 4 at addr c3a61540 by task wlan0-tx/95
> 
> KASAN detects that we are writing data beyond range allocated to vmm_table.
> There is indeed a mismatch between the size passed to allocator in
> wilc_wlan_init, and the range of possible indexes used later: allocation
> size is missing a multiplication by sizeof(u32)
> 
> Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

