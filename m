Return-Path: <linux-kernel+bounces-148632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390068A8554
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678F01C20E57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB12B140E37;
	Wed, 17 Apr 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="pjcIVCXN"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DA13C81F;
	Wed, 17 Apr 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361965; cv=none; b=mgH5L1j905MoQhAOhpKSQfsb1cNrhShHnlIvZmPm6GnW92UkpoPne7QQkGGckSM2gLvGcmjfTRAfPqEpstUcd3MCCJqPKxlRf5B9PdCFsmEPdrSLI7insOWs3NMUVfOvQa9bbCHIuik24bSre9JLg4qLdAu9STkMY5ZTve66/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361965; c=relaxed/simple;
	bh=4Cmcmmzl6A6wun1x2yb3/vcGq9AxnztLrcfzCmZZJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YFnI0eDi47e6i0IY/69pC58qP59CXn+KDtU/AcszVW5IuSMyGcPYQHoYEW+ecWpm5rDn/xmb3cge7balocECj9EXW9D6igAI3LbzwULMiSHv6UVbfKq5sA8z66PlPIvCBVgfqTfWAAr8DTMkXkXmyie85fVVyjuSl9FYA1FaQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=pjcIVCXN; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8CFC7600A2;
	Wed, 17 Apr 2024 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713361953;
	bh=4Cmcmmzl6A6wun1x2yb3/vcGq9AxnztLrcfzCmZZJlE=;
	h=From:To:Cc:Subject:Date:From;
	b=pjcIVCXNTxr1YmJPkL1TWaxn+SQm6stYgn86q/JpDYAOuib5zFrOAuxGrkhxZJ9/o
	 DxS0eRBIftNC5aQ3YBBxxm7/Cd4CcFermzSZrvSi3HaM7Dh4LNtD0rt/a56p99W7MQ
	 TXavCXLc0gO4aaODYZDNY59b3czL+PzunXCT9MIr0h75bT9TzXDVA5sBkhOD7lYVy1
	 qceVXmTIPWpwY1yeB4kp1yYXS9T5Hi3uX9PRvKZ7OgofZO74fc3EI71Y/BcL3tGOyG
	 tgK8Y3DYlTuHjqVdO8KpyoFwslsewZ+YQXZJ7FVObTUoskGRcwtk+9rOGIkxeBGlEH
	 Q56XSLIdzzyUQ==
Received: by x201s (Postfix, from userid 1000)
	id 07E5520445E; Wed, 17 Apr 2024 13:52:24 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net-next] mlxsw: spectrum_flower: validate control flags
Date: Wed, 17 Apr 2024 13:51:20 +0000
Message-ID: <20240417135131.99921-1-ast@fiberby.net>
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
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 9fd1ca079258..f07955b5439f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -595,6 +595,10 @@ static int mlxsw_sp_flower_parse(struct mlxsw_sp *mlxsw_sp,
 
 		flow_rule_match_control(rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
-- 
2.43.0


