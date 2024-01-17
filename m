Return-Path: <linux-kernel+bounces-28587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30352830061
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D69CB23E71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25988F6D;
	Wed, 17 Jan 2024 07:13:09 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D025CB0;
	Wed, 17 Jan 2024 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.38.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705475589; cv=none; b=D/b/HyI5Za18w6nNW2cRst7gnBkkd6ukBHbvnwMYxnbBZbbt4R2u6aMdrGNUnAU+Z+cmSpK7CtHWrzPnU0MCk4g2hhUR8k610mQYZDgweK9ik+S9qAiuHrS5atCMuqjdSIf8WVA817jJDsfDNSiEk2tn8oWdeTSzIBU2fnAAGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705475589; c=relaxed/simple;
	bh=VOPRzbPoK6eKabzYFOueNX9M9qUZqA8gbMPhJ2kva4Q=;
	h=Received:Received:Received:X-Virus-Scanned:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=N2dtafzipByPov7+iBVpR+a7dqJq6sINxjzQ2hhJUEawBalBS2I4kPxNsx56NN69dQ6WDDqAYIxOMnZBV/2EXbgv3UzLYnzTM+Xnxh5moGufq9Byv5cttkuAGdIE60tIlyIB5A0QS7XOSf/F3gnH6kWoLzeoL0SeB8OryAyChw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=217.74.38.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 506861867522;
	Wed, 17 Jan 2024 10:13:01 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DHjOdtHDzmxA; Wed, 17 Jan 2024 10:13:01 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 0096D1866B46;
	Wed, 17 Jan 2024 10:13:01 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z5YQWJPYpUoM; Wed, 17 Jan 2024 10:13:00 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [62.217.185.39])
	by mail.astralinux.ru (Postfix) with ESMTPSA id ED2A91863E43;
	Wed, 17 Jan 2024 10:12:59 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Markus Mayer <mmayer@broadcom.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value
Date: Wed, 17 Jan 2024 10:12:20 +0300
Message-Id: <20240117071220.26855-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return 0 in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver fo=
r Broadcom STB SoCs")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcm=
stb-avs-cpufreq.c
index 35fb3a559ea9..1a1857b0a6f4 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,6 +481,8 @@ static bool brcm_avs_is_firmware_loaded(struct privat=
e_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
+	if (!policy)
+		return 0;
 	struct private_data *priv =3D policy->driver_data;
=20
 	cpufreq_cpu_put(policy);
--=20
2.30.2


