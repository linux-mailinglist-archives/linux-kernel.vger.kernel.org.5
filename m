Return-Path: <linux-kernel+bounces-105478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9D987DEF1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17F51C20383
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCCB1CD2B;
	Sun, 17 Mar 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="DysYbDhZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA91CA87;
	Sun, 17 Mar 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693950; cv=none; b=cZJ6lfVQABPEtgDhsz3othHGq57wiyU2VwaqZGPd52r7zInfqia+IfUy4/B6Hv7oAlRTMtq7A5Yh5RF5q2tVXo8onZqW0y66DfkjNTlenN0MrhMpYgVvSRwVF7ru9VkOExToPQJItymSwGwTVnTaY2No4zk2EAHDWuFYb9MK7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693950; c=relaxed/simple;
	bh=JmyfqcZ9rveURC80934OGXTc1tUYHDkAD0mq8Ba4PUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFCZrCnxqelry/O2Xl2FOoRSbigJqyuV/tp+PLLAbDGZJUbLCP+G5omDGzT4xK9rD5iC7MapR86zUsqQU2BjtAfLE9mkY/S56iQQ4xsM3KhBqpJlaEFFF34IaaDJaU9maW6snGlOfaqSc9A2Tn9J7VnTKqE0ZZVrjumebrnTb6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=DysYbDhZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710693896; x=1711298696; i=erick.archer@gmx.com;
	bh=9dENW7lkC02jCQmaFHSQpWO0QOH344xVEESWeXRZM2M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=DysYbDhZlkaU8t1lblTQfQPsTsQWjmeYw4nw2Bl3YOFq4c2gCWVP4PSrdvqbYkOZ
	 8x/DUiCmr2M9fRNGEgv+7d9Iq7qH1U5AbPuKWiC6/7DhwASbuEbL04mI/rR7TetVr
	 V1jIRBtC7YydgBabDG5Lc9naIIS94b9IWcrQjUyanL3w154diu/K7UIn0QKaJG8sD
	 OuyDgJkkDgWGvEaXpELvaHPXEetPdUwOA76QEUuBRZO+8wX2M23tvOf+f/Nbdd+6q
	 mU0wYZjIBJ7NqZ2RCMCLSGJ3Kxyh+gBLqfRxsBCiUVv6AnUPKMNuTP4QN5m3UVux4
	 j73vyVdXP6cd0+jnVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MSt8W-1rM8W93TCg-00UIsL; Sun, 17 Mar 2024 17:44:56 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] perf/x86/rapl: Prefer struct_size over open coded arithmetic
Date: Sun, 17 Mar 2024 17:44:42 +0100
Message-Id: <20240317164442.6729-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ajPSlJa+WR0Lwl/WFfEBfTaAzg0kY5ItjAZ4jUMUfFOTkZ//Ic7
 moGQkxW4F04mwQLljWIOQZGS8HJN/Uv/rWK6mGOper/373x05kACNGae16MPsnk5oMMvUiU
 eyMIQLXfAzhhOUin4A89fynazI2HtP49mmpPSDMGMeiIOp9dLG3zLkfGaORwdThnuLvFc+8
 HOTMRykgcp3oU7UHsGcKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MMkSt5BKAXA=;fKog5R4YDcS7MPlrkxrnA2VT54/
 mpNlQxxU+/lPTHlhUXww7M7kWgPGZje8YVqRYzN1vbnb2sJ3cGTJs4kiKXBXZN8lcWnYb7wDX
 UIj2WTsilaLsXQgTiq6c2kBLUnBp/xpIO27hp+nxpVLI7TUnWOKB9TotWU/MW+i3N2Yx5sfvT
 lF016C7mVDq2LpQhacPJlKB/tvlaz/pC0ToDxi8v213TJvdXdruK5oDRK6FzS85JDXOzxVumY
 FBxfMhwShgGrKkrX+p3385wJ8Y0VXKArN56aVdiqn3rOdg6CsnLufgwtFEt5w4ZUgR1cp4Q/G
 5AuemfszEOVS6mBlI0XtHtW4jKen16ZRr4KtYnSdtUQlJhfuG9xYW10GYfqFjhINEcrueFqMH
 /SMSnRTmom31e+wdNQV1mxhsGzb1nZtWva5Vno/8FQIAApAcydl6NWfXyFnpnsYdfkc+EIVYj
 sYNxvppJF6A3BIID/X/T7zOmxv6X3SLubPug5oebaRIZonBDJlEiXM4aDD7pHoLzaitwA2PWv
 mdNeH3APg0oelZX52JTPRp2jsiwXpLYFkEneHx3FR6RNxY9MWBbffCzTj0v9AUJ99tqpEEmrX
 Y2oL7tMd0E5tNcvqAVgVr7ZUGTH9c7LC2v8DYcK7aaHBr9mgkhV7mPfUKMOW3vfrVRdgdHMJR
 wRTKMgfWDi78EuuRvWV14m4B+yWJ4r5/D4sCuzh7iyWwUEGzkuUHgqr392bceXEZGNWg+Nd0U
 yGdNBTrffxjzFaXy1iqckgFgMtIvp66sM2BHVeywD9zQyda/TMGiF1xHJMRMGfmVHCOq0zc+X
 dYwD1CWOf0LcTwsGp22HF5Nu6ZDV9OG6MFV4njcA3Dzhk=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "rapl_pmus" variable is a pointer to "struct rapl_pmus" and
this structure ends in a flexible array:

struct rapl_pmus {
	[...]
	struct rapl_pmu *pmus[] __counted_by(maxdie);
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc() function.

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 arch/x86/events/rapl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index fb2b1961e5a3..8ef08b5d55a7 100644
=2D-- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -675,10 +675,8 @@ static const struct attribute_group *rapl_attr_update=
[] =3D {
 static int __init init_rapl_pmus(void)
 {
 	int maxdie =3D topology_max_packages() * topology_max_dies_per_package()=
;
-	size_t size;

-	size =3D sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
-	rapl_pmus =3D kzalloc(size, GFP_KERNEL);
+	rapl_pmus =3D kzalloc(struct_size(rapl_pmus, pmus, maxdie), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;

=2D-
2.25.1


