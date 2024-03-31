Return-Path: <linux-kernel+bounces-126334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D389354B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427CD1C225A1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C8E145B12;
	Sun, 31 Mar 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BkmsZkbw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C91DDCE
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711908065; cv=none; b=TJp+2gLhxRnMvNMEC1eKHwzIahWp3kb5TXF1v+WB7eNmIhhaJy80M+ZMrpo1bHMTgN22Z/g8M3Pgcv/lzZBhc9uDpfzi8IG1UvB6Z7eRkeeseKnYcWI8c2msV++IVHYdem3+N8TLIgDoxgGaYsKGiEoLT+0ZNlxO3J7hSgGvn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711908065; c=relaxed/simple;
	bh=U6PTw9wWv+gzKAFDJjKShOLiwgUlTiq/cY+TQsA03sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohZzMC/OlyQ0W9prZ9qArcux7aY/1R7Rd19AD12PLCBCFBxuWfA/DnVLA4IBF5U1c7m4f0oxA5ymKNYVnXaj/Yavq9EwYqzEx8isyClJB4Jt86JC8QKd0R4vkdjDlINEO/bzOjm0ST3b6zQ5NNWwyzEr68vhqqyFKb5hglDcB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BkmsZkbw reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA74C40E02A5;
	Sun, 31 Mar 2024 18:00:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EA-m60a9f47M; Sun, 31 Mar 2024 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711908055; bh=ptka3sQE7gZhKpqN2QD9W/zR0n3xXlQGqxs9UkpvXss=;
	h=From:To:Cc:Subject:Date:From;
	b=BkmsZkbwJf8C7/w2Tp5Jy6tgHsfyfmEg6wlzqzkTc8ekGlrJV8+x2nyE+3slvsXTc
	 +Cv72CDVHtzfyb2qPMx5cBZdB0IC6CUlPPdzR64cpbyJKlmqy53K9cPS6h8y4cKuyR
	 8I/LktTAlE6AipI41vQCRwqIb4CEiA2B6LhoGESXK4hS5oKljiVAYxG8YlzhHwPTQy
	 Vmw6cMeZEhYhiGOKqOFuvgA7S56zqPy8Gv9utsXDeXUVoZaUK3PTr2xXuK9vMzwE2i
	 IYiX5cqCpjciRhT3CS0di4SUUuRlBX87JNxsIEfUb5+QSPgLzlf5/M1eWpuvPQiPqc
	 mrt5MUSxsQFKpXiMSdhDNjy/8INFevgaJJnGoQmo6XaE7t3UFEuyyPcn29KD8GQ7sb
	 dATf0dQjh7s3PuHtbJwYyNW3Ci/roGrJrCYfMD52Zyqnwm8DgZxClCKchq9QU7pHmd
	 DD9dzuVJlT9yb7exkfWcGA2YUpkDl67zwZhE9Y/oQ0M5KE96NWMpxNc8KHDpxyI8P8
	 RhgyQzvOTCvcmK6t1zcGpZQrYgL24u46zPznsj4Irne0Bs3YHUqR2qPvjLsmWuQnw5
	 sr87U400Se1Cx2iHKNEKmZgS1f1ssz7AIDyfvB9dnN1lw1cp/KMZ99Dz1/dQf/5n7+
	 xz0fMXfeMYqItJMOEtqQhsKY=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82A5540E0028;
	Sun, 31 Mar 2024 18:00:53 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] x86/alternatives: Do NOPs optimization on a temporary buffer
Date: Sun, 31 Mar 2024 20:00:38 +0200
Message-ID: <20240331180042.13933-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

here's v2 of the set to do NOPs optimizations on a temporary buffer
after the last-minute conflict and resulting breakage before the last
merge window which made me retract those.

This v2 has been extensively tested on 6.9-rc1.

Thx.

Changelog:
=3D=3D=3D=3D=3D=3D=3D=3D=3D

v0:

here's a small set which sprang out from my reacting to the fact that
NOPs optimization in the alternatives code needs to happen on
a temporary buffer like the other alternative operations - not in-place
and cause all kinds of fun.

The result is this, which makes the alternatives code simpler and it is
a net win, size-wise:

 1 file changed, 50 insertions(+), 72 deletions(-)

Constructive feedback is always welcome!

Borislav Petkov (AMD) (4):
  x86/alternatives: Use a temporary buffer when optimizing NOPs
  x86/alternatives: Get rid of __optimize_nops()
  x86/alternatives: Optimize optimize_nops()
  x86/alternatives: Sort local vars in apply_alternatives()

 arch/x86/include/asm/text-patching.h |   2 +-
 arch/x86/kernel/alternative.c        | 133 ++++++++++++---------------
 arch/x86/kernel/callthunks.c         |   9 +-
 3 files changed, 62 insertions(+), 82 deletions(-)

--=20
2.43.0

