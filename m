Return-Path: <linux-kernel+bounces-126882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2268942EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3791F26EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A548781;
	Mon,  1 Apr 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b="G2F5sCk2"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4471DFF4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990647; cv=none; b=nbKTPVhIw6ihlPQ1yeO2qV+hJFj53fa0iJXRGiGI4lRJvYlvBCCl5qEMu1FOtB28MUeZjcBpwrS3bH4fuxtJUQpw6PxHyUb7xnr2wT+wZCjSwEf5je5MSW110e6qknlNCSjVaIUrZOcVvrSdJ88eBNOED/F5IvfaOrOGkxQ/kMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990647; c=relaxed/simple;
	bh=vy2rwbkfeJlFAVqAh6iqsYi/WykwrRM/d7Y4v1HZ5aE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hjmfu8EjL7QnAO8L7f2BvwfTl61x7H/CCDm9i9RVDL121T3yQ1cZNpOeWv1X8irlxWvGzLrqXJxWNsV153H3pxsH77cx5BiuUKPw93dP8/H7zKzOAq9UondIgHyljJkk+fzvFTgDzHue5oX3P/v5KrfvEvgW51mr6e6adK1lxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu; spf=pass smtp.mailfrom=otheo.eu; dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b=G2F5sCk2; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=otheo.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id D137A240007;
	Mon,  1 Apr 2024 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=otheo.eu; s=gm1;
	t=1711990643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXWXDxA4hAxCjyuMS6SXVKSd48hGUzqLhteYMJWfkuM=;
	b=G2F5sCk2pJpMZJzoom4M7p7nAYCh0irmbxh+VYFfPzmowDvubASFpre48OhBTZhkQSftzk
	wIbB4ZYHi6orp5K3nzLU3/e5n0W+CiY+122zpCK9Lt7JsjQ7VF81d1wtaFgjxhdc3RmSyr
	WXUpNErmpa0fOicXmLEBokZVDeu6DyYTLCWBerQ13LipRvNDtRay3Py9qxh5MmuRDp5Ecq
	s5oHG5XiW+kBiNkpn5XkNeQ1nvU97V9Ifnc7DQ8Tdga7x3z3tBb6Bn7Ju0eu/sFLnPKf+l
	5sqjONgZJ41Vm9kIqtCtqiS4pH23GH1qrKyCf1YQgP505LHaWzqk07rnpn6zDA==
Date: Mon, 1 Apr 2024 18:57:12 +0200
From: Javier Pello <devel@otheo.eu>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and pudval_t to
 avoid split locks
Message-Id: <20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu>
In-Reply-To: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; i686-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: #01#@otheo.eu

From: Javier Pello <devel@otheo.eu>

When PAE is enabled on x86-32, the types pte_t, pmd_t and pud_t are
defined in terms of pteval_t, pmdval_t and pudval_t, respectively,
all of which are typedefs for u64, which is an 8-byte type with
4-byte alignment. However, variables of these types are subject to
compare-and-exchange operations in their respective native_set_*
functions, which can trigger split locks if a variable spans two
cache lines, for instance on the stack. Annotate these types with
__aligned(8) to avoid this.

Signed-off-by: Javier Pello <devel@otheo.eu>
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/pgtable-3level_types.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 80911349..61f62ab4 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -5,12 +5,16 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 
-typedef u64	pteval_t;
-typedef u64	pmdval_t;
-typedef u64	pudval_t;
-typedef u64	p4dval_t;
-typedef u64	pgdval_t;
-typedef u64	pgprotval_t;
+/*
+ * Variables of these types are subject to atomic compare-and-exchange
+ * operations, so they have to be properly aligned to avoid split locks.
+ */
+typedef u64	pteval_t	__aligned(8);
+typedef u64	pmdval_t	__aligned(8);
+typedef u64	pudval_t	__aligned(8);
+typedef u64	p4dval_t	__aligned(8);
+typedef u64	pgdval_t	__aligned(8);
+typedef u64	pgprotval_t	__aligned(8);
 
 typedef union {
 	struct {
-- 
2.43.3

