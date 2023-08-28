Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1C78BA44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjH1V14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjH1V1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:27:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B72F1A4;
        Mon, 28 Aug 2023 14:27:34 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SL660l005745;
        Mon, 28 Aug 2023 21:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=k3Kh7MMkYr1CEHrB6GRXXcR/guKDtu8T//hLSUINZxs=;
 b=GjLT9wgiaG5VLr/4Cr7y+AYg4AG31XQlxQNUt/UwVzpFPTgYgrigUHAL7JYPxySKKn/M
 0B9KUxxn3zgy+D132Nqilwd7GH0vGWo9nIgVivxidShvxJA8A6ZNZDbaA9EyubQyNcBJ
 oGDTTc6I0yE/1RgfbEXkqb5rwb5fcXmlCzvjmTnX8aXY0jHDyTcY6xDJW9Oe1MpSYH8B
 NKdGoVqmCcB4E8gxHxf6ST/fBLn/5iFkMRnEDQ76lbXTK3QKMJA995HlrHkdbGaPXrV7
 uETF6+dk4AtU8zhSPJ5Idm1ApjprLiY2CBi9DptzJ775DpDwM/3jD3aljLVPJ2ifQYzL jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr62paynb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:27:23 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SLQkZh010964;
        Mon, 28 Aug 2023 21:27:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr62paykn-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:27:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37SIYBx9009966;
        Mon, 28 Aug 2023 21:02:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7k62g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:02:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37SL2rLQ64749858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 21:02:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5233058055;
        Mon, 28 Aug 2023 21:02:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E1CF58043;
        Mon, 28 Aug 2023 21:02:53 +0000 (GMT)
Received: from localhost (unknown [9.61.91.200])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Aug 2023 21:02:53 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Audra Mitchell <aubaker@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        aubaker@redhat.com, keescook@chromium.org,
        christophe.leroy@csgroup.eu, npiggin@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH] Update creation of flash_block_cache to accout for
 potential panic
In-Reply-To: <20230828205453.307962-1-aubaker@redhat.com>
References: <20230828205453.307962-1-aubaker@redhat.com>
Date:   Mon, 28 Aug 2023 16:02:53 -0500
Message-ID: <87il8yzxqa.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2L2rQKMPGcjdpWWBjTwEHOaxfx5rB2V1
X-Proofpoint-ORIG-GUID: 0Wl_IExJPHxVoOaaei5Evq1HkSh2qY9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=610
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280181
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audra Mitchell <aubaker@redhat.com> writes:
> With PPC builds enabling CONFIG_HARDENED_USERCOPY, interacting with the RunTime
> Abstraction Services (RTAS) firmware by writing to
> /proc/powerpc/rtas/firmware_flash will end up triggering the mm/usercopy.c:101
> assertion:

Thanks, this was fixed already:

4f3175979e62 "powerpc/rtas_flash: allow user copy to flash block cache objects"
