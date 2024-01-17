Return-Path: <linux-kernel+bounces-29535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B5830FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359822888C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FE286B4;
	Wed, 17 Jan 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gejYoZzV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999E225A1;
	Wed, 17 Jan 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532840; cv=none; b=kulIfYkXa96/olQEe5dOspHuDAPvywTB2wtBXxUCEytdB2LHlE28EfkcycRkS1XtUzeddE2ZWqELWKFaULSSXA3cRfAbel+c3lKqB7DscMBGteULo98tgBv76DZeypqU0W5uDyMXsvqswomZ4Z8byC5g4ginFHAO73Oj0A8SxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532840; c=relaxed/simple;
	bh=BdGkvKEcTMKO693GK951fQ0JtUasgLDl08bRJYLMwPs=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=qiDNta0fXtxxC4i8OEQQeURPU1Q33C3Leeov09w8aB8vD8vCWfiD/sn0O2t/A0fO381CJROP2j8g9XQkd31AUWXcRAo3ZzLBIYl1m+fDbRUJHw29IVpk4WyTp4c7XhYo3oTzELrouF5gcDjQBhjGUNteQLaYmRWy6h8KhHe+H9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gejYoZzV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BdGkvKEcTMKO693GK951fQ0JtUasgLDl08bRJYLMwPs=; b=gejYoZzVds4d2oITeV1/orc5p+
	9hp+43fvaV+1x/dv4f75pWDR3w0LsiTu1x3duwVPg1IhgPbEj8i4Mo95nGluRrZmQgZsfqLYi3hZK
	G4Y8acAUsNu4QmU23OlZZlzlEEjN2Qo1RlXBBjfzHCDMheb5AJzV3/zqWOyR0o3EsbIZu6BAWpyt7
	C13vedEj99AkibGGd5hE7eVzL2HUX18FlQe6EUdhoMdMHAvZ+qQscWTrAJWGDF9xoRmibiW8+tiTp
	Y74UV81diVObdGVxD5gVgo8wAV0SlgB95EY5z/A4KXQvelRIZDk1A5NQuyVEmqasbNZFLf96DEt0t
	MIh1vuMQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF09-0011su-1r;
	Wed, 17 Jan 2024 23:07:17 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 00/10] KVM: arm64: fix many kernel-doc warnings
Date: Wed, 17 Jan 2024 15:07:04 -0800
Message-ID: <20240117230714.31025-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bunch of kernel-doc warnings in arch/arm64/kvm/.

 [PATCH 01/10] KVM: arm64: debug: fix kernel-doc warnings
 [PATCH 02/10] KVM: arm64: guest: fix kernel-doc warnings
 [PATCH 03/10] KVM: arm64: hyp/aarch32: fix kernel-doc warnings
 [PATCH 04/10] KVM: arm64: vhe: fix a kernel-doc warning
 [PATCH 05/10] KVM: arm64: mmu: fix a kernel-doc warning
 [PATCH 06/10] KVM: arm64: PMU: fix kernel-doc warnings
 [PATCH 07/10] KVM: arm64: sys_regs: fix kernel-doc warnings
 [PATCH 08/10] KVM: arm64: vgic-init: fix a kernel-doc warning
 [PATCH 09/10] KVM: arm64: vgic-its: fix kernel-doc warnings
 [PATCH 10/10] KVM: arm64: vgic: fix a kernel-doc warning

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>

