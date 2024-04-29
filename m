Return-Path: <linux-kernel+bounces-162241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10688B5869
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A091C2313A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393654910;
	Mon, 29 Apr 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug9q1Sme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3369C548F3;
	Mon, 29 Apr 2024 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393284; cv=none; b=qB/m4sLy9+lFW2hi6vkFBMGaxdyVrKK6swBsrZPWv+gZKso+2BxM0+waHpktU6UHMHi5oKjs2A+ORhuZyCM3ZDc/ciWkGwTpSqFEebqyEl6dHjil6JhvNqb8/qmRtAUEuEK4BqH2zD2vrUIIRQC8/KR8oW4gu3MZhZv74xh/mnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393284; c=relaxed/simple;
	bh=GN3QGB2jbFPL5Wk6rKTG25hzWJroU4o85TBERdc7DoE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l9SJs5rETMx4xQ3wj5eKQ/KW/V7Huju/Ty7avjs9LJjUJWe8A6N1YeFy6QzhEicsGjfvfSUB1DQk5c9jPn5TV4b+0RTBVgvRcow7JO5B3D71ExkteD0p+CyNCXGm3aJo9+qK9xt1vmD1kpLEi+Z9zEB3VhT/nazWyeyBGocXhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug9q1Sme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054D1C113CD;
	Mon, 29 Apr 2024 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714393283;
	bh=GN3QGB2jbFPL5Wk6rKTG25hzWJroU4o85TBERdc7DoE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ug9q1SmeSa9FZfVHBJQmoSFaZBTTz1yizjIKKT+tkO1UL4oQgm2PnI+uG7TlCGZhk
	 EkQDZclIClMfuml0UwZztnx7KDyUNTBGficWFh//g7o+SaX2qNkp3FzYkv3KDwJOw2
	 wFCJF6X94vJdyIvUYjnoBd0WdOCKf/pjly6f/gPzNztweC0u+PjvqIZgr8r3jgs293
	 pYfpDC+Idt2haSHeT0aTJs2GVWjHEYKciwKNNFCkqtvzH6Ga3OpaQmmXVQMrWOgpYZ
	 Cq249RThITDjVXarCdavRHYGf/unGIsWEl3oTyurp4ZAQ+Ws+kZbO0Vo6rZczLj03M
	 OrNqpgHu0swbg==
From: Kalle Valo <kvalo@kernel.org>
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,  Wu Yunchuan
 <yunchuan@nfschina.com>,  Johannes Berg <johannes.berg@intel.com>,  "Breno
 Leitao" <leitao@debian.org>,  <linux-wireless@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <lvc-project@linuxtesting.org>,
  <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] wifi: ar5523: enable proper endpoint verification
References: <20240408121425.29392-1-n.zhandarovich@fintech.ru>
	<171406032921.2967849.6111681305541795423.kvalo@kernel.org>
	<87a5lhh1t0.fsf@kernel.org> <20240428090404.2d300255@mir>
	<20240428094916.3d1e92b8@mir>
Date: Mon, 29 Apr 2024 15:21:20 +0300
In-Reply-To: <20240428094916.3d1e92b8@mir> (Stefan Lippers-Hollmann's message
	of "Sun, 28 Apr 2024 09:49:16 +0200")
Message-ID: <87jzkgfjgf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stefan Lippers-Hollmann <s.l-h@gmx.de> writes:

> Hi
>
> On 2024-04-28, Stefan Lippers-Hollmann wrote:
>> On 2024-04-25, Kalle Valo wrote:
>> > Kalle Valo <kvalo@kernel.org> writes:
>> > > Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:
>> [...]
>> > > Does anyone have a real device to test this? I have had so much prob=
lems with
>> > > syzbot fixes in the past that I'm hesitant to take such patches with=
out
>> > > testing.
>> >
>> > Actually should we just remove ar5523 driver? Has anyone heard anyone
>> > using this driver still?
>>
>> While I'm not using it regularly, the driver does still work in plain
>> v6.8.8 (and these Netgear WG111 and WG111T USB WLAN cards were quite
>> common), tested against a qcn5024 AP.
>>
>> I'm just preparing a new kernel build with the proposed patch applied.
>
> =E2=80=A6and now the same with this patch applied:
>
> $ uname -r
> 6.9.0-rc5-gcc1380dd1882-dirty
>
> wireless-next-2024-04-24-2112-gcc1380dd1882 with
> https://patchwork.kernel.org/project/linux-wireless/patch/20240408121425.=
29392-1-n.zhandarovich@fintech.ru/raw/
> applied
>

[...]

> [   84.623413] wlx<MAC>: associated

Very nice, thanks for testing! I'm surprised that ar5523 still works :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

