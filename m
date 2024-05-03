Return-Path: <linux-kernel+bounces-167541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958F78BAB14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364571F23306
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B015217B;
	Fri,  3 May 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZcT+XMX+"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE18150987;
	Fri,  3 May 2024 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733734; cv=none; b=b7XeyqStne+4iXQwqF8epwIsyw9DVg0FqIcyjtnZAaLqFN5nz/x3Gx6mt2I+tmbkFAd43Y3Zm27YDEHhIM8tm2+F1OWwXOmQFQSOdw+lW7+WVJChyqFd2vriARUvzqD5B1JYlCp+g62DR+ulAJhXRO8qLXRdDRlV01sbbxdpxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733734; c=relaxed/simple;
	bh=nGYHsFL6FMM4tEsZOLRpZNIM5+XUsbVTTzzn7XwQQ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJWCjWHDQtRmT2AwBB0LhZRQvDwftXSf9UNRsMNA/lc/rLdWJKCQ7dIP9cLOrU1ZPkgm/Cn6Awpr/+fkeQMZR01F7nyrpXnlAQqFZSHK0p5Jcj2uBflEI/+epP99NKgPtcx6fGvZR6cJC554tKv9agbT15/8RhxEfAnjAisBLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZcT+XMX+; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8DAE3600A2;
	Fri,  3 May 2024 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714733723;
	bh=nGYHsFL6FMM4tEsZOLRpZNIM5+XUsbVTTzzn7XwQQ7U=;
	h=From:To:Cc:Subject:Date:From;
	b=ZcT+XMX+nzID02l85DnCkNTCc4F+vxSwzNsrS0RMxPKwn8E2qss7ei9WQlGjyW5v7
	 UB2YIC3cfHFEGbEK8f4RPhzt26azUxnCo3TS3k6E/+tz2KzfbPavXLp+IPYKKvEkF7
	 hlGKHt2bQIYQBtwtqpF5xEKhrM/iXYGUZc7KlbCU8dDVaRpgX+r8OYNfLwDaLjxUN7
	 1J93FZszlDaR/O70rWpScnb0CKxeOALHLzRCAW4afnfV0C8DLZcOm404GAqeufMi5w
	 W/PG6JJL6Xveml2rkGZH8KKS5Mx93KJnrNBwDDRuaI59b64roYIVedHUZmGGZdbQ2V
	 PHsnvAjKMZhRA==
Received: by x201s (Postfix, from userid 1000)
	id 1084021BB4A; Fri, 03 May 2024 10:55:06 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 0/3] net: qede: don't restrict error codes
Date: Fri,  3 May 2024 10:55:00 +0000
Message-ID: <20240503105505.839342-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes the qede driver, so that when a helper function fails,
then the callee should return the returned error code, instead just
assuming that the error is eg. -EINVAL.

The patches in this series, reduces the change of future bugs, so new
error codes can be returned from the helpers, without having to update
the call sites.

This is a follow-up to my recent series "net: qede: avoid overruling
error codes", which fixed the cases where the implicit assumption of
failing with specific error codes had been broken.
https://lore.kernel.org/netdev/20240426091227.78060-1-ast@fiberby.net/

Asbjørn Sloth Tønnesen (3):
  net: qede: use return from qede_parse_actions() for flow_spec
  net: qede: use return from qede_flow_spec_validate_unused()
  net: qede: use return from qede_flow_parse_ports()

 .../net/ethernet/qlogic/qede/qede_filter.c    | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.43.0


