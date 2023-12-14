Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7DA812507
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443001AbjLNCJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjLNCJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:09:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92757E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:09:22 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0836V006535;
        Thu, 14 Dec 2023 02:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R4vwANP5SDrlxQ7BXlWuGvORdzI3wC1R0p4DJ+QmJQA=;
 b=kf5czZhOvkYi/WM8uE5WxEp3lQ3Nx6h1/aC5EkeRQGvvMcEN+Hhh/upYudQ4CEcPMWS8
 MBynObEqrb7wrQKJ6+8Z71gCNIihOiNj4kI5NFB/+OiyeHMdm4mJv/de9mRVqbwIr8kG
 GZ1F7KO31+k9N0RMoQSCTS/3KGi1fV3X0a8RNufEturDLnPGuVIkenJm/uGLynTM58AF
 5Ej2b/BGVu2QZJO+Fosqvho0rhzSQGZXkjx7kGwrHv3+Ykk/hBM/mzCEHrc5TdD6SNNo
 YN5hPOXNcDSmT/pvITFxRMpO8EgUiRAjtr9K5o4s+4CoQVL6+LCaWJG8ostaDxTaNpgT 8Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uypvrt2rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 02:09:13 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDNV1xr013864;
        Thu, 14 Dec 2023 02:09:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592cva9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 02:09:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE29B1A22086388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 02:09:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D78F58045;
        Thu, 14 Dec 2023 02:09:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EA2858052;
        Thu, 14 Dec 2023 02:09:10 +0000 (GMT)
Received: from [9.67.150.168] (unknown [9.67.150.168])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 02:09:09 +0000 (GMT)
Message-ID: <dbf0d09e-6b59-4dfe-8010-b530e2f305b0@linux.ibm.com>
Date:   Wed, 13 Dec 2023 20:09:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fsi: Fix panic on scom file read
Content-Language: en-US
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, joel@jms.id.au,
        eajames@linux.ibm.com, alistair@popple.id.au
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231214000744.1281464-1-lakshmiy@us.ibm.com>
From:   Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20231214000744.1281464-1-lakshmiy@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PHasY1MzJ3HasUMH0goJ0qwcdelafeYY
X-Proofpoint-ORIG-GUID: PHasY1MzJ3HasUMH0goJ0qwcdelafeYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_16,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312140012
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

On 12/13/23 18:07, Lakshmi Yadlapati wrote:
> Reading the scom file without the custom open method (i2cr_scom_open)
> causes a kernel panic. This change replaces simple_open with i2cr_scom_open
> to properly initialize the private_data field in the file structure,
> preventing the panic during scom file operations.
>
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>   drivers/fsi/i2cr-scom.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fsi/i2cr-scom.c b/drivers/fsi/i2cr-scom.c
> index cb7e02213032..8d65c562b488 100644
> --- a/drivers/fsi/i2cr-scom.c
> +++ b/drivers/fsi/i2cr-scom.c
> @@ -73,9 +73,18 @@ static ssize_t i2cr_scom_write(struct file *filep, const char __user *buf, size_
>   	return len;
>   }
>   
> +static int i2cr_scom_open(struct inode *inode, struct file *file)
> +{
> +	struct i2cr_scom *scom = container_of(inode->i_cdev, struct i2cr_scom, cdev);
> +
> +	file->private_data = scom;
> +
> +	return 0;
> +}
> +
>   static const struct file_operations i2cr_scom_fops = {
>   	.owner		= THIS_MODULE,
> -	.open		= simple_open,
> +	.open		= i2cr_scom_open,
>   	.llseek		= i2cr_scom_llseek,
>   	.read		= i2cr_scom_read,
>   	.write		= i2cr_scom_write,


Looks good.

Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

