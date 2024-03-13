Return-Path: <linux-kernel+bounces-101570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAB87A8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D616BB2239F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8814A45C0B;
	Wed, 13 Mar 2024 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2FfeE5K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C634503F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338187; cv=none; b=ZRI3jGvBl1uCkPRjPmFvXwATaaYnUAWQQBjEOQUZ6zPFN5+cQONoKz2bnunpbvD5xs6fr7v3rptyXhDBUbQPwlZdfNPPlGPfypJb8Hi+PUCJYfBtNiabM8fhWZmpa2xdmT05mDQuoApnFqtxXP/QIwwwXNmecBju6uRJdTJ+068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338187; c=relaxed/simple;
	bh=PwEPuxMUo5/sKc+Junep3vDKZCEW5PDExzGK+M8LuGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTrbzwFU9htO9Roro49ieYyZ6uuK0zqF6s7wBOEw11OtgNBQtLPS7K1kFJk+5D/VBzHNGZ19rXQQXUURiEcT/t29yTRDnr9JBMdTRiwOmNwYwoJINCztgAAJ17pLM4/BSkQT5TL/rs8/FiUM6G2sU8bDCJK/d5ijH3C6EkgZ8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2FfeE5K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710338185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YY7GeN9xZf21MLc2UbS3lntZ4saklnuJyBZ7lW6jh1c=;
	b=X2FfeE5Ko/j005qKDFwex36r6cqcVjrACJGSz/ciz30kYtXGJvRb3sHJ2+d04ktDLLAkMn
	dQctE3/IpdI2bry8EqxbeofW2bI1BEiNO62Xb/6AKrSc5TuUmZx+jEIuYZfu9aH8vDTpt6
	SXUonsFnpgZElYBgDULjySbzaMiLJLw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-VcupKPbuOvKv81gJxYr70g-1; Wed, 13 Mar 2024 09:56:21 -0400
X-MC-Unique: VcupKPbuOvKv81gJxYr70g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C65B01875701;
	Wed, 13 Mar 2024 13:56:20 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECA6517A93;
	Wed, 13 Mar 2024 13:56:18 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: aleksandr.loktionov@intel.com,
	mschmidt@redhat.com,
	horms@kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] i40e: Fix VF MAC filter removal
Date: Wed, 13 Mar 2024 14:56:17 +0100
Message-ID: <20240313135618.20930-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Commit 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove
administratively set MAC") fixed an issue where untrusted VF was
allowed to remove its own MAC address although this was assigned
administratively from PF. Unfortunately the introduced check
is wrong because it causes that MAC filters for other MAC addresses
including multi-cast ones are not removed.

<snip>
	if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
	    i40e_can_vf_change_mac(vf))
		was_unimac_deleted = true;
	else
		continue;

	if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
	...
</snip>

The else path with `continue` effectively skips any MAC filter
removal except one for primary MAC addr when VF is allowed to do so.
Fix the check condition so the `continue` is only done for primary
MAC address.

Fixes: 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove administratively set MAC")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b34c71770887..10267a300770 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3143,11 +3143,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 		/* Allow to delete VF primary MAC only if it was not set
 		 * administratively by PF or if VF is trusted.
 		 */
-		if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
-		    i40e_can_vf_change_mac(vf))
-			was_unimac_deleted = true;
-		else
-			continue;
+		if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
+			if (i40e_can_vf_change_mac(vf))
+				was_unimac_deleted = true;
+			else
+				continue;
+		}
 
 		if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
 			ret = -EINVAL;
-- 
2.43.0


