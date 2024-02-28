Return-Path: <linux-kernel+bounces-85437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AFE86B5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CE21C238CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3115DBBA;
	Wed, 28 Feb 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWFGDJXF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07915D5DE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141176; cv=none; b=J8wsgDFtb07Vt/it3ebQ/3EO/h/EgdE7o6+I69lP5FlTqo1KhUETZ3AFAIHV/fGcnlNk6Gsf6i0yR9auZYGD8kJnC2Z/mNjwK89YPYKfT9hpjSSJL/IjgP5Rcsk9dvL3+Dr9L6IZdAOAzTy6E4Y7mXqT+ykxaMiIAXbOP9o/YLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141176; c=relaxed/simple;
	bh=s9KEvw5LismBgwzZoMZ54Q3M6nRheAXuApxY6BCD3AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeM4lSBe/ha99NaUqOAHjiQ7gQTHnghX/gsS0oSJ7kxRdgvbvWNbsQ5pbJXXGcGFWbsmRiJs6XRlOXboqzPx820lS3yIWPWIywnerhbu92rEQKK8OcRlXSBlc9RE2qIrPpBupAC5lLilYhVyJng1qWmVHQ5dLSTbtCEQ2uaRZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWFGDJXF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709141173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YgXfPN35ycGcFyeX+4qkDfjzG1MG71vQIh7801xexLs=;
	b=AWFGDJXFErCrX8GqA9bxepkviDvKaqU4T4McAq5BqsIEnAe1HJNumilP9hPN10xdDZVyEz
	f2FG85on1M1i5y/kMozIuwXgx+ca0GFljxYpGxoh1vAnF0P/yU5C5G6fZu7NqfsXGTsI0/
	EREkb+0fIq4oc4B+vVRLEe6KOnA8VuI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-g0jyi1mVM6CIheHSWRPE6g-1; Wed, 28 Feb 2024 12:26:11 -0500
X-MC-Unique: g0jyi1mVM6CIheHSWRPE6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E29183B827;
	Wed, 28 Feb 2024 17:26:06 +0000 (UTC)
Received: from p1.luc.com (unknown [10.45.225.188])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4A67401CB78;
	Wed, 28 Feb 2024 17:26:04 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: mschmidt@redhat.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] i40e: Fix firmware version comparison function
Date: Wed, 28 Feb 2024 18:26:03 +0100
Message-ID: <20240228172603.29177-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Helper i40e_is_fw_ver_eq() compares incorrectly given firmware version
as it returns true when the major version of running firmware is
greater than the given major version that is wrong and results in
failure during getting of DCB configuration where this helper is used.
Fix the check and return true only if the running FW version is exactly
equals to the given version.

Reproducer:
1. Load i40e driver
2. Check dmesg output

[root@host ~]# modprobe i40e
[root@host ~]# dmesg | grep 'i40e.*DCB'
[   74.750642] i40e 0000:02:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
[   74.759770] i40e 0000:02:00.0: DCB init failed -5, disabled
[   74.966550] i40e 0000:02:00.1: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
[   74.975683] i40e 0000:02:00.1: DCB init failed -5, disabled

Fixes: cf488e13221f ("i40e: Add other helpers to check version of running firmware and AQ API")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index af4269330581..ce1f11b8ad65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -567,8 +567,7 @@ static inline bool i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
  **/
 static inline bool i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
 {
-	return (hw->aq.fw_maj_ver > maj ||
-		(hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
+	return (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min);
 }
 
 #endif /* _I40E_PROTOTYPE_H_ */
-- 
2.43.0


