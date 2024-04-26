Return-Path: <linux-kernel+bounces-160723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F718B41B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB94E1F229D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB6A39879;
	Fri, 26 Apr 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NeCnNsot"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626538F97
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168751; cv=none; b=mU52r7pTANr62IHd48QvZ72UHbKriAsSZOQnP3IYlan9ALdZEngN+suNq+t6Nk13Ej3A7nU1hyT5ttHHCf7cDBSpZG9I9OgJhS1b9vLWZ9HZfvtA86jwZyyZdOBEkFZegGHFv0J5z7wx7+VirfnR7E4Am/2rj9C54paHe1Voq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168751; c=relaxed/simple;
	bh=L8Ab5WCMlj93ZkUK7fmvA+6skCeg0/MC1ZxRnpvL1eI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jGjbkPCIUuld1dYkq3S8jEgUFVrUTBtjSWPC2hPr5qzE60lQbjCRAoiMwni9pMCh0c+GoTDfYb5ZR5x+X68/zQMXO/5E1Gd0VoYYY5zuoUKrdcUhdDHfLiGziWm4wtEbtzPt9pa86RPnmS/O9it7aoP21w0+0H7XAjVJGa/OhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NeCnNsot; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so7951005ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714168749; x=1714773549; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj3ZfOCdGCKn/0DhPn4SIIdN3JBrIasn6yJrQRPZkc8=;
        b=NeCnNsotut9/tuJZXuaCdSx38CnDebj1RQTWtkyWn+BtO/mkEFQKC4s1IL/YQbrJ16
         kCCjxKSbGXDFmEoxGzu/3trG1a2X6BzMRy8d50aasmSTypLvsBvCMc0Vt8NYJd4vrMBE
         qOtABM45WtqicAfMqLEKxuG77DKrU/F2G281QrnLxQ4K9Rr5MV9r3k/VCsLnCqnsd6a7
         oOLd4INI25Bv/LIeZEQ7MAGu8I1WedVPhPmuP1xUBn68vfnCIZ34NwAzWmjug2HB2oqP
         5bCHxYcesPr4U5dlaNU+RjanzMuYnduxwe3wZ2d+PYvCPnc6EXlw0lgQHGcBlrU+U1Au
         YjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714168749; x=1714773549;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zj3ZfOCdGCKn/0DhPn4SIIdN3JBrIasn6yJrQRPZkc8=;
        b=ty0a6HxiSlTCWegZHi/ruXlklURMvTO3buDUdN3CS6BmVQDJWZUPeo8LdOo+0D2d23
         6QuJ+jaavsgTTlbwJF7OrLsIKH1RNL6Uwx/JT0Booez6fqcfpoQyoTVuv9VPvzv8D6w1
         EEw9qNl1hskavjuMG3h68Q+bsXdlIMwM7xZXTGmo1uPvz75k0UgGmnOmzo0l/l08PdZN
         OPfzCMyi0V35zOor9aRLQpM3IeSU1hGF+YaSUYCVKw+B/dehXDAMTBblJZ0DwiWLRas6
         KIUZgh3FHj/SJuwapowXx4CrX0B9kEr7fRfJjpfNFyKsj8yf2CGn5cwAnM8YxemQ21Gq
         3oUw==
X-Forwarded-Encrypted: i=1; AJvYcCWGqma5rAOqag1Ls4+HAQGaQL4v6L6dJF/lCrqdZFY2lHy22lR/Jq6ujmpw12BZG0RnUJaFTXnKfP8RIan9bqVINjchyljdZZWL2wdp
X-Gm-Message-State: AOJu0YyNvWGWNoYzu6K1pgyLWy1W+5itOyJUy5N2B6NO6J6neef8oYO+
	HNaj9ZdDzR60Dqtry6eEI5KmAgrtfibG5cxly2Y5FGIlDC0byOSflZF0Nnz3y9c=
X-Google-Smtp-Source: AGHT+IG7k86hc6hdKQHC8igjv13gkothiiFulM58+LED4PQeT+W1pZHbYoVdgr5bSDxG80Q9uvmrnA==
X-Received: by 2002:a17:902:e806:b0:1e2:81c1:b35e with SMTP id u6-20020a170902e80600b001e281c1b35emr5209034plg.54.1714168749479;
        Fri, 26 Apr 2024 14:59:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001e2a7e90321sm15899787plc.224.2024.04.26.14.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:59:08 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] riscv: Extension parsing fixes
Date: Fri, 26 Apr 2024 14:58:53 -0700
Message-Id: <20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0jLGYC/32NQQ6CMBBFr0JmbQ0diggr72GIgXaQWdiSFhoN6
 d2tHMDl+z/v/x0CeaYAXbGDp8iBnc2ApwL0PNgnCTaZAUtUpUIl9LJNNKybp8fEbwqilSNpZZq
 2ogaytng6imzd+8wzh9X5z/EQ5S/9MxalKEV9rampDCJexpvn6AJbfdbuBX1K6QsTP6TCswAAA
 A==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714168747; l=1793;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=L8Ab5WCMlj93ZkUK7fmvA+6skCeg0/MC1ZxRnpvL1eI=;
 b=Yz03ohFque1N3oTKp/GjR4zQxP/h0b8sAvW+OXNnA2qpFgnnv7bfK6TqTgSpQFstclUqkqqr0
 ukjE3hC06gnCxk3HXla2IMV+CaU5FQiXaZwoK/AXHjyOarKnVxPDLNc
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This series contains two minor fixes for the extension parsing in
cpufeature.c.

Some T-Head boards without vector 1.0 support report "v" in the isa
string in their DT which will cause the kernel to run vector code. The
code to blacklist "v" from these boards was doing so by using
riscv_cached_mvendorid() which has not been populated at the time of
extension parsing. This fix instead greedily reads the mvendorid CSR of
the boot hart to determine if the cpu is from T-Head.

The other fix is for an incorrect indexing bug. riscv extensions
sometimes imply other extensions. When adding these "subset" extensions
to the hardware capabilities array, they need to be checked if they are
valid. The current code only checks if the extension that is including
other extensions is valid and not the subset extensions.  

These patches were previously included in:
https://lore.kernel.org/lkml/20240420-dev-charlie-support_thead_vector_6_9-v3-0-67cff4271d1d@rivosinc.com/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Move comment about assuming all harts to have the same vendorid/archid
  to apply specifically to the code that expects that (Drew)
- Link to v1: https://lore.kernel.org/r/20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com

---
Charlie Jenkins (2):
      riscv: cpufeature: Fix thead vector hwcap removal
      riscv: cpufeature: Fix extension subset checking

 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
 arch/riscv/kernel/cpufeature.c | 13 ++++++++++---
 3 files changed, 48 insertions(+), 7 deletions(-)
---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240424-cpufeature_fixes-91bec4d793e7
-- 
- Charlie


