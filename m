Return-Path: <linux-kernel+bounces-167357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DD8BA868
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7371C21212
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3614F117;
	Fri,  3 May 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX1xH3Ju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3114F105;
	Fri,  3 May 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723940; cv=none; b=GKIYtbI+F3zLukDZkphX+aV7iGY4oRzlc963vD/A4oowRS/TvbAOJYEjKcsDgRd2Y4DpAKpCc7s15LsNub/vUmOE0mjd6GIKxa2Ox9MrKD8zXTz1KXaPaUjdV0Us1vypxFr9weVJZAyQ6l9uqukXULCZplF/vgwnWxSkRPkUIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723940; c=relaxed/simple;
	bh=Q/UCgzGVcdSeACQEWB36d445wgW1pjP0qCwPeE9977A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjdPXq07i+Fua1F2tLx2gQBlKgMvujThUJoeK4eRXofrCRN54Rgpe8ow3O0LqYrwKumy4wF+RKeVezRbzXMFi/KjoFDS2uqwjqllAEv3eHtu6nSrvOP7RuWoFpJfFusp4gFWiapzHmiDpmjux/zQqjeO1gaZt9yP4kkM3WWequU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX1xH3Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB7CC4AF48;
	Fri,  3 May 2024 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723939;
	bh=Q/UCgzGVcdSeACQEWB36d445wgW1pjP0qCwPeE9977A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rX1xH3JupufnsR76VqhH88rxav9yplIZx623VrJHY6a1OOTB/+pOISec/GVF+fXg2
	 29VTxePPGYbvbsSS0AM8i5XfOxyBeVNWeGNiKKCXntZ+Xk71dmOb9kDvMxQXvSv+Vg
	 ST4AbfyAt633wTAE3smzzhmc1xQd+GjbDVkJVSn0mtHtYmeWUhZlT8pmZGjj+6F7T/
	 kzUPGcpvZXt9Zudg1TVPjdihEGfM7TaMT22Xe4VkdZqjXzeNDCaqEnK8rLEO0c++ap
	 9q107tFo4DoMhfOU40qkDldn6hZErEX/Py1x8/0GMoSRK7wyCzI/X2hunNeFBskdgR
	 IJI3fjgm9kq1g==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] alpha: sys_sio: fix misspelled ifdefs
Date: Fri,  3 May 2024 10:11:16 +0200
Message-Id: <20240503081125.67990-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

definitions of avanti_mv and noname_mv (and associated ALIAS_MV)
are conditional upon the wrong thing - it should be
CONFIG_ALPHA_{AVANTI,NONAME}_CH, not CONFIG_ALPHA_{AVANTI,NONAME}.

The former is a system type; the latter is for the bits shared
by AVANTI with XL and NONAME with ALPHA_BOOK1 resp.

We want all those machine vectors defined (but not aliased - see
ALIAS_MV() definition for details) for GENERIC build; for
system-specfic builds we want only one mv, so avanti_mv should *not*
be there for XL; it certainly should not be have alpha_mv aliased to
it on such config - xl_mv will be there and alpha_mv can't be aliased
to both of those.

The same goes for Noname vs. Alphabook1.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/sys_sio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
index 0bf38f868665..c28a6ae1d989 100644
--- a/arch/alpha/kernel/sys_sio.c
+++ b/arch/alpha/kernel/sys_sio.c
@@ -360,7 +360,7 @@ struct alpha_machine_vector alphabook1_mv __initmv = {
 ALIAS_MV(alphabook1)
 #endif
 
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_AVANTI)
+#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_AVANTI_CH)
 struct alpha_machine_vector avanti_mv __initmv = {
 	.vector_name		= "Avanti",
 	DO_EV4_MMU,
@@ -389,7 +389,7 @@ struct alpha_machine_vector avanti_mv __initmv = {
 ALIAS_MV(avanti)
 #endif
 
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_NONAME)
+#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_NONAME_CH)
 struct alpha_machine_vector noname_mv __initmv = {
 	.vector_name		= "Noname",
 	DO_EV4_MMU,
-- 
2.39.2


