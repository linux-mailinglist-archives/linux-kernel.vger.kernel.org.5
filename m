Return-Path: <linux-kernel+bounces-63407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A307852EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FC1C21DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1ED36B17;
	Tue, 13 Feb 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6Q36KCi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4736AE9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822931; cv=none; b=aRVV/uyEdluLnmpuClrGgUi0+dhp80kZwHqme/hX8FqOsghQXowQf4XbJCafaKsqh6vh+D2fLzRy9+vcoTDCGH2FHLd3V1Ps01v70QqUCZ8bwzKpnznuqvqEw8KSdiradUdbyukcCEnVa5aiPOoQDCNx+2MlyAwTlNccLahq5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822931; c=relaxed/simple;
	bh=Wna8JtgAJXFSml4zCECcWySuI5KK598dqkQNHIrvBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+U5eGxQrffazlFrYDJIKWT9zS+8I+xlE7mBuUQY0VlClUp/0Qo/Iwiff3cIoT5H0Cb4uY/1qnBmsXxbAUCbgZu5X9fcicarLPW80nJNJpNyZ6h3Oy6YQmGWJxcLbd3olgTZCgdZjbVhDMzPsUGfZPbw71GzME1PbJRXzY1IHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6Q36KCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0501C433F1;
	Tue, 13 Feb 2024 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707822931;
	bh=Wna8JtgAJXFSml4zCECcWySuI5KK598dqkQNHIrvBlw=;
	h=From:To:Cc:Subject:Date:From;
	b=e6Q36KCij9Ayeg7/YRQpxo20tpRc2JwVQLUClRX40VUtHnaN6R6YDWvSElfT3Vpsa
	 w09jmutGMszGhGvnShEeeGPSYRXCil9SawvLjzvY5EdteW2smoBuJtJ+YuZ4FNhbto
	 cX65lmwDldO98I/coM9mVSBExGgLFK4rNTc4qaikHoXqhsqabrhS8GeAQz2ozG5yZ8
	 +/jCu8jLiUFkCkeZ+BA2hMQw6qsI7cppjzW08MSnYIONRtwGWAnIAjguWwtGaMG2Pw
	 NqwaGGAbvdrgqbDa8VBZkHEjvde38pAhMObrT2cnR/wOHcCtH8LZuJ7d+LdYgPdzd+
	 pHsJgtD4y/0hw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] hpet: remove hpets::hp_clocksource
Date: Tue, 13 Feb 2024 12:15:27 +0100
Message-ID: <20240213111527.25218-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cf8e8658100d (arch: Remove Itanium (IA-64) architecture) removed
the last user of hpets::hp_clocksource. Drop the member.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hpet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 9c90b1d2c036..d51fc8321d41 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -87,7 +87,6 @@ struct hpets {
 	struct hpets *hp_next;
 	struct hpet __iomem *hp_hpet;
 	unsigned long hp_hpet_phys;
-	struct clocksource *hp_clocksource;
 	unsigned long long hp_tick_freq;
 	unsigned long hp_delta;
 	unsigned int hp_ntimer;
-- 
2.43.1


