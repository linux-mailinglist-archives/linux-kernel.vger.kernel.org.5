Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B7A7539C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjGNLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjGNLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:42:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA935B8;
        Fri, 14 Jul 2023 04:42:05 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EBfQVR032494;
        Fri, 14 Jul 2023 11:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yyY3d4L/4TM3DnFCbW2Hi5z0uYaJ+hL5iiHAEEri3t4=;
 b=ecuTDy+XzJU5u5e8juH4vbzpvZZ9VI8hI91uNEYUODpyzhq1bv4FmYF6R9oX9+D8+Icq
 nEY0jaBvPzpH3DopmoH7KPfBAjWGo03Dx3hRpMmeASBt42upzxE+o2714SY7hlEsxZaE
 bjrOhvTWg8xAKbTnElp8atMUeGGaMz3oYpIh7khG2TnI0fhC/Q425kP0PEjTdvDyUmcD
 wsMJXgGL0ITTQcfwdE85ut1c0e6HnbCmdkF3sFK7LEHOkvlAJ20xDtV33yEvldi54Awm
 yjksj+bBb/QoARDgCVVn+DSigH+rJ157s/cm8tWP9Vt3rBis7BVPCs1KyfAYXwg9DsFC kw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpu91k10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 11:41:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EBfOal003060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 11:41:24 GMT
Received: from [10.50.55.51] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 04:41:21 -0700
Message-ID: <fdc49063-f90c-88d8-49bb-83f9da7c703a@quicinc.com>
Date:   Fri, 14 Jul 2023 17:11:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/5 v4] accel/qaic: tighten bounds checking in
 encode_message()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
CC:     Carl Vanderlip <quic_carlv@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <9a0cb0c1-a974-4f10-bc8d-94437983639a@moroto.mountain>
Content-Language: en-US
From:   Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
In-Reply-To: <9a0cb0c1-a974-4f10-bc8d-94437983639a@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UIehr1-6VSs5Egc2FYBdlPUW24Ca8XOs
X-Proofpoint-ORIG-GUID: UIehr1-6VSs5Egc2FYBdlPUW24Ca8XOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=743 clxscore=1011 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140105
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 1:50 PM, Dan Carpenter wrote:
> There are several issues in this code.  The check at the start of the
> loop:
> 
> 	if (user_len >= user_msg->len) {
> 
> This check does not ensure that we have enough space for the trans_hdr
> (8 bytes).  Instead the check needs to be:
> 
> 	if (user_len > user_msg->len - sizeof(*trans_hdr)) {
> 
> That subtraction is done as an unsigned long we want to avoid
> negatives.  Add a lower bound to the start of the function.
> 
> 	if (user_msg->len < sizeof(*trans_hdr))
> 
> There is a second integer underflow which can happen if
> trans_hdr->len is zero inside the encode_passthrough() function.
> 
> 	memcpy(out_trans->data, in_trans->data, in_trans->hdr.len - sizeof(in_trans->hdr));
> 
> Instead of adding a check to encode_passthrough() it's better to check
> in this central place.  Add that check:
> 
> 	if (trans_hdr->len < sizeof(trans_hdr)
> 
> The final concern is that the "user_len + trans_hdr->len" might have an
> integer overflow bug.  Use size_add() to prevent that.
> 
> -	if (user_len + trans_hdr->len > user_msg->len) {
> +	if (size_add(user_len, trans_hdr->len) > user_msg->len) {
> 
> Fixes: 129776ac2e38 ("accel/qaic: Add control path")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>

