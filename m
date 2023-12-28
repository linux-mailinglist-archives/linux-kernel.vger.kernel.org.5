Return-Path: <linux-kernel+bounces-12391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C5B81F416
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A2B281DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F12CA5;
	Thu, 28 Dec 2023 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g4RhtE1B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B442568
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BS2HbeK901683
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 27 Dec 2023 18:17:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BS2HbeK901683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1703729859;
	bh=UjI/k3eS7O6HB0+dpx4a96mA1fLx2yo/8peSNdY8Cd0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=g4RhtE1BUHXsYo8g5EjEHEKsjLkFfvZekSXLp7nart7XP4ecF+ZFHC18HWy5YVOFL
	 cfE/7gHNg0rh6VBOaJuLntVcGNEcSyEkBtbxStwb/i5jFcdhmkQc+Hue+qgs+A74FU
	 btketTrP3DNPPHIBMUCHZKEXUMW3wNX8Rc+nceBCgKxG/NNbtnpB2i4GwtjNxeHWlp
	 o5+7AhDn93arHzyMkoQb4n4sxTU6xCavYWFUoUtGH9F5AqP4ztOJZ0KCSs/ITarYiI
	 tR7uy/nYMcEHKLCsH7eq5Mi/frSkKGRqtP5B4tG7qUM7tyup98kCR7AHzqokw57Yik
	 5oa+Sq9ZIe5CA==
Date: Wed, 27 Dec 2023 18:17:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Tanzir Hasan <tanzirh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>
Subject: Re: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
User-Agent: K-9 Mail for Android
In-Reply-To: <20231228002614.GI1674809@ZenIV>
References: <20231227-syscall32-v1-1-9621140d33bd@google.com> <20231227233444.GH1674809@ZenIV> <8B198413-0C9B-40A2-8478-F22206AAE6FA@zytor.com> <20231228002614.GI1674809@ZenIV>
Message-ID: <7068F1FF-1266-447D-ACC8-2F1AD774F230@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 27, 2023 4:26:14 PM PST, Al Viro <viro@zeniv=2Elinux=2Eorg=2Euk=
> wrote:
>On Wed, Dec 27, 2023 at 03:50:33PM -0800, H=2E Peter Anvin wrote:
>> > /*
>> >  * Only the low 32 bits of orig_ax are meaningful, so we return int=
=2E
>> >  * This importantly ignores the high bits on 64-bit, so comparisons
>>=20
>> __visible is for LTO, no?
>
>If we need it in cases when array defined in entry/syscall_32=2Ec and
>used in entry/common=2Ec, I would respectfully suggest that whatever
>we need it for is misguided garbage=2E  I don't think that LTO does
>need it, though=2E  How is arch/x86/entry/{syscall_32,common}=2Ec
>different from e=2Eg=2E fs/{namespace,d_path}=2Ec, where we have
>fs/namespace=2Ec:100:__cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock=
);
>and
>fs/d_path=2Ec:166:        read_seqbegin_or_lock(&mount_lock, &m_seq);
>respectively?

You're correct of course; __visible for LTO is for functions called from a=
ssembly *at the point of definition*, not declaration and certainly not as =
a type=2E

