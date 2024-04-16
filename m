Return-Path: <linux-kernel+bounces-147045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D488A6EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E7F1C20F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4112F389;
	Tue, 16 Apr 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="cJ77AM88"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD912E1D9;
	Tue, 16 Apr 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278653; cv=none; b=ZRHxFWlWRgd5g0wB2n/swX4mbFSlx75xMB94vCk2y1agwt64kaCtdYkswHvyeghaq0R15LHmWaD4nXbhC4jXPvr3eAn568HADnwjgXybHh1TowWAetXpNSq+DN4ZbsEorcqahvqaI4PfTqcs/DKjAlNQ9W21SN8MM8wiWSzsdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278653; c=relaxed/simple;
	bh=1ISri2bYvVsZAxWaG9HkNxGsuBog0gqAtEuAMx45XWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0yl6PMEVcP/diUjOrJCORz9iYAjg+kQnXZjd7+X0ihMaunskFAHmrJayAV+SqbkxjsQaJHHpeFj41mC8HDyYaoVgJBngjnNUus6E4OuPgQsXeJD28h8oeMXMTZ6VLkeETpUOyjqc9avY3xUMPV14ziDCULSq3bZMibrQISzxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=cJ77AM88; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 71B41600A2;
	Tue, 16 Apr 2024 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713278649;
	bh=1ISri2bYvVsZAxWaG9HkNxGsuBog0gqAtEuAMx45XWs=;
	h=From:To:Cc:Subject:Date:From;
	b=cJ77AM88UOdtiL1hxDlCM/LDyadeS5Fy4mTUBJZ0bVwdC0BAa5qi/0Tepp86grPka
	 VTRhnsMsOkx71RdasvKCZM4gyoNMJVcquFGND2lIX1sECz9YsgAxq91W+LNFDN7jpV
	 T8PrgAtr0OEqOhdfxLDOVS5hd4dMAcvazMFESrpKpxN9JOU55v1weh310C/1bB1fGh
	 dLhaIXut+mYSpUmSMiZsEoJOFkDKuBDItY4UR/dLgNZXa6SvS7G/2bXSAK/Kw/bQIx
	 kCg5VHbl7GxQmUjkw0Vnq/EtO/5bV+eYWh8ubbCNjv5hIkJekGPac9stRnzO6F9wnu
	 p5u0BFCA7Ztpg==
Received: by x201s (Postfix, from userid 1000)
	id B5812202498; Tue, 16 Apr 2024 14:43:20 +0000 (UTC)
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
Subject: [PATCH iwl-next] i40e: flower: validate control flags
Date: Tue, 16 Apr 2024 14:43:19 +0000
Message-ID: <20240416144320.15300-1-ast@fiberby.net>
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
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0bdcdea0be3e..e219f757820d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8643,6 +8643,10 @@ static int i40e_parse_cls_flower(struct i40e_vsi *vsi,
 
 		flow_rule_match_control(rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
-- 
2.43.0


