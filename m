Return-Path: <linux-kernel+bounces-88967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8486E8E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173461C235D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA813D3BF;
	Fri,  1 Mar 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KPWgivlo"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BE3D0AA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319397; cv=none; b=YSjq5nCf3VLDIPzgE2WTdqB2ENBJtPNyECooDMheQ1E7FNoyJTi4cTeqihZNaNascLjlDOQVdDrkhPYsGX0gCuGp80QcVKiOs7fr9lNHr3GR4mtrkDgbLI6iaUocj8S8Phzz96CGVwS+Q000yG7CurVwBZ3AhT2vzWOixvIzdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319397; c=relaxed/simple;
	bh=BVb+h0Vtm9WjPCyU32l9Vp54s57Uy/S9SWFffjmGRIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlT2dxEcjKemYArQA7z8oy3bfGIs0v7K/JavjiEbqJad1rtditjrueDyShmxKrc94Rtp8aNMxVoIc9BiQ84ZZn2bz5ZxBtpEJP7QdN6bw9ffcuRsdK6hteKWbjv9T8TK17oUeRAChfhumTbXVlvyoANGkkO1dl+JDg4Xon/Ph/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KPWgivlo reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 49BBE40E0185;
	Fri,  1 Mar 2024 18:56:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qPHddR4wPZe3; Fri,  1 Mar 2024 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709319389; bh=E01+dFN8VTEoLLAD2Ao4WnzpOXaG683rBiOqtwGShec=;
	h=From:To:Cc:Subject:Date:From;
	b=KPWgivloQIcfzz0TZiqEEd+rvvR3g+USJC8fKYEz0gZcCd0ubfoCV/p454nQqg2ZQ
	 t/gOhCe8NityxU4aeiR4EpgWuX1elQGUp6i/W61Y74haxgH1DteJtqj5s9V5PdVxYs
	 WacEaNJepNmJ4uyybKg0O9VarO8OGPolgu3TZwKgnnS22fWGeL6VR4r16vKtAJSta5
	 x9yA868mmsbWW5S58eLBg57CB69mJDOmy6KVCuvlBrYIRfcmV7qIdA+4fy8P4CX9od
	 sq7/RXJDzusNO/YQPA5seMiIdhoPdVTxAu9t2UmDdaKZwJyWfNc5UAaqPns16F4qgl
	 a7BHrvEf9EBEuP4aVRSBsH3hC/2QXNeghd8WVwbzZoJfJNdzg3R4X92q9elYBnQNhL
	 NhYqWjLnZHvVljkgRfUOBkFp6gGQlsU/ZxGBQdLTKYgz3K7D9eteeiB+OMs2MtC0lK
	 1ir9NN+AGu62f51tnSd6r3Cghu/m8MGYdQSeAkmNuomv4M6kVwJAlNnqNcaOklfSoT
	 AvJKzcyJWN0r5dC4vZuCQ44UEfTJJ9mefgcxmu2O3X3Qwm+YmGP0ckjP0r38GpNEj5
	 9qNSDwolx0cKoQ+8iXi68tIhZK2RkWTOWkSkYj4sL5+mtJuQFUGqhyBsNRUHSQ3yyN
	 g2kxGXSBJuObdh+ZVp976R74=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17A3240E00B2;
	Fri,  1 Mar 2024 18:56:26 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/2] x86/kexec: Revert 5level dynamic switching
Date: Fri,  1 Mar 2024 19:56:16 +0100
Message-ID: <20240301185618.19663-1-bp@alien8.de>
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

I think this is silly - both 1st and second, the-kexec'ed kernel would
either have CONFIG_X86_5LEVEL enabled or not - why would this be
different.

And this'll become even more the case in the future.

So remove this silly stuff.

Unless there's a valid use case, which I'm willing to hear. Those commit
messages don't say anything about it.

Thx.

Borislav Petkov (AMD) (2):
  Revert "x86/kexec/64: Prevent kexec from 5-level paging to a 4-level
    only kernel"
  Revert "x86/boot: Add xloadflags bits to check for 5-level paging
    support"

 arch/x86/boot/header.S                | 12 +-----------
 arch/x86/include/uapi/asm/bootparam.h |  2 --
 arch/x86/kernel/kexec-bzimage64.c     |  5 -----
 3 files changed, 1 insertion(+), 18 deletions(-)

--=20
2.43.0


