Return-Path: <linux-kernel+bounces-96730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC098760BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860A1282BB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BF53385;
	Fri,  8 Mar 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gE/ITZH/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316D52F98;
	Fri,  8 Mar 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889441; cv=none; b=clwJYTZgVm0VyunMi4CTi/oWMuA8oAV14lYryv42PmCWur4OG2KPp+3AS+WHe6DhEhxTJlQd9CQiu+XOgCuipoDfIUL/48hjcHRYwkQxr2XKIxsvHVzekJG89N2+Xhcvm5jKOYsJ778rorydTmcw3ZoRuaALeL7O2G30YyKB1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889441; c=relaxed/simple;
	bh=FhoXnmbvJ/5Ze5LmyD3TLnD76vV2iEIiuYBq7n4hA5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc3md9jAmk/ECd5wE5PSAfOQmA+f1Hs/HpvhDxAg9Bxbx3+RYV47/6pYMiz50MGPv7ErCfuC3TcdjBb8eKZPIEmjXV03JcWKUHGOn6vlw3u5Pmsm5FY/ctQe22KIZO0/8Xhap9FBojSmrseiqQsthJFZTJrGChmtOGP/p1ntq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gE/ITZH/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A0F1940E016C;
	Fri,  8 Mar 2024 09:17:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id coCnuob10XuF; Fri,  8 Mar 2024 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709889434; bh=rLdbM51hSGI1Ma2ufrENxid6dczjAu6sT0Aq+BYgJqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gE/ITZH/UBUGSX1Bk49cyH26HZBbc5DuNXtsPYkIs28B5gtI9niplQDMOgIoiGbfM
	 jiK48JKuVnaklGnMPaqlT4qt6AhHA8uSyMY47PeTOQXPJBLjqnp5bDTe4TpzZRJvxa
	 +7g9Z8XGTPn4ZIbP0HYi8SgOvdtylbprCRwECdeXsulezqIniJdG+PZg6Suyi4B050
	 oPXiu0qAuDwBiIJSCJjZ5G1npMRE1EaMSHlKLEPqnGYQDsbs36rdPkhZCLEeWlO96v
	 Ls1OnvRcI+RTql4xKc5JfqXE7duAs2DxmoNaDFoXjs63DC/JUbZlL8dJpHUtaf/JY0
	 Fz9D9mKOtNopiP4746nuo5kfH79Y44edmE2X3iQFyQaLhb1YjKd56tvGcSLS1ulGZF
	 qDexEvfl/cpv0TkspPYR+9PrjbrSNX28QmZq4+IP/3CkCbsfsiUdemPH6MuMXV9Lpy
	 NLzrt8C80NynUPjHzP1wnlaySiUvJ7DAp7b9hAX50e/KaNmlZcj0zpzScWdJ1M2Gjl
	 JyCm2k3r6UjWzQYpnh+jaYbUEpz5d9UK8R1ZICu7wS5gv3BfJuGr5zPQjZtyKN5Rp8
	 H0hnh0NnOkXdUJpbVK10VDcb+FV1SSBhdVZzfTYyQD9FCozn0elqLmpnXvbiNv3f/R
	 edKB8XKAteWQ7LCCL8/f2Lxs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F286B40E0173;
	Fri,  8 Mar 2024 09:16:50 +0000 (UTC)
Date: Fri, 8 Mar 2024 10:16:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Douglas Thompson <dougthompson@xmission.com>,
	James Morse <james.morse@arm.com>, Jan Luebbe <jlu@pengutronix.de>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-edac@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Robert Richter <rric@kernel.org>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 0/7] EDAC: remove unused structure members
Message-ID: <20240308091645.GDZerXfQ_XIKq0CKFL@fat_crate.local>
References: <20240213112051.27715-1-jirislaby@kernel.org>
 <c46cc960-1b7c-4e61-977a-f22ea5fdd944@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c46cc960-1b7c-4e61-977a-f22ea5fdd944@kernel.org>

On Fri, Mar 08, 2024 at 10:01:14AM +0100, Jiri Slaby wrote:
> Any plans on looking into/commenting/merging this :)?

Plans: yes, time: none.

You're on the todo list tho.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

