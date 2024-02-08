Return-Path: <linux-kernel+bounces-58505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5714784E744
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FBF1C24A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6188528E;
	Thu,  8 Feb 2024 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHHlQcq5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D67EF0C;
	Thu,  8 Feb 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415462; cv=none; b=E/AQbA/ZA4EqAiW3Sc9WA/U0ibv1gH+L78oQnMsEPF7iqqsXFbtf2K4wzRwqZoiDovmklSlII51IGM6KOq7+SNHIpT0WRLs+Lg+/YpCoU6MVGSo4mrXdLj48yK5iRTxiSzVAUHWhVoXcj4E7ATtUwLvHj1JaT/ER6hpvZe1C6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415462; c=relaxed/simple;
	bh=gg5lRi0FckXjDkUVqSo3pBy+xDC24jMwih4308TMI/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HoYjkEVJ3miEXV4qly/mfNMLG/+rXMbVg5SkfpwSPEOmtOD0n/hmwjRoYVva7Ml1244sUdfe+yLn4cxTTJi3vglHoIj9CAHxcDhYQS78KwmF7xPOPEldiA7ZPrQhCzlungxrVWdOVNf65MIHlyZTwqyCMBUar9RaUDwEmsrYYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHHlQcq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF7DC433F1;
	Thu,  8 Feb 2024 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415461;
	bh=gg5lRi0FckXjDkUVqSo3pBy+xDC24jMwih4308TMI/o=;
	h=From:Subject:Date:To:Cc:From;
	b=KHHlQcq5ZRssevtCuJ1jlYCWk7seL1eQX+J123YgSdNo/gIlpycdN3GTjZJSXUKCL
	 cRu3DB9FYwI4NsZsjTQkQ4S2ny1l7wtUkJeBGdVhHBNeHqmwnMvNqr8C8OejjwEzb9
	 mdlZCaL6AO9BE6yWCFp7vayYzHKlX6M35ltxGvGBMtnLYrSqRb4dslgzpan1mrSVWV
	 igUNxRLi6s2WtM5mmxk7Fk8746M/uadJ9CRPlZ+k4lSt/iSp+oyLh8kK5UwP0xyy5X
	 AYocyg1c8fYrcRKJ9s71j48HhPYNvtPOwfDU3e5zTCBKNW+Q0V8Ok3D5XdM6w/NpL2
	 T60n12mfK5nLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/7] mptcp: locking cleanup & misc. fixes
Date: Thu, 08 Feb 2024 19:03:48 +0100
Message-Id: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIQXxWUC/z2NSwrCQBBErxJ6bUMcjb+riIthUomNSWeYTkQIu
 buNCzcFr+BVrWQoAqNbtVLBW0wmddjvKkrPqD1YWmcKdTjWHrxkmwviyIqZ/+0wpZdoz2lA1CX
 zKJa46QJwvraXQ3MiH8wFnXx+Z3dynR7b9gVntgzggQAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>, 
 Florian Westphal <fw@strlen.de>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gg5lRi0FckXjDkUVqSo3pBy+xDC24jMwih4308TMI/o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxRehYosQjMTFqZJREP9PUCIdS9tEwvEMEsEbU
 iOtu15J4KKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcUXoQAKCRD2t4JPQmmg
 c2JpEACuYOjFpW4L3CHGYvKnQbqwEOVjCxx9bX305RgAFWX2TMhBDnG82+An3yuQ7ld8wOWc7W3
 A2sgba96KbnIOQWl1tjlzUS8NohRywHqHjbHPo/LyT1B3ReJeMZ0mihFy29zJOvLDzD9HCh0kl7
 KvZnL2Fz1FjS8akZejt8eJi99v0munrTr0WUGk6sm9vvDqiJwprR6VK46V3wY5SgOEA6VEHznXt
 DxsGk6lAEsNBK0OOr4nPOmbV9buQq5IqSVZLr09fUUUNVALJnCwJ6fbO0mPgE7zUEPkhAFWnCix
 3LscvV1g2V1sfyyUBCiPK3KKeYzTG8I5Ze7VILHCgd9haA3UBfdOl2gwVz6qk+08psm7U0Ijoe3
 kTz9fjY62clQAxEZ4LAu5uXg95tncUn6H+x8hwN86c+SuXqtUggEPuTKFIruUiwxmUP92CIVtBX
 We1bAUj4yBROFo9PNWi03ui4orDCJ45U4hTzO4qPit+3TEkAdNqd0IjbEncGuyJJcsv0WMRJNmV
 KuqUoUbkek0WzQb7/nlVflpyOH0Yr3z//YfO2h6kAA4jLBvAdL9zFkoY2Y/s0N6f5vXvEJDZx7Z
 l98N15iQVxSovB1Nj9BtWVqCPHTKPjPl8RCtQPYyPwDNZ5ZLvogXQ3lI7bqEvDx2w9BgbImDQn1
 z3LMCeWXVy9qDyQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patches 1-4 are fixes for issues found by Paolo while working on adding
TCP_NOTSENT_LOWAT support. The latter will need to track more states
under the msk data lock. Since the locking msk locking schema is already
quite complex, do a long awaited clean-up step by moving several
confusing lockless initialization under the relevant locks. Note that it
is unlikely a real race could happen even prior to such patches as the
MPTCP-level state machine implicitly ensures proper serialization of the
write accesses, even lacking explicit lock. But still, simplification is
welcome and this will help for the maintenance. This can be backported
up to v5.6.

Patch 5 is a fix for the userspace PM, not to add new local address
entries if the address is already in the list. This behaviour can be
seen since v5.19.

Patch 6 fixes an issue when Fastopen is used. The issue can happen since
v6.2. A previous fix has already been applied, but not taking care of
all cases according to syzbot.

Patch 7 updates Geliang's email address in the MAINTAINERS file.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (2):
      mptcp: check addrs list in userspace_pm_get_local_id
      MAINTAINERS: update Geliang's email address

Paolo Abeni (5):
      mptcp: drop the push_pending field
      mptcp: fix rcv space initialization
      mptcp: fix more tx path fields initialization
      mptcp: corner case locking for rx path fields initialization
      mptcp: really cope with fastopen race

 .mailmap                 |  9 +++---
 MAINTAINERS              |  2 +-
 net/mptcp/fastopen.c     |  6 ++--
 net/mptcp/options.c      |  9 +++---
 net/mptcp/pm_userspace.c | 13 ++++++++-
 net/mptcp/protocol.c     | 31 +++++++++++----------
 net/mptcp/protocol.h     | 16 ++++++-----
 net/mptcp/subflow.c      | 71 ++++++++++++++++++++++++++++++------------------
 8 files changed, 95 insertions(+), 62 deletions(-)
---
base-commit: 335bac1daae3fd9070d0f9f34d7d7ba708729256
change-id: 20240202-upstream-net-20240202-locking-cleanup-misc-5f2ee79d8356

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


