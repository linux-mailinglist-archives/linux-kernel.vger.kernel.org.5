Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36D7D84D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjJZOep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345275AbjJZOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:34:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440901AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:34:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QEKuAw016229;
        Thu, 26 Oct 2023 14:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UEcHMU92gXQ4j8QVvUTyivM0ixWQwT+arfYq5SCMI8w=;
 b=kydpvEhP8YA5LN7GpevnUs+T5+EaPTZ8u0IHs/VcIFIOepe97I5e/1lmt0humcWcFWKF
 VBDbmnq9A5JL5Z1iwZi7/gtMKhofAK/4ZmSOUfkVVmeMvh0fStKQaaWd+IT9blL3Do0p
 1q0iWNfOuDVFa13scCVs4Z6BgKAlOIrvBzH3szdv71n1rClA74p8EhS5ggTts1t4MFWZ
 xfMtzozl2SwCCrJC0dId0ABr0BrOfLJhZgXCXi85Y4gmn6yOM4SfM6xm56yr29nRTvUt
 nqMcD+dp49Iift48gXxI0WDS+QlfgL/lp06Nz48rqimHkasiPVimZ2gb5G3PPPowDCHG CA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyfm9hbjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:34:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39QEYIWP009856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:34:18 GMT
Received: from [10.216.44.163] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 07:34:15 -0700
Message-ID: <1405d85b-f749-6ba6-c5f5-ad1e38feef83@quicinc.com>
Date:   Thu, 26 Oct 2023 20:04:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <russell.h.weight@intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1696482420-1329-1-git-send-email-quic_mojha@quicinc.com>
 <ZTF+QLjm8ceL9a00@bombadil.infradead.org>
 <a0c294e1-f76a-6382-ee0f-f1d75ac9d781@quicinc.com>
 <ZTacD4tWZHrzhmQT@bombadil.infradead.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ZTacD4tWZHrzhmQT@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0lYuMFLcj4mLLR2EK1NbRNMNNVgOCkJo
X-Proofpoint-GUID: 0lYuMFLcj4mLLR2EK1NbRNMNNVgOCkJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxlogscore=906 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260125
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 9:45 PM, Luis Chamberlain wrote:
> On Mon, Oct 23, 2023 at 06:11:18PM +0530, Mukesh Ojha wrote:
>> However, if you think we should rename this
>> 'only_kill_custom' to something like its inverse 'kill_all' and reverse the
>> below check to be more meaningful now ?
>>
>>     		if (kill_all || !fw_priv->need_uevent)
> 
> This seems like a better approach to make the intent clear and avoid
> future confusion.

Thanks, have sent it here.

https://lore.kernel.org/lkml/1698330459-31776-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh

> 
>    Luis
