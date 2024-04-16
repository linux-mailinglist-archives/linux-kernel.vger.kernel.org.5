Return-Path: <linux-kernel+bounces-147347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFA48A72C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87832284491
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4A6136671;
	Tue, 16 Apr 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Zx/0mIB3"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF06135A59
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290746; cv=none; b=BX63twQUj9dix8TSBqSJFTHQi+gssxGOu/fvBdCAnp5WpngZAt5MDkWPTf37QSvnCbYbAAONx61BXl0LHzXnbVSD7Rwraeq+CYFMnA+ZXamzCaoL3RwT97Z2pklNN93M7xY5hABxbOsrjk85ogBNv4CMijtY481qmRBDUnboHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290746; c=relaxed/simple;
	bh=vNxatr6wmhiPowTIKjuTwwXXbIbHjyR7xpA57RzBFm4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mA2m5hGcpX6UDCtNouYAZWbh7Gfil1ruxzpq3HhV6o0C8IhA6QCFyE4Ejd0e6cmbm4fy+uuO2uzOqrVWHQMRZvaoU7jwlRQmXgC4BudmfeZceym4IAih4dEairEes52/hRqu/b+g8MXXpSZymzKyJkC2mrOKuoHzUrkQBFIqJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Zx/0mIB3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43GI5Ep23333977
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 16 Apr 2024 11:05:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43GI5Ep23333977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713290715;
	bh=J8pxXkE58AUR7hivIEpGL3T2EshFPqjzkbL423tGcGA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Zx/0mIB343ew2Y582XPfh8wl84ROu2m6y7q1UjSjWuiNu2/bm2AbSZ1UVdHlVimsx
	 HYH0vp8mvsVHTjOMbOrMdmUWWepYBv6MTJrPHjME+NQcUBbZldsgIK+NDkKJSlu+wR
	 mj7vRWP3+K09j/Voqw0gXYwzhqWY9sCA3ZMcG0Jyt7VbuKqosoLjOzI4DtDt2SPG81
	 J2b3z7MiPWEfZpYea/AnI8AEBRMz/fdwGNrUcwPL45PXC6t6qiuz6KrSjcgVb9I4wY
	 1GGFjnyg6CXd+Xe4DWjyzq+hJCUaiTvPBnAoVx23BNSANcPxUhF5TRowmpfi1kuGQB
	 aKG1sSjPcWiMQ==
Date: Tue, 16 Apr 2024 11:05:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, "Xin Li (Intel)" <xin@zytor.com>
CC: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
User-Agent: K-9 Mail for Android
In-Reply-To: <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
References: <20240412234058.1106744-1-xin@zytor.com> <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
Message-ID: <1AE9FA53-A130-4F95-8408-C1990DD031AA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 16, 2024 3:11:47 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Fri, Apr 12, 2024 at 04:40:58PM -0700, Xin Li (Intel) wrote:
>> Commit 55617fb991df
>
>Use the full commit abbreviation when mentioning commits:
>
>"Commit
>
>  55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")
>
>=2E=2E=2E"
>
>> added a bunch of tests to the int $0x80 path,
>
>Added a bunch of tests?
>
>What does that even mean?
>
>> however they are unnecessary and event wrong in fact under FRED=2E
>
>Are the bunch of tests wrong or is do_int80_emulation() simply the wrong
>handler to use on a FRED?
>
>> First FRED distinguishes external interrupts from software interrupts,
>> thus int80_emulation() should NEVER be called for handling an external
>> interrupt, and then int80_is_external() should be skipped under FRED=2E
>>=20
>> Second, the FRED kernel entry handler NEVER dispatches INTx, which is
>> of event type EVENT_TYPE_SWINT, so the user mode checking in
>> do_int80_emulation() is redundant, and should be skipped=2E
>>=20
>> It might be even better to strip down do_int80_emulation() to a lean
>> fred_int80_emulation(), not to mention int80_emulation() does a
>> CLEAR_BRANCH_HISTORY=2E
>
>Yah, how about you do a FRED-specific INT80 handler instead of
>sprinkling moar tests around? fred_intx() looks like the right place to
>stuff it in=2E=2E=2E
>

The question was if you wanted a quick fix for x86/urgent=2E It's pretty o=
bvious that a FRED fork of the int80 code is called for=2E

