Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40B75AC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGTLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGTLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:00:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA63269E;
        Thu, 20 Jul 2023 04:00:33 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KAWS6l024554;
        Thu, 20 Jul 2023 11:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=bKRVm10txPy8lFnneUgBXuyHE9Mx1pg18Ovf6qqrVz0=;
 b=m2BilA2KprhxFPcrszswc9JkY6gxSw0FkMWpBeNsCjIIRtLFLy+oUbzJGf5kjWttEFRO
 CBJ2gA4tkCXnyvUScDdN9/ZoNuv8T/awPSOb/rkbvlCO9QdC+YPk0A6Wep4lFN7iYPim
 LsEx6My6nfGSQqvcZDFao/7BDMQfPIKgmWAh0B8ymHp5TbytHLkTuTXJDeAMHXbrJmYt
 ThBztMuUc5WG3dJJyW3vq+gwrYmaHren4fjWnoOe6WQAbxCTyzNzzJqgpfUPdMtyvgM7
 ayHFlDfyxwYmxX03tISQF1C0yVaxkLU6x9g8mPo1Ce09mK0Iu2ElXjrYlbt/4WRnOpqq fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxwcgrkp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:00:28 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36KAbq91032201;
        Thu, 20 Jul 2023 11:00:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxwcgrkna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:00:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36K9H1GJ003390;
        Thu, 20 Jul 2023 11:00:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xp8nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:00:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36KB0NbG38338938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 11:00:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D56FB20049;
        Thu, 20 Jul 2023 11:00:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A600020040;
        Thu, 20 Jul 2023 11:00:23 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Jul 2023 11:00:23 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: AF_UNIX crash in bind() triggered by strace test
Date:   Thu, 20 Jul 2023 13:00:23 +0200
Message-ID: <yt9dedl2rgoo.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E1cK2fdn4YFSv0Evtt5uph5Qj5By2Ykb
X-Proofpoint-ORIG-GUID: I-vwR6ADdYzu6bsgRFPvuNbcMH0mvNAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxlogscore=967 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following crash was reported in our CI on s390x with
debug_defconfig, which enables FORTIFY_SOURCE:

detected buffer overflow in __fortify_strlen
------------[ cut here ]------------
kernel BUG at lib/string_helpers.c:1031!
monitor event: 0040 ilc:2 [#1] PREEMPT SMP 
Modules linked in: [..]
CPU: 0 PID: 243755 Comm: net-accept-conn Not tainted 6.5.0-20230719.rc2.git1.f1311c9e1695.300.fc38.s390x+debug #1
Call Trace:
 [<000000003465b7a2>] fortify_panic+0x2a/0x30 
([<000000003465b79e>] fortify_panic+0x26/0x30)
 [<0000000034a3a77e>] unix_bind_bsd+0x86/0x390 
 [<00000000348839d0>] __sys_bind+0xe0/0xe8 
 [<0000000034926270>] __do_compat_sys_socketcall+0x260/0x4d0 
 [<0000000034be3b66>] __do_syscall+0x1de/0x208 
 [<0000000034bfaf38>] system_call+0x70/0x98 
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<0000000034774880>] __s390_indirect_jump_r14+0x0/0x10
Kernel panic - not syncing: Fatal exception: panic_on_oops

This is caused by a test case who sends an unterminated sun_path
to the kernel in a bind() system call from the strace test suite.
As a test i made the following quick fix, which "fixed" the issue:

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 123b35ddfd71..c505edd74d8c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1206,11 +1206,13 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	struct unix_address *addr;
 	struct dentry *dentry;
 	struct path parent;
-	int err;
+	int pathlen, err;
 
 	unix_mkname_bsd(sunaddr, addr_len);
-	addr_len = strlen(sunaddr->sun_path) +
-		offsetof(struct sockaddr_un, sun_path) + 1;
+	pathlen = strnlen(sunaddr->sun_path, UNIX_PATH_MAX);
+	if (pathlen == UNIX_PATH_MAX)
+		return -EINVAL;
+	addr_len = pathlen + offsetof(struct sockaddr_un, sun_path) + 1;
 
 	addr = unix_create_addr(sunaddr, addr_len);
 	if (!addr)

However, unix(7) says "The pathname in sun_path *should* be
null-terminated." So this change might break userspace. I'm not sure
whether we should return -EINVAL, or just truncate the name to
UNIX_PATH_MAX. From a quick read, it looks like connect() would trigger
the same problem. Any thoughts?
