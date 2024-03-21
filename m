Return-Path: <linux-kernel+bounces-110678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73597886250
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144B3B22B42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C7137741;
	Thu, 21 Mar 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7OfKdtl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED1136663;
	Thu, 21 Mar 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055334; cv=none; b=Rd3B06IgTV8Fi/1sRv1gldS+ErDUqMrgVA80/AGv5DVni9tIUx/z7RxN0z5lo3omflXFskEsBeg4Ayen+vNvi/6cMIXhz7Y6CP4sYcE/wNyMT1kzgDO/ADpJB+Rj1TsAqs+tbAnNul+o+i7QY4zYstry5IHxyJLiL79DmZzGQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055334; c=relaxed/simple;
	bh=T57rZfYNzAJexFYog0IuK6gMKIgQzW9AmUZDr2sR3+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xzmnp8ORZnQU7GHhg3B3EIAgjy+zDRjL0BjGw77SPuiHGHYgB0rwhGjg3lJrcN4H+8j3Sg79aHIx+IGbhj48FDJJzZdIOgFm5PSd0yuSMwtpZTE/LIFh9NcTc25zvQ6om5LIDzuPISdSpvW/Uxp0uACO6qPMbzWncuWCEdBEhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7OfKdtl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711055333; x=1742591333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T57rZfYNzAJexFYog0IuK6gMKIgQzW9AmUZDr2sR3+U=;
  b=k7OfKdtlB10Mco8QIzEMN41nbWh634vpER0uEg+rKegJ0d11xn4cE3rW
   0zpw5kwcicItbvRpEGzbpDDEwxopx173XkKVNCWK4AaQshTwrEZ8NQWBU
   y2X7Ql7W6ojcBqXP46prk77B54ewhO1c39Zab+xULftEU+23M7pUy3k6N
   K+UYzU1qZV15qb4erGe27bCoVwJ3ZEXn7k9ukWANLU5GLPltQDTMLI6Wl
   l/X2yWCSXSvc75+AyQIF+HIJc8SEKmsWeq98INybtcSx99T6K3wAlCIoJ
   zgjm5T3Ce3q+DOKyeTR8wqmomRFzSWjnvbL/483SURJ+L69FklHbfDkEP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28551488"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="28551488"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="19362676"
Received: from derragan-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.183.52])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:08:51 -0700
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: jsnitsel@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] crypto: iaa: Fix some errors in IAA documentation
Date: Thu, 21 Mar 2024 16:08:46 -0500
Message-Id: <20240321210846.1307596-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321210846.1307596-1-tom.zanussi@linux.intel.com>
References: <20240321210846.1307596-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jerry Snitselaar <jsnitsel@redhat.com>

This cleans up the following issues I ran into when trying to use the
scripts and commands in the iaa-crypto.rst document.

- Fix incorrect arguments being passed to accel-config
  config-wq.
    - Replace --device_name with --driver-name.
    - Replace --driver_name with --driver-name.
    - Replace --size with --wq-size.
    - Add missing --priority argument.
- Add missing accel-config config-engine command after the
  config-wq commands.
- Fix wq name passed to accel-config config-wq.
- Add rmmod/modprobe of iaa_crypto to script that disables,
  then enables all devices and workqueues to avoid enable-wq
  failing with -EEXIST when trying to register to compression
  algorithm.
- Fix device name in cases where iaa was used instead of iax.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../driver-api/crypto/iaa/iaa-crypto.rst      | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index de587cf9cbed..330d35df5f16 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -179,7 +179,9 @@ has the old 'iax' device naming in place) ::
 
   # configure wq1.0
 
-  accel-config config-wq --group-id=0 --mode=dedicated --type=kernel --name="iaa_crypto" --device_name="crypto" iax1/wq1.0
+  accel-config config-wq --group-id=0 --mode=dedicated --type=kernel --priority=10 --name="iaa_crypto" --driver-name="crypto" iax1/wq1.0
+
+  accel-config config-engine iax1/engine1.0 --group-id=0
 
   # enable IAA device iax1
 
@@ -536,12 +538,20 @@ The below script automatically does that::
 
   echo "End Disable IAA"
 
+  echo "Reload iaa_crypto module"
+
+  rmmod iaa_crypto
+  modprobe iaa_crypto
+
+  echo "End Reload iaa_crypto module"
+
   #
   # configure iaa wqs and devices
   #
   echo "Configure IAA"
   for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
-      accel-config config-wq --group-id=0 --mode=dedicated --size=128 --priority=10 --type=kernel --name="iaa_crypto" --driver_name="crypto" iax${i}/wq${i}
+      accel-config config-wq --group-id=0 --mode=dedicated --wq-size=128 --priority=10 --type=kernel --name="iaa_crypto" --driver-name="crypto" iax${i}/wq${i}.0
+      accel-config config-engine iax${i}/engine${i}.0 --group-id=0
   done
 
   echo "End Configure IAA"
@@ -552,10 +562,10 @@ The below script automatically does that::
   echo "Enable IAA"
 
   for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
-      echo enable iaa iaa${i}
-      accel-config enable-device iaa${i}
-      echo enable wq iaa${i}/wq${i}.0
-      accel-config enable-wq iaa${i}/wq${i}.0
+      echo enable iaa iax${i}
+      accel-config enable-device iax${i}
+      echo enable wq iax${i}/wq${i}.0
+      accel-config enable-wq iax${i}/wq${i}.0
   done
 
   echo "End Enable IAA"
-- 
2.34.1


