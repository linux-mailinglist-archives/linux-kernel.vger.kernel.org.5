Return-Path: <linux-kernel+bounces-61950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD778518DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A079A1C21534
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DAA3D0DD;
	Mon, 12 Feb 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3O7vg3zq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dx12KB1W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A83D0C6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754901; cv=none; b=DlA+e6aUDTv89glPAjjbBmvmavgP4eEY8NxRvRr+UN3UlbiLmQDYKPx8T+SwrM6sQF3tCm326reSt9n/L7wlYoOmTEcCPnLHjb3i6Dwy0TeVex7W1onmhoQFN8fH3SuIAg/htBsxR7LvRWoPoCaCwFIyj7BLVtEdTYv/WGKjcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754901; c=relaxed/simple;
	bh=1BWC0UQfvIxzQO7IVLyaJkmBdrewdliNCuz3xW/kdWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sjik+q57cRVzSvYhS3cPK7P9lC8kPLqOK80pgejO5HLHz8xI3GF4gdrQ/DOXsN9knThDv2qfhCHee2IDkDa+3OSYezgDH0Ox30vjkrtkCdLUH+ymr5HO2R1+GbkaW1i5XhgAVJMhp9XdjI5OUllWVmEZoSrWBMZBlHYgyhZqw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3O7vg3zq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dx12KB1W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707754897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AISrXD1Q33tYBSRVk/8iPW5GJ8FTn5xJaDxG7hZwWOQ=;
	b=3O7vg3zqDREBF3TLw4EqC58s9CYZtIX1d5b8glvxIM7smiIq6lkeXajBzl6ZYfahAUSGCb
	fvUQCwYoeX7g/xujcRsA0M4vrO0YG/4GbyGBLgEkHiNb0RxU+Xok8U3cqmkxA/ol5keekn
	yK5F75kCSYrbx6WYbLFKkR4LhMtblczRTIf7Y6MaSxRtngh83juNR8QO2Gj/7slZ4BOsvz
	nUFr8fAhwHt02Ph0j009lqqp1ijIgJVZyw/8Y4L3n9caTyUFrOCMxRl5caguz242L3FUUA
	SZjpc3xuJDZ+TsmFqMAmdr6P/UjcWTEMMo2iR3He9/g41DSu3q+zD7v4x7VATQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707754897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AISrXD1Q33tYBSRVk/8iPW5GJ8FTn5xJaDxG7hZwWOQ=;
	b=Dx12KB1WdBy2Qs4v3dwFwJ1C0JdUkfW+rGbPPCrd8swP6Xg7Lwq7YBgJFA/Gw6nUFYpwOA
	sJ1+7k2ogDvsQTCQ==
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "mhklinux@outlook.com" <mhklinux@outlook.com>, "jgross@suse.com"
 <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
 "arjan@linux.intel.com" <arjan@linux.intel.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "Tang, Feng" <feng.tang@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
 <ray.huang@amd.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Sivanich,
 Dimitri" <dimitri.sivanich@hpe.com>, "paulmck@kernel.org"
 <paulmck@kernel.org>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "andy@infradead.org" <andy@infradead.org>,
 "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [patch v2 25/30] x86/cpu/topology: Use topology logical mapping
 mechanism
In-Reply-To: <5024c989133441608592ef86bc78ca2573bcc728.camel@intel.com>
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.971809766@linutronix.de>
 <5024c989133441608592ef86bc78ca2573bcc728.camel@intel.com>
Date: Mon, 12 Feb 2024 17:21:37 +0100
Message-ID: <87r0hhk60e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02 2024 at 06:45, Rui Zhang wrote:
>> @@ -147,6 +148,9 @@ static void topo_set_ids(struct topo_sca
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.pkg_id =3D topo_=
shift_apicid(apicid, TOPO_PKG_DOMAIN);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.die_id =3D topo_=
shift_apicid(apicid, TOPO_DIE_DOMAIN);
>> =C2=A0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.logical_pkg_id =3D to=
pology_get_logical_id(apicid,
>> TOPO_PKG_DOMAIN);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c->topo.logical_die_id =3D to=
pology_get_logical_id(apicid,
>> TOPO_DIE_DOMAIN);
>> +
>
> Just wondering if we could have logical_core_id.
>
> drivers/hwmon/coretemp.c uses an array to save per core temperature
> information. We cannot use core_id as array index because it can be
> sparse. Currently, to get the temperature info for a specified core,
> we need to traverse the array to know which core each entry maps to.
>
> Ideally, we could have a global logical_core_id, and use that as the
> array index directly.
> This can also simplify kernel code in many places when checking if two
> cpus are in the same core or not.

That's trivial to do now :)

It's an orthogonal change and we can put it on top once this pile is
merged.

Thanks,

        tglx

