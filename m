Return-Path: <linux-kernel+bounces-48388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C95845B52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EBD1C284D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CB6A32E;
	Thu,  1 Feb 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y8rlhkVK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D3779EA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800791; cv=none; b=iVqYF9C9xmSj0SNNl/0R101fyuL2rXOJOfMhl6FvHRxwW/WZH1rbhTjX9pNPyYc2eQpqlfaSVOqFb5eRZcRss6ApyGtPOPEw20RYs713WD+5tMfw/dUbTu19U9b4tE6FIiKXnVdyqF/LkVBUG/4cMoDqveBqjw2GGOSNtIRhTuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800791; c=relaxed/simple;
	bh=atE6eRegdz/BiaRQH20mz9rNccJ3IJb0I5UDSQIHy5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2cfKXBv6zsAL6wRtSI7lvpA1v+73qmmITNnli2pvXlH5u43Mu82kznHctpWyWU35cnTejM6hmkG1AbBrwml7ttZUE3ShGqienIUKjfRWGn7EItcRXI/S1ThOegcqsE4oiH6bdgfA3gCrmba/4sTqNnncNloE31cO6OuRK3W5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y8rlhkVK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC8C340E01A9;
	Thu,  1 Feb 2024 15:19:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HMImUzNma5oW; Thu,  1 Feb 2024 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706800784; bh=pjw6kYn/uDg011VqXwRJEPbupdiC09ecf8P/cyc91FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8rlhkVK+X2C+XSLekMtj+Gn/JfgemTy564P/vB/GEWjwoTAmML2L1auIcNJnnKGi
	 htcdMQcYblXVPUWuSkIGLgd+X6+ibrry6eZb0dlgYmQ3NOnuzHGBy11e4p7QKcJxeL
	 sJ4skbq0rFmq/ybnlV/qrwXpDdCLEZrHgYWiI8yjS6a+5+yku5Pi96fkyPEhBTnYUk
	 LiXuSeYSx8aYO1LaFQvEPSwVfw2bQAF9gql2WWg/lKiWafIAHZKu3xYAQDvphK2+12
	 r4Z73HuRKcCu0CbHgsknHe/MTTq4FqPsojWgswJvyuuIC3bzYE0nxW9W2Xi+XZkG5I
	 AIUAf9NF7zaDvT9o9JWnuN6ncVmCESIj7a/V/+YDB/D7jEjNBRUAODj+neb078U5j+
	 hOpSRHVW9yKlcKhOdjhobgBWWVYI+wrPKmHIEFwyaaNW5GbkTa8wnFtc59XK+qavh5
	 QO/v0PSuiK2RD5aT4MuAE8Z8t/6KxHUuU5fiVy0xV3uXdo3i+bOwHvBpM7ZeKmkY7l
	 0SSOyLWrSFzy+8i59VRlgc5N58tiT0S1efhMjhZxdTLlqjRh3tuCKHRBbQmjXLl4yf
	 Slz7XiDKgvLYOTmhmG2x7aE+Kyf3n08quwXVk8iHmOxe68BFbbIscJL5o/jdhTSMhW
	 0L0YKGgHdOzMmkhQEfop6oI8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC5AD40E00B2;
	Thu,  1 Feb 2024 15:19:25 +0000 (UTC)
Date: Thu, 1 Feb 2024 16:19:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 08/19] x86/cpu/amd: Provide a separate accessor for
 Node ID
Message-ID: <20240201151920.GLZbu2eGaGaENG7L94@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.813770902@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.813770902@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:42PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> AMD (ab)uses topology_die_id() to store the Node ID information and
> topology_max_dies_per_pkg to store the number of nodes per package.

topology_max_die_per_package()

is what I can find.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

