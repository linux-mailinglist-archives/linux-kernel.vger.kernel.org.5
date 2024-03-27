Return-Path: <linux-kernel+bounces-121514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8367588E91A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D8323D55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4CC1422A6;
	Wed, 27 Mar 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSCY6PNK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF713A3E5;
	Wed, 27 Mar 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553094; cv=none; b=cGAuwTmIToD1ogtRihgeXCgaBNI/DMcLrL7XPV10xF6mhLJ0X8sLAMUKVu4wc9yc829Xu9sbFArxmDRney8xh5MXhKnSpdkDlYZcI+8lHnnarobOMkEYRHNF43uiptAJX32XIApnZYCleELtnva/2jiFnR1hDit2mNVbcqbPum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553094; c=relaxed/simple;
	bh=K8EtF1oz7qGa6EZGjVbDGQaJGDn7Nfv4xr++cP1EjNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb4Chvg9qJgLnDM2w+3Xl3xWh7L2eBRKq7E/CLl4yljREgScTiYU6hneM5wofn6F5OgBtMLKkaNaF7pTqW6y+KLg+sw1FQtkOj3oBDmxmwZMHQyObWzn072YwwqGAlr05oUthdazr1T3louqBu6wojlBUlKwOEIoPrXIoe5Y4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSCY6PNK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553092; x=1743089092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K8EtF1oz7qGa6EZGjVbDGQaJGDn7Nfv4xr++cP1EjNk=;
  b=MSCY6PNKTP23vGD/2hIU2hwGrxjACySyOdhvWwQSzFVQNL9UAYw0N18B
   QOOFVnfy7EEiDS3hPyTm32XhiHgbBAbmCOsP5+Hr8TJo/OkMRpgKVt9R3
   uUXfxNlJ++QQFKVEWVytmq1AOWxBnscgaaGulzQOFNje9QaSzgqFiut4h
   KsZNf8DoiuczwhkWQwjerdI9WFMF4y1cXpskWIFyknFrgC+QGpzqUUkk+
   rV/Ug4ftpp2POa5uo4gsAj4Ia2Dwl9f3LPQNQstbt1Q5dMgmsXfq5Ptsp
   coqkohaNHr1fP7NAdXUH/ShI6oI3CUY8lzqk/vgeiOYk25+bSd7XfPTa+
   A==;
X-CSE-ConnectionGUID: Gk8Xw3SnRs2lcsPEjI9KnA==
X-CSE-MsgGUID: il7CuF7dT5abml00iU9qxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518117"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518117"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414126"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:24:45 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v6 04/21] bitops: add missing prototype check
Date: Wed, 27 Mar 2024 16:23:41 +0100
Message-ID: <20240327152358.2368467-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8238b4579866 ("wait_on_bit: add an acquire memory barrier") added
a new bitop, test_bit_acquire(), with proper wrapping in order to try to
optimize it at compile-time, but missed the list of bitops used for
checking their prototypes a bit below.
The functions added have consistent prototypes, so that no more changes
are required and no functional changes take place.

Fixes: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..f7f5a783da2a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -80,6 +80,7 @@ __check_bitop_pr(__test_and_set_bit);
 __check_bitop_pr(__test_and_clear_bit);
 __check_bitop_pr(__test_and_change_bit);
 __check_bitop_pr(test_bit);
+__check_bitop_pr(test_bit_acquire);
 
 #undef __check_bitop_pr
 
-- 
2.44.0


