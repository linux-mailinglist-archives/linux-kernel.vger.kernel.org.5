Return-Path: <linux-kernel+bounces-106138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D832387E9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6842A2810B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567638DCC;
	Mon, 18 Mar 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFVwYSq+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD537711;
	Mon, 18 Mar 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767056; cv=none; b=kR1568kmfgMFmmnCma+c42nYcT0TF4DkSTCdy7l9NZ01+KAf7PzJJvPl35grcZch5Am8CnZCLwsrAieqtEWWdd1naHrJnAgGmId/BX/qK0bGE56SQIMSL4VC/0sVkC/NWsbAup41pxHc0k43aEV58/38jTb6pd+gLlu2mOGO7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767056; c=relaxed/simple;
	bh=CYdWZsOzq1pnl9m/WNdRLA7plSjBlkbbLINFudwQ8gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iP2O6rCjATCcR/A28PFFVcMGILxdigxOhqz4A6fxqAIso7RqVNmRFx9BO6ax7Wei1oSlnYGQG9SpG2G0+1qXV1y6wPnmw5sKOZp9jvgY5wHK0g/0XSi8cQhSdtXUTTlP8qNNT5dbWsED+bknGTiuQUidue2LPAfgju3Tte3g8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFVwYSq+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710767054; x=1742303054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CYdWZsOzq1pnl9m/WNdRLA7plSjBlkbbLINFudwQ8gA=;
  b=MFVwYSq+NEL5KfkIr14tQutnzR59AXXdMdD4fAUojjqzuMUOFiyBk+fn
   MfDrC0SC51ycLQKfGbA+GP9c+linI93gZjWhS4crrFNsL5DV46gM+QZ0u
   tNaELut0MRZqwvfmayno+KE2FpSXLtnU9MgJqWCDnDGz7NEGhFsIofSXF
   +z/O6XM5fLV4FiM8VFWW1qtYzMFaSRFwdp6kZUk5BJN/KZovsFSrKYzhC
   FXBhPCGhuF6yTgzomHb9dSfbxUhu1/ZWId1Y5Y9m0pd//Zk0kGoiK4udC
   IdLa9TKYXGDovWlg61w10kpeV1VZZ6k8vODfOqyxdrJGILazgEp4Nvmd+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5707133"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5707133"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="44392842"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 18 Mar 2024 06:04:11 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: linux-hardening@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC kspp-next 0/3] compiler_types: add Endianness-dependent __counted_by_{le,be}
Date: Mon, 18 Mar 2024 14:03:51 +0100
Message-ID: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
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

 include/linux/compiler_types.h              | 11 ++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 24 ++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.44.0


