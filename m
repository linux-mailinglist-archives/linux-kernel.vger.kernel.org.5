Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2F7C5D97
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbjJKTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbjJKTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:21:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29BEA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:21:56 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BJHVFe023054;
        Wed, 11 Oct 2023 19:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h+v1IOG/jmNDJTRhW9IuaIpAohQ4Dp4Gm4L7ijlhMLQ=;
 b=ZAVIne1qZ+e/BJWw3nQbQntJdSvHIqv8FsfTOZKEpWPJWycCaukcZEPfpvLJxvrUbDKc
 f66Q7wzKU4Ump9IGeuVXKLTOQ6LL0r9pDu/Cp1apsA5qbe4BjNGFOx1AdSNQP176afU0
 1Rr8k+w4OGwXRnr3+cC3nBXCTpJXduexv/99lbWWjqMpuQFyf6+p2jDOIawNd1IZlE59
 9h5andyJSpX2GDYbzmRDmPj7nGQLc3uUboNeqQkYdIntlv+kTwEpFkb/EzPSFLORYwFJ
 S4XPbCTcMFGFQ+qyNriI1FLZMIGDmz01mGAC2uS4TanZ7hQSHSezztvV2/xC2e40sGpP KA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp1qx07nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 19:21:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BI4bYK024465;
        Wed, 11 Oct 2023 19:21:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnstqgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 19:21:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BJLmnE24773120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 19:21:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FB0158055;
        Wed, 11 Oct 2023 19:21:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 161CB58043;
        Wed, 11 Oct 2023 19:21:48 +0000 (GMT)
Received: from [9.61.37.205] (unknown [9.61.37.205])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 11 Oct 2023 19:21:48 +0000 (GMT)
Message-ID: <8a81172f-e920-88d2-41ec-f9ce90a0afc1@linux.ibm.com>
Date:   Wed, 11 Oct 2023 14:21:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] fsi: sbefifo: Handle pending write command
Content-Language: en-US
To:     Ninad Palsule <ninad@linux.ibm.com>, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20231010204348.2600242-1-ninad@linux.ibm.com>
 <20231010204348.2600242-3-ninad@linux.ibm.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20231010204348.2600242-3-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FOHvAE02bLqYh64MaygYn6MUziDIyB7G
X-Proofpoint-GUID: FOHvAE02bLqYh64MaygYn6MUziDIyB7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_14,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110171
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/23 15:43, Ninad Palsule wrote:
> If previous write command is still pending then free it first.
>
> As per the current kernel driver design, write operation prepares a
> buffer for FSI write, the actual FSI write is performed on next read
> operation. There is a possibility of memory leak if buggy application
> sends two back to back writes or two parallel writes.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v3:
>    - Incorporated review comments by Eddie.
> ---
>   drivers/fsi/fsi-sbefifo.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index a95b32461f8f3..1cc88a78e588a 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -877,6 +877,13 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
>   
>   	mutex_lock(&user->file_lock);
>   
> +	/* If previous write command is still pending then free it. It is safe
> +	 * to do that because read cannot be in progress since we hold the
> +	 * lock.
> +	 */
> +	if (user->pending_cmd)
> +		sbefifo_release_command(user);
> +
>   	/* Can we use the pre-allocate buffer ? If not, allocate */
>   	if (len <= PAGE_SIZE)
>   		user->pending_cmd = user->cmd_page;
