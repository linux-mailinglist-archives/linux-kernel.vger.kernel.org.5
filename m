Return-Path: <linux-kernel+bounces-146411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBA8A64E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2411C21F37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A412837B;
	Tue, 16 Apr 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+KlyKEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003873199;
	Tue, 16 Apr 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251948; cv=none; b=inNgQ2z0MsVRAoCjwZljZQByJJfMtAHCed0XvXLMzuxtLj6Km+/jkctbEmeZACzZZJpE0TjHUKwuDueWU46DMrZJjdh3VXWlLkS/cBwR8NOatcyW3lVjq9BoUcs9I9shDNEuv/byRb1owbTRqkYWLDLcXa9OU5dU5sgx6HnnhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251948; c=relaxed/simple;
	bh=XvRd1i+MJnnAivOan/S0mSzDdn9jpLQDQUOM7uQ3tnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iT/evCh+58gW3O47fFw8l2EZhElD5cR6kpJ2H5Bcl+Xk+Rhx8Kxbk4GhNqqnzM6dYWfdlF4m+ohK8H4KMh/uPlUKRzu8jQLKIiiUvIumJ18r8mPFH7MU9wDd4Quc/cruGWFYi4oevqqov0+FtUI/FUvgq855aBq9ydRWOo04cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+KlyKEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EECC113CE;
	Tue, 16 Apr 2024 07:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713251947;
	bh=XvRd1i+MJnnAivOan/S0mSzDdn9jpLQDQUOM7uQ3tnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+KlyKEOutnRnyO+UsswV3gp+zpimrfr/hw48XAD6AZwtI+Yxug9lOxurAUT6NEeE
	 G3TcCfIwxW9Z6CE6M0EekJwAS5DUCzoXPrKcSjN7XKntCzOq7P85fe9C0Aqrep9pwN
	 kxcm7oaJVcCTjls7vgwW5HMc8zgkT8lQOgH2th53V2Ea0LCDmtgCiQwbMVk6NEU1as
	 yy83YFPs8Gv2bFYWZHKK7VIcFRGBSoDuR78kul2scGgph54ox6koEjY2+/7x3n3yRG
	 +9MzTYT0bfhbwbwo5ObMEWmv9gkaCuGjXm4ZZ/fLcD9vLGb6uVcWhRCKKAv268888n
	 O8ZwKwqp15Syg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH] serial: drop debugging WARN_ON_ONCE() from uart_put_char()
Date: Tue, 16 Apr 2024 09:19:04 +0200
Message-ID: <20240416071904.21440-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <Zh3vY99GFFyKJF0B@xpf.sh.intel.com>
References: <Zh3vY99GFFyKJF0B@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pengfei Xu reports, that the -next commit 1788cf6a91d9 (tty: serial:
switch from circ_buf to kfifo) tries to emit a WARNING and that leads to
lockdep errors. Obviously we cannot print anything from uart_put_char()!

This WARN_ON_ONCE() was/is a debug aid to check if the condition in
uart_put_char() can happen at all. Pengfei Xu confirmed it can. Unlike
me and kbuild bot in my queue.

Second, I completely forgot about it, so I did not remove it in the
final version, nor mentioned it in the commit log.

Drop it now as we are all good. And we even have stack traces (and a
reproducer)!

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 558f159ada15..bd4a72f8e821 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -573,7 +573,7 @@ static int uart_put_char(struct tty_struct *tty, u8 c)
 	int ret = 0;
 
 	port = uart_port_lock(state, flags);
-	if (WARN_ON_ONCE(!state->port.xmit_buf)) {
+	if (!state->port.xmit_buf) {
 		uart_port_unlock(port, flags);
 		return 0;
 	}
-- 
2.44.0


