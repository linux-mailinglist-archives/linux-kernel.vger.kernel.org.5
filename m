Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672CB7911F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbjIDHU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjIDHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:20:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D89A7;
        Mon,  4 Sep 2023 00:20:25 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38478w2u020418;
        Mon, 4 Sep 2023 07:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=bKDUBlQ5AuwRYstkWVVn9yuvQNAJeOOL4UrmQDWu3Jc=;
 b=qP73+7GYPw1RbFwjpNVa9j9xLW6NQX+BEXB0o+82D7MRgJ9XYs2pzcPw2QeiTN8MGxLd
 6Ru7D4RYFAoTJ6hPXvUYArByc0at14qPoC79TAcRmiJxY5zgHugRz3W5VpV24vGSYdNf
 YlsXGb7MqbVQRmUqKknMy1Y7Dfe3WGC57kD6Mmf8uv8LTmqrLrcVi9DQoL2wOYg4mAeK
 Lh+Ta0DbGY0csNHYY0siAnLiUrS5SAEWVAyeM3RaXrenn7+5BAhPSAkMLeG1YVl5gKcL
 cBC7Rhtcw+6xnFYOpl4yv2ye8vxQekfppGPbHliyx7o5khd0COHDncjwt+ppGV1Gjupb eA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw84euscs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 07:20:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38479ZCt021441;
        Mon, 4 Sep 2023 07:20:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfry0v5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 07:20:23 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3847KM5J60424452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Sep 2023 07:20:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92CE05805A;
        Mon,  4 Sep 2023 07:20:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3747758052;
        Mon,  4 Sep 2023 07:20:22 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  4 Sep 2023 07:20:22 +0000 (GMT)
MIME-Version: 1.0
Date:   Mon, 04 Sep 2023 09:20:22 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] s390/zcrtpt: Don't leak memory if dev_set_name()
 fails
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20230831110000.24279-1-andriy.shevchenko@linux.intel.com>
References: <20230831110000.24279-1-andriy.shevchenko@linux.intel.com>
Message-ID: <d8c5522ddfe034e839cc93e8b4ef36fb@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XHW5zy7UYRUzK6NFX2ztxwyeSpWIcSm1
X-Proofpoint-GUID: XHW5zy7UYRUzK6NFX2ztxwyeSpWIcSm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-31 12:59, Andy Shevchenko wrote:
> When dev_set_name() fails, the zcdn_create() doesn't free
> the newly allocated resources. Do it.
> 
> Fixes: 00fab2350e6b ("s390/zcrypt: multiple zcrypt device nodes 
> support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c 
> b/drivers/s390/crypto/zcrypt_api.c
> index 4b23c9f7f3e5..6b99f7dd0643 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -413,6 +413,7 @@ static int zcdn_create(const char *name)
>  			 ZCRYPT_NAME "_%d", (int)MINOR(devt));
>  	nodename[sizeof(nodename) - 1] = '\0';
>  	if (dev_set_name(&zcdndev->device, nodename)) {
> +		kfree(zcdndev);
>  		rc = -EINVAL;
>  		goto unlockout;
>  	}
Thanks Andy, I picked this patch and forwarded it into the s390 
subsystem.
This will be visible in Linus' kernel tree with the next merge.
