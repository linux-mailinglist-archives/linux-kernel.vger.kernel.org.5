Return-Path: <linux-kernel+bounces-147048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E538A6EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0DBB21E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D75130A47;
	Tue, 16 Apr 2024 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Kv5w/pgW"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5112E1F0;
	Tue, 16 Apr 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278654; cv=none; b=J7CV5vJfnci7ZSoM+3Zp0oDvAtOjIoAUM6qAw5SPOBOg5ggtnpCCggkBtA+tbApJy76SdAePr37+GF2Q6HWbxjQRa833f7nA4DnqNX+cjXnsn6vVzv9CDXb2mnMFAHZX4OVAzxBTyqw+wrSL2LVo+uMc9kAGSa79z5aGCyInNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278654; c=relaxed/simple;
	bh=S0cQ7yy/rMu5HoKW7QjhMOhVSEsLJ1FSOL4fQV1pzxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aud2nZqv7eKiG8dXa5lg7dKAgwd/RWEmSW+GGLLSx23Hu+yNJoEkkVD85fKp1e1i983I+38BcJs8C6oUF0n2cPbsqOVLTjC1p1A7PKJLCy/gIe5cuIo1Fb5Ap73sNmDva7+fkwbJejmoPFD3JlpbigdKIpt5EMNcuIEVvQRQ78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Kv5w/pgW; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7784A600A7;
	Tue, 16 Apr 2024 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713278649;
	bh=S0cQ7yy/rMu5HoKW7QjhMOhVSEsLJ1FSOL4fQV1pzxo=;
	h=From:To:Cc:Subject:Date:From;
	b=Kv5w/pgWOCU8njSkEtNSiP3cjfdDInrYbOd0HEvl15KJubDJTXyUiQA3aiNckdPCX
	 GKRKtN8jCmlRjR6PgDf6x/mg1ARpj6NvVewWLj86+azOfWGm59j/p7yofTdUUwwhwD
	 4cHmDoM0RZKndaRqm6E+ty9NlNvWytN9SJoKRNQ3RhuNgycEcI9pY9EuMjLtqrydjJ
	 Bn6w2hV+oME2Qm2K2kRb6BkYqFptncsjVjDgB3b2SwXi3RuCw5qHKAjSwn05NMlUHC
	 i2x3Dn7Rmi+QebwA8qB6RncFXhRJRkwDf62cUEfVvJoMFPEc1CyW74P+EYgTbBScAW
	 PjvBYdlwBJCng==
Received: by x201s (Postfix, from userid 1000)
	id 548EA20401F; Tue, 16 Apr 2024 14:43:31 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: intel-wired-lan@lists.osuosl.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-next] ice: flower: validate control flags
Date: Tue, 16 Apr 2024 14:43:30 +0000
Message-ID: <20240416144331.15336-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver currently doesn't support any control flags.

Use flow_rule_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 2f2fce285ecd..361abd7d7561 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1673,6 +1673,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		flow_rule_match_control(rule, &match);
 
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						fltr->extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
-- 
2.43.0


