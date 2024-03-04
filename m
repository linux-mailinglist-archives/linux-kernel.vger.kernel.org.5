Return-Path: <linux-kernel+bounces-91256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A06870BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3446B1C224FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CF28F58;
	Mon,  4 Mar 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Aa3J9sIm"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA09FBE4;
	Mon,  4 Mar 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585427; cv=none; b=UEaMM4MCmqtOEOnDS1OBB0my1hdgRLCQlPDe76tIr1eVuNOxWk3OkJrXij1myVG369+K7yeCQlDDqMhTcTbCO+vfAi9pzZMEzRK6ZVDy+2pFnawj9qqBMN8X7+nobi0VOTQMv/sgeZvMBUW2PhTLxR8kkEe2XQ9WyeDfpWxEQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585427; c=relaxed/simple;
	bh=Z/5HgW3HtAQ/58jEICABfUMoOPMnHw+/085ldoNkPlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UfiFjxMzfQx7HiilvMCoxL9uzE5sXSwP8JKySvSVSFPZUAgimusNJXbK1bCo0fu0KOwOM1z7NoyXew6Ic19I0gdT0Ya0C0Lkm3xdiFcKEN11YZicKyap/xjY3fK2K4Eh9BUZZ5vC6E0sFESulICTOlKQ6ISDP03j7IF0NjHMbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Aa3J9sIm; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709585412; x=1710190212; i=w_armin@gmx.de;
	bh=Z/5HgW3HtAQ/58jEICABfUMoOPMnHw+/085ldoNkPlM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Aa3J9sIm4TK0BpuhtOkmjN5H8nxCZ7ZHKClKx8Q7+TbZJ2rZmNjA9y/wx5+HTa1S
	 td1eKLwi/j9KOsMj3IgoE/pbb7081bJ3Dq5qn0IJMqQyPfW9WWl/T/BieiHKkzHI5
	 oNx0awHB0RliSEnIu8H31+CS2wS16vRMs1mrWw2nwOdv72ve+AqcbZLcvM6bP7XuJ
	 YvjFjXTDRFkG0W2JRQFwE3anchwQyq4UnW/TQCxsO4l7L9SoPKNeABOuuM8xdsGi4
	 nXfveE6g6Aqjm5nMlWWRkYa+mxMKnYyntds8H1p07pZBVMUzHw4X4zfj+NIn2V7gs
	 pDPHp5Le6Pfp0zCG3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MA7Ka-1ra4XG24bq-00Bbw8; Mon, 04 Mar 2024 21:50:12 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] platform/x86/amd/pmf: Fix policy binary handling
Date: Mon,  4 Mar 2024 21:50:01 +0100
Message-Id: <20240304205005.10078-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ItZxIaOHI9zA3jgwgJMiPNN12ANCBfRjzmPkIAa9XpBq7CAhMx
 BwerjIICj37wt4zp9A5FvSZ/2zVqZMdAHDoeM3w6fjXjhd4OATu5G+ST4Crg6w94c/sofGg
 8kIRQOii/y4CwJFfDjDyruolojBweYW6V2Mf7+79DVNZ7aC7Wek/GXxnOwqVSTRNJi8K2DK
 MjcvqKbFWJWZ6DfygPZMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uAhTHImG3x8=;1T20MSu35SJ6JnV/foM13kLVkec
 1RD0rSEoxYzDynbcNENGx+5Kk1A+7t0xwBTzfWuMSkemqULNMqaPVNqXwX7ee3pg/JzEZVHTX
 BfeQ/zaJfFq9WLw3No6clXk8cPAtfwlqC4l36ZZYzQSqqB5BOkCmMYhKkisNnQH9HpfzoVNdy
 R/aHqiHNruWpuZNsvd+OcFlniDqAMblsMnnGb9J38YS0G2BmoWzBls1UM4mA9wC3kStpINdqO
 rPn4O4U9eBy3Kqce7nFCvPHiwTcBsEgg66ZKgHYIOTyWjDmdxMKk33Wnrhabgqta6Gm5Dik+S
 XIvb4njeYJirqmD3naY6yWgJlRZalFd7sbxo4cCfANBaDj4uc+s6GXJw/pNwvsUuA975RJPaW
 c/xmAcrBOTiVy9JA+F6uN9MrifSK7c/0CzU+CoaZl6GvJW7Vh4uNrI7uY5OK/xY4yb1maOiGE
 gokdvZY6lWITg2MPFhLo422EuxVhqZ8VvMJn1E8GfY24XvqvFCYwp4MauDqJGel9rkkCufKS6
 p9XkCkelE5XUH9YOTXSACRNTjyqGAM7OOMfQXFZ+L0XTpTIz3EZTB+c7j02SQNdxyxB+rYeK0
 8vxnxSt/C23qXzkZoIo7Vnz0DZmdcW4rWynd9XY+EoanY4nByDJ2gjqJ1gQKTLZHq26fqn4sj
 ppY6s+f939nS2cvF4I4NjSdEpxq1NDP0HTgMDIs3xD1pJyjectIC/t5RGbh4CZCAbc00tQFV1
 MlOdlM3L30whZZTCyyq+ib+zCtaU06WbNQFtWSBbNSpPEkSvfqzSbsT7iEYghO+hJ1Jh1qvkW
 w6vZ7Tw1QEvsGwYTlhSsd6lvydxWwe4FtGH9HdDUf8tiI=

This patch series fixes various issues inside the policy binary
handling code.
The first patch makes sure that a valid error code is returned upon
failing to start the policy engine, while the second patch drops the
usage of readl() on non-io memory.
The last two patches fix a possible out-of-bounds memory access when
parsing the policy binary header.

All patches are compile-tested only.

Changes since v2:
- add patches 1 and 3

Changes since v1:
- get the full dword instead of only 8 bits when reading the header
- check if the policy buffer also has enough room for storing the length

Armin Wolf (4):
  platform/x86/amd/pmf: Fix return value of
    amd_pmf_start_policy_engine()
  platform/x86/amd/pmf: Do not use readl() for policy buffer access
  platform/x86/amd/pmf: Use struct for cookie header
  platform/x86/amd/pmf: Fix possible out-of-bound memory accesses

 drivers/platform/x86/amd/pmf/pmf.h    |  6 +++++-
 drivers/platform/x86/amd/pmf/tee-if.c | 21 +++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

=2D-
2.39.2


