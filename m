Return-Path: <linux-kernel+bounces-10583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C00B81D67D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B016C1F21C90
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2015EBD;
	Sat, 23 Dec 2023 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kJHR+ZFF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE912E5F;
	Sat, 23 Dec 2023 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703363420; x=1703968220; i=markus.elfring@web.de;
	bh=CkiadlJnceiWb4wDxQjgDyAYKO3sigBrvSKQufUjwtQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=kJHR+ZFFUvcx4ZXEZHizmsrOcZkY5mcHXI8p0rI2tz7HBYkMqUwrIRIB9MXmQ6XV
	 QML7/ikykymwmL5EbkL00RHOffech4O1Qd2GI1pvQPya1fTxmERvBHZMpyJ2QsG0y
	 r0VtsG/7YnT5RwuUxByv/eWydQyHlXtlwgYSleVYoNRC0L/Ps/1cH90DROk6Freiy
	 biOx7SiOiA8lXquf6lIxSzRm+YRcEAm/zS5ScCMkiz1jYolRHy/CZxDfCOvePuxue
	 2CpFuWsfMr+p6psAlhtvsbS3g/b+mUN7cF4qnTAhcJC+EOVv6WauuNz/lnPNs7hQJ
	 a5hdZq+Ryy70YE31xQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX17-1qpXar1c0L-00j9SN; Sat, 23
 Dec 2023 21:30:20 +0100
Message-ID: <5b38ce71-3c76-4efc-a688-6f2651f93b6d@web.de>
Date: Sat, 23 Dec 2023 21:30:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] perf/x86/intel/pt: Return an error code only as a constant in
 pt_pmu_hw_init()
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xPGwYXpbcPGu2+M0VdwPQ7SUF0a7M37z16ssBjvgoCPi+x9tAoO
 NvQZ1g4SjMgDz4Ava3z+cL6tjUVRgCTDRTWYi5SO6+wiAmHZX6EnbAjVGCH7dW7IHiaSj3z
 ixLweZnePPhXebrte08ntjAtgJYFTck9lLBDVlGoQyqQeDOytPBAfzQr5wchziJY2dljghN
 iSuUCfIOO6P7BP0buSvRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+SMfoYLuucE=;c/mPHW8OJcA3zTVCoyoYFJeALSM
 ZvfjHlnns9cYViZmfJpVMKTY31aF2ERQpa5xEcvlV45JG935oc58SmkfMKKfoEOgbC1ZY4IXh
 LQO16NkMeGI3PgGc5EG0LxvJYCOkTmXyYDpxVMGZlNFYdckX8gdwWjvFtGkWtyTqvskLO6aYA
 DAwQ8+fWP/4qBps6HdOXn8LoN+cDy6b1ipjdoXby3ElBvS+i2PRnqFlqLn4VSDOmyfohWgTS0
 8ZaUF+RhAVQbtiUfSnz6B7kvTO9WlJMOkEYIhUxRm09UeBPJ/Tq5c0HYBdTvkrU7g+S4SOO8H
 EnHiihcnVCSEpNjtVd+aI00BGqip06aI2lVLW+lamYW+tUkb00gKUrwF+GFhvBOPNJIMOHHmU
 1YFIEKC8g95QAtiEDfjGcedkQK4Gevf+jYk5owwhdtVqiOCwvp/rusG9W/oPehAUyGG10tkf0
 +FcSKqVbrTzX6WiViXoYgY1AqVTQcww/aLc+p8fQTg4VHh6KOih94YSz5jW0674dYIiaSfxEG
 n758oBn8MkCPcj2Wp64mbx3gYKY+B5bwHsmPXtYCvUcKC7LKu/EZEkLs5oZJEfd3NJEgj7lFi
 aODCc5JoltK2rrHuywY4nGKA5JgNq/JVYxjnM7wr9FV0vxPER4SCo19FOBBll8nAzge1HNmhd
 UYppXorGtr//W1AAuerUj2Hx1Ha6Lj7ECEueWLhIlxV6PU8z8AqpCxC9HtAf69G2CHSqC5ASx
 nc47PsRqx/Vza6Sj99uXUyxqr63NC6i1JaAphwL+xq1kP1V+KkozWQdpEIe/4J5CgbHEym6YN
 qpMjL/kccAFya8Ma+017jgPKT5Tk4i9rJa33XNWwwNdpNRrxooeoCAxvITQnfH586G2cCFYRq
 1R4VNboquWKAwpxhYn2OB00+VJF3E/rYx64TTh3MSZNi1xo0Zv8Yqla8/it+3MycVEsuwx9XT
 T57zjQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 21:06:27 +0100

Return an error code without storing it in an intermediate variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/events/intel/pt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8e2a12235e62..24fd18e2da34 100644
=2D-- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -190,7 +190,6 @@ static int __init pt_pmu_hw_init(void)
 	struct attribute **attrs;
 	size_t size;
 	u64 reg;
-	int ret;
 	long i;

 	rdmsrl(MSR_PLATFORM_INFO, reg);
@@ -242,11 +241,10 @@ static int __init pt_pmu_hw_init(void)
 			    &pt_pmu.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM]);
 	}

-	ret =3D -ENOMEM;
 	size =3D sizeof(struct attribute *) * (ARRAY_SIZE(pt_caps)+1);
 	attrs =3D kzalloc(size, GFP_KERNEL);
 	if (!attrs)
-		goto fail;
+		return -ENOMEM;

 	size =3D sizeof(struct dev_ext_attribute) * (ARRAY_SIZE(pt_caps)+1);
 	de_attrs =3D kzalloc(size, GFP_KERNEL);
@@ -273,8 +271,7 @@ static int __init pt_pmu_hw_init(void)

 fail:
 	kfree(attrs);
-
-	return ret;
+	return -ENOMEM;
 }

 #define RTIT_CTL_CYC_PSB (RTIT_CTL_CYCLEACC	| \
=2D-
2.43.0


