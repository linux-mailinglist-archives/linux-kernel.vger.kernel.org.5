Return-Path: <linux-kernel+bounces-6417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D681819891
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A7F1F257CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37C11C88;
	Wed, 20 Dec 2023 06:24:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m118196.ym.163.com (mail-m118196.ym.163.com [115.236.118.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BA11715
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from fedora.. (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 7353926010E;
	Wed, 20 Dec 2023 13:57:40 +0800 (CST)
From: fuqiang wang <fuqiang.wang@easystack.cn>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] kexec: fix potential cmem->ranges out of bounds
Date: Wed, 20 Dec 2023 13:57:30 +0800
Message-ID: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSxgfVkhLShoZSRkZTR1IGlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c85cd1f610276kunm7353926010e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Qgw4VjE*SlEcDAwDCw4M
	MRYwC0NVSlVKTEtIS05KQ01JTEtCVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJSk1ONwY+

This series tries to fix the potential cmem->ranges out of bounds.

On the v1 version, there are still some issues that need to be
discussed, as follows:

1) Whether we need have the cmem->ranges[] partly changed, or keep it
unchanged when OOB happened. Previously discussed link:[1].

2) Set cmem->max_nr_ranges in crash_setup_memmap_entries() to 1 or 2.
Previously discussed link:[2].

3) To enhance crash_setup_memmap_entries() readability, how to move
code. Previously discussed link:[2].

v2:
  - Fix potential out of bounds in crash_setup_memmap_entries().
  - Add a comment in fill_up_crash_elf_data() to explain why the array
    size do not need to be changed.

v1:
  Link: https://lore.kernel.org/all/20231127025641.62210-1-fuqiang.wang@easystack.cn/

[1]: https://lore.kernel.org/all/ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv/
[2]: https://lore.kernel.org/all/273284e8-7680-4f5f-8065-c5d780987e59@easystack.cn/

fuqiang wang (2):
  x86/kexec: Fix potential out of bounds in crash_setup_memmap_entries()
  kexec: Fix potential out of bounds in crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 20 ++++++++++++++------
 kernel/crash_core.c     |  7 +++----
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.42.0


