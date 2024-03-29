Return-Path: <linux-kernel+bounces-125197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEF892204
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372B6B21224
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CA812FB3B;
	Fri, 29 Mar 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivNquirn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06818C1C;
	Fri, 29 Mar 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731641; cv=none; b=IvYJzeymCUWJSQI6aRznUjXURgX9jMGJLYxsNNh1rZij3vwomkNHquYMlPquiViaSTRX+KkYn9KZfEQgfbEoMPtyvv6D8h/kEOCXmTqzR/XTadUizpNpzPQrWsR4vBOoNssJGns0fsCAkslbTxyyEvLOu6X2pbcR7LXFm/49kaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731641; c=relaxed/simple;
	bh=abtOGXDVWzqaXLinMfOXQcAoXBRnh0WQhiDxkaX9K5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmuCw89zA5PLLLgZoqGLwHLuFqwfx2RSjy/n8CYQx7J8j2pJ3nnlmlqS1AW5V7pkFx7vLkBY9I9Q5IoENaXuCbuFfCJUu6o2DojaPOBK88WXMN0qvMs3NxzOF1nsCANT/PhWgaViQb+43QhPUfeipJf5yx6IbTInNDFdDMeuUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivNquirn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731640; x=1743267640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=abtOGXDVWzqaXLinMfOXQcAoXBRnh0WQhiDxkaX9K5Y=;
  b=ivNquirnYggzHAWynZCEHE9lIMKKaGSUcKsj1DxDtC3YXrunu9Hh5tTF
   954FGOHoroQ1Mxyp9GpYDKP6EoITy1NGtEFLy8/OSn43a8Aof2kIlJo5F
   l14yG8OnkhJ2yOb/cXKmJLrzWowA42vjXl+VbQauDUfPGUGHs2SAh+NJe
   s0D0UnKzhxBad1wiS61C224CSkTOmASD+8629kMgbAhPu9BppPQh/xrs4
   4elgYV2PSohBwDYkX7gXIcv+1TJlYjO0FHZ9pm6icD1RV3apTO9Vo9Yiy
   wilhdYH+BgYoaWowG57neWvYABAy0cgvsX8fn1jA+b/hwZLBjuxVO9yeh
   Q==;
X-CSE-ConnectionGUID: Vyjb74ZzRuaqs7Zwdx1D6Q==
X-CSE-MsgGUID: t1TJXLSoQ56XQK15Go4vDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18367597"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="18367597"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48231963"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa001.fm.intel.com with ESMTP; 29 Mar 2024 10:00:36 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: fix variable shadowing spam from headers
Date: Fri, 29 Mar 2024 17:59:58 +0100
Message-ID: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=12 and/or C=1 are useful to test new code, but warnings coming from
the generic headers are noisy and distract a lot.
Fix the two most noisy networking header files by using __UNIQUE_ID()
for the variables declared inside macros. The rest seems to be clean,
except for the recent Clang's enum-conversion (which's sanity is still
under discussion).

Alexander Lobakin (2):
  net/tcp: fix -Wshadow / Sparse shadow warnings in tcp_hash_fail()
  netdev_queues: fix -Wshadow / Sparse shadow warnings throughout the
    file

 include/net/netdev_queues.h | 54 +++++++++++++++++++++++++++----------
 include/net/tcp_ao.h        |  6 ++++-
 2 files changed, 45 insertions(+), 15 deletions(-)

-- 
2.44.0


