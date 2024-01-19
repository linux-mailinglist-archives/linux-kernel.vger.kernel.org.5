Return-Path: <linux-kernel+bounces-31011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3459832789
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622701F2393E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6B3C697;
	Fri, 19 Jan 2024 10:22:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4943C47B;
	Fri, 19 Jan 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659736; cv=none; b=YSbFS3zNK1zYn07PlW27v6h8X69VWj+QlRSSHjchYYmfDtj1XJL7o2sZUqNdFJC0MBdHAUBogl4vmAAZzPnk/HixNVrceGmvPnv/+8fVArNUV3aAyeHIIO5OcmTFI/wRblcsF+CkFpAvVrE2nLlYFe0k8SaAeaN6+qtTyiKddAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659736; c=relaxed/simple;
	bh=cFTfeYTEyi2SeQ/I5MLfRnu5AR8LgWP5KCaBATw3Yds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n2Ug+j2U73kNkrBEfWI8cT1OPcxFfQDXgmE/+iJUH3xIQAyGgEp6gSztNLacXsyrTSYEFZm9jSdQiESe/5Rfpla8kFv66FSac0ZjF6ltAguko74hkGG8hvmsfLeQMY8uN5ENdpCqv85wmbUu2KcteDGsOOVRgfBlp7y3JcQissI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGbJG324MzGppL;
	Fri, 19 Jan 2024 18:21:50 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 21791180073;
	Fri, 19 Jan 2024 18:22:11 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 18:22:10 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xudingke@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>
Subject: [PATCH net 0/2] fixes for tun 
Date: Fri, 19 Jan 2024 18:21:09 +0800
Message-ID: <1705659669-26120-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500008.china.huawei.com (7.185.36.136)

There are few places on the receive path where packet receives and 
packet drops were not accounted for. This patchset fixes that issue.

Yunjian Wang (2):
  tun: fix missing dropped counter in tun_xdp_act
  tun: add missing rx stats accounting in tun_xdp_act

 drivers/net/tun.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.41.0


