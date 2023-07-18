Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4E757570
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGRHiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGRHiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:38:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A54198;
        Tue, 18 Jul 2023 00:38:50 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7Osnl014391;
        Tue, 18 Jul 2023 07:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=32InxsPJC+q1pq44FtbN1Nmf3gbhoM2dKizSnMtxqJE=;
 b=olSFM+N8pfNmav1wL3r93rWw61Z2WnqyngIeawkyn06y1P1RfofBI8bJRr/NR0Nsp5kP
 iZhZG39FvOHX/4j5nvr5VgmW93qeA8dbC1mk++cy5tRZWP/L+hOf+8NdICt54eKk6fQj
 8lo2r9zUAtBmlkbTnS1VXZzmqNkexMa5GFTGzBq5HWqIrbJ/JPbnvBpC4RqD5k/p4Owc
 pVL5zlIl7+QQ1e5I1r23R8i7/QFLsh2C9h3Dn67dUxT+Mbx2Kz0buJqFMi+AwZJ2zXOC
 jJCuZpe4gfJFRzyUES7gObydipA+tRUWdCRRE52jO4qeFIG/drrPC5R9mnm3f+OdvLuY XA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwpaugd72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:38:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36I51uN4007106;
        Tue, 18 Jul 2023 07:38:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80j24qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 07:38:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36I7chov11141874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 07:38:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C711201A4;
        Tue, 18 Jul 2023 07:38:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3883201A3;
        Tue, 18 Jul 2023 07:38:42 +0000 (GMT)
Received: from osiris (unknown [9.152.212.233])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Jul 2023 07:38:42 +0000 (GMT)
Date:   Tue, 18 Jul 2023 09:38:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Wang Ming <machel@vivo.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] arch: s390: Use kfree_sensitive instead of kfree
Message-ID: <ZLZBgocu7f2u+2j8@osiris>
References: <20230717094533.18418-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717094533.18418-1-machel@vivo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: foG5Ej1fuh2k90gbTaMpq8-6guRWHawx
X-Proofpoint-ORIG-GUID: foG5Ej1fuh2k90gbTaMpq8-6guRWHawx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=287 malwarescore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:45:19PM +0800, Wang Ming wrote:
> key might contain private part of the key, so better use
> kfree_sensitive to free it.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  arch/s390/crypto/paes_s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
