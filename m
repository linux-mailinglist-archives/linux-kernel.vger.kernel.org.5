Return-Path: <linux-kernel+bounces-105693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B787E2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A235A282EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE4208A4;
	Mon, 18 Mar 2024 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/ZriTdP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D71F951
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710735174; cv=none; b=gwFOcit0BVm6UMDY6rdA5vErTxGjypRg3gtXxrcXA+ggwht10/9frQwhC7l83pnrKT/tvs7b1vRgYrGEOOOg/DxDQHvVjP+CJ1+DkLGdbjTH+C+sD8pb2xzpcsa7INAYMupxKANvVx8ybQsTydzNZ/t3AIGgsQ/woZB0j/4LYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710735174; c=relaxed/simple;
	bh=Q0B4Vrp20I6xvXHyIvu2roSZtbpiXkTd9aergIICdxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqWT41o2rizh7UTqYERFBgNRGqPm6UnXGNG8nu0Br8nP4xZg3VD3fK30aY/hXPgd/vsTvgECpx9lbmMaxRdy4TPn0H4h16dhZd4/qdWoSNO6FWRbegSm3zmhIq4DYwCyrG5RDr4QgqiioftFGJzwt+vkylQlHgwE3yfZYIkC4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/ZriTdP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710735172; x=1742271172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q0B4Vrp20I6xvXHyIvu2roSZtbpiXkTd9aergIICdxM=;
  b=f/ZriTdP2fErudaxJEeN0Al6gDUdWyxvAtPuZqexBMsu/BPLgQ9sa4K9
   qzm8CFK8rPGyoaL/yUQDuBJ5QlVsLMCUdTu1e8Q7gwEPp7IqvoVGpmLH6
   24gwAgicqua2re6ovQSPmcoHunVfy4byJGL3PGrJZGPSfYIJ4oWmyD1qf
   x4xhbM/aDlu7WZZc8BGDg5OvzMeMZriO+l3sjMHcwYUxpxLLxbadoMa9W
   HFN0dmSria9CKYp7dqWDxXrjyqgIb62XpuVd6UcfcpBIR3/pFwSOebFW0
   BSbu5g7vfmzQWefazGPY4PaL8ix7F7sa77WDtQxKyIT+SATMnSQnm/X33
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5393847"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5393847"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 21:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="44383679"
Received: from tgl-lenovo-03.sh.intel.com ([10.239.87.93])
  by fmviesa001.fm.intel.com with ESMTP; 17 Mar 2024 21:12:48 -0700
From: wangxiaoming321 <xiaoming.wang@intel.com>
To: lucas.demarchi@intel.com,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: wangxiaoming321 <xiaoming.wang@intel.com>
Subject: [PATCH] drm/xe: Failed getting VMA cause display stuck
Date: Mon, 18 Mar 2024 12:12:44 +0800
Message-Id: <20240318041244.1239610-1-xiaoming.wang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failure of binding VMA is duing to interrupt,
So it needs to retry while return fail.

Signed-off-by: wangxiaoming321 <xiaoming.wang@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 99aa5ffb0ef1..d33476b631e1 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2621,6 +2621,9 @@ static int __xe_vma_op_execute(struct xe_vm *vm, struct xe_vma *vma,
 	}
 	drm_exec_fini(&exec);
 
+	if (err == -ERESTARTSYS)
+		goto retry_userptr;
+
 	if (err == -EAGAIN) {
 		lockdep_assert_held_write(&vm->lock);
 
-- 
2.25.1


