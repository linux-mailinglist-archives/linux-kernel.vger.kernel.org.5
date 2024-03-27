Return-Path: <linux-kernel+bounces-121515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA388E91D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84D51F2296F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B1143C7E;
	Wed, 27 Mar 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnV9W+JM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382613A863;
	Wed, 27 Mar 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553095; cv=none; b=qjgevTpWN5oM8d8KCfCzVrZr2jE6trdQgZyA24ah4yMd3huqx7wKdy6foSV7qSQj/fcCIzwmn0ygh5trhNXMZqdv+sADRWhS3xxHSeTBJBU2A9zLdD5iGkpdC9LhQ69cX6j+PWvgLgv1hJxEo0visnSIst27HeGzdO3SDWgQjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553095; c=relaxed/simple;
	bh=OA1Ptf4IMx7vsr5cedXMrz/h7QDUB7xfD+abDh4DUJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwxzcU96zJ1nOhabsqiZZriNtzZ/jrCZn+I3e0iftgdG2ykDjDCHh2xofnWU2dwQhkyHKlwpRTTph2n7+5AdalTVbarqhVIV16iM7Ixzb15iumwxJZI4Onm0le6EVTkxoOOiB5rj0Nu7C1PCikFzfQUp/qJbHgPepvNVYWm+0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnV9W+JM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553093; x=1743089093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OA1Ptf4IMx7vsr5cedXMrz/h7QDUB7xfD+abDh4DUJg=;
  b=bnV9W+JMdzYhqZ/pWfU+6YHHYfVFlveU2rBLp5QyfixuMU5WBCu29vaD
   PBK4IEB+n35Jek0HeTimYi038l5D4P+LHcIyG+rP8lhYr/Fsy/iHzvUY7
   u9pD6p1SD+0kcaVWVsFNcW4Z0IN7KNhwAf8IcVs8n2VejOkGoQhS+M8Am
   Dp7FC2JW1imianVFgCUFcgPPGDDY9V4rHiiBvnTA6WfV5oLNaZ1DJB2Fs
   ZhrCWKT1HFYZfqL6GWZlagZZC2ZSTBzMf5gUtTg5a2jadhCJ8kG/ICK7x
   pk/PR1snr9WNV4yR7o8VNrvibkhT9bjIjhCfngVhadad4JJhe5PKNIWxJ
   Q==;
X-CSE-ConnectionGUID: mVyFc9kFQXqe+88j5jnJSQ==
X-CSE-MsgGUID: AucZ80KJTRe3QJdjcP2xUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518132"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518132"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414150"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:24:48 -0700
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v6 05/21] bitops: make BYTES_TO_BITS() treewide-available
Date: Wed, 27 Mar 2024 16:23:42 +0100
Message-ID: <20240327152358.2368467-6-aleksander.lobakin@intel.com>
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

Avoid open-coding that simple expression each time by moving
BYTES_TO_BITS() from the probes code to <linux/bitops.h> to export
it to the rest of the kernel.
Simplify the macro while at it. `BITS_PER_LONG / sizeof(long)` always
equals to %BITS_PER_BYTE, regardless of the target architecture.
Do the same for the tools ecosystem as well (incl. its version of
bitops.h). The previous implementation had its implicit type of long,
while the new one is int, so adjust the format literal accordingly in
the perf code.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitops.h         | 2 ++
 tools/include/linux/bitops.h   | 2 ++
 kernel/trace/trace_probe.c     | 2 --
 tools/perf/util/probe-finder.c | 4 +---
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index f7f5a783da2a..e0cd09eb91cd 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -21,6 +21,8 @@
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
+#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 7319f6ced108..272f15d0e434 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -20,6 +20,8 @@
 #define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
 #define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
+#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 217169de0920..cd5cab0be1f3 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1180,8 +1180,6 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 	return ret;
 }
 
-#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
-
 /* Bitfield type needs to be parsed into a fetch function */
 static int __parse_bitfield_probe_arg(const char *bf,
 				      const struct fetch_type *t,
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c8923375e30d..630e16c54ed5 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -186,8 +186,6 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	return ret2;
 }
 
-#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_LONG / sizeof(long))
-
 static int convert_variable_type(Dwarf_Die *vr_die,
 				 struct probe_trace_arg *tvar,
 				 const char *cast, bool user_access)
@@ -217,7 +215,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 		total = dwarf_bytesize(vr_die);
 		if (boffs < 0 || total < 0)
 			return -ENOENT;
-		ret = snprintf(buf, 16, "b%d@%d/%zd", bsize, boffs,
+		ret = snprintf(buf, 16, "b%d@%d/%d", bsize, boffs,
 				BYTES_TO_BITS(total));
 		goto formatted;
 	}
-- 
2.44.0


