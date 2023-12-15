Return-Path: <linux-kernel+bounces-413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8688140BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C28E1F22F42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4E5677;
	Fri, 15 Dec 2023 03:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="fIKiuafG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370B53A2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1702611749; bh=S8EbHr+1Fb9q+H61h6uyUVAAOWrp1qaooLCgdsiAGJw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fIKiuafGj7Dutme++KBjpPcmnqFolayYPwe+a+UpJOML59zgfuptM0bFNpTSm+83m
	 Hmdk631uh6kBWApqgWSx9TwW8+/UwM61CXKmv2iwZk8C8uMMLQ+mpEgOUvzpPP4QmA
	 O8xO+jyrpDrrQnCUBXlx0POxag+l1xhvSfRgizDTwm7gJGiS3fObWmYzKmLzRerONj
	 jKPMBLGj2xg3T0dNZkkZbKf/HcDSrZ9d2iaBsrhP+cIa46CrIsOf63/a6wwLnz+HfK
	 ZXAUTq1b32EXBdUqVmchZYeroX28IIk6QLhBf9M491Zsd+6SWGK8bukxyyj8xTneGw
	 Ylu4Ri6XE2r6w==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 7E9028147F;
	Fri, 15 Dec 2023 03:42:23 +0000 (UTC)
From: sxwjean@me.com
To: vbabka@suse.cz,
	42.hyeyoo@gmail.com,
	cl@linux.com,
	linux-mm@kvack.org
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev,
	corbet@lwn.net,
	keescook@chromium.org,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH v4 0/4] supplement of slab allocator removal
Date: Fri, 15 Dec 2023 11:41:46 +0800
Message-Id: <20231215034150.108783-1-sxwjean@me.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Hvqg6Vbq3xfWygLtBS5A3hKzFx0w8b3O
X-Proofpoint-ORIG-GUID: Hvqg6Vbq3xfWygLtBS5A3hKzFx0w8b3O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312150025

From: Xiongwei Song <xiongwei.song@windriver.com>

Hi,

Patch 1 is to remove an unused parameter. It has a longer history, please
see the change history inside the patch.

---
Patch 2 is to replace slub_$params with slab_$params.
Vlastimil Babka pointed out we should use "slab_$param" as the primary
prefix for long-term plan. Please see [1] for more information.

I did the basic tests with qemu, which passed values by sl[au]b_max_order,
sl[au]b_min_order, sl[au]b_min_objects and sl[au]b_debug in command line.
The values looks correct by printing them out before calculating orders.

---
Patch 3 is to replace slub_$params in Documentation/mm/slub.rst based on
the changes of patch 2.

---
Patch 4 is original patch 3. It is not related to slab allocator removal.
It's to correct the description of default value of slab_min_objects in
Documentation/mm/slub.rst. 

---
This series is based on [2].

---
CHANGES
V4:
- patch 1: Clean up typos.
- patch 4: Make the description of slab_min_objects helpful.
           Refine the subject.

V3:
- patch 1: Collect Reviewed-by tag.
           Refine the commit message.
- patch 2: Remove the changes for variables and functions.
           Resort slab_$params in doc.
           Refine the commit message.
           Remove RFC tag.
- patch 3: Use slab_$params in slub.rst.
- patch 4: It's original patch 3. Just resorted patch orders, no any other
           Changes.

v2: https://lore.kernel.org/linux-mm/457899ac-baab-e976-44ec-dfdeb23be031@suse.cz/T/#t
- patch 1: Collect Reviewed-by tag.
- patch 3: Correct spelling mistakes in commit message.

v1: https://lore.kernel.org/linux-mm/20231201031505.286117-1-sxwjean@me.com/

---
Regards,
Xiongwei

[1] https://lore.kernel.org/linux-mm/7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next

Xiongwei Song (4):
  Documentation: kernel-parameters: remove noaliencache
  mm/slub: unify all sl[au]b parameters with "slab_$param"
  mm/slub: replace slub_$params with slab_$params in slub.rst
  mm/slub: correct the default value of slub_min_objects in doc

 .../admin-guide/kernel-parameters.txt         | 75 ++++++++-----------
 Documentation/mm/slub.rst                     | 60 +++++++--------
 drivers/misc/lkdtm/heap.c                     |  2 +-
 mm/Kconfig.debug                              |  6 +-
 mm/slab.h                                     |  2 +-
 mm/slab_common.c                              |  4 +-
 mm/slub.c                                     | 41 +++++-----
 7 files changed, 92 insertions(+), 98 deletions(-)

-- 
2.34.1


