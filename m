Return-Path: <linux-kernel+bounces-88970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C910686E8E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81978284E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB393DBBA;
	Fri,  1 Mar 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gT5c9ixn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0803D548
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319400; cv=none; b=NdjvCytCdDKBH0f0cN7g7Y1Lb6o106B01Q7t1pnqBtvVhngLe+fDpJop72AIzpO6cFwTvcBAmvzqNlCVYxkyJ5zf0HmAlRdcRZn+QSu8WcLNcnp57+X9byImLApd6Q3J0roi1Y9XkgOG7KrpTVgbH8ix5sqK+3QOvub2bh6sa/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319400; c=relaxed/simple;
	bh=k5E4WWGp+V+degHNN7v/pKAtVxC2pZvmpVUXfqdSfPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3GF5xiRU4APKjZJmsseA48x9Pxd00hF3sfDHujNlTM38sFX8O1TYVfNxe1pGMjX1rcHsV6C06yMNvhmypMFmyRqq0pjQK0Hs7do6RCx3xWD6HybbBa7EFYGQkXCKeuyJyl8QNfoLCjhASPElQsZhU4dSiwJtZxBgOkA3PnhbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gT5c9ixn reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 834C440E0196;
	Fri,  1 Mar 2024 18:56:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UZe5OO0KE1r9; Fri,  1 Mar 2024 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709319394; bh=aN+C2xm0YbEn8nVRyX6/uoOtPGSz1gU4UO9UwrqDSKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gT5c9ixnrC+Rd0ZGaWzShfz63pxWzWEvv4QAlD6JlDrYbQNyan9DrUHoUgNOs70ql
	 TAjZ5jMimNqGpSvUZGIvaLyiPNHRd/yT31LmtdhlaGvjtY3QUDfFkoYhoMxu35JuD3
	 Lz6xFxNZpDE0ffEtwWbJi7YZ6VzpCnZLPejeNprKVwgxzcbuCgDuayyFRTsyaCkzSk
	 4RJrxTavvRVpftkD7x96yyBrQTRoN7uuxpwtuN4/rsx9f/odUjQvInXLTXiENyroA+
	 /YxYHwYepWM8JFXBIGpNhJ2F/cutx5r4LRJqLFe1M2BkBOi0x59lL/FpXM43vFJSGI
	 tYVrfaONaRixZ3cIcyB3iHWTRY+/E8McHc93tcmEOpYV4qP+hgzMeZcWiF9p+lshf+
	 MCgG1to6LT5fWpJJUlRSB8XDoXFqFZLfzKS0PlMjeikHXO4X9UIWaoNFikdPebunft
	 Voe5rztrC4oiKqra+gNuAcuF/fc0I2/wBx+j3sHmBFaPsMyiCdpqrZ6ZL+l6wicKNB
	 ob551g2FE6R/z7mBUNicivgzG+fRv9o37YcCYNpt1K6DjJDjKd5qPUAbHJEFyAqHUa
	 Fm/C9GqErAxjUgjV+m+tTKx6vuNddMdbIOeELEAYvYRuJJgKT7rfJ+tlivLMi/3Z0s
	 mjsoW/ySua6TmhYSGVgH+xo0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A2AB40E016C;
	Fri,  1 Mar 2024 18:56:31 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/2] Revert "x86/kexec/64: Prevent kexec from 5-level paging to a 4-level only kernel"
Date: Fri,  1 Mar 2024 19:56:17 +0100
Message-ID: <20240301185618.19663-2-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301185618.19663-1-bp@alien8.de>
References: <20240301185618.19663-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

This reverts commit ee338b9ee2822e65a85750da6129946c14962410.

This whole dynamic switching support is silly. I don't see a use case
where one would use an old kernel with CONFIG_X86_5LEVEL disabled to
kexec into. I.e., you use pretty much the same kernel.

But I'm open to corrections.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/kexec-bzimage64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bz=
image64.c
index cde167b0ea92..4f2e47338b7f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -375,11 +375,6 @@ static int bzImage64_probe(const char *buf, unsigned=
 long len)
 		return ret;
 	}
=20
-	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
-		pr_err("bzImage cannot handle 5-level paging mode.\n");
-		return ret;
-	}
-
 	/* I've got a bzImage */
 	pr_debug("It's a relocatable bzImage64\n");
 	ret =3D 0;
--=20
2.43.0


