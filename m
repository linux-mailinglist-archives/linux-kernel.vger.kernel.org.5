Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430D77BA6F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjJEQnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjJEQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:41:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FC219AD;
        Thu,  5 Oct 2023 09:26:33 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395GPped012144;
        Thu, 5 Oct 2023 16:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/SvxsxPLgknsUyoedy05iuyDbiMbvNzgf2Sdg8OQ5vc=;
 b=kpwyEuQTNKHl4i9kI2Uao574UivqcsmalwdAnCqwzptqBg2UL45chZ2oB2k+nUgP3RQH
 UW4Yu2kpHM0av7YpoDXnxGY0PsigcYs26kXqBsH8qF4lRjGvioUUTA4wca0irtc372R6
 4bM1p0VVTxI3XWWK8N3Dxz660GfF5uuotyudq9eYAa+NqCXQVUvcp40TRhqftqBvR4vH
 hMEC1kI4IYNAhPIAwIKFX2ShpLgfIw1nLEdH/hEnWbDd/7wDTtkBq+qQ7JlWEYjxCGu1
 4jin10fH47g6UvdCxU3rj5cDJZGl95vCnMzqdrbYkz18ABz/ZKu34Bbxbf1BUaJ6BLUe 0g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj0ndg1gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 16:26:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395EU1hb007447;
        Thu, 5 Oct 2023 15:13:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygm4gd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 15:13:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395FDDvo41222626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 15:13:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2152004B;
        Thu,  5 Oct 2023 15:13:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 929142004D;
        Thu,  5 Oct 2023 15:13:12 +0000 (GMT)
Received: from [9.179.14.29] (unknown [9.179.14.29])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 15:13:12 +0000 (GMT)
Message-ID: <bd38baa8-7b9d-4d89-9422-7e943d626d6e@linux.ibm.com>
Date:   Thu, 5 Oct 2023 17:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/cio: Fix a memleak in css_alloc_subchannel
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
Content-Language: en-US
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aNR7iEgwscrZ82l9-nm77TT6FXdyvJGN
X-Proofpoint-ORIG-GUID: aNR7iEgwscrZ82l9-nm77TT6FXdyvJGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=633
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.2023 09:14, Dinghao Liu wrote:
> When dma_set_coherent_mask() fails, sch->lock has not been
> freed, which is allocated in css_sch_create_locks(), leading
> to a memleak.
> 
> Fixes: 4520a91a976e ("s390/cio: use dma helpers for setting masks")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Looks good to me.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

