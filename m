Return-Path: <linux-kernel+bounces-132393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031A8993FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD8D1F28F41
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035181BC40;
	Fri,  5 Apr 2024 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUNFV42Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE40E546
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712289566; cv=none; b=ed/PK4Hao5K++MOxD1372nePxfXCmUfhNh4qDX9BzLMXdOB7JG2s26gEB62Gme/mkok1VRNVmI/5d/DU2niPBqJh2b4ICg08M10J6bY1TgP0VnoqdcFrTZkWqQP46krLTmhBg2PKysK2EHDAtPBHFb9sIsl3uIsZ5Lyi7OnjgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712289566; c=relaxed/simple;
	bh=giU40Ob5II2VjX8bWTB54VarAI+Jr9Lbwcl/O6Ry+RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icYnAKg+mF0lbR13IiP05cMewLt4oYTscfFDp1QsjEmDMumQ0AMilvx87xDTms7fXIf3sD14hvev0VgYo+OsFqvE0ejEMX0AmTNb5Qvav8GAsFVu0F8YuaH0yzsufafKtW4QBdFKGbgTIFP72R3QUPQ195OuM0CDNwCIAJI2TM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUNFV42Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712289562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F7yPh3QTB7FkxbLm1lXDMlRiRFk5C+eT+UIW9LjRtUA=;
	b=iUNFV42YqYhIvWGhz4QeeXyICbNszEzZe7UBE/4IO5vm5clwUop0+pJRG91c+TDqObfabZ
	GRN8ReVU5J/dIAKgBcJmyOH/zy7jf39BwgKf6mLNWRTwvPboSl9SgNkiZk2jW5eEsyQriH
	5ApK5P4BYCQKL+8jy5WyTWoKm9Cr97Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-NG0_X88hN1-f1iSmt59s5Q-1; Thu,
 04 Apr 2024 23:59:16 -0400
X-MC-Unique: NG0_X88hN1-f1iSmt59s5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A16B2815E28;
	Fri,  5 Apr 2024 03:59:16 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FE661074E;
	Fri,  5 Apr 2024 03:59:10 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	gshan@redhat.com,
	akpm@linux-foundation.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	ryan.roberts@arm.com,
	apopple@nvidia.com,
	rananta@google.com,
	mark.rutland@arm.com,
	v-songbaohua@oppo.com,
	yangyicong@hisilicon.com,
	shahuang@redhat.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v3 0/3] arm64: tlb: Fix TLBI RANGE operand
Date: Fri,  5 Apr 2024 13:58:49 +1000
Message-ID: <20240405035852.1532010-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

A kernel crash on the destination VM after the live migration was
reported by Yihuang Yu. The issue is only reproducible on NVidia's
grace-hopper where TLBI RANGE feature is available. The kernel crash
is caused by incomplete TLB flush and missed dirty page. For the
root cause and analysis, please refer to PATCH[v3 1/3]'s commit log.

Thanks to Marc Zyngier who proposed all the code changes.

PATCH[1] fixes the kernel crash by extending __TLBI_RANGE_NUM() so that
         the TLBI RANGE on the area with MAX_TLBI_RANGE_PAGES pages can
         be supported
PATCH[2] improves __TLBI_VADDR_RANGE() with masks and FIELD_PREP()
PATCH[3] allows TLBI RANGE operation on the area with MAX_TLBI_RANGE_PAGES
         pages in __flush_tlb_range_nosync()

v2: https://lists.infradead.org/pipermail/linux-arm-kernel/2024-April/917432.html
v1: https://lists.infradead.org/pipermail/linux-arm-kernel/2024-April/916972.html

Changelog
=========
v3:
  Improve __TLBI_RANGE_NUM() and its comments. Added patches
  to improve __TLBI_VADDR_RANGE() and __flush_tlb_range_nosync() (Marc) 
v2:
  Improve __TLBI_RANGE_NUM()                                     (Marc)

Gavin Shan (3):
  arm64: tlb: Fix TLBI RANGE operand
  arm64: tlb: Improve __TLBI_VADDR_RANGE()
  arm64: tlb: Allow range operation for MAX_TLBI_RANGE_PAGES

 arch/arm64/include/asm/tlbflush.h | 53 ++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 22 deletions(-)

-- 
2.44.0


