Return-Path: <linux-kernel+bounces-108478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C99880B06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150D41F229A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0197F1DA4D;
	Wed, 20 Mar 2024 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S5gwNjv7"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D0182C5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915049; cv=none; b=Beds5MIcNGyJMnlk3coVUvRtLTo1qK+tRPW70hRUEQ6UuswhgS9ISYpbjZTWhyOMnmZYEZKYnnUa3Q8Svur72gwXoahT4Jh86XOdBjjBlzWp1x3gIIa/tFfcDVa0O1t88GOSndCIxkL/N+APUk51IFvWqGAL33lhtqtIwCsMcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915049; c=relaxed/simple;
	bh=VUlBmGcp8svVRc+YgVvPOifmDRnW+ZmwDpx4QVsS7Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixnmOEBbm1lbDrhYJ16Wz/JfLlEP3SRiaWrV9wJocypgLw/gAmPV7Uf2EIIjDi0Nb2c0D7X7Fjyfg1BZWf/Am7hAhzgYDugCQuVOTemrz+7aFlQthMpzBv7xgvs1MRG1Jd4zdyMS4J2FUao9Te4Cg4Fatq6oPlaGRuYfCc54quY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S5gwNjv7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a052a3fc5so155831885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710915045; x=1711519845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCZgkB2SZu0i/tSjRR46WOtj0M+sNHf+HRU976J1PX4=;
        b=S5gwNjv7rJIYJ3VDBg8xMHkiad+9TbnYc5zUrCVGF2afOYKUuIMjRE8vzYClS4ysW5
         +b2QkaiTRJ6KG18uQWLd+JF/3W2QPfuxMHdJTYNB2oaTw3W3AUBCsEWFnqO/Q9VC6DZR
         c8iSWGRKI54FH292DuskKmh/VfEtLJcOMUwhIMi/Yw1LQp3n/DVvisPEoXvDQEHq7PDd
         xyWOJ3QHa6NYD4cIBWu3Dqg832XyD5RQC9ftUAjV6cZwHRbzvX7rvag+RB0yZYR+kKHg
         IfzBRfhZR4m0olbg1N3Jr98DErl2l25xNE0VrLAUwD7jQdlYgEKIsKumvc+lgwDXT9+j
         OXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915045; x=1711519845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCZgkB2SZu0i/tSjRR46WOtj0M+sNHf+HRU976J1PX4=;
        b=mvo1TlyVTVtTN6+BabTDysrcKm9EMBfO8wVmjepFfmEQPzaR9IVIlz9/301nxH7z54
         kb3vn/NMbb9lwyuGG/GRGWuOxbiV8eF5+Bb+hhkN1iu0BO8pQgKjnuCBJ/JwhzYuy0rX
         SLi3XVkV8P/GLYnnNpRlP+VK4R2F0gaCb+/OhnDjPAuVNq0t9JZodlkWNEVyKMm4ZSFb
         KSPJm21KWase34bD2WqIh3YWAqnw8td+kH8nu5ddMz5sFQMPLGci8ZG/oK34jDhZzNdL
         y5utTW3g8iP0tqHH9IvhY+Ix/MHfDPEVcUNiCa1XptujXrnmnDTR60MkrwdxktytmJz7
         Rmbg==
X-Forwarded-Encrypted: i=1; AJvYcCVDMYEhuqlVe90/VqMy3oGdug5SpF9eVSsXJ6cTu1lnx6KC+pnnX11Ngwh8dAmwb8KYXZCypGH1i7iPkmqgfEm+reVlMxjPTIjdznyP
X-Gm-Message-State: AOJu0YysfdA+rjmFJ2JLne0HcO/VoSh9t+3sPmy1fgId/OsH5o2zM3F9
	JmzfF0X57sIXHJ8M3Hx9zRjkwvmlw0MYF/jPDxplA7a7UWys2l20ndOoIYGEzuk=
X-Google-Smtp-Source: AGHT+IFa111kisVq1eXAsilnKhEWjB1FxneYVefed7MzhMngJVWVGZbwSa2ElD7e4aapqGZS/vkJjQ==
X-Received: by 2002:a05:620a:5d8b:b0:78a:1c41:ac4e with SMTP id xx11-20020a05620a5d8b00b0078a1c41ac4emr2285040qkn.5.1710915045498;
        Tue, 19 Mar 2024 23:10:45 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.215.123])
        by smtp.gmail.com with ESMTPSA id r15-20020a05620a03cf00b0078a042376absm2295914qkm.22.2024.03.19.23.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 23:10:45 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Wed, 20 Mar 2024 06:10:38 +0000
Message-Id: <20240320061041.3246828-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
and after all devices are initialized at boot time, eliminating the need
for user intervention. If no HMAT is specified, it falls back to
using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v3:
 Thanks to Ying's comments,
 * Make the newly added code independent of HMAT
 * Upgrade set_node_memory_tier to support more cases
 * Put all non-driver-initialized memory types into default_memory_types
   instead of using hmat_memory_types
 * find_alloc_memory_type -> mt_find_alloc_memory_type
-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
 * https://lore.kernel.org/lkml/20240312061729.1997111-1-horenchuang@bytedance.com/T/#u
-v1:
 * https://lore.kernel.org/lkml/20240301082248.3456086-1-horenchuang@bytedance.com/T/#u

Ho-Ren (Jack) Chuang (2):
  memory tier: dax/kmem: create CPUless memory tiers after obtaining
    HMAT info
  memory tier: dax/kmem: abstract memory types put

 drivers/dax/kmem.c           |  20 +------
 include/linux/memory-tiers.h |  13 +++++
 mm/memory-tiers.c            | 106 ++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 25 deletions(-)

-- 
Ho-Ren (Jack) Chuang


