Return-Path: <linux-kernel+bounces-73278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A251685C064
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429B01F22991
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9FD762E0;
	Tue, 20 Feb 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CStDWttW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lx75ninb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD776033
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444453; cv=none; b=nxKcox47OG+BcsbEC9jcsPiW/RMhr8H6CXS70lc+0lyLbjEsHz5HPPuxq2lb1k2KiLhyZ3q45DZaw4Fe1K/akmbDFccHHi8Tuu838nV/Sa30yQQL60gV5Rs8HNjT52YdjL+UgoG5jalOTu+MNoIe5KMqBNI4tDPoS+8MAwnPgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444453; c=relaxed/simple;
	bh=12zW48ePexZ0k+y2CYm6y/WG/nHpA+YjLh0HmgwcExY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POtdTa+swuw5QdiQXH0khUkMh8JLx7Fi5i6DCZXUwlGjAzSBU2/XPiYGOLvaPg8xpwAEOS7jo//xnWI5ymZpdaaS7tuDvC0V84H4oc98hLeI719pUSdn50AMpwDSA+sLG9J/HrbWC1lvf8ah5k0e1TrD3QaPFebHQQEqeaTiE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CStDWttW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lx75ninb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708444450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxZf+GSRiuJn0QynLFhu7uKPGCPz3hSj1LX5ayl6vRs=;
	b=CStDWttWR/onVKZm1927ofC1lS+PrG4n+0gUY9RNk4JBwHvGuxC4z1GBFtUZCAQ1L2BN1z
	CFLcvtjBEKYWpKLSijjM03GQJziFBB5sHukR4ua3wSqO6TlGTdz7Wl9bWbtcMgd/npqRFD
	cFQaH180A78K0XltTlbWBVVMc4WU7/tJo4TPvml9d6BcGcYCJcg7O+oZGh9B+JbmtkFSmb
	69zXBXlb/qVmN5of3tuz3BwuW/OSyvC58z1BHLDbOVHtIGlM1LISKeUzZUeBG+8J1Cy/7K
	mquCNvyNjwCy0C4omZUe1xFLpPEmIjx9ye0Z8HxF106IXVKOevxIiHZ9dtOopw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708444450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxZf+GSRiuJn0QynLFhu7uKPGCPz3hSj1LX5ayl6vRs=;
	b=Lx75ninblEBiACICOlD1GKkm6rCtTyj3Fp0hnQiVFMHTmj4AvvyDsjavwX6bp93cAhUnjI
	77DUlyiYXiHmiLDw==
To: James Morse <james.morse@arm.com>, David Hildenbrand <david@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
 <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com, D Scott
 Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com,
 lcherian@marvell.com, bobo.shaobowang@huawei.com,
 tan.shaopeng@fujitsu.com, baolin.wang@linux.alibaba.com, Jamie Iles
 <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 peternewman@google.com, dfustini@baylibre.com, amitsinght@marvell.com
Subject: Re: [PATCH v9 02/24] x86/resctrl: kfree() rmid_ptrs from
 resctrl_exit()
In-Reply-To: <59ebda21-6164-4dff-9ba8-956d5a715048@arm.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-3-james.morse@arm.com>
 <52f81c45-efa7-42c7-86f4-fc1084b1d57a@redhat.com>
 <59ebda21-6164-4dff-9ba8-956d5a715048@arm.com>
Date: Tue, 20 Feb 2024 16:54:10 +0100
Message-ID: <87v86jgmhp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20 2024 at 15:46, James Morse wrote:
> On 20/02/2024 15:27, David Hildenbrand wrote:
>> On 13.02.24 19:44, James Morse wrote:
>>> +static void __exit dom_data_exit(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&rdtgroup_mutex);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 kfree(rmid_ptrs);
>>> +=C2=A0=C2=A0=C2=A0 rmid_ptrs =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&rdtgroup_mutex);
>>=20
>> Just curious: is grabbing that mutex really required?
>>=20
>> Against which race are we trying to protect ourselves?
>
> Not a race, but its to protect against having to think about memory order=
ing!
>
>> I suspect this mutex is not required here: if we could racing with someo=
ne else, likely
>> freeing that memory would not be safe either.
>
> All the accesses to that variable take the mutex, its necessary to take t=
he mutex to
> ensure the most recently stored values are seen. In this case the array v=
alues don't
> matter, but rmid_ptrs is written under the mutex too.
> There is almost certainly a control dependency that means the CPU calling=
 dom_data_exit()
> will see the value of rmid_ptrs from dom_data_init() - but its much simpl=
er to check that
> all accesses take the mutex.
>
> With MPAM this code can be invoked from an error IRQ signalled by the har=
dware, so it
> could happen anytime.

Which does not work because you can't acquire a mutex from hard
interrupt context.

Thanks,

        tglx

