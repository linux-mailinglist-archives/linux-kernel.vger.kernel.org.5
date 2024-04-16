Return-Path: <linux-kernel+bounces-146273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586FF8A6310
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C601F21F87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D563A1C9;
	Tue, 16 Apr 2024 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="DWXb6Au5"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703211720
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245841; cv=none; b=gba0KRMci2y9aod8UtsyyDqCKnKpE9cGKAqsCuSK6C9q6BIEx9gwXYqCpyQD4+gpq/rZZUsC7kA98lDBuY+MWTi9C4WLHcgff7GP1QH4KX13pynIAWnwM7W5K76AfULniqc7jzvVPuzWlgwcle/Hk0DZb6W+nvhWRzRLTiMqPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245841; c=relaxed/simple;
	bh=+n+QybA0XLkfuoxEtHl8wvGl8+Nk/g5jc7wA0BJKxTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UyE6yJmNg/ZUyM5XyNDseTdUFl+3ohok7vERNGGrcE08RW5H6ISEpx/d1fC7wWQCdroxiHPTkkwbBQjnulj6fJbyd3bdlgHOAxOdFfv9GA5oT3HTxr+SHJr3KdJAgx9Mvyi3+gWaQBdD1lZMkoHs3tvF8ZOk2Pvme7j6Z8B9HMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=DWXb6Au5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713245791; x=1713850591; i=efault@gmx.de;
	bh=CEXOWJpsSsEGIcTUdU5bLURuQkwTb8AcWqo6bjs1E7Q=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DWXb6Au5timcXxHM8Qdk8jGsbuHlT2zcBYx2y19Gf8wtI1yVjx/YodeGJ3SvRO20
	 nVwWOUvtW5SBixvN7wjgTxggYz/kDc7E/BWMrvnylKZDQU+rtz5oINtwyxBy94lKK
	 Uaz+0s7XkU1R7YEQI4BVop0RHD6NQAcRre4l1Sh1NsKYYAKNJ/uNNZCxfA+ZnBcTg
	 VhESL01fdMJVfipQslmh8SDecGZHd2/wmblIctGwiZ996Yks02EROxCbVnOJyYtjZ
	 j7G0hWIKhADebRWk39Fz67hN1RkqJTka1rVSr/WDpm7yRXdqPJ3nb2GDZ/zZRaM78
	 tl/oV4MQZdGs4ciJ1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.137]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbBu-1slwzZ107S-00sc9o; Tue, 16
 Apr 2024 07:36:31 +0200
Message-ID: <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com,  linux-kernel@vger.kernel.org
Cc: wuyun.abel@bytedance.com, tglx@linutronix.de, Chen Yu
 <yu.c.chen@intel.com>,  Oliver Sang <oliver.sang@intel.com>
Date: Tue, 16 Apr 2024 07:36:28 +0200
In-Reply-To: <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.631664251@infradead.org>
	 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
	 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
	 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fvIYdFOTSr/E03xQtbqaniaVGdLmo2j2pN1KJTggfh55E+NGnfI
 RVLxf+P14PwYTjPIFJ9YGVM5tRarWsfhmdwpgTrB+rj4YN9r5hhz9B4ox2gFyiwg5XXWJev
 I9J+GA34bT1pM0m/OA0/h+/BxcmTy/sDRehPIcIQ3sHJnzPY4WyeD1u5+KAdE1ct7GnKjYd
 Hs5GobxxLJLs3DVwULrhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E/9xtIhvhSs=;gryy5R/HUi6p3nG2W6Pwpbne7RV
 zXEfGXxWPzGWD8hA9DyYkdqAZSEpALqKkxnE+tFNgwrL2nNkdGLifd9Lh7vt+45LoZO8xc0ip
 RpCoobuyoYfTRvo12Or9zMx6s9haQYM2aBYwqN6deki0AcFNfKR0VSEsidL9G6u0FVL7xpCHC
 nTyiRHRGiBUB+WdYpuEJlWkxEbSd5KrCY0O5CG2BiCYuJA4VYVqE42013zaaASHRvZTr9q5MO
 0GBIyyr+RPVFUCpjByzsOyQuJOTqaA27OFerxiH0roPLAP1G+OzCHQQq7OKz5GM3X5NeYbjjk
 7tzbsCttPJvOtIUsH4RgdWwMONy7g3EmFt03V+MINlwiBb/XYGYvzQUph5/20EZqS0rwiOobC
 Et6h20hD+09o1vz55R3xUmTP3TDvo8cm1+bQe9RT7VJgaEqsSOesKgPrLvTqWyn59+MBR/mUe
 c26GqcR4AHwVqvMM+FYid1Nd+9uaQjZga8beHQ7Pyy225CV91rs0lqkNMmjmX3A1MiLAMYIwu
 ZC5da2i2R8Rs1i3VZyPuTx3zyL4I3Oj06pw+noP0J+tB6V/o9Zw2+xZvlIAZfoAbELPKur+RK
 GKfLDkE0o2RlmhmiSuNp153Q0SbKYFqMOdrwJPx06tHnmC3Kzikjfhswv9ulTN1v+/yaatk5B
 VBW/UxvVMd8V0QA56qBocYvhGxsYgbjMyinSoHtlZUf9jrdVYTmJngrBMjIxPbhdFqSJRycMV
 L/nQSV+eSxuXChl8pkgfFm5B71kY/R3/iyu4v1GvVafEwaW+PaFchvWz9hA5nc7IXEuaJFcce
 haKiQVZECuTknUW8UKw53YyBrY+VMhpHJFI7PJECoWZSs=

On Tue, 2024-04-16 at 08:48 +0530, K Prateek Nayak wrote:
>
> Wondering if you are running into the issue where pick_eevdf() returns
> NULL despite there being runnable CFS task on the runqueue. Can you try
> running with the following patch from Chenyu -
> https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com=
/

I hadn't tried it in master branch, but had in my 6.1-eevdf tree which
contains the previous delay dequeue version, because I found that it
too would explode, which surprised me having run it quite a bit woe
free. Patch helped 6.1-eevdf not at all.  I just tried it in master to
be sure, and while the death throes were not identical, this one began
with SCHED_WARN_ON() in put_prev_entity(), box still went belly up.

BTW/FWIW, turning on AUTOGROUP seemingly rendered box immune (unless
booted with noautogroup 'course), and that immunity even held when I
launched all players in the same cgroup (hmm).

	-Mike

