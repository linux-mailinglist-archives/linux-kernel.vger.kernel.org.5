Return-Path: <linux-kernel+bounces-131319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE21B898641
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8930C2885F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AEC84FDC;
	Thu,  4 Apr 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXYkYqNC"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62481D696;
	Thu,  4 Apr 2024 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230957; cv=none; b=cd/yrA+QMmqNqL88W9of5QL4l9U6xCvb1s/AUe4HtJ6TztQmS9PYrbvsSbnCETAQfjPJV++ZoFFB+xdR5vtGFS/+1ABDk76kPofwu2RwMhfxZ49jX7BNjyPGEqrNN3CgjMA/k2Izw3UwUGIBnokdbKE+9afFNVu+Z6G+6X5LYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230957; c=relaxed/simple;
	bh=gc0+x8gc+vIJy2Lf94WlX85eiWnFIj2hU9/8RcPaHf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E0W1aspGBRWv8ia4zwC9jJ7C0X2xqjHGB+83pcaoOUCfxhvvEmbbNBxXbiL8rJm2L+gONNPreAvDauaNB/sMsY2B36oT2KTcOLF5pgqtJSDUGYbUyUZh/zhkwX+AofOoIL4qc/BNqItRM9FUJIw2FCLRGkZeFv+7GdJ6iIB3j7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXYkYqNC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41551639550so6242345e9.2;
        Thu, 04 Apr 2024 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712230954; x=1712835754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/9UaWH58JbSSliu9hWrazNjsMfAiTpooxWMtLVHRkQ=;
        b=aXYkYqNC697rs46sQ+7imO6JBPRIHR5eaAq8dsaCbenzGAttsoKuogxCW0ZP6g53J+
         Mju5pA3OD5esXSQyn2f09C0YXPx/qVv5GVM1oT851EyYTsKLoeIVKXQ9/UB++tNxC9CT
         QzNnW6P3SWzEEM+wpP1jcOHlwVNwc1VRC/Lm+xTuTJ92L8s/CPv5tuXfYSu50L6FGbRi
         xzogHN8eusmBwYL6LvXXaCuC/F9vC0lGzFPWiKAW1AntkxVwf4HS+O+i/hdXx8gcNkOY
         VJF/bCZJZh2AZrc1I4RybLrH5dL00KKfQdMGdSKuNBg2reWknmE5HBzcbcKsu95mo6FZ
         tJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230954; x=1712835754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/9UaWH58JbSSliu9hWrazNjsMfAiTpooxWMtLVHRkQ=;
        b=L9KoB5cYDTRLZkbOHlK6rmO9Tq1Eq1huGNbUUFLKWV+P+qb1R8ouJs+x4y8xW9ZWeV
         NDRTVgaX7EZEbREiUIQMFR/fs50dYxhQpM1Hk0pyjy7AgPssm83JL/7xnYHLcb/gOv/c
         Hghq0MLXrljwlW0PfbH3BlCoOlwvj8aMu+pyZxNWjhUvpadoaSWkw7blqdhOYWA7t5cH
         /ffINDIGBPPsTNwun8JZk1ThQqFSKC/k0MnnGIznw23S74YwRZ9KBVl2HYd+fsSqrASh
         2nfrHuWNBO5H9WFM5R/NZ9jPh7ayDfMuLfdbxkPoCNmZpHEX4ugieRhyV0oMsUaarNhU
         UDUA==
X-Forwarded-Encrypted: i=1; AJvYcCXaqr4OrKseLapJEbx4c3d16aAVieWWRBlaY6+ax0zY8gSIUGiVGIGaijSSALqVtSxloBJqisZPDfIdACHnveUsiVRF0jKafi9G7vpARRW/Y3Cd0ZSVWxNoBaYN69BqH4PM
X-Gm-Message-State: AOJu0YwfKXYZlYskNFuEAK0yLMm2f/3y0WkwOgodBmDd63breJn6BWeI
	VYk/zovhTB+wugtaP/OKS8kAthaYkAQfLRxe+zsTrGSQi+4P3Bv+
X-Google-Smtp-Source: AGHT+IH4vjW4HOFwL0nxbzJW32/tQIfeK4E02sLbTVajHqefX6+EkRKk3hQ3JvJK5+Y61Zy5YxGxEg==
X-Received: by 2002:a05:600c:310b:b0:416:2485:e6ce with SMTP id g11-20020a05600c310b00b004162485e6cemr1984611wmo.22.1712230953991;
        Thu, 04 Apr 2024 04:42:33 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b0041568e91c41sm2411599wmo.41.2024.04.04.04.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2024 04:42:33 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huaweicloud.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v4 0/2] bpf,riscv: Add support for BPF Arena
Date: Thu,  4 Apr 2024 11:42:01 +0000
Message-Id: <20240404114203.105970-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in V4:
V3: https://lore.kernel.org/all/20240326224943.86912-1-puranjay12@gmail.com/
- Fix some style issues.
- Add Tested-by: and Reviewed-by: tags by Pu Lehui and Björn

Changes in V3
V2: https://lore.kernel.org/bpf/20240325155434.65589-1-puranjay12@gmail.com/
- Use REG_DONT_CLEAR_MARKER in place of DONT_CLEAR as the name.
- Use RV_REG_ZERO for the above as it is guaranteed to be never used in as
  dst/src register in BPF LDX/STX/ST instructions.
- Use #define RV_REG_ARENA for RV_REG_S7

Changes in V2
V1: https://lore.kernel.org/bpf/20240323154652.54572-1-puranjay12@gmail.com/
- Used S7 in place of S11 for storing the kernel_vm_start
- Used 17 in place of 16 for DONT_CLEAR marker
- Remove an unused variable
- Removed some misleading information from the commit message.

This series adds the support for PROBE_MEM32 and bpf_addr_space_cast
instructions to the RISCV BPF JIT. These two instructions allow the
enablement of BPF Arena.

All arena related selftests are passing:

  root@rv-tester:~/bpf# uname -p
  riscv64
  root@rv-tester:~/bpf# ./test_progs -a "*arena*"
  #3/1     arena_htab/arena_htab_llvm:OK
  #3/2     arena_htab/arena_htab_asm:OK
  #3       arena_htab:OK
  #4/1     arena_list/arena_list_1:OK
  #4/2     arena_list/arena_list_1000:OK
  #4       arena_list:OK
  #434/1   verifier_arena/basic_alloc1:OK
  #434/2   verifier_arena/basic_alloc2:OK
  #434/3   verifier_arena/basic_alloc3:OK
  #434/4   verifier_arena/iter_maps1:OK
  #434/5   verifier_arena/iter_maps2:OK
  #434/6   verifier_arena/iter_maps3:OK
  #434     verifier_arena:OK
  Summary: 3/10 PASSED, 0 SKIPPED, 0 FAILED

Puranjay Mohan (2):
  bpf,riscv: Implement PROBE_MEM32 pseudo instructions
  bpf,riscv: Implement bpf_addr_space_cast instruction

 arch/riscv/net/bpf_jit.h        |   2 +
 arch/riscv/net/bpf_jit_comp64.c | 203 +++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c   |   2 +
 3 files changed, 205 insertions(+), 2 deletions(-)

-- 
2.40.1


