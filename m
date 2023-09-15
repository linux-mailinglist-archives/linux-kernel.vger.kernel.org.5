Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1655B7A20EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjIOO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbjIOO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:29:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DF2708;
        Fri, 15 Sep 2023 07:29:19 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FEGNph012977;
        Fri, 15 Sep 2023 14:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=L1JdvrFXRMAq+NwN/x/5/Pebd2+L1Pp1g6La/uh1FLc=;
 b=ruej39xRmhdWDO9p3/uC/K2DcA5UDk0JUoaxbYkAtpEjTIVA9chEP+Hyz0nngf13/OSU
 O+2Q6twUffQgK/ifzuTT8rE9HhUQqL8dmN7y+ffoBMbBBr8p3sT/plOClwNStX5pGKEU
 caI2MXKNMeSOsTpM93xXPl3U5spJJL9pMDOVTGqM5OZ2BnznYHui6YuGFFtkKbg2yHvw
 b6QXsk+FEkyGvljdpReDnxGC3SJmL4AEyKijU5efa4n68GlWdW9RdgBqm2DqdDtB75CU
 5aV4sOTTGNFsyEm839gQDOB+ortZbHsEIPy/RX3M9h+asv8p4IqlY9i7eZrftvuSBOsv aw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4r9b1b13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 14:28:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38FCgYrZ011942;
        Fri, 15 Sep 2023 14:28:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r2kvub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 14:28:55 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38FESswU31064346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 14:28:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F0E558052;
        Fri, 15 Sep 2023 14:28:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B9358045;
        Fri, 15 Sep 2023 14:28:53 +0000 (GMT)
Received: from [9.67.12.83] (unknown [9.67.12.83])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 15 Sep 2023 14:28:53 +0000 (GMT)
Message-ID: <ccb1ade9-5a5b-99dc-f26f-2637059249ef@linux.ibm.com>
Date:   Fri, 15 Sep 2023 09:28:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] crypto: vmx: Improved AES/XTS performance of 6-way
 unrolling for ppc.
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20230830134911.179765-1-dtsen@linux.ibm.com>
 <8734zf7ef6.fsf@mail.lhotse>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <8734zf7ef6.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aBeT9aIEofoOYbXD872lv7cLLktXoLIo
X-Proofpoint-ORIG-GUID: aBeT9aIEofoOYbXD872lv7cLLktXoLIo
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_11,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=551 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150126
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still waiting for the CCLA to send to Openssl.

Thanks.

-Danny

On 9/15/23 8:29 AM, Michael Ellerman wrote:
> Danny Tsen <dtsen@linux.ibm.com> writes:
>> Improve AES/XTS performance of 6-way unrolling for PowerPC up
>> to 17% with tcrypt.  This is done by using one instruction,
>> vpermxor, to replace xor and vsldoi.
>>
>> The same changes were applied to OpenSSL code and a pull request was
>> submitted.
> https://github.com/openssl/openssl/pull/21812
>
> Still unmerged as of today.
>
> cheers
