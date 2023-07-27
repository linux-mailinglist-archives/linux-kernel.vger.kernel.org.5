Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6B764654
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjG0F4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjG0F43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:56:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA03130D7;
        Wed, 26 Jul 2023 22:55:46 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R5qxTj018845;
        Thu, 27 Jul 2023 05:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=o+EIBjujxUgUO2otmKEQSeb4Vv3m4Ywk+cFlo5Tu4sc=;
 b=RPw1QxQsDTWZXKUS044YRNVdeBGnJCTiLuvsu510FNjN2gvNYa52pIcRXAvkhhsSwbmh
 IWK1sEja39IoBLMsUO8kL8JWMysL9jpAOj+GcHo9uPcatI4nmnNufi5taVnW5xe7GDnE
 3VhBlKiPhrHeX/GqbZFLjiKvxTFPxyFuqqfq0Vy/jBX4JWRNOGYyFfb7nDSnb+rIlBST
 xH1t6RYrxsGgC5ElTqIIg11wX4vissuyFXxboyHOeW5h1hKh63GdARGmOHE2NrfAzbOO
 mBP5On0Opi5f9AS7S+28Nvkgv+RdQ0JQ2DySY9oji9LtRZthsGgd2uNmRSqSH8Az/3+h PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3jtp011v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:55:22 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36R5sHW5021175;
        Thu, 27 Jul 2023 05:55:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3jtp0119-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:55:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36R5AEXP026209;
        Thu, 27 Jul 2023 05:55:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0sesbecd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 05:55:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36R5tJX619595956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 05:55:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7E3D2004B;
        Thu, 27 Jul 2023 05:55:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CB1020040;
        Thu, 27 Jul 2023 05:55:19 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Jul 2023 05:55:19 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     =?us-ascii?Q?=3D=3FUTF-8=3FB=3FT25kcmVqIE1vc27DocSNZWs=3D=3F=3D?= 
        <omosnacek@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Harald Freudenberger <freude@linux.vnet.ibm.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Fix missing initialisation affecting gcm-aes-s390
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
        <97730.1690408399@warthog.procyon.org.uk>
Date:   Thu, 27 Jul 2023 07:55:18 +0200
In-Reply-To: <97730.1690408399@warthog.procyon.org.uk> (David Howells's
        message of "Wed, 26 Jul 2023 22:53:19 +0100")
Message-ID: <yt9dbkfxsxtl.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jEHmCZ_RSXWAXdm5e4N3Lm_egRSNPA8H
X-Proofpoint-GUID: w2jNjsW5JfH-1HDwdVHh2Yyp_g7YSTeI
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

>=20=20=20=20=20
> Fix af_alg_alloc_areq() to initialise areq->first_rsgl.sgl.sgt.sgl to poi=
nt
> to the scatterlist array in areq->first_rsgl.sgl.sgl.
>
> Without this, the gcm-aes-s390 driver will oops when it tries to do
> gcm_walk_start() on req->dst because req->dst is set to the value of
> areq->first_rsgl.sgl.sgl by _aead_recvmsg() calling
> aead_request_set_crypt().
>
> The problem comes if an empty ciphertext is passed: the loop in
> af_alg_get_rsgl() just passes straight out and doesn't set areq->first_rs=
gl
> up.
>
> This isn't a problem on x86_64 using gcmaes_crypt_by_sg() because, as far
> as I can tell, that ignores req->dst and only uses req->src[*].
>
> [*] Is this a bug in aesni-intel_glue.c?
>
> The s390x oops looks something like:
>
>  Unable to handle kernel pointer dereference in virtual kernel address sp=
ace
>  Failing address: 0000000a00000000 TEID: 0000000a00000803
>  Fault in home space mode while using kernel ASCE.
>  AS:00000000a43a0007 R3:0000000000000024
>  Oops: 003b ilc:2 [#1] SMP
>  ...
>  Call Trace:
>   [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
>   [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
>   [<00000000a2a60888>] aead_recvmsg+0x478/0x698
>   [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
>   [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
>   [<00000000a273e066>] vfs_read+0x26e/0x2a8
>   [<00000000a273e8c4>] ksys_read+0xbc/0x100
>   [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
>   [<00000000a312ff30>] system_call+0x70/0x98
>  Last Breaking-Event-Address:
>   [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]
>
> Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to create =
scatterlists")
> Reported-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Link: https://lore.kernel.org/r/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStP=
qBhubxyk_A@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: Sven Schnelle <svens@linux.ibm.com>
> cc: Harald Freudenberger <freude@linux.vnet.ibm.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: linux-crypto@vger.kernel.org
> cc: linux-s390@vger.kernel.org
> cc: regressions@lists.linux.dev
> ---
>  crypto/af_alg.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index 06b15b9f661c..9ee8575d3b1a 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -1192,6 +1192,7 @@ struct af_alg_async_req *af_alg_alloc_areq(struct s=
ock *sk,
>=20=20
>  	areq->areqlen =3D areqlen;
>  	areq->sk =3D sk;
> +	areq->first_rsgl.sgl.sgt.sgl =3D areq->first_rsgl.sgl.sgl;
>  	areq->last_rsgl =3D NULL;
>  	INIT_LIST_HEAD(&areq->rsgl_list);
>  	areq->tsgl =3D NULL;

Just tested, with this fix the kernel no longer crashes. Thanks!

Tested-by: Sven Schnelle <svens@linux.ibm.com>
