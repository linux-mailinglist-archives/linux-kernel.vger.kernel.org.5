Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF0677E909
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345638AbjHPStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345634AbjHPSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01E26AB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:48:51 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GIjKgM019745;
        Wed, 16 Aug 2023 18:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HGRgSwAZpEdiyidr/28SwniT8wJgFtVIIsMtwRj/8Hk=;
 b=CsmHQChadG9jm2Q3U6DzEYj8B6Rw0qAOgQ+vVKGInqAzDyacR8SoyXPnYMF15XWSSB3y
 tQKUQ/9/fDhuplc+UU8+DLGRQMMrXpX0iuaN0c47Ssl8R/HdTlchD1jv3pjlf8wT48Ja
 cBshdk4fyN1sUVnjN/EYBzsDaGUrMQJlXVqipFJuXKFrhIvLXzAg49mjHLH3SuoM/866
 M/qjDDlw7IVlBPsfWZH8/8Kic6DwTLJ7LZp/nyXgIbEgcctJIU9eFrof6E3OiaWNQSTZ
 GrNwzom2gtwT6sjzYhYgltWAk+1x2n9/bel71AiAKnhSzGb8RoIV6anHfqRqK5ZZQ/J1 nw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh40x81c3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 18:48:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GHtI5s003446;
        Wed, 16 Aug 2023 18:33:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdsqsf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 18:33:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GIX25D36307466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 18:33:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64E3A58043;
        Wed, 16 Aug 2023 18:33:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F37E58059;
        Wed, 16 Aug 2023 18:33:02 +0000 (GMT)
Received: from [9.61.54.222] (unknown [9.61.54.222])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Aug 2023 18:33:02 +0000 (GMT)
Message-ID: <1b841ade-20c0-d239-d8ae-2bb4426fefa8@linux.ibm.com>
Date:   Wed, 16 Aug 2023 13:33:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fsi: i2cr: Switch to use struct i2c_driver's .probe()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alistar Popple <alistair@popple.id.au>, linux-fsi@lists.ozlabs.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20230816171944.123705-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20230816171944.123705-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yauwYME-gy79HOYH6MC0xO5uI9Jmvvj3
X-Proofpoint-ORIG-GUID: yauwYME-gy79HOYH6MC0xO5uI9Jmvvj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=941 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160163
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/16/23 12:19, Uwe Kleine-König wrote:
> struct i2c_driver::probe_new is about to go away. Switch the driver to
> use the probe callback with the same prototype.


Thanks!


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> this driver appeared in next just today. I intend to drop .probe_new
> from struct i2c_driver after v6.6-rc1, so it would be great if this
> patch would go in together with the commit adding this driver.
>
> Thanks
> Uwe
>
>   drivers/fsi/fsi-master-i2cr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
> index 61659c27a973..40f1f4d231e5 100644
> --- a/drivers/fsi/fsi-master-i2cr.c
> +++ b/drivers/fsi/fsi-master-i2cr.c
> @@ -301,7 +301,7 @@ static const struct of_device_id i2cr_ids[] = {
>   MODULE_DEVICE_TABLE(of, i2cr_ids);
>   
>   static struct i2c_driver i2cr_driver = {
> -	.probe_new = i2cr_probe,
> +	.probe = i2cr_probe,
>   	.remove = i2cr_remove,
>   	.driver = {
>   		.name = "fsi-master-i2cr",
>
> base-commit: 53e89e3e4490d6630a68e61a3cb478e7a7f2ce8b
