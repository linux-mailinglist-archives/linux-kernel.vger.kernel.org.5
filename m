Return-Path: <linux-kernel+bounces-60197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F1850145
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331FF1F29E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDF1FC4;
	Sat, 10 Feb 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTK3tS+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA063C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525811; cv=none; b=BS2R4VW4V1/Ps36cFuMG4JaVtrBRWUei8zqK0juxhLchl+hpBl6Qh6q+RP7mcJk4iWSC2if8prL2znDYPnRmcH5e37VbkqS2m2YflatMPWXst0kiu0kcIIu53MK6dpHB6TvGJX4zp8qrzknqt86JY0Ns9H9+IWeGesNtRVgJp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525811; c=relaxed/simple;
	bh=vneO9qhwWCzEpkKUOYOluMuEQWm5lUI2J3SjCud0dtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTN9t98NWGkdtUG88S89KJot5soUgu+n1Ic+RHcRTaDjFMPjisOk0M0a7VTJkf5E+BJ0kMKkvjh7xpTqZLAiUBDQ/zY4wNeyfoHDaDiYjzPKjr3bkiMNrRQaROEYd26E+if8xClq1JuXb28awHKxEzqvODNH+4UkiB6Yikjn+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTK3tS+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55226C433F1;
	Sat, 10 Feb 2024 00:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707525810;
	bh=vneO9qhwWCzEpkKUOYOluMuEQWm5lUI2J3SjCud0dtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTK3tS+43IRwB1i6EEl82pbaR3A9W1XTQ1S73bOCO/yoPkloe60/NCDFw6pwuTqLd
	 UWWZYkS5YavVqdfWnGuEzq9oc0FWWd3b4qx8hDtTIHpiQc8GdaEaTCkAFNVdChhHte
	 DozcZkcXktjPfMxaI7virS7zOZSSAUpPi6COGk6OFBpJYm40LtONDxtq5lg0K+Lg7i
	 veJBnyK7PbI90huW/wrb3RIZZF0FRCksCiawU0BYs2cj2IQQ51zKhd2+cXzLY/jdfB
	 5uArnLaQrqlrxdmtBAAUjqvwkfdKw9zk7MaEqbTSEYZ4JKqOvCmKRequcPZ9rnh1VT
	 WsOqexaUj+24g==
Date: Fri, 9 Feb 2024 16:43:28 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>
Subject: Re: [PATCH] x86/bugs: Default retbleed to =stuff when retpoline is
 auto enabled
Message-ID: <20240210004328.n7uxevxfiqr3gsot@treble>
References: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>

On Thu, Feb 08, 2024 at 05:12:15PM -0800, Pawan Gupta wrote:
> -		 * The Intel mitigation (IBRS or eIBRS) was already selected in
> +		 * If Intel mitigation (IBRS or eIBRS) was already selected in
>  		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will

						 ^
						 should be a comma

>  		 * be set accordingly below.

-- 
Josh

