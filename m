Return-Path: <linux-kernel+bounces-65427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189FC854CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92E41F24D83
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2CA5DF13;
	Wed, 14 Feb 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KsOG9DPa"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5D5A0FB;
	Wed, 14 Feb 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924619; cv=none; b=YguTHZpgQinPXTp4pg7B07vj5mMGn6ysILPcoFDuyl00+jUL3OasPQmfyUlmHmjUZFdvca7mz9UN68kwig3ZnFzlDTC12AIguzHZ6bmisyPyyhQhfVjv/cXwePfLnpMStYSqY/j0/vmnf5vdTrYEr40F8H1n8uvIgXz1EVYG5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924619; c=relaxed/simple;
	bh=LNiQsxwpb6KqaUIrwzAIc1YaPde2cuUFEm8Lin9I+4c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YlwpW7QEF7ZJn89WRfEN/Ew3IKc86m15qPKkfgJpkf25pA0atcmKD/wjeIMyr7TZUuAdQRxVIlGsrk15PcORNpI8IQHNeOJU/RE3mF7xQnddjOBcaVE8Bmi01aUc+AgOIU8RgYy9qrm5gwdqOzYI5v99rJ2uNWUVGBtaarq8vtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KsOG9DPa; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41EFScet1331064
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 14 Feb 2024 07:28:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41EFScet1331064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1707924521;
	bh=rk9njXpf6hzFHY17pEhUqSZF9wRgLnS+p3Equ70uV9g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KsOG9DPaw5ir6qEJCooeMQWJQMCKKXsB2ez4BpMq4njCXB/iMypn6kRHAYmoAYIIf
	 bI2i7x7i9vd/OUg3t6q9x1O7qGE96Ypb/3YMNpACt0umzVvoeS2BMGQTXT/SGKUJfi
	 Jb0GaAPO9/6YSB+JBbfT4UZkfZbg5wfA11KuWqoPUgfDi/TBxsUVGzbf3Joa5RmXtW
	 Do14EBY5W+LnmVF10jBXuD09SgEe/1Lr8vOu1xubrGFtdkWjDBrTgWFhJUwnlmKAl+
	 JeqS9Se6UTcm9/mW0OJ/aCaWPUbnSHpsCQvPZcWRGuggLm/w0mgmieUCXUJk1knukA
	 F2gD2n6NiHfiA==
Date: Wed, 14 Feb 2024 07:28:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <jroedel@suse.de>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
User-Agent: K-9 Mail for Android
In-Reply-To: <c424618c-d6c6-430a-8975-8851a617204e@intel.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com> <c424618c-d6c6-430a-8975-8851a617204e@intel.com>
Message-ID: <34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 14, 2024 6:52:53 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom=
> wrote:
>On 2/14/24 03:35, Petr Tesarik wrote:
>> This patch series implements x86_64 arch hooks for the generic SandBox
>> Mode infrastructure=2E
>
>I think I'm missing a bit of context here=2E  What does one _do_ with
>SandBox Mode?  Why is it useful?

Seriously=2E On the surface it looks like a really bad idea =E2=80=93 basi=
cally an ad hoc, *more* privileged version of user shave=2E

