Return-Path: <linux-kernel+bounces-45160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F96842C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02671F267C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1E69970;
	Tue, 30 Jan 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WtOl0kYi"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C279952
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641475; cv=none; b=raJ3pO2twuAzzVsd16IbmIqer11IELDp+O5pn7UfeqMLx8sN26FyLJdPY2QWnn+YYESsKEYqQclqEwMfB2LjWIDNGsGSa9okxnpiuxiGJbAYek16wu61CR3EB1CGbolTRVyZiMLfAVumYky4P/6SAyCWWy5ZYnB8zW2NxJvMcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641475; c=relaxed/simple;
	bh=nus7scvl4gLMAQ9st9lYJlzmjXyvjRvTvEos3E8SaN8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YvthnFT7wuTvt8HJJyyJf5nPib1bKoMeCilLlwXMh2xNx2tVmTW5qacjOQHRHfaokIe5y6GyTSu7QGlXMbDMDYUpm5tiMB42PlWTbAcHT0y88SnMGtGWNmDWQ7fMrNd4H8o1ZpDy6zwWzxhaWaPpHEztwYq2QQ8CxCnKtaq6w2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WtOl0kYi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso2035615b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706641473; x=1707246273; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4D44QK/kPW88RwduNoGSI0iqhkYRS1kC786c0l3XOWc=;
        b=WtOl0kYitu1vk6+q9ok354ZBzSSeGHb1mECB12anN16/adJSmK/EWiYkyGgQpqz+GB
         NrZbS8As71csahGuZNk3flpFwI/Ppq4cdYRA9T1uZK91u1E/dDekmBqmzdLmzTzc50lb
         W28Cy+y/xBKxSkmyHI/3CqgHbGG07QK+4hDFeHU2xp0qR/UvDbf0E+/zzBPMM8fbRjt6
         8RDTxVYRFmreFOz4kiVoDk/J2HA2u0g0qvVc/Pk0NdDAKBNwaGuWMs0l2MnrFM3Zw6+D
         FfiY53s7AjeyVC2z8dBNr9TTUW5PBJi4vzwOIcWWRPhaYi20eCdowJbhDgUu28hZoeJ4
         joEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641473; x=1707246273;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4D44QK/kPW88RwduNoGSI0iqhkYRS1kC786c0l3XOWc=;
        b=Ol5OH26LtFxN3J/ZWJ1EONUDqkW2bhIDvSVCUZAPBrtVgal6gB5qp9ue/HsuKHfqfY
         b3FXTJbQoipFeW/1ismQj0ylyw7azaCKrqFKU8R5g5OUHO3VpcszXNJVHiBddX2Z5wm6
         I9zw6Tvckj6F2WIEqPDioILVFTg/rdr6m4gr7xD+kJGMH+MoPTHmOCUUvQ93Mcx3OSgU
         KFpUgCP8PEUtWcTZLRXFqb4l0n73MsTgFQsfRlX60cEUC6xotA+wCOCWmv5g0uazpOan
         yFAmZhczVDNPALqTCzdFw4DzIftk336w3+9H81ivzOka2uCFFUxNKkp9Bv81p1M/Ch04
         EWmQ==
X-Gm-Message-State: AOJu0Yzs36toRK5wGiDhq0U/SpPcBrdR6aSYLjiK0J/P+976iPdV5ca0
	UxFxtJI7HO24lJARFx44MUHImXahpRpRlqRo0y0ZbCv/T1lQOZcZ876lBUYE2rs=
X-Google-Smtp-Source: AGHT+IHDqzd/dBdeKM2ZuEG20ibf2MrAQHh0T7+zovFIc6n7MNP/9tMbddtfCfApaIPGdcPdBlRWvQ==
X-Received: by 2002:a05:6a20:291e:b0:199:8ed6:746e with SMTP id t30-20020a056a20291e00b001998ed6746emr4930207pzf.58.1706641472640;
        Tue, 30 Jan 2024 11:04:32 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090aec8600b00295c3bb9318sm1196541pjy.54.2024.01.30.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:04:31 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/3] riscv: mm: Use hint address in mmap if available
Date: Tue, 30 Jan 2024 11:04:29 -0800
Message-Id: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1IuWUC/3XNQQ6CMBCF4auQrq1hagXrynsYQtoylVnQkhaJh
 nB3gbBxwfKfZL43sYSRMLF7NrGIIyUKfglxyphttX8hp2ZpJnIhcwDF3wnrrtN93ZIfat00EVP
 iTjlpwBTu6oAtv31ER5/NfVZLt5SGEL/bzAjrdReFOBBH4MCLwhq8lU6qAh+RxpDI27MN3bqxA
 +oYyLm0pWz0DS5Gwz9QzfP8AxGwGU3+AAAA
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706641471; l=2052;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=nus7scvl4gLMAQ9st9lYJlzmjXyvjRvTvEos3E8SaN8=;
 b=KdPbSOIofsdWCW2zc9sZLA78Ps5RefDdeL5SX6tbIQDoFBXQBMlLBYRg9jpjXuHz+YesaWxjJ
 OSV+nMMkghNBtK/mt4vwjxEe5eas0TqtgvuALwBT9CPyCLon78uuHuz
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

On riscv, mmap currently returns an address from the largest address
space that can fit entirely inside of the hint address. This makes it
such that the hint address is almost never returned. This patch raises
the mappable area up to and including the hint address. This allows mmap
to often return the hint address, which allows a performance improvement
over searching for a valid address as well as making the behavior more
similar to other architectures.

Note that a previous patch introduced stronger semantics compared to
other architectures for riscv mmap. On riscv, mmap will not use bits in
the upper bits of the virtual address depending on the hint address. On
other architectures, a random address is returned in the address space
requested. On all architectures the hint address will be returned if it
is available. This allows riscv applications to configure how many bits
in the virtual address should be left empty. This has the two benefits
of being able to request address spaces that are smaller than the
default and doesn't require the application to know the page table
layout of riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Add back forgotten "mmap_end = STACK_TOP_MAX"
- Link to v1: https://lore.kernel.org/r/20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com

---
Charlie Jenkins (3):
      riscv: mm: Use hint address in mmap if available
      selftests: riscv: Generalize mm selftests
      docs: riscv: Define behavior of mmap

 Documentation/arch/riscv/vm-layout.rst           | 16 ++--
 arch/riscv/include/asm/processor.h               | 22 +++---
 tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
 tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
 tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
 5 files changed, 67 insertions(+), 104 deletions(-)
---
base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
-- 
- Charlie


