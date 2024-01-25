Return-Path: <linux-kernel+bounces-39431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7B83D109
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863EEB2681A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FAB1B804;
	Thu, 25 Jan 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZE7fGnf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3B1A731;
	Thu, 25 Jan 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227059; cv=none; b=Suijg7OzZVS0+loNCeS5bmBKi/ShYpeeLEpH5KuZnP+dCFj+oUPTq7wAqQmVm1rKnV5WnO2nbBi+VN3OMVNsVTpZvnHPtVYzNmGhCtftoMi6dqRPn/kRCDifNrg4X/K76gye6MBNm0Cq1mk6kYvYiLG9Ckvzh8waLsLQXht6dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227059; c=relaxed/simple;
	bh=+5d3tyhMXlyo3iELNdYQuZU7PNVS/IBrZgPRKsrWJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGxeXw3uG8JgV8TRLfS3zR8D1DiN3HlJ44vI+qCBC1URzKB6fD9kodJ/hMHJYcv7mC5ztlREhZvRRn61G0ZrCqAncqD1acrA/B/N8AAPzxAGf8yZqmD56k3uT4wpPXy6AhUeMd/QvM23rUge2BJRiR+BrLQYMXiqqFzk/VAPcK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZE7fGnf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227058; x=1737763058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5d3tyhMXlyo3iELNdYQuZU7PNVS/IBrZgPRKsrWJ48=;
  b=EZE7fGnfsoNgF9k6Pv/XgFpvgpV9i6DSLRmSXv4CtHsn0EjKXQYxq6s1
   23ADwsV2lr+U1Od9FRlVkUf51x0K+FHbAGyhwszksS6Q6LozfXmJTarXD
   fOB++HmGNoCd22AlzElgEQVbTiYFApn6xw717FbwPItlovWn/HrL78pEQ
   5a4/VxjwEJ9o9YQH4kEUE4+VrffsGBhl1EdDOXfRiYScUWvLdgZmDTd3y
   W3aGdTfJo99dm8YHjXKKvtTxhUgjNEG5UCm1f4HfWcfQtv6FdEbEb286/
   kTjAN7k4p4Fim8XI6ieAtv5Mbrq9vwE77l7Lng4t3R8xAk9bHxIGOtOXF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15867567"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15867567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930191101"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930191101"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:35 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [RFC v2 2/4] cred: Add a light version of override/revert_creds()
Date: Thu, 25 Jan 2024 15:57:21 -0800
Message-ID: <20240125235723.39507-3-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125235723.39507-1-vinicius.gomes@intel.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a light version of override/revert_creds(), this should only be
used when the credentials in question will outlive the critical
section and the critical section doesn't change the ->usage of the
credentials.

To make their usage less error prone, introduce cleanup guards asto be
used like this:

     guard(cred)(credentials_to_override_and_restore);

or this:

     scoped_guard(cred, credentials_to_override_and_restore) {
             /* with credentials overridden */
     }

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/cred.h | 21 +++++++++++++++++++++
 kernel/cred.c        |  6 +++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..e9f2237e4bf8 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -172,6 +172,27 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 					  cred->cap_inheritable));
 }
 
+/*
+ * Override creds without bumping reference count. Caller must ensure
+ * reference remains valid or has taken reference. Almost always not the
+ * interface you want. Use override_creds()/revert_creds() instead.
+ */
+static inline const struct cred *override_creds_light(const struct cred *override_cred)
+{
+	const struct cred *old = current->cred;
+
+	rcu_assign_pointer(current->cred, override_cred);
+	return old;
+}
+
+static inline void revert_creds_light(const struct cred *revert_cred)
+{
+	rcu_assign_pointer(current->cred, revert_cred);
+}
+
+DEFINE_GUARD(cred, const struct cred *, _T = override_creds_light(_T),
+	     revert_creds_light(_T));
+
 /**
  * get_new_cred_many - Get references on a new set of credentials
  * @cred: The new credentials to reference
diff --git a/kernel/cred.c b/kernel/cred.c
index c033a201c808..f95f71e3ac1d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -485,7 +485,7 @@ EXPORT_SYMBOL(abort_creds);
  */
 const struct cred *override_creds(const struct cred *new)
 {
-	const struct cred *old = current->cred;
+	const struct cred *old;
 
 	kdebug("override_creds(%p{%ld})", new,
 	       atomic_long_read(&new->usage));
@@ -499,7 +499,7 @@ const struct cred *override_creds(const struct cred *new)
 	 * visible to other threads under RCU.
 	 */
 	get_new_cred((struct cred *)new);
-	rcu_assign_pointer(current->cred, new);
+	old = override_creds_light(new);
 
 	kdebug("override_creds() = %p{%ld}", old,
 	       atomic_long_read(&old->usage));
@@ -521,7 +521,7 @@ void revert_creds(const struct cred *old)
 	kdebug("revert_creds(%p{%ld})", old,
 	       atomic_long_read(&old->usage));
 
-	rcu_assign_pointer(current->cred, old);
+	revert_creds_light(old);
 	put_cred(override);
 }
 EXPORT_SYMBOL(revert_creds);
-- 
2.43.0


