Return-Path: <linux-kernel+bounces-68868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22C858122
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8511C20CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B0133424;
	Fri, 16 Feb 2024 15:25:21 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9813341C;
	Fri, 16 Feb 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097120; cv=none; b=q2mGgKIBxAn6TjwjO39Ufb/W1hxkMd/BGWSJs/y0YCXqtXph2LHV26dyuIYMK4uwuxuc33RCijSkR69Ga7N0qH8HYwaINA/0DtW9YkU89HRU5WYbs5+62Z/ZUM5y7oppcrk9gGVWUaYIsuW6TuO83zln6QPpLWMA/R/CZwXBk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097120; c=relaxed/simple;
	bh=0d4a909JZ7AEgtDboMnxUVr1QUz9fzJ35MpJ5SdnxVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+KM3bMUJTkKHy0ZMFQ+3364GANlwW0wo20LZAMamDtb56QLLR4kzjHX+5TqbuOqd6vsMaQLLkUL9D/nk3MW0HuqIqXbOe3QL98VAmNPqNJo7TYw0VsTjakEBomS6yBH7b4vcCZhLNE15LYBywswpT+q4o4qCWFnylFdHcvVfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TbwMf0scdz9xrth;
	Fri, 16 Feb 2024 23:09:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 20943140489;
	Fri, 16 Feb 2024 23:25:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.131.30])
	by APP2 (Coremail) with SMTP id GxC2BwAHQCRBfs9lTLSaAg--.11044S2;
	Fri, 16 Feb 2024 16:25:08 +0100 (CET)
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
Subject: [RFC 0/8] PGP key parser using SandBox Mode
Date: Fri, 16 Feb 2024 16:24:27 +0100
Message-Id: <20240216152435.1575-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHQCRBfs9lTLSaAg--.11044S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1kurW7KFy5Kw17KFg_yoW8Ww4Upa
	n5C395tF48try2krWfJw1xWw45AF48Ar4agw4Iqw1UC3sFqr48CFZ2kr13Ga47GFy8X348
	trs8AF15WF1Uta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjfUojjgUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

While I started working on my development branch to illustrate how
SandBox Mode could be enhanced to allow dynamic memory allocation and
other features necessary to convert some existing code, my colleague
Roberto Sassu set out and adapted a PGP key parser to run in a sandbox.

Disclaimer:

The code had to be rearranged in order to avoid memory allocations
and crypto operations in the sandbox. The code might contain errors.

David Howells (4):
  PGPLIB: PGP definitions (RFC 4880)
  PGPLIB: Basic packet parser
  PGPLIB: Signature parser
  KEYS: PGP data parser

Roberto Sassu (4):
  mpi: Introduce mpi_key_length()
  rsa: add parser of raw format
  KEYS: Run PGP key parser in a sandbox
  KEYS: Add intentional fault injection

 crypto/asymmetric_keys/Kconfig          |  17 +
 crypto/asymmetric_keys/Makefile         |  20 +
 crypto/asymmetric_keys/pgp.h            | 206 +++++++++
 crypto/asymmetric_keys/pgp_library.c    | 556 ++++++++++++++++++++++++
 crypto/asymmetric_keys/pgp_parser.h     |  18 +
 crypto/asymmetric_keys/pgp_public_key.c | 441 +++++++++++++++++++
 crypto/asymmetric_keys/pgplib.h         |  58 +++
 crypto/rsa.c                            |  14 +-
 crypto/rsa_helper.c                     |  69 +++
 include/crypto/internal/rsa.h           |   6 +
 include/linux/mpi.h                     |   2 +
 lib/crypto/mpi/mpicoder.c               |  33 +-
 12 files changed, 1429 insertions(+), 11 deletions(-)
 create mode 100644 crypto/asymmetric_keys/pgp.h
 create mode 100644 crypto/asymmetric_keys/pgp_library.c
 create mode 100644 crypto/asymmetric_keys/pgp_parser.h
 create mode 100644 crypto/asymmetric_keys/pgp_public_key.c
 create mode 100644 crypto/asymmetric_keys/pgplib.h

-- 
2.34.1


