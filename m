Return-Path: <linux-kernel+bounces-111043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAAE886743
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F991F24394
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07B012E72;
	Fri, 22 Mar 2024 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ik7dQoJ1"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB511193
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091049; cv=none; b=ovzk6TEu0eZEfpcD0cVCogEB/8hqZlqN2euqONbqGlZTw35Mm3StZE6KDJvNm80kgPIsghdbjzdf8AtgV7DoJSkweLOIs4nyJZFmXggNIMRYvfDDz41q7A6HWlkZlw15yUn7e2t3KmOXF17F6wiOZyA2ZpQPGP5K4k7vjO8CSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091049; c=relaxed/simple;
	bh=cC3Eez1CLayYKIyINIjN1grR1+1EPv1fuI+L5FJKjoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pLTm4JVzE1xB5vQNbuFEJ3oYvGrpikqoPfyCyvyFtKDZgDe1frt3I95mjN2ZhLwQDKjsLpnHq02u/XjPU71cU9ZfPDaIvLJTQTdRtqAT0KNwwfKppgHHeKYjTyriAryXS5M1Jn2K5wbyT7lG9tRYLNj+n7m63gEJA3rPA/7fdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ik7dQoJ1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e519d73850so1146192a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711091047; x=1711695847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7neNI4OXUjIQ5rL9BmGxx5XZjsprNGi1CqpvhfOJ5A=;
        b=Ik7dQoJ1pLA1nVRsBBUuSZHJ/ZbSZUJUi8PE1vEnMRiwnsNEfFRgK08dPM+flYcvUs
         LC5GwiYcU9n1QVnNvNL1SRMjPD2mVS+Hxa2VrNEyfHUTZIvoZPlB/wruaYMrzKJwIvjZ
         vPTPO2Vrz+cppFWqO8LwUSRCVSJWZY+o5XCI6uMatHsQHKPI2feWeyB4j0odh+4YC6TH
         ZdA+0ZuIC/Or4UaGAVj8ZyvY1UilHP3tF/lsMRrZoDdFD7YVWXujkbBIVS5vZa7ogPlj
         QK17dIh88R1cPA/vhipqXh4e35D2Q34wXE114g212YUQeuGLEa/YQaTjtuzLYzrA4bG1
         mTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711091047; x=1711695847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7neNI4OXUjIQ5rL9BmGxx5XZjsprNGi1CqpvhfOJ5A=;
        b=wqlASKWdcdeuNpmn/jmko0Q/itooIo9WK2C4oJitLLZ0yfSs/ShvR988jBJ9tTrui8
         5YEXAjpTGuQAdA3WqSTkM4DDmvOXWT8vJo2bQvUBSZwUAAZPcPzsJWBZEvZjUDQ9NG4r
         6jW/zBEsPIsDXeFum7/grdPIFoGqHIzVFbrNZDuOuwBxB5kejVlZGJKTBZWOXlbSDbZq
         0yiCPXRR0LbTJ7k2iEvjBoFjfSt/JalAuhptNQ9hgi591RHlEJBJlQrie4ngMjMfybEh
         hf1+XT8NA/p6eaR2WG3IDhIXnoGwGYOGlWzuKoI6mP4bjiGgQj8slh4DOhqeohXzb3GJ
         CfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXjTrnTWZjE9y5+FzDt07QXTc8J6Waxpuz/LKJKA5W7dJoDfb23os6k8PDIvGQ4W6/Fu1g5/xiK83ZB9swdrWzK6WabEYgP8WcabF4
X-Gm-Message-State: AOJu0Ywd0aUmqdvuPmNaPKQaV6I13gF4YjfytfZqjbbwfEcS5qR8h3mT
	cYwqb4KjEW00/FAJA12OqCnDLOIaLNewVLjfLsPQVeo/iDPrIH3IooGNFnhINuY=
X-Google-Smtp-Source: AGHT+IGDL07edZqKGbxe2OTitulABo89PW1+afEDf8VZk/5xbSmUkIHDwnIlESs+qhqPqacblb6/Pg==
X-Received: by 2002:a05:6830:87:b0:6e6:7b48:b801 with SMTP id a7-20020a056830008700b006e67b48b801mr1669775oto.16.1711091047143;
        Fri, 22 Mar 2024 00:04:07 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.215.108])
        by smtp.gmail.com with ESMTPSA id k1-20020ae9f101000000b00789fc794dbesm553974qkg.45.2024.03.22.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 00:04:06 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri, 22 Mar 2024 07:03:53 +0000
Message-Id: <20240322070356.315922-1-horenchuang@bytedance.com>
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

-v4:
 Thanks to Ying's comments,
 * Remove redundant code
 * Reorganize patches accordingly
-v3:
 Thanks to Ying's comments,
 * Make the newly added code independent of HMAT
 * Upgrade set_node_memory_tier to support more cases
 * Put all non-driver-initialized memory types into default_memory_types
   instead of using hmat_memory_types
 * find_alloc_memory_type -> mt_find_alloc_memory_type
 * https://lore.kernel.org/lkml/20240320061041.3246828-1-horenchuang@bytedance.com/T/#u
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
  memory tier: dax/kmem: introduce an abstract layer for finding,
    allocating, and putting memory types
  memory tier: create CPUless memory tiers after obtaining HMAT info

 drivers/dax/kmem.c           |  20 +------
 include/linux/memory-tiers.h |  13 +++++
 mm/memory-tiers.c            | 105 +++++++++++++++++++++++++++++++----
 3 files changed, 110 insertions(+), 28 deletions(-)

-- 
Ho-Ren (Jack) Chuang


