Return-Path: <linux-kernel+bounces-68870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7184858125
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7653B1F280C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35072134CD2;
	Fri, 16 Feb 2024 15:25:41 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF5134CC6;
	Fri, 16 Feb 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097140; cv=none; b=t2zA4/jMj8puWrC3OGoO1OFJYJsBk0mD1W6RJXo5G3KFxpC/zLVH7kju9ZWu6ysF8HmeKsEf6XFj4AhjiUwrhakNwuf1eRV7y8ODSPNbeZe2trAfkOuUcku6aRnieOWkHSlsmBlDFyczuR6WIzXvUbPiUUiBf3fvVlu/KZRDNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097140; c=relaxed/simple;
	bh=yBLUhpeAUzPAqo16EKBu9cOxlJA9biOKiyVYJXyBxSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYiDEb0NJ7k2hzI1IYnGOlgul1ZpEHgWgqJRA+c4X+FKQa0SX4XQhu18u07Si4vDgsdhydDq9x0JRahOdJ158SkpDs1qljeocAC75iKKAKbD/yZ8u5HV137C5jrynUPPdWIkA+dULhHBdSQgkj5oCirTIamebsZaM7t3UVbx2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TbwHh2Gb4z9xsyV;
	Fri, 16 Feb 2024 23:06:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9E75A1405A2;
	Fri, 16 Feb 2024 23:25:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.30])
	by APP2 (Coremail) with SMTP id GxC2BwAHQCRBfs9lTLSaAg--.11044S3;
	Fri, 16 Feb 2024 16:25:24 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	David Howells <dhowells@redhat.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [RFC 1/8] mpi: Introduce mpi_key_length()
Date: Fri, 16 Feb 2024 16:24:28 +0100
Message-Id: <20240216152435.1575-2-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216152435.1575-1-petrtesarik@huaweicloud.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHQCRBfs9lTLSaAg--.11044S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUJFyUAr47KFWUuF4kZwb_yoW8KF4fpF
	4Ykw45JrWkJr1SkFyfC3Z5G3W5G3WvgF1UKrZrJw17J39xCrnxWFZ7C34Yva18Gr1xAF1U
	X3y3WFZ5Crn5ZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRMfOzDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the new function to get the number of bits and bytes from an MPI.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/mpi.h       |  2 ++
 lib/crypto/mpi/mpicoder.c | 33 ++++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index eb0d1c1db208..a7dd4c9d8120 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -90,6 +90,8 @@ enum gcry_mpi_format {
 };
 
 MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
+int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
+		   unsigned int *nbits_arg, unsigned int *nbytes_arg);
 MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
 int mpi_fromstr(MPI val, const char *str);
 MPI mpi_scanval(const char *string);
diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
index 3cb6bd148fa9..92447a1c8bf9 100644
--- a/lib/crypto/mpi/mpicoder.c
+++ b/lib/crypto/mpi/mpicoder.c
@@ -79,22 +79,41 @@ MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(mpi_read_raw_data);
 
-MPI mpi_read_from_buffer(const void *xbuffer, unsigned *ret_nread)
+int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
+		   unsigned int *nbits_arg, unsigned int *nbytes_arg)
 {
 	const uint8_t *buffer = xbuffer;
-	unsigned int nbits, nbytes;
-	MPI val;
+	unsigned int nbits;
 
-	if (*ret_nread < 2)
-		return ERR_PTR(-EINVAL);
+	if (ret_nread < 2)
+		return -EINVAL;
 	nbits = buffer[0] << 8 | buffer[1];
 
 	if (nbits > MAX_EXTERN_MPI_BITS) {
 		pr_info("MPI: mpi too large (%u bits)\n", nbits);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	nbytes = DIV_ROUND_UP(nbits, 8);
+	if (nbits_arg)
+		*nbits_arg = nbits;
+	if (nbytes_arg)
+		*nbytes_arg = DIV_ROUND_UP(nbits, 8);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mpi_key_length);
+
+MPI mpi_read_from_buffer(const void *xbuffer, unsigned int *ret_nread)
+{
+	const uint8_t *buffer = xbuffer;
+	unsigned int nbytes;
+	MPI val;
+	int ret;
+
+	ret = mpi_key_length(xbuffer, *ret_nread, NULL, &nbytes);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	if (nbytes + 2 > *ret_nread) {
 		pr_info("MPI: mpi larger than buffer nbytes=%u ret_nread=%u\n",
 				nbytes, *ret_nread);
-- 
2.34.1


