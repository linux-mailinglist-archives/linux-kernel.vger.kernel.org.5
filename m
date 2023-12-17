Return-Path: <linux-kernel+bounces-2819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF681625D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FB1F21D82
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C754B147;
	Sun, 17 Dec 2023 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CsbKKpV3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326294B131
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BHL9P3c403970
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 17 Dec 2023 13:09:26 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BHL9P3c403970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1702847366;
	bh=KdPuOoPgErrSBVmW7yfmqp9/uMOdEbu6olafAGTTIeQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CsbKKpV3TlXtICMMuIxbvG7qq7WP0zBTr86nL3DsVmU43uXWlzBk0QwZDmbGW8u47
	 oHCw0tOT63Kv71CwJSFdRfCQtiBTqJPp7TGfdv58NVvUJ3/a+cC89FzpdrZ4s1tQes
	 IImRDGZtyEVFMLlrmltYFnrXnbZrSRfIlREegFMeFEy+qZKd7qHsgKbiVu6ZeNrwUD
	 DVeNP1TwhR3HklfyrIs303MInwTALfTfAaUoApcD94n0gnP51uNkDajWHScwIVB7E2
	 soLquXrHZVMFodI/2JdIphPZMtVamC8U5NlGlnnfQJ37xROrTMfMUfgfGbZl+WXvIB
	 GRevEgX5+JVvw==
Date: Sun, 17 Dec 2023 13:09:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>,
        Brian Gerst <brgerst@gmail.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] x86: Move TSS and LDT to end of the GDT
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whgooqaEBK27sBMHob9+PwqaZghEsGnSVJsHK=y8U05tw@mail.gmail.com>
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-2-brgerst@gmail.com> <CAHk-=whgooqaEBK27sBMHob9+PwqaZghEsGnSVJsHK=y8U05tw@mail.gmail.com>
Message-ID: <CE363373-A1D0-4B03-A046-F4686597766F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 13, 2023 10:51:11 AM PST, Linus Torvalds <torvalds@linuxfoundat=
ion=2Eorg> wrote:
>On Wed, 13 Dec 2023 at 08:34, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>>
>> This will make testing for system segments easier=2E
>
>It seems to make more sense organizationally too, with the special
>non-data/code segments clearly separate at the end=2E
>
>So I think this is fine conceptually=2E
>
>HOWEVER, I think that you might want to expand on this a bit more,
>because there are other special segments selectors that might not be
>thing you want to expose to user space=2E
>
>We have GDT_ENTRY_PERCPU for example, which is a kernel-only segment=2E
>It also happens to be 32-bit only, it doesn't matter for the thing
>you're trying to fix, but that valid_user_selector() thing is then
>used on x86-32 too=2E
>
>So the ESPFIX and per-cpu segments are kernel-only, but then the VDSO
>getcpu one is a user segment=2E
>
>And the PnP and APM BIOS segments are similarly kernel-only=2E
>
>But then the VDSO getcpu segment is user-visible, in the middle, and
>again, it's 32-bit only but that whole GDT_SYSTEM_START thing is
>supposed to work there too=2E
>
>End result: this seems incomplete and not really fully baked=2E
>
>I wonder if instead of GDT_SYSTEM_START, you'd be better off just
>making a trivial constant bitmap of "these are user visible segments
>in the GDT"=2E No need to re-order things, just have something like
>
>   #define USER_SEGMENTS_MASK \
>        ((1ul << GDT_ENTRY_DEFAULT_USER_CS) |
>         ,,,,
>
>and use that for the test (remember to check for GDT_ENTRIES as the max)=
=2E
>
>Hmm?
>
>             Linus

Somewhat unrelated: X86_BUG_ESPFIX should just be deleted, as we aren't ac=
tually ever cleaning it=2E All current x86 processors have that problem (un=
til FRED)=2E

