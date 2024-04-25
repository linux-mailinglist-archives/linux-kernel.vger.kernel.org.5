Return-Path: <linux-kernel+bounces-158829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98448B2573
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174C01C2124E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431D14BF89;
	Thu, 25 Apr 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=florommel.de header.i=@florommel.de header.b="XY7JoNks"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0712C466
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059810; cv=none; b=UM24aIf4sLbL1M5br8NmeZvpW+wItO92IHEC2blbR0mlGZ2dX+EyFKwLGdDEqalHWVQEvRjSaLgOoG427erw1+mbzo+92lZYTRQHEVV7XkCVVTQXFkOMzOuou/ZsnR7kRoMbWJb0oMu8lZbYsMQeNZpCehe0nwegfGQuVlmjKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059810; c=relaxed/simple;
	bh=xG7fDb+6M9Dl+PPdjce0c6L8V0dt39ywKTrpjxmF/cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fG0zCRXIMcDPnw1llLwF1pzSvo+xiguM2YgsDhqGQCIjtgN+9eZlCpnujGVqoEVQgsbhqdS7pyCSa7jJ1P172drzdn7+9b9StOGiXlhjsTvxstzGAijsysIkeTj+BPPUumqOwKxbAU8+I3cFL0fCsN11CEXhStgMPzU5gncfh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=fail (0-bit key) header.d=florommel.de header.i=@florommel.de header.b=XY7JoNks reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 30584 invoked by uid 990); 25 Apr 2024 15:36:36 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Thu, 25 Apr 2024 17:36:36 +0200
From: Florian Rommel <mail@florommel.de>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Florian Rommel <mail@florommel.de>
Subject: [PATCH 0/4] scripts/gdb: Fixes for $lx_current and $lx_per_cpu
Date: Thu, 25 Apr 2024 17:34:57 +0200
Message-ID: <20240425153501.749966-1-mail@florommel.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ++
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-0.092597) MIME_GOOD(-0.1) SUBJECT_HAS_CURRENCY(1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 2.307402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=xG7fDb+6M9Dl+PPdjce0c6L8V0dt39ywKTrpjxmF/cM=;
	b=XY7JoNks1kpuyB5HfDLkrosls/g+gp1P/6wl7xevkMBC0GXCTsfrjlxbRE4c3AQ4BvD+r2hCK/
	+IRpYHMRDF6CSDOzCJVi/bkf6ZACX2EJKhxTUQt1QXv7+9C/5s4OyUvO+GO65NHICi8gpckWgX9Q
	SEi5I+95Lh/86nMhtUsmz18cH4yCEDdjciCerXfBYB6mQsY6D0krCIrx0VZAQfgDW0ryYKuQGNGi
	VsGPnsHEz+Lclou6FA1TK4bR9rS6+9mUN2cDm2KXP91zUV+sl9cPesEWwc4M7bHiD00qLxAOJ3TA
	v0HkEOFIu4dfi9Oohu+1Z5IyH3i/GVCocIoGw9bfrZ1LrV8/UDjEN/ip16o3FFKEtBkcii1GcGk4
	zsyd4eWQGbAbC/y99e6dvBb+KZ4cC9six3FyZP53MYIe8y1bCn1Z3p28S01hV2FX6UkEMqOVIm1y
	jUqQOBvIp9nCulga/q2ma/knsSJ+kUeE30Ax6+zXz65IunCSfFLHxNWlw66++Of6w854acNlOvXz
	qoBpjJVyLCC3pRb7DTvHDa37pcPiaGNnjhw6pkJvFKHSufhWFoCE43JME79KGA5gjqe3SWWbZAoy
	ayRM3tN9Ry9Tu6URuv4wudyHq0upw4A5km0tI5rMhSW6RsjwyvfCfPb0apde07ZO17jxEzj5N8SA
	A=

Hi all,

This series fixes several bugs in the GDB scripts related to the
$lx_current and $lx_per_cpu functions.  The changes were tested with
GDB 10, 11, 12, 13, and 14.

Patch 1 fixes false-negative results when probing for KGDB

Patch 2 fixes the $lx_per_cpu function, which is currently non-functional
in QEMU-GDB and KGDB.

Patch 3 fixes an additional bug in $lx_per_cpu that occurs with KGDB.

Patch 4 fixes the incorrect detection of the current CPU number in KGDB,
which silently breaks $lx_per_cpu and $lx_current.

Regards,
Flo

Florian Rommel (4):
  scripts/gdb: Fix failing KGDB detection during probe
  scripts/gdb: Fix parameter handling in $lx_per_cpu
  scripts/gdb: Make get_thread_info accept pointers
  scripts/gdb: Fix detection of current CPU in KGDB

 scripts/gdb/linux/cpus.py  | 11 +++--------
 scripts/gdb/linux/tasks.py |  2 +-
 scripts/gdb/linux/utils.py |  2 +-
 3 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.44.0


