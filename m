Return-Path: <linux-kernel+bounces-65904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974E85538E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EAD28F6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79813EFE1;
	Wed, 14 Feb 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="We3T8zLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3A13DBB7;
	Wed, 14 Feb 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940675; cv=none; b=etgGNSYQk18MexhoBmyTCQSFC+L81n6HCp6qYo5v9dpi61ZIonlSrP/kauPii9YXupqxSUoP0+iCYPqxWPxiCFVsAnn7Vg3+hXRTqpVqvlbRpOf6FTJrY8dS1K7afsJMgglMMqCdr9+vyPkQ73D8VB4cu210ODPyrCgJCCnQ8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940675; c=relaxed/simple;
	bh=JObSMzd6HvbxyZ7oi2dYfoS+BK3H8zc/IpUDq+NI1aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rMOHPxgDHaJU5wZeY402WEIAQ10+wSYc0ZN+Hve/y6BpAlXaHjnKwg5VSIvIOM61rlqoTqCo+WQwpMQU3J6txiTl9a5ATBlEPJDOqgjH6LfwRqFoOUQGc1A/iLZQmtEcNs9N054Lm2iBSJbEGkknbk6+GuCfaDoNacj06xQGEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=We3T8zLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654EFC433F1;
	Wed, 14 Feb 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="We3T8zLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1707940669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EBWgH/bJ48TOitK6Vt3KlSbCS2O18SAPEqKWNkp++qs=;
	b=We3T8zLRQ/yIJ9kKCOZn3FPO7zMrdzBAjxqcziriLpa3MLC1FYMrVvaaTNUCtA4/G60Sx4
	1a1c0efcte5Y5dXbLc5PKdVsKu/sOPBeU18X/r9qLHuFuLxOBVkHn05RVoyvBRLKe6wPia
	xth+hOo7NokZTBtmz7AAZBYVUH1wjbc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2f6abd26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Feb 2024 19:57:48 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Borislav Petkov <bp@alien8.de>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/2] CoCo/RDRAND brokenness fixes
Date: Wed, 14 Feb 2024 20:56:46 +0100
Message-ID: <20240214195744.8332-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This takes a two-pronged approach to the matter, now that we have
details from Intel and AMD:

- In the generic case, if RDRAND fails, simply WARN(), and don't try
  again. It turns out the "try 10 times" thing isn't actually a correct
  recommendation from Intel. Since RDRAND failure implies CPU failure, a
  WARN() seems in order on all platforms.

- On CoCo machines, where RDRAND failure implies the whole threat model
  is compromised and execution shouldn't continue, we ensure that the
  RNG gets 256-bits of RDRAND at boot, or otherwise fails.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>

Jason A. Donenfeld (2):
  x86/archrandom: WARN if RDRAND fails and don't retry
  x86/coco: Require seeding RNG with RDRAND on CoCo systems

 arch/x86/coco/core.c              | 37 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/archrandom.h | 18 ++++++---------
 arch/x86/include/asm/coco.h       |  2 ++
 arch/x86/kernel/setup.c           |  2 ++
 4 files changed, 48 insertions(+), 11 deletions(-)

-- 
2.43.0


