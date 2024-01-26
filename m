Return-Path: <linux-kernel+bounces-40906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44CF83E7BD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EEA1C27FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325D67E8F;
	Fri, 26 Jan 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bhJ/3yeb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727360EDC;
	Fri, 26 Jan 2024 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313370; cv=none; b=oJSuqZ3XwR1ruqYBx8WWmLo4RpG5g0Lp2ZZtHmGWegcRbw5FDpMamcCo37YA5PUPgdp3CaWfyQlXfGBkyrAZhWcLklf2hDuBWWpgev45OejlieIbTfNCmQ3AHSf65R/dtwCyQR2XcWzI0qypUJ7GvqyEP3voeimrAEoMYnJjTDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313370; c=relaxed/simple;
	bh=HPdSmHAE6Kxoa7SYi6b4pU2RaZg30ypDGBoGBXZqmt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O01tOduA3bDxrHc99UFKrMgumn0cqM/V8Eutym2sJgLq8jzEtCYdBYSHvMQ4gT3Flv0A23wd59bcB9kmEmgFYPXz/FDC3qwyhsNQC65/m2Z6eqZ76CzFVyNfpl+U3VwULhKbuLOpML4WwvbigekGNAEjnE2ScNDnv+nbwc1SQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bhJ/3yeb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNfA8L012981;
	Fri, 26 Jan 2024 23:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=QWn0sK+o2qrE9NX7n6L36OqvevsYmIxX7KEX82k6Etw=; b=bh
	J/3yebKee0Qp0BkgUZqxyDqdKAVgnIw3NDHuZil3d3eS3+u/b9wM1x971FMUzPm1
	RJfTYca2AFQHxMuV33g+MrbD5NK9ooEy//ifyXU4Yd9z9IwM2Nr40GjGJu7saQZM
	v2GCcvqS1ByC/yj8OOji5AChR50yzKuNSpPEuhRHMsJCMXnMzrRB0+Rdf2uK8EIF
	6p22qggKY9r5pAhXrKORWcqr9eMgX0JoHd233H3TuqGcL1ApmdoSHKRpaPmqhMVD
	mktJSqcHAP1NmIOrv+vlPe941jPBKP8Ii/2fyWL8XckU/b9Pd2dOanuPcn6wsR/5
	aDQkGu7ZJaTWpyH+4oUQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvjx88dm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNt07N009982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:00 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:54:57 -0800
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <vgupta@kernel.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <soc@kernel.org>, <guoren@kernel.org>,
        <monstr@monstr.eu>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <dinguyen@kernel.org>, <chenhuacai@kernel.org>,
        <tsbogend@alpha.franken.de>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <mpe@ellerman.id.au>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH 00/46] Dynamic allocation of reserved_mem array.
Date: Fri, 26 Jan 2024 15:53:39 -0800
Message-ID: <20240126235425.12233-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3OvLg89_a0PTiBhJYKkBTPnFsW88O-J1
X-Proofpoint-GUID: 3OvLg89_a0PTiBhJYKkBTPnFsW88O-J1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 mlxlogscore=859 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

The reserved_mem array is used to store data for the different
reserved memory regions defined in the DT of a device.  The array
stores information such as region name, node, start-address, and size
of the reserved memory regions.

The array is currently statically allocated with a size of
MAX_RESERVED_REGIONS(64). This means that any system that specifies a
number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
will not have enough space to store the information for all the regions.

Therefore, this series extends the use of the static array for
reserved_mem, and introduces a dynamically allocated array using
memblock_alloc() based on the number of reserved memory regions
specified in the DT.

Some architectures such as arm64 require the page tables to be setup
before memblock allocated memory is writable.  Therefore, the dynamic
allocation of the reserved_mem array will need to be done after the
page tables have been setup on these architectures. In most cases that
will be after paging_init().

Reserved memory regions can be divided into 2 groups.
i) Statically-placed reserved memory regions
i.e. regions defined in the DT using the @reg property.
ii) Dynamically-placed reserved memory regions.
i.e. regions specified in the DT using the @alloc_ranges
    and @size properties.

It is possible to call memblock_reserve() and memblock_mark_nomap() on
the statically-placed reserved memory regions and not need to save them
to the reserved_mem array until memory is allocated for it using
memblock, which will be after the page tables have been setup.
For the dynamically-placed reserved memory regions, it is not possible
to wait to store its information because the starting address is
allocated only at run time, and hence they need to be stored somewhere
after they are allocated.
Waiting until after the page tables have been setup to allocate memory
for the dynamically-placed regions is also not an option because the
allocations will come from memory that have already been added to the
page tables, which is not good for memory that is supposed to be
reserved and/or marked as nomap.

Therefore, this series splits up the processing of the reserved memory
regions into two stages, of which the first stage is carried out by
early_init_fdt_scan_reserved_mem() and the second is carried out by
fdt_init_reserved_mem().

The early_init_fdt_scan_reserved_mem(), which is called before the page
tables are setup is used to:
1. Call memblock_reserve() and memblock_mark_nomap() on all the
   statically-placed reserved memory regions as needed.
2. Allocate memory from memblock for the dynamically-placed reserved
   memory regions and store them in the static array for reserved_mem.
   memblock_reserve() and memblock_mark_nomap() are also called as
   needed on all the memory allocated for the dynamically-placed
   regions.
3. Count the total number of reserved memory regions found in the DT.

fdt_init_reserved_mem(), which should be called after the page tables
have been setup, is used to carry out the following:
1. Allocate memory for the reserved_mem array based on the number of
   reserved memory regions counted as mentioned above.
2. Copy all the information for the dynamically-placed reserved memory
   regions from the static array into the new allocated memory for the
   reserved_mem array.
3. Add the information for the statically-placed reserved memory into
   reserved_mem array.
4. Run the region specific init functions for each of the reserve memory
   regions saved in the reserved_mem array.

Once the above steps have been completed and the init process is done
running, the original statically allocated reserved_mem array of size
MAX_RESERVED_REGIONS(64) will be automatically freed back to buddy
because it is no longer needed. This is done by marking the array as an
"__initdata" object in Patch 0018.

Note:

- Per Architecture, this series is effectively only 10 patches. The
  code for each architecture is split up into separate patches to
  allow each architecture to be tested independently of changes from
  other architectures. Should this series be accepted, this should
  allow for each arcitecture change to be picked up independently as
  well.

  Patch 0001: Splits up the processing of the reserved memory regions
  between early_init_fdt_scan_reserved_mem and fdt_init_reserved_mem.

  Patch 0002: Introduces a copy of early_init_fdt_scan_reserved_mem()
  which is used to separate it from fdt_init_reserved_mem() so that the
  two functions can be called independently of each other.

  Patch 0003 - Patch 0016: Duplicated change for each architecture to
  call early_init_fdt_scan_reserved_mem() and fdt_init_reserved_mem()
  at their appropriate locations. Here fdt_init_reserved_mem() is called
  either before of after the page tables have been setup depending on
  the architecture requirements.

  Patch 0017: Deletes the early_init_fdt_scan_reserved_mem() function
  since all architectures are now using the copy introduced in
  Patch 0002.

  Patch 0018: Dynamically allocate memory for the reserved_mem array
  based on the total number of reserved memory regions specified in the
  DT.

  Patch 0019 - Patch 0029: Duplicated change for each architecture to
  move the fdt_init_reserved_mem() function call to below the
  unflatten_devicetree() function call. This is so that the unflatten
  devicetree APIs can be used to process the reserved memory regions.

  Patch 0030: Make code changes to start using the unflatten devicetree
  APIs to access the reserved memory regions defined in the DT.

  Patch 0031: Rename fdt_* functions as dt_* to refelct that the
  flattened devicetree (fdt) APIs have been replaced with the unflatten
  devicetree APIs.

  Patch 0032 - Patch 0045: Duplicated change for each architecture to
  switch from the use of fdt_init_reserved_mem() to
  dt_init_reserved_mem(), which is the same function but the later uses
  the unflatten devicetree APIs.

  Patch 0046: Delete the fdt_init_reserved_mem() function as all
  architectures have switched to using dt_init_reserved_mem() which was
  introduced in Patch 0031.

- The limitation to this approach is that there is still a limit of
  64 for dynamically-placed reserved memory regions. But from my current
  analysis, these types of reserved memory regions are generally less
  in number when compared to the statically-placed reserved memory
  regions.

- I have looked through all architectures and placed the call to
  memblock_alloc() for the reserved_mem array at points where I
  believe memblock allocated memory are available to be written to.
  I currently only have access to an arm64 device and this is where I am
  testing the functionality of this series. Hence, I will need help from
  architecture maintainers to test this series on other architectures to
  ensure that the code is functioning properly on there.

Previous patch revisions:
1. [RFC V1 Patchset]:
https://lore.kernel.org/all/20231019184825.9712-1-quic_obabatun@quicinc.com/

2. [RFC V2 Patchset]:
https://lore.kernel.org/all/20231204041339.9902-1-quic_obabatun@quicinc.com/
- Extend changes to all other relevant architectures.
- Add code to use unflatten devicetree APIs to process the reserved
  memory regions.

Oreoluwa Babatunde (46):
  of: reserved_mem: Change the order that reserved_mem regions are
    stored
  of: reserved_mem: Introduce new early reserved memory scan function
  ARC: reserved_mem: Implement the new processing order for reserved
    memory
  ARM: reserved_mem: Implement the new processing order for reserved
    memory
  arm64: reserved_mem: Implement the new processing order for reserved
    memory
  csky: reserved_mem: Implement the new processing order for reserved
    memory
  Loongarch: reserved_mem: Implement the new processing order for
    reserved memory
  microblaze: reserved_mem: Implement the new processing order for
    reserved memory
  mips: reserved_mem: Implement the new processing order for reserved
    memory
  nios2: reserved_mem: Implement the new processing order for reserved
    memory
  openrisc: reserved_mem: Implement the new processing order for
    reserved memory
  powerpc: reserved_mem: Implement the new processing order for reserved
    memory
  riscv: reserved_mem: Implement the new processing order for reserved
    memory
  sh: reserved_mem: Implement the new processing order for reserved
    memory
  um: reserved_mem: Implement the new processing order for reserved
    memory
  xtensa: reserved_mem: Implement the new processing order for reserved
    memory
  of: reserved_mem: Delete the early_init_fdt_scan_reserved_mem()
    function
  of: reserved_mem: Add code to dynamically allocate reserved_mem array
  ARC: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  ARM: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  arm64: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  csky: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  microblaze: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  mips: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  nios2: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  powerpc: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  riscv: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  um: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  xtensa: resrved_mem: Move fdt_init_reserved_mem() below
    unflatten_device_tree()
  of: reserved_mem: Add code to use unflattened DT for reserved_mem
    nodes
  of: reserved_mem: Rename fdt_* functions to refelct use of unflattened
    devicetree APIs
  ARC: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  ARM: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  arm64: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  csky: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  loongarch: reserved_mem: Switch fdt_init_reserved_mem to
    dt_init_reserved_mem
  microblaze: reserved_mem: Switch fdt_init_reserved_mem to
    dt_init_reserved_mem
  mips: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  nios2: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  openrisc: reserved_mem: Switch fdt_init_reserved_mem to
    dt_init_reserved_mem
  powerpc: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  riscv: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  sh: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  um: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  xtensa: reserved_mem: Switch fdt_init_reserved_mem() to
    dt_init_reserved_mem()
  of: reserved_mem: Delete the fdt_init_reserved_mem() function

 arch/arc/kernel/setup.c            |   2 +
 arch/arc/mm/init.c                 |   2 +-
 arch/arm/kernel/setup.c            |   4 +
 arch/arm/mm/init.c                 |   2 +-
 arch/arm64/kernel/setup.c          |   3 +
 arch/arm64/mm/init.c               |   2 +-
 arch/csky/kernel/setup.c           |   4 +-
 arch/loongarch/kernel/setup.c      |   4 +-
 arch/microblaze/kernel/setup.c     |   3 +
 arch/microblaze/mm/init.c          |   2 +-
 arch/mips/kernel/setup.c           |   4 +-
 arch/nios2/kernel/setup.c          |   5 +-
 arch/openrisc/kernel/setup.c       |   4 +-
 arch/powerpc/kernel/prom.c         |   2 +-
 arch/powerpc/kernel/setup-common.c |   3 +
 arch/riscv/kernel/setup.c          |   3 +
 arch/riscv/mm/init.c               |   2 +-
 arch/sh/boards/of-generic.c        |   4 +-
 arch/um/kernel/dtb.c               |   4 +-
 arch/xtensa/kernel/setup.c         |   2 +
 arch/xtensa/mm/init.c              |   2 +-
 drivers/of/fdt.c                   |  42 +++++--
 drivers/of/of_private.h            |   5 +-
 drivers/of/of_reserved_mem.c       | 178 +++++++++++++++++++++--------
 include/linux/of_fdt.h             |   4 +-
 include/linux/of_reserved_mem.h    |  11 +-
 kernel/dma/coherent.c              |   4 +-
 kernel/dma/contiguous.c            |   8 +-
 kernel/dma/swiotlb.c               |  10 +-
 29 files changed, 234 insertions(+), 91 deletions(-)

-- 
2.17.1


