Return-Path: <linux-kernel+bounces-135055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21289BA79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC612B21090
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31639FC3;
	Mon,  8 Apr 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JSEuceW1"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8423B290
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565570; cv=none; b=KOQQgAEqsm3BDu2cwmHyTpqB9gY4go9WnK7PaSTcKIoy7gSVMmeS/T7lC//OaBAVptnicaRwXV/dUHnHIOKPiJlb69dZTvhki2Qcx4aLyPEUz347+GassRhm0WyX4ZQlWmuJrYnYF8kZoTXS+oh1XRg0sPpPivJv4Ce70rLlUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565570; c=relaxed/simple;
	bh=YMZb6vwrgh+v7Kwzz0FOwU9n/PBR6ZO2Gss4xGzgPA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=La3r95xCAAWsaiyQL9V9zFtU+YSozbw6IoVZkjPKU7b8Kq48jrr0Bp9DUyjWOZD7oZG/Hp/d7ubEHyWY0AIDVP/NchmWHnUVttvqPEqSIBXy/IAvdrwsCK8GK0txPdDun4VNY8npqaQcc+atICU8SZRoa4gjchPkFTU1xeIw04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JSEuceW1; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712565558; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HdClZ6EubvaDzPpcaQCtO2EUiZbaVzikLkeNDLVNikU=;
	b=JSEuceW1wFxBAGt3ZJ06j/0I8X4qQx9M5ftN5YGMxn5yEGnZ2MzeYayAZqkWAnCUjxahLuGqM8KZSQso3HslwoLxeWfgYSA30hILKQfcCVJuJs68JcPqkHdsziM8Svx8iVYA/UtYwVc3AuIHc2rlJDE3vqjhYiGhqJR1DfHxqT4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W46ePOA_1712565557;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W46ePOA_1712565557)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 16:39:18 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rdunlap@infradead.org,
	arnd@arndb.de,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/3 v2] powerpc: boot: Fix kernel-doc param for partial_decompress
Date: Mon,  8 Apr 2024 16:39:16 +0800
Message-Id: <20240408083916.123369-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the kernel-doc annotation for the 'skip' parameter in the
partial_decompress() function by adding a missing underscore and colon.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/boot/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
index 977eb15a6d17..6835cb53f034 100644
--- a/arch/powerpc/boot/decompress.c
+++ b/arch/powerpc/boot/decompress.c
@@ -101,7 +101,7 @@ static void print_err(char *s)
  * @input_size:  length of the input buffer
  * @outbuf:      output buffer
  * @output_size: length of the output buffer
- * @skip         number of output bytes to ignore
+ * @_skip:       number of output bytes to ignore
  *
  * This function takes compressed data from inbuf, decompresses and write it to
  * outbuf. Once output_size bytes are written to the output buffer, or the
-- 
2.20.1.7.g153144c


