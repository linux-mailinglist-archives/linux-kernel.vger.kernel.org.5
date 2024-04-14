Return-Path: <linux-kernel+bounces-144049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852B8A413D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F021F2153B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F151B95A;
	Sun, 14 Apr 2024 08:34:20 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99C4689
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083660; cv=none; b=rAJWk5/bzPIzGm7OItpOV83HPCu/jBeCiUCzu6Nm9aeLaDrifoUebYqHjbV0x36Jbp4rb2CPGWb4JiUPa6tYtjPJFjYcY4j9ZavYbP9ktYCJLiluyMhduv1s77BK0Ps8l2E+yw05Lh2H4HXKAYE3uhtrnhNArvD1B/7dnAGmLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083660; c=relaxed/simple;
	bh=ZmAIjSzcFfDjoTquD/K8a25ft89stMkxMjIVNSqucwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kynAUr8TQlmEW94YUUCcNNnKre4QewLKUIXsbjKlQSoo+wEV7HEoKFXs2AzmSVGxgzWh7TcmoN02jX89EEZksCn3pfLbESxGHIXTb4Fckgnwc03pcEOcIFDVbpBwXaUpVeo54CTzbGG1C4PU6B4hbpBb9hXEFUFmOtGt/SjEK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 280EE40E01FF;
	Sun, 14 Apr 2024 08:34:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sn3DNO4raZsw; Sun, 14 Apr 2024 08:34:03 +0000 (UTC)
Received: from nazgul.tnic (unknown [212.23.229.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B340240E01C5;
	Sun, 14 Apr 2024 08:33:51 +0000 (UTC)
Date: Sun, 14 Apr 2024 10:36:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>, x86@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jpoimboe@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [bisected] Kernel v6.9-rc3 fails to boot on a Thinkpad T60 with
 MITIGATION_RETHUNK=y (regression from v6.8.5)
Message-ID: <20240414083626.GAZhuViviWKudQ5Apm@fat_crate.local>
References: <20240413024956.488d474e@yea>
 <ZhpOIeVq1KQXzjBp@archie.me>
 <68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>

On Sat, Apr 13, 2024 at 11:46:09AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Boris there suggested: "perhaps we should make
> CONFIG_MITIGATION_RETHUNK depend on !X86_32":
> https://lore.kernel.org/all/20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local/
> 
> But that did not happen afaics. Would it be wise to go down that path?

Am looking at the whole thing. Stay tuned...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

