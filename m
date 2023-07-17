Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5FB7560D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGQKrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGQKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:47:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388E11C;
        Mon, 17 Jul 2023 03:47:08 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAgXqt025251;
        Mon, 17 Jul 2023 10:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=jFBFqpnfhUVJbxNc05QJz/994Fw3API3ZNvD1L+WRO4=;
 b=KM5g+UDUKrg3KzV9wIGVg7jvVlSp/TYvfWHcnu+6i2nH5ZgatSC2ynvciUuQhizjmT7S
 vNX6FQTmqkdEMmMg3j5n5u3pzdr1tUvxrd3xEQjTZeBhm4p4fjuw8KksEdv4Ma3gtV66
 cjG60CpvsrK/gU1SKr0MB6Dx0D1jDKs+Qnblqr3gupFK8orqdEwQ8iXsS2M3MenEGJ0Z
 Z9NTHNd5PXpzq4Roun48kcQL44/1dI7D7kFj8F+BrFvyBUTCshTLfXXWi9NnUcBebgl7
 p3odkvYjzG0RC0V1H1B75fH7ZdavV3KP0LtL/0JuFW4Nce+lBDZV/qUJZ+X1a/kvnNUe Nw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw3t68cvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 10:47:03 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H8nO3E016229;
        Mon, 17 Jul 2023 10:47:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ruk35jarq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 10:47:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HAl15C34275660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 10:47:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E29658061;
        Mon, 17 Jul 2023 10:47:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E405805A;
        Mon, 17 Jul 2023 10:47:00 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 10:47:00 +0000 (GMT)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 12:47:00 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Wang Ming <machel@vivo.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] arch: s390: Use kfree_sensitive instead of kfree
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20230717094533.18418-1-machel@vivo.com>
References: <20230717094533.18418-1-machel@vivo.com>
Message-ID: <4206a7e79f32538e2505722ef4b57386@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yDQNnVg5SQF2hi25htKSmEYUYcDQBXHD
X-Proofpoint-ORIG-GUID: yDQNnVg5SQF2hi25htKSmEYUYcDQBXHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=485 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-17 11:45, Wang Ming wrote:
> key might contain private part of the key, so better use
> kfree_sensitive to free it.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  arch/s390/crypto/paes_s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/crypto/paes_s390.c 
> b/arch/s390/crypto/paes_s390.c
> index d29a9d908797..38349150c96e 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -103,7 +103,7 @@ static inline void _free_kb_keybuf(struct key_blob 
> *kb)
>  {
>  	if (kb->key && kb->key != kb->keybuf
>  	    && kb->keylen > sizeof(kb->keybuf)) {
> -		kfree(kb->key);
> +		kfree_sensitive(kb->key);
>  		kb->key = NULL;
>  	}
>  }

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
