Return-Path: <linux-kernel+bounces-142203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5278A28D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960C328AD85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DBD502AB;
	Fri, 12 Apr 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jNllclIB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9474DA05;
	Fri, 12 Apr 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909060; cv=none; b=OkFksQZeYAXHjVMjFfavYJy+FdL3yHw0X6bvGj6BIFXu10a78/fpVRMsVuu7pqE74sAnnlAG9sERs/JTjRKU8p8ldyJ7Vj1r/J22dFRE533OPpuF80m0H6EXu/7fZp0dZIUkFyhPuzv///3W02pYh6sCnc7rapdSx/HxRb7gujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909060; c=relaxed/simple;
	bh=nIWUop786WwaUkA148r4Yi041jVffY1R6AdbkbVokME=;
	h=Message-Id:From:Date:Subject:To:Cc; b=XeWc5cNXBDB+G3uIc6MuHXASCSqJn4hCrAyjhjZwhj0XJ8fBg4ZmOvtSgurmn2ikcqUL23tJaShtGrxBv1LsIxPbn1sydob1P9DvdBz19LKcVnUQWgPEBU7MW/P7dbK2BBtkP2HRsSLy7VBvCrChvrcIGDQizy+k9vCV7cXNyEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jNllclIB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Cc:To:Subject:Date:From:
	Message-Id:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TZIYJ0iaQArFGrOLPYJ4tsogyNaAuf4eWxh/L+DfOaM=; b=jNllclIBnCKaxYK+mZCnEaw538
	iAGBBmHhPQQFW4Ol9+hljzCnpT9QFfIfKTmmBNLelu2iVFVSYk9Oz5jFyMVEnV0ZoFlPvDcqTpMjh
	HPj6Dfg35HLiXg9z0NWz9M0xm2dOjdpIcyHR/b32nNCimBC4Ka66AOQBROOWMGO7GMviJAES+sXsd
	PsRpRavdumDfk0W9sbi+KyBG/X8M/Mmp5Q3uS/NazvfXKqkWfOjIuE6Kh6OHpe5hRwAEgB7EyviyP
	KcF9gDqHIB0KTcWm7UhP+I+vbXj4H/XFljhgkUu24mYt9fpdCfzR+uysYUNcF7Si/8gS5uqEm9GB5
	Oxv5R91A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBtG-0000000926G-2suv;
	Fri, 12 Apr 2024 08:04:09 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBtG-00000009KSr-0Gxd;
	Fri, 12 Apr 2024 09:04:06 +0100
Message-Id: <20240412073530.2222496-1-dwmw2@infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 11 Mar 2024 12:19:14 +0000
Subject: [PATCH v2 0/2] Support clean reboot after hibernate on Arm64
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the hardware signature in the ACPI FACS changes, the OS is supposed
to perform a clean reboot instead of attempting to resume on a changed
platform.

Although these patches have a functional dependency, they could be merged
separately. The second patch just won't *see* a FACS table if the ACPICA
fix isn't present.

v2: Now that the ACPICA patch is merged upstream, note its commit ID

David Woodhouse (2):
      ACPICA: Detect FACS even for hardware reduced platforms
      arm64: acpi: Honour firmware_signature field of FACS, if it exists

 arch/arm64/kernel/acpi.c      | 10 ++++++++++
 drivers/acpi/acpica/tbfadt.c  | 30 +++++++++++++-----------------
 drivers/acpi/acpica/tbutils.c |  7 +------
 3 files changed, 24 insertions(+), 23 deletions(-)

