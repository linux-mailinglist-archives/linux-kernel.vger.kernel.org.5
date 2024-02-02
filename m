Return-Path: <linux-kernel+bounces-49905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC884713A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D810EB25B3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75946B83;
	Fri,  2 Feb 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRLSM7mY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14041E4A6;
	Fri,  2 Feb 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880928; cv=none; b=kKZK8CLf62vMMo4nF0fiq9HYi/6hulrZHdl6xtLyuvROjRajgttFQ4X4AY0DknzkqLwEBLO4QvXGUKoqxMUEB0BuiEiWIUOjdfjuc8Jy5Feoj+nX4emjajY0C0JDN6oVNwdlVvIEWIqu7Mw6Id1EmNgvLUf/q/FKAjH+kJadGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880928; c=relaxed/simple;
	bh=7eFQengerwA9drGKbBSRiI3jh5gQkIy0/WN8yF4kW5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDAirjA0h5S9Ll4XyPNoCSJDuyEEVxqTzXuoqM1D6AiG79/k0gqgI6m6otbzpbFhlVgduMxDWPSIfrDp217gHDaBY9uwIQDifTCCWf1MXeLCUFCwLoVLMZwNDtlotYx5VYcBRcRp0IDk+zRYOfsFb7YpuYzrNd8mGnMvsstUxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRLSM7mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3B1C43394;
	Fri,  2 Feb 2024 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706880928;
	bh=7eFQengerwA9drGKbBSRiI3jh5gQkIy0/WN8yF4kW5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRLSM7mYYOf+1dV6jtbbEtoEV813bFXK7NmK4Mcvj9CpQvCjMKLfsC/R1Oo34SkkV
	 MYnB/WaBRQATuooUF1RokGWwLbY9pRS3KDISENNZVwRG+F9KhDFxUgs3vwa0rMuB+9
	 bktrA1tFVleEDBF/6DXVqeUmgyUmbIWiffmPAovpczR2XKwc+H+F/ZjlCa4usM0Omk
	 BpYhAH41HlbJsxrujtWts2EJ+5xAcTUetVAyvlR0d1lVq6Sf1qR+0pu3aZ/uuzKgWi
	 ImHgaXjS2tt6uqlUSBwTJHXdNRh2TXNr0b/yBtXz6vToO41rr3hie4TedwZ1XCQhfB
	 MCUCyBzHXcjiQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kbuild: rpm-pkg: mark installed files in /boot as %ghost
Date: Fri,  2 Feb 2024 22:35:18 +0900
Message-Id: <20240202133520.302738-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202133520.302738-1-masahiroy@kernel.org>
References: <20240202133520.302738-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark the files installed to /boot as %ghost to make sure they will be
removed when the package is uninstalled.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/kernel.spec | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index aaedb6d1b26f..ecedcfc11e73 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -77,6 +77,10 @@ ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEA
 		echo "%ghost /lib/modules/%{KERNELRELEASE}/modules.${x}"
 	done
 
+	for x in System.map config vmlinuz; do
+		echo "%ghost /boot/${x}-%{KERNELRELEASE}"
+	done
+
 	echo "%exclude /lib/modules/%{KERNELRELEASE}/build"
 } > %{buildroot}/kernel.list
 
-- 
2.40.1


