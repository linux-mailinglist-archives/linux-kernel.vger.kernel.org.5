Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4369E763F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGZTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGZTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:20:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04A271C;
        Wed, 26 Jul 2023 12:20:34 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QJDju9014729;
        Wed, 26 Jul 2023 19:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=ULMQmjsjYc30tFAsSDGfTwUEtxmLnFVMNahNtH53+Lk=;
 b=F96ixHS6BPhHO4lQmmVer/GPurx42EFg/eR5AJcqCAK+0qFzk3Itx99mpxslZLORuT/3
 MUD5gvajYpcxyKT62eBg8llT7XWTZE3hjDDUwZrG6SMcmP+qtLsDBSI4LjjwhvmNNOoO
 GYRlNfiUm5gMPmPxTfjq1ow8FHI4zZmcewcpmMJv5xERuql7faRSpxjOX1l0JW0b6yu3
 wSdkwPZKjblhpageWE9ZHGpPi0PcLiLUjhLs4M+Ro6MY5QSjfOGZnUV3J+RmJm2YkYOy
 MZXhlXaCOvx7h/z5Ja76aWYz/vtdY57Oea+l/VKCjW2MCCSvPqI+nq4k+Mcpdi98lDif 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s39f9r5wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 19:20:24 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36QJEVpk016128;
        Wed, 26 Jul 2023 19:20:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s39f9r5vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 19:20:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36QINM3g002181;
        Wed, 26 Jul 2023 19:20:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unjq0bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 19:20:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36QJKLCm18285264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 19:20:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 027DB20040;
        Wed, 26 Jul 2023 19:20:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7BB820043;
        Wed, 26 Jul 2023 19:20:20 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Jul 2023 19:20:20 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Harald Freudenberger <freude@linux.vnet.ibm.com>
Subject: Re: Another regression in the af_alg series (s390x-specific)
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
        <15125.1690385912@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 21:20:20 +0200
In-Reply-To: <15125.1690385912@warthog.procyon.org.uk> (David Howells's
        message of "Wed, 26 Jul 2023 16:38:32 +0100")
Message-ID: <yt9dsf9abhu3.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CXFDiluuVty54R36xuRWSL3pcgzLR6cH
X-Proofpoint-ORIG-GUID: nw-JBIwxoc_g9VInTnoRyxFLBqafpeHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=790
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260171
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

> Well, I can reproduce it fairly easily.  It seems to be:
>
> 	static inline void scatterwalk_start(struct scatter_walk *walk,
> 					     struct scatterlist *sg)
> 	{
> 		walk->sg = sg;
> 		walk->offset = sg->offset;  <----
> 	}
>
> Presumably sg is rubbish.
>
> Dump of assembler code for function gcm_walk_start:
>    0x0000000000000038 <+0>:     jgnop   0x38 <gcm_walk_start>
>    0x000000000000003e <+6>:     xc      8(64,%r2),8(%r2)
>    0x0000000000000044 <+12>:    st      %r4,32(%r2)
>    0x0000000000000048 <+16>:    stg     %r3,0(%r2)
>    0x000000000000004e <+22>:    l       %r1,8(%r3)
>    0x0000000000000052 <+26>:    st      %r1,8(%r2)
>    0x0000000000000056 <+30>:    jg      0x56 <gcm_walk_start+30>
>
> I'm don't know much about s390x assembly, but I'm guessing %r2 has "walk" and
> %r3 has "sg".

Correct. I looked into this today, and it happens with c1abe6f570af
("crypto: af_alg: Use extract_iter_to_sg() to create scatterlists"),
but not with the commit before. It also only happens with
arch/s390/crypto/aes_s390.c, but not with a generic aes implementation.
I also see the s390 aes driver returning EBADMSG even when it's not
crashing the kernel, so i wonder wether it's another problem in some
error path.

I tried to understand the patch mentioned above, but i never worked with
the crypto API in recent years, so that would require some learning on
my side. Adding Harald, maybe he has some more insight.

> AS:0000000116d50007 R3:0000000000000024 
> Fault in home space mode while using kernel ASCE.
> Failing address: 0026070200000000 TEID: 0026070200000803
> Unable to handle kernel pointer dereference in virtual kernel address space
>
> Krnl GPRS: 000000000000000c 0000038000000310 00000380002a7938 0026070200000000
>            0000000000000000 0000000115593cb4 0000000000000000 0000000000000010
>            0000000100000000 000000017e984690 000000000000000c 0000000000000000
>            000003ffaf12cf98 0000000000000000 000003ff7fc536ba 00000380002a77e0
>
> I'm not sure what to make of the 0026070200000000.

Well, propbably just an arbitry value loaded from corrupted memory.
