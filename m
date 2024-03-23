Return-Path: <linux-kernel+bounces-112262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA05887796
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A9282B86
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C139FDDAE;
	Sat, 23 Mar 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tENLiFqR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01531A38C9;
	Sat, 23 Mar 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711183869; cv=none; b=dpM5h3QSpTg5wiQAdsxhToZtC732A2MyK+0SfxPONOJwjxzE/9ezbuNANu9ouHcL1bA9SICaw1hh3P7h/8MKjGbVm9R/zaH4N4MR9V0aaQr7P0kBIQtGWGd8kvt+F2sU2RFNlPqSYEosSjOMXYR+B12yJWNxNimLxFAqcYGds8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711183869; c=relaxed/simple;
	bh=ZSQSp91ByCG6sof7vhTbEshJ5jEtojlDs7i/lt75JqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQSI5H1rMRqQEn8ahoA8IQdOVhB+QH6ezqWyK/Rg4n3fgnQZzcl0o00f3E84iIF08TNt3QneLL9RdJDFJ424xkMKek7gT1+2zUgb4KupPdiSIEP3IYltVrgTpjhREKRK5LIml3zhDEM4yJYJlM5R3Uv+HgT1gCr+BhuhjQ36s5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tENLiFqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31BBC433C7;
	Sat, 23 Mar 2024 08:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711183868;
	bh=ZSQSp91ByCG6sof7vhTbEshJ5jEtojlDs7i/lt75JqM=;
	h=From:To:Cc:Subject:Date:From;
	b=tENLiFqRQIhUIkB2+FnlLQHb4/yPHYEGO7V2uf50Or0Iosntq2bcYZUsvgubujHD1
	 xrE7adskmN+8Nb1olweNGTrmQvQ3Owv8ud2tIIXgU9YsJtBsJmnVGqLXzWwO0dufoy
	 sLvbGInT0N1lZ3rK/7gDeuJQ/W8/QHKqkcdUeq7cHTZcS9NObWje6ZHhDxoQWLj9AP
	 k+KChcXKJgi41QCF5p1RIqAuJnAwbJhvQ/iS4bb0kyX6n9lkgCybon9NGTNJ0X1up7
	 ugVdRk4jFuRMn/37ycQ7+W+v2b4BpKGD9Su2ocZCTyk8XrquZeGXv4thlECcrG455A
	 un8cCVfHEj6Eg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 0/2] kconfig: fix an unselectable choice in MIPS again, and make sure it never happens
Date: Sat, 23 Mar 2024 17:50:59 +0900
Message-Id: <20240323085101.1243814-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The reason is already explained here:

https://lore.kernel.org/linux-kbuild/20240127162309.1026549-1-masahiroy@kernel.org/

Commit 5033ad566016 fixed the issue, but the MIPS maintainer
simultaneously applied commit 101bd58fde10, which introduced
another instance of the same mistake.

I will not ask him to pick up this any more.
That would take two development cycles until this choice structure
is banned. Meantime, MIPS would introduce yet another mistake.

I will apply both to my tree.

The second patch makes it an error to stop this whack-a-mole game.



Masahiro Yamada (2):
  MIPS: move unselectable FIT_IMAGE_FDT_EPM5 out of the "System type"
    choice
  kconfig: do not reparent the menu inside a choice block

 arch/mips/Kconfig        | 18 +++++++++---------
 scripts/kconfig/conf.c   |  5 -----
 scripts/kconfig/lkc.h    |  2 +-
 scripts/kconfig/menu.c   | 22 ++++++++++++++++------
 scripts/kconfig/parser.y |  2 +-
 5 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.40.1


