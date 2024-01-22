Return-Path: <linux-kernel+bounces-33080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F283642D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CDCB24286
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154373D0A8;
	Mon, 22 Jan 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ7aSHDO"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AF3CF7E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929333; cv=none; b=WhBcj4pwvPN5xH3GOjbB2Ip5YRQsbPOF3i/aMg/GfhH50LnGZburHEsCh0Quf7yP6L8yh5BsNQJraitzS+Xd7qoJfXp9kQx7j5TQg/hM38xfl0jUzJKCAaLxd/mXbeHzhZS012IawReoU9X7kUyyvl0zrEIO4wXIruGwqso+iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929333; c=relaxed/simple;
	bh=W+FoyetTrQpGek8P1EOIK8LIPkRaG1NkOkcmwDPfLHU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LpPW9nnomO3fpkaBmhaNCw+pA9EXzflYojaYGT2wLxiqzzdlRk6UfAztig3TIc0CBNBeAGJq8/p0NInRcc/ZYxjvEgY0sUDR7kY5YYpbXFhZX/I3OJankbIF+758Brinpga55HBxqpR0+jUKYmuNst25vEEt61jzqaDuK8yiIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ7aSHDO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2900c648b8bso2384579a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705929331; x=1706534131; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrphHGbARUcAn/ngDkEkvNE+edD8/JC5ZlNhTk3XAow=;
        b=cQ7aSHDODy7GkMg9sZznHeHzJ2pvsCBWk87Esi60MlYFBC7XOcQ+PfGfVpPnhHLjLO
         xy7xAKN6NU3fQTViO4vAdaz6TbdgT1Qc/iGEH+cIoPuEGGDKhBLjoBjkeQbmfulWJIzS
         XE81T6u/HpzbHhE8agQXnSiiN+k6VVhhPCQUr9DUzFyS6CuWEjv3gMb2BVcUXK/ep6bU
         ySNZHypeSbapayWLA1epUa4FndrOOazLbNWen+6wYalt2+UE7RmFlZR16kiWzeM7gwle
         Df09uySkVn0boywQxd4Ni2g/ofscpxdIcGRVBHOZyG0dGfCowOEWonBLySHhYrfAcbKn
         uMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705929331; x=1706534131;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrphHGbARUcAn/ngDkEkvNE+edD8/JC5ZlNhTk3XAow=;
        b=d3PAYTAfpwRLjOqFTwNOZ1nKbYLYpZMXuNhfFVa1O9Y9nfdpNN1TZrdLOmOHQsHoFn
         rVovHnVE+3paverupVutv0wSqAxSUKw6N5FsLtRomxojWk82vPTxHnQ4yQ9/q+SPRuQ5
         Is9rB+vq82w0I7dLQhbdBGMwzqNgaj2iP8e2WWNmJW92h3hFdviML4haO4UPJTWwErPS
         KVmhz/q5+Z6tn+BBHtlrEukvE/DQRQj2Sr5kA9UKxapaGjvmLriglYV0FlZxtbJ9fHVI
         ck0cM2LsDLl1m/j0TVqejtiVhxcJFAdaVEEednksjrPH/e+2g3Y6IaCU20YfdsFmgckB
         FY6g==
X-Gm-Message-State: AOJu0YxpaBSYiB3CRozuvAJWT3sxwDLGstIWRykFCjq6YH6bWUTvQ4HM
	MVNWYabh/fliIM4/5JYGLff29MwQXwmmDkFXWjXlJh78WLw3eQIH
X-Google-Smtp-Source: AGHT+IFNQDl540fxCGy2i8tIT2fvvAFS8S62EzDBCUR26yZTImUesliSUExG18mDXMel4WKirVQQwg==
X-Received: by 2002:a17:90a:fd91:b0:28d:2aa7:b684 with SMTP id cx17-20020a17090afd9100b0028d2aa7b684mr1698483pjb.1.1705929331288;
        Mon, 22 Jan 2024 05:15:31 -0800 (PST)
Received: from pop-os ([2406:7400:56:bb44:b813:6b6f:a7f:98ed])
        by smtp.gmail.com with ESMTPSA id oh12-20020a17090b3a4c00b0028feef0f956sm9474431pjb.17.2024.01.22.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 05:15:30 -0800 (PST)
Date: Mon, 22 Jan 2024 18:45:27 +0530
From: Pranav Athreya <pranavsubbu@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: Pranav Athreya <pranavsubbugmail.com@pop-os.smtp.subspace.kernel.org>
Subject: [PATCH] x86/alternatives: Fix switch block in apply_reloc()
Message-ID: <Za5qb8livKA4XTeG@pop-os>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adhere to Linux kernel coding style

Reported by checkpatch:

ERROR: trailing statements should be on next line
+       case 1: apply_reloc_n(8, ptr, diff); break;

ERROR: trailing statements should be on next line
+       case 2: apply_reloc_n(16, ptr, diff); break;

ERROR: trailing statements should be on next line
+       case 4: apply_reloc_n(32, ptr, diff); break;

ERROR: trailing statements should be on next line
+       default: BUG();

Signed-off-by: Pranav Athreya <pranavsubbu@gmail.com>
---
 arch/x86/kernel/alternative.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ee0f681ae107..340cb5724d8f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -297,10 +297,17 @@ static __always_inline
 void apply_reloc(int n, void *ptr, uintptr_t diff)
 {
 	switch (n) {
-	case 1: apply_reloc_n(8, ptr, diff); break;
-	case 2: apply_reloc_n(16, ptr, diff); break;
-	case 4: apply_reloc_n(32, ptr, diff); break;
-	default: BUG();
+	case 1:
+		apply_reloc_n(8, ptr, diff);
+	       	break;
+	case 2: 
+		apply_reloc_n(16, ptr, diff);
+	       	break;
+	case 4: 
+		apply_reloc_n(32, ptr, diff);
+	       	break;
+	default:
+	       	BUG();
 	}
 }
 
-- 
2.34.1


