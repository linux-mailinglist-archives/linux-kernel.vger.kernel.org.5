Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314FF77693B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjHITxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHITxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:53:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E8120;
        Wed,  9 Aug 2023 12:53:43 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Jgrgw015792;
        Wed, 9 Aug 2023 19:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=F4kb9BtXh6O5K6bYFOt1XF3yfN9A5TwKydKl5x981y0=;
 b=AkXlwPAILjPB5bCJKnBKSsEVvYkZJPwhlehNs2bRgF6+yQ7NjqNPNkm/ovSlFwz68zqR
 5SZPnRlpiuqj9RXV34lYAtCqeVeBF4aVwKOXkgsBGLWCPOBjxv1Sgbe1GCbl+a6ir2/5
 Fd7J2eZOOSu8T3i6xFMpOks/FUydG209BzWRoxGRBKIl0YGc6NIQQUS4NQEA0F9ct7vL
 7IUd4zrPN2zuw8U9cug/Sq4xUF8kPHT78hjOwIK2Z8xqV8uaVLynWRwj68M6Y7+U7tlX
 4qvFnIeNjdzqANkFrExNK7jcOQvRgUz1Av0fK77M7J97KcCO4+JY8F9UfX7EWYvX3iAK SQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scgyx8qrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379IrAU8007543;
        Wed, 9 Aug 2023 19:53:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14ykjw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379JrUdw16777872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 19:53:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E081020043;
        Wed,  9 Aug 2023 19:53:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C20EE20040;
        Wed,  9 Aug 2023 19:53:27 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 19:53:27 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 0/6] Enable loading local and third party keys on PowerVM guest
Date:   Wed,  9 Aug 2023 15:53:09 -0400
Message-Id: <20230809195315.1085656-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y8WDeppSpuZcMtLll-IX03fxB202HQy2
X-Proofpoint-GUID: Y8WDeppSpuZcMtLll-IX03fxB202HQy2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_17,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=879
 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a secure boot enabled PowerVM guest, local and third party code signing
keys are needed to verify signed applications, configuration files, and
kernel modules.

Loading these keys onto either the .secondary_trusted_keys or .ima
keyrings requires the certificates be signed by keys on the
.builtin_trusted_keys, .machine or .secondary_trusted_keys keyrings.

Keys on the .builtin_trusted_keys keyring are trusted because of the chain
of trust from secure boot up to and including the linux kernel.  Keys on
the .machine keyring that derive their trust from an entity such as a
security officer, administrator, system owner, or machine owner are said
to have "imputed trust." The type of certificates and the mechanism for
loading them onto the .machine keyring is platform dependent.

Userspace may load certificates onto the .secondary_trusted_keys or .ima
keyrings. However, keys may also need to be loaded by the kernel if they
are needed for verification in early boot time. On PowerVM guest, third
party code signing keys are loaded from the moduledb variable in the
Platform KeyStore(PKS) onto the .secondary_trusted_keys.

The purpose of this patch set is to allow loading of local and third party
code signing keys on PowerVM.

Changelog:

v2:

* Patch 5/6: Update CA restriction to allow only key signing CA's.
* Rebase on Jarkko's master tree - https://kernel.googlesource.com/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
* Tested after reverting cfa7522f280aa95 because of build failure due to
this commit.

Nayna Jain (6):
  integrity: PowerVM support for loading CA keys on machine keyring
  integrity: ignore keys failing CA restrictions on non-UEFI platform
  integrity: remove global variable from machine_keyring.c
  integrity: check whether imputed trust is enabled
  integrity: PowerVM machine keyring enablement
  integrity: PowerVM support for loading third party code signing keys

 certs/system_keyring.c                        | 23 +++++++++++++
 include/keys/system_keyring.h                 |  7 ++++
 security/integrity/Kconfig                    |  4 ++-
 security/integrity/digsig.c                   |  2 +-
 security/integrity/integrity.h                |  6 ++--
 .../platform_certs/keyring_handler.c          | 19 ++++++++++-
 .../platform_certs/keyring_handler.h          | 10 ++++++
 .../integrity/platform_certs/load_powerpc.c   | 33 +++++++++++++++++++
 .../platform_certs/machine_keyring.c          | 22 ++++++++++---
 9 files changed, 117 insertions(+), 9 deletions(-)

-- 
2.31.1
