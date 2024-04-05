Return-Path: <linux-kernel+bounces-133450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F248989A3DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832D5287A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC66117277E;
	Fri,  5 Apr 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cyL7wMZ6"
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF2172767
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340475; cv=none; b=nkCF7S8vUsariyOriXCJcyshbNCtgAec+v8IlqpwAyeM5VJLH0cxmNcscwsUmftxnV46TGhBX19W3wRGhkcZCbtD/0mkFjgD0Tp9MmQAs3F9r+unNwe1AiqAPqw9cScBpQXx8R316rGXW4xyqXbxFwJeHUOWd1d63cd8E92f6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340475; c=relaxed/simple;
	bh=kiwUCEjPx78g1bk35VucSw6ptQJmiUDwfINeVgK5ces=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMXiHwu15p35Hp8g3kcHq0e+T5q0ml3DrYRnMoviS4M43mjjBunBC6jI0SYQUW3FRs7LT95oynrzuipu86hgQkMSKX/xz9PKZN8hFTLcqAgQqM55pSMyf9/MXQnTFW55SRIV1EfSF8mNjxNhwN6nBl3R+zpgRNEU6K+u7ggxtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cyL7wMZ6; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VB60H71S8z7Qf;
	Fri,  5 Apr 2024 20:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712340463;
	bh=kiwUCEjPx78g1bk35VucSw6ptQJmiUDwfINeVgK5ces=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyL7wMZ6fGr++bxregCQEm29qB3fuZgv653iTA9GW51TcUaqXfg7KmuPDuTqcUkKe
	 SfxMZxvEY0inVS2JBEN5QQq9vmLag7zRP8f7AnAnC7axhKSIoC8dmhYmcienEPkhH2
	 tyIzl9AeQHADN+6Mrz57ceiG7iQq9xIzLG1VEUcM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VB60G5glFzpnt;
	Fri,  5 Apr 2024 20:07:42 +0200 (CEST)
Date: Fri, 5 Apr 2024 20:07:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <keescook@chromium.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Marco Pagani <marpagan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v4 0/7] Handle faults in KUnit tests
Message-ID: <20240405.pahc6aiX9ahx@digikod.net>
References: <20240326095118.126696-1-mic@digikod.net>
 <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60d96894-a146-4ebb-b6d0-e1988a048c64@linuxfoundation.org>
X-Infomaniak-Routing: alpha

On Fri, Apr 05, 2024 at 10:08:00AM -0600, Shuah Khan wrote:
> On 3/26/24 03:51, Mickaël Salaün wrote:
> > Hi,
> > 
> > This patch series teaches KUnit to handle kthread faults as errors, and
> > it brings a few related fixes and improvements.
> > 
> > Shuah, everything should be OK now, could you please merge this series?
> 
> Please cc linux-kselftest and kunit mailing lists. You got the world cc'ed
> except for the important ones. :)

Indeed, I don't know how I missed that... Do you want me to send it
again?

> 
> thanks,
> -- Shuah
> 

