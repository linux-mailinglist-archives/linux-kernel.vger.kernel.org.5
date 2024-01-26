Return-Path: <linux-kernel+bounces-40620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3B83E34A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C581F26A72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1023742;
	Fri, 26 Jan 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oStABYS2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e/Sdjn69"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028122EF9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300572; cv=none; b=R4XLLL4V+JpPvbltnFwSF63WLeUpKZQBQTNZp37BgG+DTkgTox9FYGA2D7LDzEyLXFnXUZAYzYGg+5ehMhC6OrGPbp275qBoZuEWmAuBI/D8jW2L3u5FhL8yENnCoojFs06MDvd04zxtqH9C3QLtD3kZ+RgZDWZNJX8JSFGrG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300572; c=relaxed/simple;
	bh=tBU/Xb/2SvjwvzmqrK39MOJLLy+M/EBTekaRKFEliwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFma2gC6Thm4ql/TnFRkMny69p7dsAgzmbN+14kMnP0kGT4tGmo568S+xq1IPqqjH2SWg6mfy/r/viQ6CqSJAqPBrTRc1qVnYMnaOedmBVIpex2qKVaGm3StWCXR+Wgz8rmvKMWLrKbfhfY1YubcwTCVDxV64BgWsocwnNQhVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oStABYS2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e/Sdjn69; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706300568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=841xmotN080Gj8mdI3q/cuaEGS+WUt6XWaaj98SJfC0=;
	b=oStABYS2G2zTv+ODpU8P2xgVD0mZAmsxS4qF+kxGGJjfABa9k0xyZzjsZkuUiqISWJAS6F
	BGKw6BV2kfvKA85ploNHoWYE5F3gLoWtSFtLaZmJXKum1elDqQIJRKcPqeNBdDWYGjyrGu
	XgxCJS69C3D2AG9f2npYQ5Hn9TlxlEC5hFvPyrU4DsD36XD8DWX9kmJv8AQ3NrK2qo4I4p
	rchfG2EN3e8uTpNrwifBcXzZnhTDB+P3ijLqivtm1KX5RkDXopt+dxmwlzIALDHAm02IH+
	7dE6mqum2XDZ60UApKFMcvROvw6zmu7JO/nIbCvu24UxhWZ6sblAUS1APAcPww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706300568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=841xmotN080Gj8mdI3q/cuaEGS+WUt6XWaaj98SJfC0=;
	b=e/Sdjn69Gp/hEaJQ2kx627HStGPFxqq/vH2MJX8/rj8yPCZ2BblOJqJ49Oax65On4CCyTX
	Cs9s/ns5acKe1GDw==
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "mhklinux@outlook.com"
 <mhklinux@outlook.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>,
 "ray.huang@amd.com" <ray.huang@amd.com>, "thomas.lendacky@amd.com"
 <thomas.lendacky@amd.com>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "Sivanich, Dimitri"
 <dimitri.sivanich@hpe.com>, "Tang, Feng" <feng.tang@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "paulmck@kernel.org" <paulmck@kernel.org>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "jgross@suse.com" <jgross@suse.com>,
 "andy@infradead.org" <andy@infradead.org>, "x86@kernel.org"
 <x86@kernel.org>
Subject: Re: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for sizing
In-Reply-To: <7c8874d971c69fb4c22c1b771983f8d5109a9387.camel@intel.com>
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.739960607@linutronix.de>
 <7c8874d971c69fb4c22c1b771983f8d5109a9387.camel@intel.com>
Date: Fri, 26 Jan 2024 21:22:47 +0100
Message-ID: <87fryjhmjs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26 2024 at 07:07, Zhang, Rui wrote:
>> > =C2=A0
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cnta =3D domain_weight(TOPO=
_PKG_DOMAIN);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cntb =3D domain_weight(TOPO=
_DIE_DOMAIN);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__max_logical_packages =3D =
cnta;
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__max_dies_per_package =3D =
1U << (get_count_order(cntb) - >
>> > get_count_order(cnta));
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("Max. logical packa=
ges: %3u\n", cnta);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("Max. logical dies:=
=C2=A0=C2=A0=C2=A0=C2=A0 %3u\n", cntb);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("Max. dies per pack=
age: %3u\n", >
>> > __max_dies_per_package);
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cnta =3D domain_weight(TOPO=
_CORE_DOMAIN);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cntb =3D domain_weight(TOPO=
_SMT_DOMAIN);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0smp_num_siblings =3D 1U << =
(get_count_order(cntb) - >
>> > get_count_order(cnta));
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info("Max. threads per c=
ore: %3u\n", smp_num_siblings);
>> > +
>
> I missed this but Ashok catches it.
>
> Say, on my Adlerlake platform, which has 4 Pcores with HT + 8 Ecores,
> cnta is 12, cntb is 16, and smp_num_siblings is set to 1 erroneously.
>
> I think we should use
> 	smp_num_siblings =3D DIV_ROUND_UP(cntb, cnta);
> here.

Indeed. That's more than obvious.

> Or even check each core to get the maximum value (in case there are
> more than 2 siblings in a core some day).

We want to get rid of HT not make it worse.

