Return-Path: <linux-kernel+bounces-141314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8828A1CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F884B31384
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFB03A8FF;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuHVqbRQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36938388;
	Thu, 11 Apr 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852744; cv=none; b=kgDmxQ11OPVURDpbz2D2lWYXlqNADcYEMo5bkzPqj/c1wN6Ou8HipZuwOrZ56g8icrQGov1G/GEOg3u+xf4Df6HhMsz0cpqJTvLDvvqqkjo4LgMy7+K0h+88QuzJzq7OCKHItmL7rsWF9LEaK3MLno7mu0aa7/vyM1Ws/Sv6d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852744; c=relaxed/simple;
	bh=vawJVSPNs8IPTuOUeCDr5RYxL3kOMDGd2wsLFCGKNRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPxHtXrXRHb012uj1zEIPvWwFsZpLXFNwRokNpaAHEfmkYLodO8P62Q48EE9uPnC8BtBU3+cVS7YwQzPNNcMumv6rfnObQJDo1BY3iN7voFTt6Fk9wqPTJ5zO/u1Fa0iNLNq9z616Waeaa7vB9uVWVDi8K3FzOaKcYoUKQMg7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuHVqbRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74688C072AA;
	Thu, 11 Apr 2024 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852744;
	bh=vawJVSPNs8IPTuOUeCDr5RYxL3kOMDGd2wsLFCGKNRg=;
	h=From:To:Cc:Subject:Date:From;
	b=PuHVqbRQSjYGl2oWM9bKSUwT9RwRAZvWdxqZ1gdaa2Hc7FSsNyV/u+4Ua4E/Djv6L
	 lt8zYJUpCL5qImAcZHUYWzZqGgtNaTyH48XqxUPQKF8FC9+B+95zg5vy5p3RKrPIT6
	 UC1ZSbcQCx3HFj/E4/lavB1N3UmELNCuN5uq0xgKQtklmjcV+pRdFwBBe4uAo3OHu/
	 vkTF5wEQVLute2v3/LbWfnVNjptv9X/epxRCImZo13pb+Y57e46OSeQNbeer34uHOO
	 pvAgWliPzkkX0O1P2NjtiWzvRgN2lXfaXFvW0GoFYAMZlrhyuZG2trUg6ZDahomFB/
	 JKjrhKx75h6QA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefan Kanthak <stefan.kanthak@nexgo.de>
Subject: [PATCH v2 0/4] crypto: x86/sha256-ni - cleanup and optimization
Date: Thu, 11 Apr 2024 09:23:55 -0700
Message-ID: <20240411162359.39073-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset reduces the amount of source code duplication in
sha256_ni_asm.S and also reduces the binary code size slightly.

Changed in v2:
   - Take advantage of .irp in patch 1
   - Added two additional cleanup patches

Eric Biggers (4):
  crypto: x86/sha256-ni - convert to use rounds macros
  crypto: x86/sha256-ni - rename some register aliases
  crypto: x86/sha256-ni - optimize code size
  crypto: x86/sha256-ni - simplify do_4rounds

 arch/x86/crypto/sha256_ni_asm.S | 253 +++++++-------------------------
 1 file changed, 49 insertions(+), 204 deletions(-)


base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
-- 
2.44.0


