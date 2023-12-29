Return-Path: <linux-kernel+bounces-13186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07458200DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F72428445C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55512B86;
	Fri, 29 Dec 2023 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jq4jNfO5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C212B6B;
	Fri, 29 Dec 2023 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3EA5340E01A1;
	Fri, 29 Dec 2023 17:32:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m2923ETygnOY; Fri, 29 Dec 2023 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703871134; bh=y87yQhMe83x84E0oJ1qSJX5sTal91GOtJb88CpisDUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jq4jNfO5TGWOzoOTlCXEFyGTZsjEyWRS87OJv8lURWOHq9QBUmJ68acO4kdkIBa8t
	 elweZLvEBFg0Q3aewJ2yN8df65K4Sv/5CHq4szYv2QGrbqZOqnrN4n7PJ51wt1FKRO
	 Mc1iAGaxrQ1DKxZ0iFw8u6BA5lAa/td46+GzsbPUCyxQNJAf+7b0BYSNA8/bNVf6wB
	 kjojOJEfCbQePUkx1Iw8VZbgqDO1toqhgiUdWH8Bji8itcp1FulEq8H1+PUZV4KUbT
	 zbC91A2s1vQUF2SRFU2WGhGCW/BbG7ma+H5sFIxgfOfmcfgLjNlbjS5MmBW6mc7BJ9
	 9R72qiQDA/QOg5plHJW//K5v/lMXVEdcNszjf6PSnNdrXLM56xziatct4SxDmNAl25
	 MAFlAizFZDRaPdM88zWZs+uuL524LbmLwMp+4KJp+FUjsSFmSJV2SajjeO/MYZECLd
	 TXTK/m1tEJvwgeyUhAVQezF1aUkO/CCG092USbyccaiQvAXN+ijpp28PCcP19z3rBZ
	 G3qIg+skd6YxF5aSOdLw0eFgsQ88KSgh4y2DoFdcZy1hSttDMIFAZzYfIQbUTgYkev
	 7TDOrPAusdhIQ+OnrmIl0/XTZ/aLEH1msVk0MBZ0Yt5BTGQmwYNv/uofK2tNP5oxNL
	 NKMdamG06diNmdAFQN3hfOw0=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD1B640E00C7;
	Fri, 29 Dec 2023 17:32:09 +0000 (UTC)
Date: Fri, 29 Dec 2023 18:32:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, forza@tnonline.net,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: haltpoll: Do not enable interrupts when
 entering idle
Message-ID: <20231229173203.GFZY8Ck4tVMQJyWoQ2@fat_crate.local>
References: <20231228145416.GAZY2MGLY6THMkAZ2W@fat_crate.local>
 <CAJZ5v0j3Wb-9Czb50u=NWjNz-W8mgMDEarWY7XG49d+LdzKAYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j3Wb-9Czb50u=NWjNz-W8mgMDEarWY7XG49d+LdzKAYw@mail.gmail.com>

On Fri, Dec 29, 2023 at 06:12:36PM +0100, Rafael J. Wysocki wrote:
> I would have appreciated a Subject: line here.

mutt uses it as the actual subject if I do

mutt -H /path/to/patch-file

since I want to type in stuff before sending.

> cpuidle governors have no ->enter() callbacks, drivers do.  And this
> particular haltpoll is a driver (there is a haltpoll governor too,
> confusingly enough).

Fun.

> Nevertheless, applied (with the changelog adjustments mentioned above).

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

