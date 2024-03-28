Return-Path: <linux-kernel+bounces-122990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AC8900BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F641F265D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC807BAE7;
	Thu, 28 Mar 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F91xG6sN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7A81751
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633608; cv=none; b=Ge+h/YbaqGDPueqnDO+zmSQZFmkNWvu4Cz7WlDoAyvVizC7Mz42t2hKwHo3WUGVbSIEpHCk5zIV62h0Lw04QqWEI3zrBmtspGHXqNUekb9lqIYCLqhNZR2HwPAdWL/dowtZDhi/CWFFa0Mz5R5FQZea6DA9dG6vY5epN+ohVX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633608; c=relaxed/simple;
	bh=m+4RMEyF1XG5sdloerFWFTsyYJRbW+BicofL6yYpx6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QuB0Xe5jaF81srF3BnWsyULdkNzsCelmF4pvoOumqyxDG7CH476lTcYf2zuUr6yL6F/KN3T165IJn2Z3JCeVys6XHkt0jCsJ4qQwO/QVWjqGDEexAIUUIttkfTURhfjZVQX+9nRGhtaxoCBcXlQIFicGJWN34YohCkb4ApqLi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F91xG6sN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SCevRR024100;
	Thu, 28 Mar 2024 13:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=t2ZVAs8unsBSfF4LkjybvlbVRB0r0ywHzZpUsLk4GpE=;
 b=F91xG6sNeuepgwOcFnOCjb6q3uBC+RUlbDXxtvRxx+0RbrlQq7A0a3nvMkQMnJtO6hDC
 3Nd1W1+eXjjAL6w+hZIWKrDafpDThGRV4y6D/9oEAFAroySl5Db33iCEKm5fnNN1DpPd
 Gyc9MRhuSqDubGyqXymzc2PHi0QUYKQFrUE2Fd44U4kgOUaWtr0qF7Fghb8o6GDaKTy/
 cF61hOQ1qrJ1EvQaMKwcVQcO0AYkISE486D76AdpJMxN4uLAzd+CMu1e7sVPFB5CV/sQ
 eu3/x5yrcl8qIiFSHVnXu0dIvnyxX56DZAqb4GABmzdWgkPNEUbJkRzfNKt5j5Zq/WE0 Cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9h06cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 13:46:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SDV0jx018186;
	Thu, 28 Mar 2024 13:46:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nha79f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 13:46:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SDkZKP013877;
	Thu, 28 Mar 2024 13:46:36 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-175-57-99.vpn.oracle.com [10.175.57.99])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x1nha79eh-1;
	Thu, 28 Mar 2024 13:46:35 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH] objtool/x86: objtool can confuse memory and stack access
Date: Thu, 28 Mar 2024 14:46:34 +0100
Message-Id: <20240328134634.350592-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_13,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280093
X-Proofpoint-GUID: mz6WTB0k2_3qKTzpcqyFXgU5lxWmqXe3
X-Proofpoint-ORIG-GUID: mz6WTB0k2_3qKTzpcqyFXgU5lxWmqXe3

The encoding of an x86 instruction can include a ModR/M and a SIB
(Scale-Index-Base) byte to describe the addressing mode of the
instruction.

objtool processes all addressing mode with a SIB base of 5 as having
%rbp as the base register. However, a SIB base of 5 means that the
effective address has either no base (if ModR/M mod is zero) or %rbp
as the base (if ModR/M mod is 1 or 2). This can cause objtool to confuse
an absolute address access with a stack operation.

For example, objtool will see the following instruction:

 4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12

as a stack operation (i.e. similar to: mov -0x20(%rbp), %r12).

[Note that this kind of weird absolute address access is added by the
 compiler when using KASAN.]

If this perceived stack operation happens to reference the location
where %r12 was pushed on the stack then the objtool validation will
think that %r12 is being restored and this can cause a stack state
mismatch.

This kind behavior was seen on xfs code, after a minor change (convert
kmem_alloc() to kmalloc()):

>> fs/xfs/xfs.o: warning: objtool: xfs_da_grow_inode_int+0x6c1: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402220435.MGN0EV6l-lkp@intel.com/
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3a1d80a7878d3..18a9140173326 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -412,6 +412,14 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		if (!rex_w)
 			break;
 
+		/*
+		 * If the SIB base is 5, and ModRM mod is 0 then there
+		 * is no base. But SIB decoding will set sib_base to
+		 * CFI_BP (register 5).
+		 */
+		if (have_SIB() && sib_base == CFI_BP && modrm_mod == 0)
+			break;
+
 		if (rm_is_mem(CFI_BP)) {
 
 			/* mov disp(%rbp), reg */
-- 
2.39.3


