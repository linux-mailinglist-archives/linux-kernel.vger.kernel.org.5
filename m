Return-Path: <linux-kernel+bounces-119487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7CA88C995
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9E1C32AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1EE18EB0;
	Tue, 26 Mar 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTAbXAa2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7F611E;
	Tue, 26 Mar 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471320; cv=none; b=OIhfrd1lLlYZJFtDHMyOBCTWNtBj6OhcjUqNjrv5wlCkEdW8gO/Fw2xAzYqpoFadZSwVbzUgKYm4V7nJYtTTIR76Ni1E2/WRvNm08xD2elYod9dq33uibqrCGVrGGRCbpH86kpBolnjbHKAyaj+lcfATw0weZ20zdS22uxJeT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471320; c=relaxed/simple;
	bh=D/32WRfGg/BAJYBjvPV5D+qdqDFfYpgQ3mlM4TaI5OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMligWhVpJwWcZozInuR4p1K/GxkfsaON0uOpUmsJd21DxvgnDZ5yMdHoGKwG6ZN/AEop/mZOwqMLQ+5mhj6FyOsl2bcyrql6acatZwF/V+Ow2lygqrBDicU/+ogKMCpMkj4a9FBLCGVUwF9+4TTgOPIV0bEHEq4XCAtucnHShU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTAbXAa2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471318; x=1743007318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/32WRfGg/BAJYBjvPV5D+qdqDFfYpgQ3mlM4TaI5OE=;
  b=aTAbXAa2KH0syNVGod3rPltLHpGizAROkRTytaMSxT7yOZKvhckYz1GX
   i399kej3pXUl3rMWH79hPZR7uFwFSl7Ew+7lcEg2SitHMy2n+Ps5Tmbvc
   RF/CcPMm8aOp/bdAXLPOkzlKABl5goGfEFQxHVB1PYo7vlj1p8ibfO2AN
   enddrveICCqWKrvLLpgqt1voL5MDOr8k/HV+Im+z2jUIwGMMZS3Dw49I8
   plvj65XCiFIntTitjYhZwqiVQq0tgadGUdRO7P2H3WwIly5mPQnTFNSyv
   buBzkUU2zubh1G6MaCjpuwrJh9a+n3gD7sgeLT0DFnhNRSSnmmAnDMLYl
   A==;
X-CSE-ConnectionGUID: Rrjav80lQLS5usgmCy0MEA==
X-CSE-MsgGUID: FbqWCRa+RoGe1SicFW6kAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24023281"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="24023281"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20667384"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 26 Mar 2024 09:41:42 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] compiler_types: add Endianness-dependent __counted_by_{le,be}
Date: Tue, 26 Mar 2024 17:41:13 +0100
Message-ID: <20240326164116.645718-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some structures contain flexible arrays at the end and the counter for
them, but the counter has explicit Endianness and thus __counted_by()
can't be used directly.

To increase test coverage for potential problems without breaking
anything, introduce __counted_by_{le,be} defined depending on platform's
Endianness to either __counted_by() when applicable or noop otherwise.
The first user will be virtchnl2.h from idpf just as example with 9 flex
structures having Little Endian counters.

Maybe it would be a good idea to introduce such attributes on compiler
level if possible, but for now let's stop on what we have.

Alexander Lobakin (3):
  compiler_types: add Endianness-dependent __counted_by_{le,be}
  idpf: make virtchnl2.h self-contained
  idpf: sprinkle __counted_by{,_le}() in the virtchnl2 header

 Documentation/conf.py                       |  2 ++
 scripts/kernel-doc                          |  1 +
 include/linux/compiler_types.h              | 11 ++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 24 ++++++++++-----------
 4 files changed, 26 insertions(+), 12 deletions(-)

---
From RFC[0]:

* teach kdoc new attributes (Simon, Kees);
* add Acked-by (Kees);
* fix a couple typos;
* send to net-next (Kees).

[0] https://lore.kernel.org/netdev/20240318130354.2713265-1-aleksander.lobakin@intel.com
-- 
2.44.0


