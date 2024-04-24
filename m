Return-Path: <linux-kernel+bounces-156996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C248B0B61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55CC2851CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85815D5D7;
	Wed, 24 Apr 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="X1O+trFs"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53A15B986;
	Wed, 24 Apr 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966191; cv=none; b=bFNmZE+wIeSV2K28GadXTkZtzKeriEz4O5lnKuBoB/9BzOq5jcXN9TRb4h12KxHbRBFMvGuNyZEJvT9XJ+//osEPUwfi0XCxn27DiNEF5+Cc3ioZipijM+ZBR3a5KpsPbsLNN70T8PzXcrqzGdXtT+5wMVdjzWxD9pSfd+IH0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966191; c=relaxed/simple;
	bh=EWAIznzUX0DHOlahRpLSJ/x5hLx2THJ0Nhx/H7hZWYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o3uKQdhDSEC51X9IW4heoiXLc/Y75S1du3CKWcNBrr8rXq5zF0oYgjngBvYQv1qOdUBzwYaDfFAC2eryRzzwBpWAkv6RtCw4nxXd7dZxnF0a4HyEfWil6NLQfLNA7DqbkkcmdmU6GzBLzU5sIb5X6KR1kre+kz/mfLGRFjg1rhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=X1O+trFs; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E9574600A7;
	Wed, 24 Apr 2024 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713966185;
	bh=EWAIznzUX0DHOlahRpLSJ/x5hLx2THJ0Nhx/H7hZWYw=;
	h=From:To:Cc:Subject:Date:From;
	b=X1O+trFsOgKa62JcfLSbuM0jHkDfDyHFfKNmEg+YxkjXEz3RJC9jULsnBaTlg11MX
	 GOxef++oKDXDEJeHDHckE235YLIYyAF+CfgiYfauHu6M+LjZ+oLGoFv6p/2OT69ksn
	 4fdYVhForzGduvlLAi4fvxvzXwDWdfJxQLQYozEHoeoYB+JfKIMsDBnt2sP2GVlIXh
	 YyKflYYtgDtBrAhBQg9FC081zDTnH0wBKQHVpR1moDOf1hvfOXh7djXpiOpn/1NfuZ
	 vzTTYn1uVT6dRBSJpam84mELLNd4/YVmaq+DAL98TpLwixT8gG71z8mKzWzwnv/Qqh
	 ZrI0/mSonGWYg==
Received: by x201s (Postfix, from userid 1000)
	id 967542044F0; Wed, 24 Apr 2024 13:42:52 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next] net: qede: flower: validate control flags
Date: Wed, 24 Apr 2024 13:42:48 +0000
Message-ID: <20240424134250.465904-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver currently doesn't support any flower control flags.

Implement check for control flags, such as can be set through
`tc flower ... ip_flags frag`.

Since qede_parse_flow_attr() are called by both qede_add_tc_flower_fltr()
and qede_flow_spec_to_rule(), as the latter doesn't having access to
extack, then flow_rule_*_control_flags() can't be used in this driver.

This patch therefore re-implements flow_rule_match_has_control_flags(),
but with error messaging via DP_NOTICE, instead of NL_SET_ERR_MSG_FMT_MOD.

So in case any control flags are masked, we call DP_NOTICE() and
return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

This is AFAICT the last driver which didn't validate these flags.

$ git grep FLOW_DISSECTOR_KEY_CONTROL drivers/
$ git grep 'flow_rule_.*_control_flags' drivers/

 drivers/net/ethernet/qlogic/qede/qede_filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index a5ac21a0ee33..40f72e700d8e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1843,6 +1843,19 @@ qede_parse_flow_attr(struct qede_dev *edev, __be16 proto,
 		return -EPROTONOSUPPORT;
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+
+		if (match.mask->flags) {
+			DP_NOTICE(edev,
+				  "Unsupported match on control.flags %#x",
+				  match.mask->flags);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match;
 
-- 
2.43.0


