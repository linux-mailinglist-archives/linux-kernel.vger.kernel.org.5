Return-Path: <linux-kernel+bounces-162257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C028B58B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D3E1F24906
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C410953;
	Mon, 29 Apr 2024 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NusVyk7t"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF4322E;
	Mon, 29 Apr 2024 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394315; cv=none; b=o+Lbq8AdRg7KgYYZ2f5M7LeEpYTYIZAWjVHkhJeHEiWrqbwaXwdEEDhhSErcCHJJwK/klkZd4gZ0Bw2krsbe808Cy2WC5dZSSJ4q8lg7RyVKENgH8YBvH9vzDHEXspUrY+2u/7RQoS30Ov4aPA66k4josVuOtx2t41BfmFWaBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394315; c=relaxed/simple;
	bh=v4UXMKorrS1MWpudNhezId53qq7JsKiY5JAW3oUdBZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfgWkN9iv1FrVbRpvnUTx5KxxcWYJkg6ix4viOGIgRg/tZOxi/kjgXc0z3YN4NmP6I5wREoJM1H6x+QMXV846aiZYQs1CzdbJp/v1lgvqL0xIYhCIxZuE5jhoEm3Vff+BkEP0SipI+h6abfNFj6ModnOT4hUwlR5LJ8LTxpPkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NusVyk7t; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFA4F40E0187;
	Mon, 29 Apr 2024 12:38:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id usRaInnAyky6; Mon, 29 Apr 2024 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714394307; bh=uBo83RXsgIKfYIzl0qK0twOO+iMg1Pp04mCeg+L0u3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NusVyk7t3e/4AVJvzRmoo/WpHndXOyrDyvqq7AIfC805pIVSuCuy77Lxo9kRaxz/u
	 WcKT2ZCfdBVZ/wkfqmgBjJBF6NY16RdIYQG5OkVX1UdC7/6A59vyoXDKUHKpTE/eXj
	 F3CBCjmPVbYauhBW792GJNVScgvfWapxRHZMc7RCuaA+TSJ49p1ca05dwVdqPD8BQh
	 flHDxZIM5cyl7C+m+MO7LPdK1V2mlfcrxrDs8DWsKR1/JKUXGjzPvIBpdgVeRilcb0
	 d7QpoJ0q83Vkzv3JZTPfgWB4FxOgZPkFX0zqwLm9/7JGHEBomvQDFcp7JZJTLdFc0Y
	 k8ww5GlMbdkjbRi8Oj6A+x4aVXK1KiT0ZgWiGp3jgc5ZH5kjMeZWiFzvT7SeTjbYOR
	 rv+0GBGKjVVvTjjGd3hwj6l8EHphZVT4QMxElMXdUKUFkglyDb4+WIQM9KYa23lplh
	 W/jnrNz97GdbsFkG/YMEgxeRXLZ7DXhDnLwNOxShE4sgsrjTnIBYolQ8HXsKD0NTW8
	 JpRnlWvEqdoFQXcAPXv8Km19/MPvkFxHl3VnQOE8kGxlW28uvS7HuwxkCvvfn1pfoD
	 ePYKV2ZA7HojMw2sLASUz1vrWh1/8Yv6sWSFRJJ57WNp/T+vIiAdjz4AQeXiR16LhJ
	 o+Kr9mEsrVANE+lR4st9PAr8=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06C2240E00C7;
	Mon, 29 Apr 2024 12:38:19 +0000 (UTC)
Date: Mon, 29 Apr 2024 14:38:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce/amd: Prep DFR handler before enabling
 banks
Message-ID: <20240429123818.GCZi-UugM5_UFHm7es@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-7-yazen.ghannam@amd.com>
 <20240424183429.GGZilQtVJtGhOPm1ES@fat_crate.local>
 <190ec43d-bd44-42a4-a395-f278f97748fb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <190ec43d-bd44-42a4-a395-f278f97748fb@amd.com>

On Thu, Apr 25, 2024 at 09:31:58AM -0400, Yazen Ghannam wrote:
> They are independent features. SUCCOR is the feature that defines the deferred
> error interrupt and data poisoning. This predates SMCA. SUCCOR was introduced
> in the later Family 15h systems.

.. and as we've established, it is not really enabled on them for
whatever reason so for simplicity's sake, we'll simply assume that it
was enabled together with SMCA and that would simplify a lot of things
in the code.

Please put that in the commit message so that we know.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

