Return-Path: <linux-kernel+bounces-119008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD388C293
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B23D2A5330
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E86D1CC;
	Tue, 26 Mar 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qr888QUD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F05C8EE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457420; cv=none; b=LG/0EVxzDyFMM+ZWGD+zK6jIbny3xX215m8aWFhBzFjls6Jmpt1vlkuymP8568jhD87VLNrNicJ18Y2EaWqx7aRfOAAUGuf6Fda2sWo/NPPOnT/5ZrN/XdzoMKVxkvpFaI9CEilsTHV/K3XHlkx6/C7BrRnGgZdfQHoEooEY1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457420; c=relaxed/simple;
	bh=0Ipuu3Xh11QyPs5qekBAM/D0XYpq/ZELDefmxQ/1S3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owsT/yOu38QcTW0/4JaNfvHjLrlSwtLPQD57bnc2j0SaoJYoKuKWyi8Zqg5qf1CNj2/L5kF5lfBbg6vU4ZjVgX5hD6GIzknb6vKa6K4sVhf2lWGFbXXEH5G39++GGMN6KD+7MrSk+sh4ecLj+aeH5c9MoMqAHNYYHcJBJ9XIHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qr888QUD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B7CAD40E016C;
	Tue, 26 Mar 2024 12:50:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v-owZCfkRxVJ; Tue, 26 Mar 2024 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711457412; bh=06BKn4JRYDCymbCW3aUPHk5b/bEgAy9YHyinGcr1ris=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qr888QUDFpSGYa+5F9wIQJHEMyKgGhYOlrq8agRp4Li/geLGAMxWo/pxCodEJSbvB
	 HajweXL2M9oCOJHukJgfDpC2mOsLOAaWXlSPfmq4zvhw0CSQB4BX9149ip+zCmBLDr
	 TcWVzROu1MQ8kCb5OeT7Ud0F0QVYofuydCz69E1KVzu83cu1KbEMRz5061fuuKWm6+
	 Pj/o28ZEGalBrKHkVHARVAO3ENbNyVX3pS3Wx3SEOZr1iVX5S+U3uwYUGzVvvJtyCQ
	 lfG4HiVYqKjrNdcS1yjhdKp1MXpxDLuao031hhnDOaVlYW799KyslpYjPySxhV+8j3
	 JCBXwTClxKi5fqJc3L3MwHnQO8TCDEGtoSf2JPsYG6SF8FB68DVmo0RUeRs6NtTaKT
	 HLePVsyhkg8+xxD8JRVh9PKzdsqudXz7JDXN+cgpXiSgWI71jsLdBiQNiNcVTCMW+Z
	 U6nfNV+a5dqag5rINoLs/tlsgdLOP9ybJL4Xk7q9f5yrYVuIJZ3HFgsEirqBYXeSS6
	 okbd7HM/m2wRx5o8D5OwpCdT3EG9AjSm9ToM7eRDY8DSD2Qe09J3rWARyMeiM8PPzm
	 fQp5T/euowVfgfYW7YxfLQs7AQFaNLaz41bFOkKQcPX5sK5mqLaBdPo/TTPgIrDsjW
	 EdC4JIKE0IGOR9FozvyuLwdM=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77FE240E00B2;
	Tue, 26 Mar 2024 12:50:02 +0000 (UTC)
Date: Tue, 26 Mar 2024 13:49:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>,
	kasan-dev@googlegroups.com
Subject: Re: Unpatched return thunk in use. This should not happen!
Message-ID: <20240326124956.GFZgLEdFNDZSnQSuWx@fat_crate.local>
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>

On Tue, Mar 26, 2024 at 01:40:57PM +0100, Paul Menzel wrote:
> On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, Linux 6.9-rc1+ built
> with
> 
>      CONFIG_KCSAN=y

Are you saying that with KCSAN=n, it doesn't happen?

From the splat lt looks like it complains when loading that cryptd
module. But that thing looks like a normal module to me so it should
be fine actually.

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

