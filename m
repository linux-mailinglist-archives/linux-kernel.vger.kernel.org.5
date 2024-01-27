Return-Path: <linux-kernel+bounces-41075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3383EB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 06:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAAD28355D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8283414A8C;
	Sat, 27 Jan 2024 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="bGsxg2TZ"
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FD7F;
	Sat, 27 Jan 2024 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706335002; cv=none; b=D0FGZcUtBEKtQfPdizDcPQXAjdPaQy/O5ic9TvNZrn93TiqDvJmm/66/yGB7iOrvTPQeV61YBBmFWax890QjrF3QcDWJ68AVsThwkHrNQq9gml0uNOcZqaVEwh5Xs9LWhg9VMqUv8j9zY/W95ziTLhX1L2FmF8mk9BfygFwFb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706335002; c=relaxed/simple;
	bh=QmTDRUbNHgrq5t9JI5UYewOWGURNdPHH08srd4UcjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4b9SBFTmLliRO3P7DggrM/u0zMjrZOvURkfiM6xYnqHSYHHX/cFaAGiUV9lwQCFIdDD7RfNI8TYVs/OXPSEXxw0NGW4y1RBQDu8nGnntIUaO6fiZ7wqq/AU6IZ39c1rAuN+lI6gTAv/y7lNeNJ6N4dckCUXfPjK8/jRMXgOA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=bGsxg2TZ; arc=none smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R48jDX026485;
	Sat, 27 Jan 2024 04:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=campusrelays; bh=Jaf7dwKCpzOam5AxGVkQC1zxu44hKX42z/tivO06WcI=;
 b=bGsxg2TZ2xE8ej0BpJ/gSoVrfxGnS5ugqZwGMh93/llF/eNRRRea/irYHs3FfIDUZlJX
 ibkixVycodjAcYTV5aGXRD7jEsi7VlED3Z92hVyjV9noUAZUxj3AxO02rPqBAUIae1ni
 cvCDspJe/mXcTJzbaCco3J3bOjCb0IuCuc/ew+DBeN7lA2eGRPDmkwBL6x6EX7llFVt4
 EmpmsoM6ZCgqRjS8ABGsiPVcl7cuW3JWV2AliiU6Qbc6a6zgApV1fXJHLdVZ7OI+ObqQ
 J73LBn9KHqpF/JLBuC6MFL9eh8wnCKEsASBzHFdgxhSkCJtHGjXK7l1NBeeJuOu8GSiJ sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3vvr6sgk29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 04:41:36 +0000
Received: from m0166258.ppops.net (m0166258.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40R4fZW7019561;
	Sat, 27 Jan 2024 04:41:36 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3vvr6sgk26-1;
	Sat, 27 Jan 2024 04:41:35 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [RFC PATCH 0/2] x86/kprobes: add exception opcode detector and boost more opcodes
Date: Fri, 26 Jan 2024 22:41:22 -0600
Message-ID: <20240127044124.57594-1-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kVJuc-U0v0AAMI2LBDzzUlJWS0ZpTZDO
X-Proofpoint-ORIG-GUID: 6YLeFrF7svbWsgXIk0n3OeKrq3OypKIi
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=899 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270033
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

Hi everyone,

This patch set makes the following 2 changes:

- It adds an exception opcode detector to prevent kprobing on INTs and UDs.
  These opcodes serves special purposes in the kernel and kprobing them
  will also cause the stack trace to be polluted by the copy buffer
  address. This is suggested by Masami.

- At the same time, this patch set also boosts more opcodes from the group
  2/3/4/5. The newly boosted opcodes are all arithmetic instructions with
  semantics that are easy to reason about, and therefore, they are able to
  be boosted and executed out-of-line. These instructions were not boosted
  previously because they use opcode extensions that are not handled by the
  kernel. But now with the instruction decoder they can be easily handled.
  Boosting (and further jump optimizing) these instructions leads to a 10x
  performance gain for a single probe on QEMU.

Jinghao Jia (2):
  x86/kprobes: Prohibit kprobing on INT and UD
  x86/kprobes: boost more instructions from grp2/3/4/5

 arch/x86/kernel/kprobes/core.c | 54 ++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 13 deletions(-)

--
2.43.0


