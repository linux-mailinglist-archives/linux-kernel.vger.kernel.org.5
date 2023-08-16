Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E477E740
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbjHPRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjHPRHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:07:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8A103;
        Wed, 16 Aug 2023 10:07:09 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GH1HZn017879;
        Wed, 16 Aug 2023 17:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UbtiZF/lm5GmdH+p7DaGEJM/axIjbx++gyIUhFQoXVU=;
 b=hHlM0xrmUSmPlS0BbbpHkaU5EiMN1MdkI0h2Fqnm4UZsEddEThxrZnamkor3VtMGFAcV
 mtpVLdnq/51/3pGFyb/PcwC946EkwRfjSzkWOtGWECsfH4eITJv0UYC1ipmwSefC08PF
 M05iWjBQhfxIGpYJjXY17jEtfKGDKMaE+7UoCmQg7W9W0HhETu2MgY6lTj5oamV9Lh1V
 QiwRrh+skUsnQnrTtqib7c86EqilCQEYcuj7C6nAH2JzitNVZPIETXearJZNYCZDDpEQ
 rOzE27ns+1UOinqc7vVe5bE3P2dIr/MjrYcryJ1ouu63/9KRQtXBSO/j05Mca/QXg8Rn ew== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sh2g706mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:07:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GFScxo007856;
        Wed, 16 Aug 2023 17:07:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwkegyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 17:07:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GH72HU44761646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 17:07:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E4F72004F;
        Wed, 16 Aug 2023 17:07:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC91A20043;
        Wed, 16 Aug 2023 17:07:01 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.63.64])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 17:07:01 +0000 (GMT)
Date:   Wed, 16 Aug 2023 19:07:00 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] s390/ipl: fix virtual vs physical address confusion
Message-ID: <ZN0CNK4tZdp+ig0g@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230816132942.2540411-1-agordeev@linux.ibm.com>
 <f7df1bfc9a2ef4900dccb01ab81aa1fa9aaa6eb9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7df1bfc9a2ef4900dccb01ab81aa1fa9aaa6eb9.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bmWARjQ0WFRa4zrdixIeGnqsrnYYxzAR
X-Proofpoint-ORIG-GUID: bmWARjQ0WFRa4zrdixIeGnqsrnYYxzAR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_17,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160150
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:13:24PM -0400, Mimi Zohar wrote:
...
> I'm trying to understand if there is a difference between the other
> archs and s390; and whether a similar change is needed for the other
> archs.  Loading certificates on the other archs call kmalloc to
> allocate memory for the certs. Is the memory being allocated on x390
> using kmalloc?

No. The memory is allocated in the decompressor and passed to
the uncompressed kernel. I do not think anything needs to be
done for other archs.

> -- 
> thanks,
> 
> Mimi

Thanks!
