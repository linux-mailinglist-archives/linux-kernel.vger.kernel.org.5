Return-Path: <linux-kernel+bounces-138458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25989F18E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB871F2180D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC615B0E1;
	Wed, 10 Apr 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN7ADNtA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB115ADA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750321; cv=none; b=J23e8e9GrfDq+6RihWi4jYGTC9nqJf1WBmQ6fzfYTvJzRvt/eAWvtANRtjuUNutf65lYoJit6b6bCaLdpzogKw0HRO6MFhE/eN2Pjl/QUt9+a0nB6Ne16H4G1EwjSIjvKOALe6ITEy6/X5P7HOZdozHMoHXBB0IpZO9cMfDFDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750321; c=relaxed/simple;
	bh=D6g7kz9v1lvnZv12s+hhXRD9WFjxJ0VoV/zFfH1fEXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxWcE/Br4iNgm/BnQw2caXNnSGCBpn38QF3R/jIfg/2uHwHcWshasFTNqITCe6gjoKrSFNbt0yHSpMWelxzeftE3KniUOqx7+r28u24YNuSxw6sfrFqgJvRJsIZU8SBjkqfd5KFgMzIeGglbqNN0KfFcWOHFb0XCmHXnnqE0buI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN7ADNtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37D8C433C7;
	Wed, 10 Apr 2024 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750321;
	bh=D6g7kz9v1lvnZv12s+hhXRD9WFjxJ0VoV/zFfH1fEXs=;
	h=From:To:Cc:Subject:Date:From;
	b=gN7ADNtA9kOKv2MBmNcwFJ/WzdRIS0TQAnQmZRekIvRoK4RXM8MDzMQDES/aZSlKC
	 jGTaD9/j0HULprQI97rZlsidLO/7Ge/jsyXD6gysWa6J6jtKnRmx0ZD1d/a4qJjxaS
	 lLXYscXxFXkAR8solCU0KiWRUlscBlsNQA8kO6iXXC9XIAEQrJTi0KH4nkLciva9HT
	 TlO99wjcHBxfA+ZkR6r/id4hs80xJok9mNGTXO1p2KucPo7uDoOR3PUeWJ/yCqLHI1
	 AmTkDfEybvtIwKh1BoiskVeKg5VIbWjyNwugTy1mAku5n2ckemEP1eEZm7ZvnqQfka
	 AZGENFyRd+owg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] PolarFire SoC Auto Update design info support
Date: Wed, 10 Apr 2024 12:58:03 +0100
Message-ID: <20240410-opulently-epic-8654bdac3422@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=DKDUkLAPHTrXR9D8TwtwSjtryroUcX4bNpjv3LfEM94=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlidVd4t133aY1wWKDPGzFHuFFLRKArpXzVun1mrUvKE 3xfKVl0lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCLOXgx/RRPyY+KPpZREXF3f uHdT7oGvXGw7DQwObDqf2HNUfdnfGwz/0xkv3f7wdYH8lT1SE4IO/JQTPKzI3HT9tVfpPPEZ2fI sfAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

There's a document that is internally available that the author of the
design info/overlay format stuff wrote about how it is composed and I
need to go read it and make a version of it publicly available before
this can be merged.

While implementing the design info support, I found a few opportunities
for cleaning up the code and fixed a bug that had been mentioned
internally about failure cases printing success. The scope based cleanup
stuff in particular is rather helpful for the drivers using the system
services mailbox, so I'll roll that out to the other users soonTM.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (5):
  firmware: microchip: support writing bitstream info to flash
  firmware: microchip: don't unconditionally print validation success
  firmware: microchip: clarify that sizes and addresses are in hex
  firmware: microchip: move buffer allocation into
    mpfs_auto_update_set_image_address()
  firmware: microchip: use scope-based cleanup where possible

 drivers/firmware/microchip/mpfs-auto-update.c | 140 +++++++++---------
 1 file changed, 70 insertions(+), 70 deletions(-)

-- 
2.43.0


