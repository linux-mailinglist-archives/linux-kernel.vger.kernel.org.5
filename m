Return-Path: <linux-kernel+bounces-118052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1AD88B664
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52F4B2E41C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC66EB69;
	Mon, 25 Mar 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="bhO9fU9G"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F633995
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402905; cv=none; b=ID9IBaM2LcA7oC/Jw35KsLR1O7Isa21j2e+63SGdQUtx+l2941SG/wz3iWBcxYeS7wa03L+R7PilYoVppBxwQTIWNI8qnIgKuux1vTC+9Jp902h6HhViGnZHYFg5J2/GYiEbHx+j+JGRTvNl/OOgl5wbODLylxOHWhxxtp96JSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402905; c=relaxed/simple;
	bh=Yukuaoa5zcDGAtUDFuTzHk2qar+UNWcKKdsAlD0PyVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fStDeh77xvo2fn4KeW7NBeAoH0J/hTLAXINijerLxCd9vNM9dfukJ0yk0Me1In1yyAHhbJjzquLfj5GG8ITIUIujG422lAkA7v1HoKNkmQ8UzhtkzBv5VUtzq5d0I9BJEuIdROMqDEDyOnKo4B7iSSULd/QfYaF5bRBh9/9gPbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=bhO9fU9G; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711402903;
	bh=Yukuaoa5zcDGAtUDFuTzHk2qar+UNWcKKdsAlD0PyVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bhO9fU9G/zTnI472vhTUUEQT51sHDeCZswpc0aNd9UhkPYV1MZb9yjvQZL6oR7P+P
	 cnn9xjGAeW+96wBYSlEbW3su9+MqIRqXe9paDECbMd6VWo0QqMuhAzUA0JV/e2j0lj
	 wDILSimLoDBEQgMr6F7B0GS0pDwg10t+yd7MJeBI=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9FEB767076;
	Mon, 25 Mar 2024 17:41:41 -0400 (EDT)
Message-ID: <177f14cee291788df618a22398fdb027afe0f6c6.camel@xry111.site>
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Michael Kelley <mhklinux@outlook.com>, Dave Hansen
	 <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui
 <decui@microsoft.com>
Date: Tue, 26 Mar 2024 05:41:40 +0800
In-Reply-To: <SN6PR02MB4157E96FB6980EC52134C830D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240324190503.116160-1-xry111@xry111.site>
	 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <c8dfca5f964701ce614d364ed7b18fa930aa2f61.camel@xry111.site>
	 <SN6PR02MB4157E96FB6980EC52134C830D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 20:06 +0000, Michael Kelley wrote:

/* snip */

> I haven't done a complete census, but there don't seem to be
> that many places in x86 code where the microcode version is
> checked. Several (most?) already have some kind of "out" when
> running on a hypervisor -- like bad_spectre_microcode(), and
> apic_validate_deadline_timer().

So I've sent V3 as
https://lore.kernel.org/all/20240325212818.125053-1-xry111@xry111.site/
with the check added.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

