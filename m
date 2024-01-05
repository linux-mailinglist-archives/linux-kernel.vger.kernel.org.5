Return-Path: <linux-kernel+bounces-18134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F6F825946
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD359282E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58C328C2;
	Fri,  5 Jan 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lq67GxWJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3A321AE;
	Fri,  5 Jan 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704476573; x=1705081373; i=markus.elfring@web.de;
	bh=wS6PsNt2y18wBuHSYkuJprLzMZM4lOzVE4kOejHdGJY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=lq67GxWJRGfWDFM4hyAkBMKMcaHlk13zd6znpFgEpJpfUlLXls1iWoacwPmMzlbw
	 NusFy5rCO0Ep0RNpefUSE4YLq3a/KY9x5LNPGfmqkNPNZ7bJNDPQbQSvdXT7au5iQ
	 KwadT2y4CxO1taJKxbo3LfI2V8H0bDSoeSFf+JRwo/iOaB09W4O2mnUoIvjmEbZIE
	 JzM0vMa6GmvlUHjQuJtiJeosOJAIDMErIE53ks7rQ6FSf1VR2wh7sYLnG4ZyeHeI5
	 xaf9H2r/NtUV/Y5W6L1u70UimZt09lH7SokDAjSh0XfQIhkOJthGUAqz6y1ITQ2Os
	 y/KxE7HuG4jHHrxq9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1qsjvv1WcA-00oMI5; Fri, 05
 Jan 2024 18:42:53 +0100
Message-ID: <ecc3a3ea-e199-4d57-b244-9811b5e408e4@web.de>
Date: Fri, 5 Jan 2024 18:42:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] powerpc/4xx: Adjustments for four function
 implementations
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
 <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
In-Reply-To: <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zlLBn14E+TDhGhUEP6jHPfOKj+JOryPQzEfKwTZPn9VnLpoNOWk
 povpIOGxci93DD4OQ/nyOXkfEbUxDLyobedMEKhL3zb+nMzue9M9TR3B7R3nzWvgszWO9SW
 EZKE7FXceD19TgMmqAGY7VJ9VK1HZABLig9YT0s58t6k8V52guQycNjO1y4cb4TMY5IvGl7
 AS/rulsxSv/Kya1J0AXLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a/PxcM6gL48=;hh+akCP6GjvdmxP77qr8CwY8Muu
 l3Nx8PTqKpbr7FACJ91WCKUmGSyEsJdKzbD0rd21/mAmN8LQ5riMx+yLrvNYv/uDN2SjaVvMt
 Ldcj0yZgirw1rpno3hD8mGQ2jLp0Cq/2CTXwgd9B4IqoGqkvcviOuLnPCJLG1HCYWEbxYoV0L
 UuEdwG3ktj9bA51saHYDq8i5qk8wE3cGu1lCxWHULJ0feMroT5/q5inhUvGKIzXyepfAUMObF
 xH/M+oVrsQuXW/yqBfTvpdJeyGLkv3hBnrR+1hgIoklym4WWHPKPj/iTLVSfxwVya3+RggSUb
 SUA/3xa3TX61JKt2DZ0EMfKTnT7uPIYgLzuY+/p45BLqhSDJXYER87iX3/eLmO8pe9Ot856IB
 CMvSV/k/tDR17WUCCuFY1OI+MFKcJQHVirSk05JCu41VeF3mbpn0PxlcVrSpdAChj9/PGdlQt
 PDAubueycD6xze5PGjyqNGHbNl/H27p2574LNrvsz23xVjsh956o9Hu5UKLHwLM71eQBkeTkH
 JEo2tgYJxh2nSUvGKtVd9EgZCuSY1rpPbNklWwx2dfenIWf0gt5KU4AC6cAKF4buACL8EDv8T
 yAuBpHRmN7X3GEvqb8+xhQZNLygtP65zLDItZGik9ApIoawowVDPMb/J3vvOU3k5VsN6NynGm
 GXrATSuC8IXzu5a8kUU5HFy5kGG8ykb6fhCS5NFRYQD54vBiGbQjeLLHf6vlal8hzMkPMyBKZ
 WkLQdmmT448o8OHyKVid5M0oqmIThs6XqlPc+wjR4i6hbK50RJX11NGSHaWIs+y8gwudB+bwY
 wESX3Vq5hgiVTy5eGW9iZ1VgaXC2/OBAo7e3TZAAKXe+7pXq6kBfWQQvwCOmiFrN+m1PuVlCg
 6sM+tW5LQ5Nh+RDPCZUUwvy4UEQnTJBt40QJNb2ch8kKYiFvbY3xZKhWFQx4ko2xzGy88Vqsr
 /a4h4w==

> Date: Sat, 25 Mar 2023 16:10:23 +0100
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (4):
>   Fix exception handling in ppc4xx_pciex_port_setup_hose()
>   Fix exception handling in ppc4xx_probe_pcix_bridge()
>   Fix exception handling in ppc4xx_probe_pci_bridge()
>   Delete unnecessary variable initialisations in four functions
>
>  arch/powerpc/platforms/4xx/pci.c | 69 ++++++++++++++------------------
>  1 file changed, 31 insertions(+), 38 deletions(-)

Is this patch series still in review queues?

Regards,
Markus

