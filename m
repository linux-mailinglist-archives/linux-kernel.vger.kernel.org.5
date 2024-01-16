Return-Path: <linux-kernel+bounces-27398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFA82EF47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6CE1C2340B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C801BC4A;
	Tue, 16 Jan 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="KZ6SaCGb"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E791BC21;
	Tue, 16 Jan 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705409915; x=1706014715; i=erick.archer@gmx.com;
	bh=WqURBa1tPHtba6Jq6GlirP9uW1GLBR8Naqt998xfh+o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=KZ6SaCGbCecZ5uSlIPF9/YPTHk3YfLpocH2ZGLAyRJj7xYMMHPr6WklOR+5m1b4W
	 7HrraJHKFrAPNKAaRH7O08z9KbM09bDezYLbkg6RtlEZ1yEKl76DpWv1FC620OxmN
	 ggWiYQQmyoZjfoHrT5WQK7WD3KL+TLqTXgCgacS1iTvOzZxt7UfeZP7A4VQNvQKA4
	 1GDeC3tT6asxikb3u0YYEPAwAgQ8YevbQxt26vGptttmeQr6Q/axIjW4Em/l11l8o
	 RiKRl2ITlg+SVB3bksXtJH7tHhteXmzKCLmo5kYrLSzb/Zr20Hcr87Dlid6PFlC16
	 Lv8HFjlRmHP+AkBwjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MFbW0-1rLoSi2eZq-00H5tr; Tue, 16 Jan 2024 13:58:34 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	x86@kernel.org
Cc: Erick Archer <erick.archer@gmx.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] perf/x86/amd/uncore: Use kcalloc*() instead of kzalloc*()
Date: Tue, 16 Jan 2024 13:58:13 +0100
Message-Id: <20240116125813.3754-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TVEwA2glfLpDSznvFi1nOPLs8BGM4B0IRF4s7tsTlwGjHIW6e4d
 girJ19eXCtnEnKLoMCOiYnHnmgUmwJs865H5HLOr6ChGXDSSOX92bbpvT9JPotMl4Vk0n7P
 4J/7aebYWPmGzn8Jg3l80oRLsiaUXXGbgYIC3NOsCZiuewm9Mb/F0ZUXvI+cjaHZ2e/AjPI
 sBMHryAfCqlxtkZvK/Lug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vhga32RZi1g=;yz7ktIwQ63rJtHBJB0vyghWpQyt
 /ejawrygnkrG0gM7Fs3hT08viZFnKYKqAglIygP4TDrVsk6fPk5vqnakrdrTVmOd4DU1KCM8U
 HnyeuxtyM5nNX7Poqn3w81O9X+Ihf/CkQokyS9k3R7BV9WgS0//35I8gbxpd9HoMjohrYx5RG
 7ro96nixmU93+A2fMsqOtm4y8wbIXKaypSwIulUz9nw6TzaTQjebmM7oSrzIPbhRZU4CBvhFI
 MioszZBetHerm0UsqFCbZ0fizqP7cY7RhhAlTiZl5ZSJEo0XrMQA9MBnzfNexBwPoxAyUGH2n
 l8K3JGdgOe6QgY7zRAXrx+zQ0kLgPkIDZXp5DQzV3NuPt9KC/Kmz+nVsOAw/GJ6sXaHoz+xRI
 2rJuBzfn1Zfb9EA2aWxpvvxXnMX58/5LKONGH7mnVUWtQ/tGWbouyW3zkCx98xfMLOGeERgbl
 PGpNynvBwV+AF8sJNFNmyvv2Elx7vDih0OXWK6x4up4rFsN/aYeYDHCNpriygeZb1W2iY7qBI
 aVpsY4HfT4kietZw/TKRb7xVm4gp6yfKNawAT35OAtZqB5jxzKFRY4jMWu46CGe1clcPEJXUV
 Yii8i3jrdoUq2X/r3uRQVkwo1Q6EEixqcwcACt8yLDCKWe9H3nOvoQhDcZLiPSa6GmoZCybcC
 yLZaNnV+F33NPMLztMOXKuw40fMTlEhkAmtplNsOaX1yj4untxbTtGoTSEduTrtvUZvlqSBqr
 1eT4ADORX4lt7j+RSYEZd1/5SxO/SeGM7wI/yNPhlvg9Tamp06F1ig80CWzsf6SGM29f/0SMz
 Zzb4fsNtoSSvlTurs3B4+VEepk90Q15CQ/d3gtE/EYrAQTmPTPJVe9ygOdhyfK8XKsXTs2Kcl
 9yz06o306nDe2gNTfh5V32zSFw83o9r3HLdnp5tepZHA8SjquvDosoi5+l73aOyIzlY+iHEG1
 iUw6Hk8P6ZwgA3GfGQMWCCthyfY=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc*() function instead of the argument
size * count in the kzalloc*() function.

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-code=
d-arithmetic-in-allocator-arguments

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 5bf03c575812..9073eb0613cf 100644
=2D-- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -479,8 +479,8 @@ static int amd_uncore_ctx_init(struct amd_uncore *unco=
re, unsigned int cpu)
 				goto fail;

 			curr->cpu =3D cpu;
-			curr->events =3D kzalloc_node(sizeof(*curr->events) *
-						    pmu->num_counters,
+			curr->events =3D kcalloc_node(pmu->num_counters,
+						    sizeof(*curr->events),
 						    GFP_KERNEL, node);
 			if (!curr->events) {
 				kfree(curr);
@@ -928,7 +928,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore,=
 unsigned int cpu)
 		uncore->num_pmus +=3D group_num_pmus[gid];
 	}

-	uncore->pmus =3D kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
+	uncore->pmus =3D kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
 			       GFP_KERNEL);
 	if (!uncore->pmus) {
 		uncore->num_pmus =3D 0;
=2D-
2.25.1


