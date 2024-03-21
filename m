Return-Path: <linux-kernel+bounces-110677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56288624E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A56A1F22020
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED3136988;
	Thu, 21 Mar 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJK5qdcN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC472135A72;
	Thu, 21 Mar 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055333; cv=none; b=pyK1EB5H8saxS3XUBFqT97VofWKaNhIXqWsJilqqQJSYR7s5GkgsdDdGNRrMYhzdFuCwWF5YBIZdYThSZfI5tCbSGYFPo49ugPdFshq4kmoemNeXokyKQ1SMy4vNHiPGQBjWRBLWTaeiCsbdx934DSqt65Zb5c84CMkuXctg1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055333; c=relaxed/simple;
	bh=TeJGj1/tK9CmXzP6fD4kuH3rPg5TtofR/Xu7iirtjCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mBj53jROMJNakzM0g9JzhjOetGVmoAkO7O8theMpZZ5aVS9e/DytHHEVQ+AUP/fwtK9yUJ7HvD/qMkIgnJRVXAA+H0TVig/Vvbk9VvMgvCdSsLq07HaqSnpMEquazIN/jV9KMPRrIV7JNkN1PbpdZjnNYOJT9ns8XqrTet0bmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJK5qdcN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711055330; x=1742591330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TeJGj1/tK9CmXzP6fD4kuH3rPg5TtofR/Xu7iirtjCM=;
  b=fJK5qdcNnuCXkgIVYmKJIzhd5Ozt3eQhd+LQtrhpTJxABI1GXi7IceGy
   Y+cFuOW/FJo/+4WRnMHh99gCnFe2gC3cICrHsVcRS9U9x5M0v2zDNIeTn
   5XbgVvt9rznhu2dK/n9EU+wJ+ItYVesXIC08PeL4KzrNc6X6fVOK52D1E
   JflKouytRPqgUJNakPWcRIoHZ07h90X9jSpU1+DbR923iupD+OXkNTwiR
   2NLLABnVxBhSvQa5z9Y8suBrIBWzBDkwdwwTZJDdZiBIXY6lPU9i9LS8U
   nXPjHDJShlZZxqffxmd28sgc/7NDzZFgc+GE++10ovF4s4vmbHNgJ63dk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28551474"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="28551474"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="19362672"
Received: from derragan-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.183.52])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:08:48 -0700
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: jsnitsel@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] crypto: iaa - A couple of bugfixes
Date: Thu, 21 Mar 2024 16:08:44 -0500
Message-Id: <20240321210846.1307596-1-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Herbert,

Here are a couple of bugfixes to iaa_crypto.

The first is a documentation fix from Jerry Snitselaar, which I added
my Reviewed-by: to.

The second is a fix for a divide-by-0 bug when running with a single
cpu, which was reported by Jerry as well, and which I've tested with
various numbers of cpus and other permutations with no problems.

Thanks to Jerry for the patch and bug report.

Thanks,

Tom

Jerry Snitselaar (1):
  crypto: iaa: Fix some errors in IAA documentation

Tom Zanussi (1):
  crypto: iaa - Fix nr_cpus < nr_iaa case

 .../driver-api/crypto/iaa/iaa-crypto.rst      | 22 ++++++++++++++-----
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 10 ++++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.34.1


