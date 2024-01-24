Return-Path: <linux-kernel+bounces-36463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E183A130
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1371C26A78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C350168C7;
	Wed, 24 Jan 2024 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCHJcyRe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB937168B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073286; cv=none; b=HvWxAAuglou/BuIV0gqh1sMwREG56hlo9Zn4ziNrbOkqG9SCQytqicOXHORrSWC4s+odbakDbm6WMWwFBqhz1dJI9lHbhCWSVlJng9Fi43LyJmUI81Ur/MtxvaC6lr/mKgAfpRLl83/ky0E+0PM+X0+t1PXX72SVfZ7PcnA+tyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073286; c=relaxed/simple;
	bh=KSKWN/Vehd1GrrJ7gOl5RQ9IDdLq92owDJctm0QgXaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=f4i0ZEsS032WFcFpdQo8qgVhuddA7z6KY6mVnH24HAGz24AWyByzWP4nWN8zk1fm2DDiQ+XSAcJY8tnozYgNpnkiRS4UdMxYTsop1qCAylapImJnPKzZnubji9L4lUuGI2Mlvg6LiqLVRM6q0XoL8fmJUSaezxUxSUCuainmv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCHJcyRe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3L4u54LHfqMXosGMqcQJnrhKT6dGGjewV9v1qvLObEY=;
	b=XCHJcyRex+4WnYKTvzCbWt6ixL565WCeNh0GsMxsM/sQBi+nOSKGNR1CiEy70THwii1luk
	PVnfJ9qczDo9WzcPCKbkgn1rOFcyakpOvwzvrF1pPtsO5rTRjhrDc7XMwxAvU+JYnXdJNZ
	GczfwoULrlVTmumrcQ7k3ynVLi4NZX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-aRLOfTZSNhm4Axm7wlbsBA-1; Wed, 24 Jan 2024 00:14:40 -0500
X-MC-Unique: aRLOfTZSNhm4Axm7wlbsBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2B7F85A58C;
	Wed, 24 Jan 2024 05:14:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21D6B1C060AF;
	Wed, 24 Jan 2024 05:14:33 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next v3 14/14] loongarch, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:54 +0800
Message-ID: <20240124051254.67105-15-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on loongarch with some adjustments.

Here use IS_ENABLED(CONFIG_CRASH_RESERVE) check to decide if compiling
in the crashkernel reservation code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
- Update code change regarding below commit: 
  commit 78de91b45860 ("LoongArch: Use generic interface to support crashkernel=X,[high,low]")

 arch/loongarch/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edf2bba80130..57d37dd9f964 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -260,7 +260,7 @@ static void __init arch_reserve_crashkernel(void)
 	char *cmdline = boot_command_line;
 	bool high = false;
 
-	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-- 
2.41.0


