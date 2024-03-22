Return-Path: <linux-kernel+bounces-112094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860668875B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2543A1F23BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190382C76;
	Fri, 22 Mar 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQA9+YsP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A2823DB;
	Fri, 22 Mar 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149646; cv=none; b=HDawZ86zS9bnxklJOducbKUEnQ/4BqwIyTzADDc5YP3b7K/OMX2vxMEGPAqE6MYQWtxbtQcwYY/ZsBeWrplFk+Wjit9i7M0yjLzpQYD2nt2rUJAeYOrMhuJXE/lxWsZi/TOhB5v4OjVteZydTLC2GpdvY0pM67uKRYohM30Y9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149646; c=relaxed/simple;
	bh=ebOkpUDlnY+ZOdsMS50jXdJSlUYtcAdWbayQmEjRjVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mU0ciSvcjDZuy+VlxqHyOok48Se6qu6Hl8IthwNLLGcb2b6F3wFf4gqtPthDvGm6VQeq/1tiJFAxSkQ4xuI84eIVdqQEHxhMsB/KqzibE/84m7FmIXA8otl0iIOvZyOuMGUBMOFOWE9Mdni966ImacfToRW/DJfIScpUcVnc3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQA9+YsP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711149645; x=1742685645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebOkpUDlnY+ZOdsMS50jXdJSlUYtcAdWbayQmEjRjVg=;
  b=fQA9+YsPV88wAPbuxd3t/EsZhuBhPI5HAu8JPJCdzH/s4CtTwk6eNefT
   EsLJD/Di4OBhJh5vYtgti4x9OzvDshLYNfre5OfxDa5K++yy4bJ1l30Se
   pn5SU1OFwzg//ltqclI/mFcPIALiZTBj3MNHlyCSwP2XGxTBWT6CaEgt8
   KnPqiTHbsX7N1W+yG4Ie6q1MBDSuCaSoxnzbvDEtG8IgjuNFUSIkwzXtV
   v35ZQjQMQlqCRZtNdj4/3+Jqwg4G2WMMqdsQfp1EXiwZRceOh/V5StiEz
   jcMsZFt8L2dQCz1B1S5Qiufcq7jkox97yhrAtwY0asyTvEUwUmRozyGxu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6408542"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6408542"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:20:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="19748979"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2024 16:20:44 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	ebiggers@kernel.org,
	ardb@kernel.org,
	x86@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v2 0/2] crypto: x86/aesni - Simplify AES key expansion code
Date: Fri, 22 Mar 2024 16:04:57 -0700
Message-Id: <20240322230459.456606-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311213232.128240-1-chang.seok.bae@intel.com>
References: <20240311213232.128240-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, V1 [1] was posted to update the aesni_set_key() prototype to
remove an unnecessary error code return type.

During the review process, it was discovered that both aes_expandkey()
and the AES-NI glue code redundantly check the key size. V2 includes a
cleanup to invoke aes_expandkey() immediately if AES-NI is unusable.

Thanks,
Chang

[1]: https://lore.kernel.org/lkml/20240311213232.128240-1-chang.seok.bae@intel.com/

Chang S. Bae (2):
  crypto: x86/aesni - Rearrange AES key size check
  crypto: x86/aesni - Update aesni_set_key() to return void

 arch/x86/crypto/aesni-intel_asm.S  |  5 ++---
 arch/x86/crypto/aesni-intel_glue.c | 24 +++++++++++-------------
 2 files changed, 13 insertions(+), 16 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.34.1


