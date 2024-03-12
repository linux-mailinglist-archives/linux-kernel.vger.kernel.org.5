Return-Path: <linux-kernel+bounces-99887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502FA878EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C29928501B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB659B78;
	Tue, 12 Mar 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N87hEi6d"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646159B5A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224280; cv=none; b=dLc9WSAvzvFiVbv8RGDGoPcw0IVT11GQG3niDERHsDYuXwdG7kfpeQTGE9EDBxo2PaW4Lq6QaD6e90rjEWriojhJUyt182PguS3krlyBtesk5m5GYxdYZXPmk8H6EUrlJSy1rc6xmeZZIrhkmtLWOUs01sAng6P05kDaP5SDa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224280; c=relaxed/simple;
	bh=nmhtM2hCPPzOA3PI1UXfFRGQ2/QNiXyNuDJau9M3uBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNaFhyKvYRjjL97BME6CkwexZPEu3TbqHgT0FK8T/qL52gIWZasUo3aEU6YxW48WH8cEqTNq13GRfp3A/BSg8MBuqCKaZXASO6BgBOu5/Lfl6YeAQpKkZEJatdUlyN8cibkAZibVDAC9hpOBc6LoT6nXchelmsDMYOU5fLTB8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N87hEi6d; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783045e88a6so318255985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710224276; x=1710829076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgGl/GezxVhRISLyx8tZ9PTH8m4h7yDB3m04Y7JMT5Y=;
        b=N87hEi6diJng+w7+kr1gATEIjESXvtw+Akc9f6rIK63qn+rl+fDI9YzT3pZIvLm2AS
         OabDFtRqCET9CeXl9TW1mvwAw+q5Iu2x8e+dI/ZOY1Cfo4Pvg4LUdE98CjZm50RoeSQJ
         9ymy2k0sf7H86rm0Dysxp5qPoueOXY3sgFMAgpvPmX1ruTqp0SBnhC3ADYXksDFcVFCq
         ZjtzN2DQqaPe4+byUBjTn/bvgLNg6yJ3WQPxYdioeQdXirc3fdG+iDg8VDKRhhoWNeIh
         4zsxKVOOpG+K9JAD1D45Uhd8/QurjMHKsCswPJIeKzSDVNdZWisjkRAUW3KIRBJtxEC2
         y21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710224276; x=1710829076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgGl/GezxVhRISLyx8tZ9PTH8m4h7yDB3m04Y7JMT5Y=;
        b=jEDyOEt/uyFAeHIV+/C4nyAL8Q2k0y2Q/Mq2DT2yfvYal+J/V4wgmhdH1dzPd7eKE+
         DS0hhu6AXfCUU7AomGJmuNU5/QB/67ARaoVx3ARhTqz/6qTCZprBBaY4RlDOOUuxW2bm
         s0E/wr8YDD8pKp0Bxvvy0+UkGRENXBmlM3aguOTHR1hW/oopJFt0jXH0zaPft56srjWC
         18zII6ppoRY8vEmUKohspUzRzuAa5RLU8RaTRkg85kPK2WjEXl1gVSEhg1C3B/eVe0Rs
         ZvG/AH2ggNWoKyHvllTWcEd3ii1Jg8ACz60qKCtb4GMhLxDDNOP8onwqiEKoWyjwiA4N
         Ov4g==
X-Forwarded-Encrypted: i=1; AJvYcCW8YQyBT5wZoqQFTOpiOuYwTC3tSGNYgtNZk7KdjqsL1pTgCu56nY3Uzsi/g46tbaxWR9kHiRezd+Ku5UYk7py4w8LDqmzz/tJtSKfl
X-Gm-Message-State: AOJu0Yy8nKjqezC6VWlVNP8gw2tvgDARVaf599oZ/rd8S1r5Ky2NGE2w
	1Ur/W8BPVzd5xWy2fmMubqTun3/Tz+pBfYJoF/eoNNO7ce3xBW6xwG763y0npIo=
X-Google-Smtp-Source: AGHT+IGQVjf55XaSaA7QRv11XERHDa0ikizCRigRPLUcQWIpU3ODAYNJ7IKwN9aaMW4bZrAoONZoqw==
X-Received: by 2002:a05:620a:4494:b0:788:7dc5:cf8f with SMTP id x20-20020a05620a449400b007887dc5cf8fmr499319qkp.35.1710224276179;
        Mon, 11 Mar 2024 23:17:56 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.133])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b00787b93d8df1sm3394396qkh.99.2024.03.11.23.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 23:17:55 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Tue, 12 Mar 2024 06:17:26 +0000
Message-Id: <20240312061729.1997111-1-horenchuang@bytedance.com>
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
at boot time, eliminating the need for user intervention.
If no HMAT is specified, it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
-v1:
 * https://lore.kernel.org/linux-mm/20240301082248.3456086-1-horenchuang@bytedance.com/T/


Ho-Ren (Jack) Chuang (1):
  memory tier: acpi/hmat: create CPUless memory tiers after obtaining
    HMAT info

 drivers/acpi/numa/hmat.c     | 11 ++++++
 drivers/dax/kmem.c           | 13 +------
 include/linux/acpi.h         |  6 ++++
 include/linux/memory-tiers.h |  8 +++++
 mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++---
 5 files changed, 92 insertions(+), 16 deletions(-)

-- 
Ho-Ren (Jack) Chuang


