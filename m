Return-Path: <linux-kernel+bounces-95229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEEE874AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465CB289649
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752783CB7;
	Thu,  7 Mar 2024 09:35:47 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519B82D8F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804146; cv=none; b=Ow5QlbuMOGcVbRYJiRix7E1CNolOQw7vZDSZWu9bbE0tfZw9NKRi2fTdon4HW7bvTK8jPqrhf5jH9EFUL5PzOJEO/96tFwxOXEWjKnjDDEfgoxnRIJqEFK0YuqsBexJuyFN+G0CktoGUdkRNOFL7J4hOjZ+xi/DueBePsS4iiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804146; c=relaxed/simple;
	bh=OSWY6xEEDq69IrCc35Q1ZUgfQWUenoBJfmc30oiTdEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lDULW7TTBuu2xpLY8s/Ne9L3chZf/44EeUnbiVx+A12cgtHQPp5WO5WAOnNwngSS7nTnoDoHJxFTueudI2RZ+7jufjAVbyK6OESKUIA1AU0fUL115oHJ4EaPVnq1vNxsqpLCNsueLZ+OJ6opaCubcgt5eTwe+8lcpFOskDjP6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([84.195.187.55])
	by albert.telenet-ops.be with bizsmtp
	id vlbb2B00K1C8whw06lbbx4; Thu, 07 Mar 2024 10:35:36 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1riA9q-002dLQ-BJ;
	Thu, 07 Mar 2024 10:35:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1riAA3-00FN5Y-Gh;
	Thu, 07 Mar 2024 10:35:35 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-m68k@lists.linux-m68k.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: pgtable: Add missing #include <asm/page.h>
Date: Thu,  7 Mar 2024 10:35:30 +0100
Message-Id: <ba359be013f379ff10f3afcea13e2f78dd9717be.1709804021.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When just including <linux/pgtable.h>:

    include/asm-generic/pgtable-nop4d.h:9:18: error: unknown type name ‘pgd_t’
	9 | typedef struct { pgd_t pgd; } p4d_t;
	  |                  ^~~~~

Make <asm/pgtable.h> self-contained by including <asm/page.h>.

Reported-by: Jani Nikula <jani.nikula@intel.com>
Closes: https://lore.kernel.org/r/878r2uxwha.fsf@intel.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Jani: Feel free to pick this up as a dependency.
Else I will queue this in the m68k tree for v6.10.

 arch/m68k/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/include/asm/pgtable.h b/arch/m68k/include/asm/pgtable.h
index 27525c6a12fd0c7f..49fcfd7348600594 100644
--- a/arch/m68k/include/asm/pgtable.h
+++ b/arch/m68k/include/asm/pgtable.h
@@ -2,6 +2,8 @@
 #ifndef __M68K_PGTABLE_H
 #define __M68K_PGTABLE_H
 
+#include <asm/page.h>
+
 #ifdef __uClinux__
 #include <asm/pgtable_no.h>
 #else
-- 
2.34.1


