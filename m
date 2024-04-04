Return-Path: <linux-kernel+bounces-132158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4289905F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ACFCB29541
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE2F13C69D;
	Thu,  4 Apr 2024 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kKPC3kzL"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A113C68B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266072; cv=none; b=ScXL6j/ZTKwGElFko4imERODyanrOZ4i7Hpg8Gmg+Ux0CEybD/7m45xDHv7ZDZbLkizJ0uqM0wzw6Q5zAypretf2TfVzWXUU+zDQNfLvsUqhpzp0+vt6/pp5pARcoHjmXt8sB8RM4mqhj8oVqfNiDpDd4LiEE3r8JMNDnPNL5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266072; c=relaxed/simple;
	bh=i+qYSe82dk6E1DEDEYjK9f3oiyy6F6UrVwE4dTrUjFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHpTzQNgR4RJcyJEurv6YcVMYtLUvj1FGVNpTNnIpBrLVIGplNY7cc+34nE++jdbM9knT+Qmbs9hPPWsQ7iWnG3O4RKBToM6Ao00PnX6W6vLUq6Elz01gxEkvwcx6uuzzN/Qh4mBYipL/Gw0OncmFQjIQ4tWmWcY4GKp8KZ7TAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kKPC3kzL; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712266071; x=1743802071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vXMyRUMmIDSRpvnnN6Ds8+s/LCFeDKLvTc9elA3zE8M=;
  b=kKPC3kzLgpxKq2pBE5X7cdrcBz+ZK1T4PB8DLn39PtP5fszzTns8um+C
   IROnM6O/rNoM7XqdixIdfcrPZHkjD/vKLaUL71g0wh3ENWeuNHvi4Rl/t
   yngVf789E9hBrTu9lm+zSysneWfqhj+3ny40AfGw21KR5Fbxgc7/AtJBe
   g=;
X-IronPort-AV: E=Sophos;i="6.07,180,1708387200"; 
   d="scan'208";a="392718183"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 21:27:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:38359]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.69:2525] with esmtp (Farcaster)
 id 9ce1e057-8baf-481b-b517-faf690d2bbe9; Thu, 4 Apr 2024 21:27:48 +0000 (UTC)
X-Farcaster-Flow-ID: 9ce1e057-8baf-481b-b517-faf690d2bbe9
Received: from EX19D002UWA003.ant.amazon.com (10.13.138.235) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 21:27:48 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D002UWA003.ant.amazon.com (10.13.138.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 21:27:47 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.28 via Frontend Transport; Thu, 4 Apr 2024 21:27:47
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
	id 8F20F235D; Thu,  4 Apr 2024 21:27:47 +0000 (UTC)
From: Ali Saidi <alisaidi@amazon.com>
To: <kjlx@templeofstupid.com>
CC: <alisaidi@amazon.com>, <catalin.marinas@arm.com>, <james.morse@arm.com>,
	<kvmarm@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <maz@kernel.org>, <me@davidreaver.com>,
	<oliver.upton@linux.dev>, <suzuki.poulose@arm.com>, <will@kernel.org>,
	<yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm64: Limit stage2_apply_range() batch size to smallest block
Date: Thu, 4 Apr 2024 21:27:42 +0000
Message-ID: <20240404212742.11248-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404044028.GA1976@templeofstupid.com>
References: <20240404044028.GA1976@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

I measured the time it takes to unmap a VM by changing the kvm_page_table_test
to report it. It's and on Graviton3 it's about 300ms per 1GB of flushing
with 4KB pages. Unmapping 128GB takes around 39.5s and with a single call to
__kvm_tlb_flush_vmid() instead of the 32M calls to __kvm_tlb_flush_vmid_ipa()
reduces this to around 5.9s (~7x). This means each iteration of the
stage2_apply_range() is reduced to 46ms. So we're certainly calling
cond_resched() a whole lot more. 


> Just a quick followup that I did test Will's patches and didn't find
> that it changed the performance of the workload that I'd been testing.
> IOW, I wasn't able to discern a network performance difference between
> the baseline and those changes.

That is a bit unexpected that the performance wasn't worse with the patch Will
sent because it should have disabled the range invalidates since they these 
invalidates will be getting rid of blocks?  Which Graviton were you testing
this on? 

Ali


