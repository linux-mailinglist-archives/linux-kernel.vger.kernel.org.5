Return-Path: <linux-kernel+bounces-10232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BA81D19D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C64B22A33
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48717E4;
	Sat, 23 Dec 2023 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvEWwNfd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70752837A;
	Sat, 23 Dec 2023 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300345; x=1734836345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Cam6ielx4SiTFi9eZoINF4R5A6ww9rh77PqH8LO7LY=;
  b=MvEWwNfdMDBTgN8s8ujU89w5D54sd0rs8g/+9h8OQZHikMWsFrL6t+Ze
   t4Z4ezLdZmOsRWEtbqP+jLlGE4saKDjMrJk3okORnCKZrt7mZNpdQmQxx
   AACzWfD+RQU4+PtxNFyrT2wYRsNpzWgbt4rswAgh4uxxRxpOE1Vz0dZ9D
   r1io/UicwYBhD9lqNHD1yFZxTf1uZnMLhswJwU8Py7HVAsWlf3VK+0l8d
   quV7wZ+0di3I0gPzTLFMr3BfK+zWRdI4HPTciKjea0os4HeNQcdFsJqhf
   O5B5ver9jj4jOiotDKYYr+yYHEztXlNf985sNn/rb4gl6gFp8iauUAWRN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610903"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610903"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537510"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:02 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 16/34] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
Date: Sat, 23 Dec 2023 03:55:36 +0100
Message-ID: <20231223025554.2316836-17-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, there's a need to modify a lot of static keys or modify the
same key multiple times in a loop. In that case, it seems more optimal
to lock cpu_read_lock once and then call _cpuslocked() variants.
The enable/disable functions are already exported, the refcounted
counterparts however are not. Fix that to allow modules to save some
cycles.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/jump_label.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8..f0375372b484 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -177,6 +177,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	jump_label_unlock();
 	return true;
 }
+EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
 
 bool static_key_slow_inc(struct static_key *key)
 {
@@ -304,6 +305,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	__static_key_slow_dec_cpuslocked(key);
 }
+EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
 
 void __static_key_slow_dec_deferred(struct static_key *key,
 				    struct delayed_work *work,
-- 
2.43.0


