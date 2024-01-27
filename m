Return-Path: <linux-kernel+bounces-41305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC783EE96
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31A4284A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4952C19C;
	Sat, 27 Jan 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWp/lLxp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C661E493;
	Sat, 27 Jan 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372594; cv=none; b=mPMnjRmDTWW0JdRiH0uc9dPgUaUqmjxCq6l7bRxz9t4IoM64JCZv7GOMZ8tH+RwzQ3fca+GDbYA2IwtPTZma0F4KdGchZdkwJYIn4nny7nk6xsUWTr+JxPnkT8o0oTq1IgYPoEzBGMeKwD5igIwbRHmdgZYOupxMfI9DpEH2EB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372594; c=relaxed/simple;
	bh=7O7bM9DbGm+dHFdHjSz8m31D3316fr8BOWGszZGmnP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pDZi4Pr+7H3azFEvcvwBeZwLNgbnY7jBXGMeK8bAZJ3EPJN0pIME9Wd7kF3hVRi6SXv5+oqqxG7RIycHs8w9P/9FKlTdMseJbKeKsS45p49ZgnnAHooS1Cs531C2bvhqwhQZFWTffF/zq6rOJg+fK8yQQaj+r1yDQ5hhAtgQFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWp/lLxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B11C433F1;
	Sat, 27 Jan 2024 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706372594;
	bh=7O7bM9DbGm+dHFdHjSz8m31D3316fr8BOWGszZGmnP0=;
	h=From:To:Cc:Subject:Date:From;
	b=kWp/lLxppL1Wmt0PYLrNpRtNqtBo/WX9lGCN3fsRTmerNnoJJrOLbeP52MC44Aon/
	 PyZrsBY7MiVsKapmAjDZKsX1Fd3iyU9mYrONcVYq7LXbfe3TIsURek5GbNWbL0KDHV
	 xLvpsCCjxE50YATkpQgjTQdrhOL8iI7PuRlvJhECDIApyfcLxK5QpxF3PwS9YS3XIf
	 pJgpScWJMXxnkKoYsp3dvkdJF7losCwVsadbGx0OHfA4XtZc6JoenQTtTv5QKQBNbW
	 AO2dK33CWfIbyEQLBu0ojQMceIHb3B6yFzCGaIH0ADezfV89C0uDIFVyP4fGkUTyON
	 Uq/0oH7voAZzQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] MIPS: fix the "CPU type" choice structure
Date: Sun, 28 Jan 2024 01:23:08 +0900
Message-Id: <20240127162309.1026549-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The bool type "choice" is meant to list exclusively selected config
options.

Unless you are familiar with the Kconfig internals, you will not
understand how CONFIG_B can be enabled in the following code:

  choice
         prompt "Choose one of them, but how to choose B?"

  config A
          bool "A"

  config B
          bool "B"
          depends on A

  config C
          bool "C"

  endchoice

B is not a choice value because it becomes a child of A, as a side-effect
of re-paranting in menu_finalize().
It is unreadable, and I even consider it as a bug.
My plan is to forbid such a silly choice structure.

Just write as follows:

  choice
          prompt "Choose one of them"

  config A
          bool "A"

  config C
          bool "C"

  endchoice

  config B
          bool "B"
          depends on A

Fortunately, arch/mips/Kconfig seems to be the only file I need to fix.



Masahiro Yamada (1):
  MIPS: move unselectable entries out of the "CPU type" choice

 arch/mips/Kconfig | 76 +++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

-- 
2.40.1


