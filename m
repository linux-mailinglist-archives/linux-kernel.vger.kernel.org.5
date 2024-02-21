Return-Path: <linux-kernel+bounces-75372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC885E759
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D343A282B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F885C7C;
	Wed, 21 Feb 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJTFzrIL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97B42A8E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544102; cv=none; b=iOAYnIl6CHLVXe1FZVsl1yp0Vkih6I9scGAyzNrQn/FjbyWS81kd2QRVEdZ22wXtbkyTuaGxaRS3d9nfmLY4QuqreHbzoSQU+TisoXGHWbpYjg581cfcdB0Nymi92kdGmmcVIs/Y+rb/dYI7AyT2xgcQYLCgdboAZiLCA8QIHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544102; c=relaxed/simple;
	bh=44qEQdJMfaSNb11EbOKN6pmY9OPWEq2Zhb6DQ7St/Os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AmfNZn3DsaeDTmwfTbZjjlSdH+idv/mczYsWWe8SkdCytM5rpjnmzdLYSllu5XNWPLiLnZv0GN6ByRT9OrHHCHI2m+orqeuPqppMTm4OmB3IhXF9ze5rDlBcDC7s8+qmHa/4yhoqac4kwCG+xez0V7SEDqqu23p+MYanfmsSEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJTFzrIL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708544099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhDzXBG2uB7LKh7oAIx2e00L9hXw871RXOHRvEWuUyQ=;
	b=GJTFzrILHZ85Gls9uKs/czrJvd5GM8BstYCxxEG8kwShlJpyV9uh9P6Z9OLX2nqCJ0IUz1
	d7QVbHYNBBvNMcmVjxWcJo1q+E3OHJHUAxPPKNRfB0atk5j5YBPiTJMmy+XPi3v+UXZ53P
	+Gtt3bokzxIyQSi4OgarTSXH/mId4+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-wE8LQ5YxOiykAph_qfzG4A-1; Wed, 21 Feb 2024 14:34:58 -0500
X-MC-Unique: wE8LQ5YxOiykAph_qfzG4A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d07c0825aso3273268f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544097; x=1709148897;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhDzXBG2uB7LKh7oAIx2e00L9hXw871RXOHRvEWuUyQ=;
        b=jO5/uC+21OS3cpcCWBo9ocm6azTl06fr21SyzPcRTbFAvuZiFt4lOrRlPSSM9GdObb
         NIi6A2CmCkyPOF3kzfMLU9mSw7aOeis92Cf9DYnx5YWK1FY1GfnhlBof9A6WwVBTOGOD
         VNtLhn93eP/pqpt7qVidAwrjfGun/HhWKCBgKwKgk5CjAc38tNtMN+NdURswHdotvzb3
         7V8uEroWrEPfEK/dI+ZUuZ7VBIVW+3ICCdCspUMvRF6v+M4llLYVdDireQ5NyrRLSSLp
         t+V2gM+I1docCiU54CwFkT6kHKQUPWttoLLToEEw5DcCKdBsNiCUl2hL8X7Uprle6CV8
         f65g==
X-Gm-Message-State: AOJu0YwOGI/ClG5qj1Apwrcqw0iYJdeVSWNPiqtsXWBP9iXCwuiJ8rvz
	VnfwzurOcynq5DSXvHWwQ/rt4NUShN5luhLL6sDgSIAygPv4YLOUKtTu0wu2H3dBO7swfU8+cNS
	/bJK1N7emcOG75YRLOD9DmGrKWc8691gYul+prBydYiAUYsr02aDbgmIURkx8sw==
X-Received: by 2002:a05:6000:1f0e:b0:33d:6ef6:8762 with SMTP id bv14-20020a0560001f0e00b0033d6ef68762mr4263353wrb.29.1708544096875;
        Wed, 21 Feb 2024 11:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXx0/SAfI6jQhKxNACjf4FSDz7BKbVJ+p84OlFksnszRxAz1KEZmFC9JsBd8uwGiMrH3g3zA==
X-Received: by 2002:a05:6000:1f0e:b0:33d:6ef6:8762 with SMTP id bv14-20020a0560001f0e00b0033d6ef68762mr4263334wrb.29.1708544096410;
        Wed, 21 Feb 2024 11:34:56 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d66c5000000b0033af3a43e91sm17706755wrw.46.2024.02.21.11.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 11:34:56 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Maxime Ripard
 <mripard@redhat.com>
Cc: linux-kernel@vger.kernel.org, Enric Balletbo i Serra
 <eballetbo@redhat.com>, Erico Nunes <nunes.erico@gmail.com>, Brian Masney
 <bmasney@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
 <quic_bjorande@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
In-Reply-To: <9083c414-62f2-4bff-93ee-13f8ff60eb34@linaro.org>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <9083c414-62f2-4bff-93ee-13f8ff60eb34@linaro.org>
Date: Wed, 21 Feb 2024 20:34:55 +0100
Message-ID: <874je1ipb4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 21/02/2024 16:24, Maxime Ripard wrote:
>> On Wed, Feb 21, 2024 at 04:10:12PM +0100, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 15:48, Maxime Ripard wrote:
>>>> On Wed, Feb 21, 2024 at 03:22:38PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
>>>>>> These options are needed by some Linux distributions (e.g: Fedora), so
>>>>>
>>>>> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
>>>>> use on my arm64 boards, does not have any problem.
>>>>
>>>> Is it relevant in any way?
>>>
>>> Yes, because it is justification why we are doing it. Each commit is
>>> supposed to explain "why" and the explanation here is not enough.
>> 
>> There's a why though: it makes Fedora boot. It might not be enough for
>
> I want to know to understand. Maybe it is not really neeed but "nice to
> have"? People write various vague statements...
>

I usually try hard not to be vague. There was a why, it wasn't enough for
you and that's fair.

But I think the crux of the why was explained: I don't want to remember
each time that need to troubleshoot something, what options are missing
in order to boot Fedora.

>> you, but that's a different story. So, if it's not enough, please state
>> exactly what you expect from that patch description so Javier can
>> provide it.
>
> Any explanation what ZRAM is necessary for Fedora to boot.
>

I mentioned already in another email, Fedora is enabling the systemd
zram-generator and not having a /dev/zram0 slows down the boot to the
point of being unusable. One could disable that service but then is yet
another thing to remember when trying to boot an upstream kernel built.

Could had added all this information to the commit message but I thought
that it would be too much...

>> 
>>>> I'm sure Debian can boot without MEMORY_HOTREMOVE, or BRIDGE, or
>>>> NUMA_BALANCING, or BPF_JIT, or NFS_FS, yet all of them are enabled. Let
>>>> me know if you want hundreds more examples.
>>>
>>> So if there is any bug, you are allowed to add new one? If there is any
>>> silly option, you are allowed to add new one?
>>>
>>> Feel free to propose dropping of any irrelevant options.
>> 
>> No, of course you aren't. My point is that Fedora is a distro just as
>> established and legitimate as Debian is. And apparently "it makes Debian
>> works" is a reasonable argument, since, well, it does.
>> 
>> If making Fedora boot with that defconfig is not a legitimate goal,
>
> It is, but I asked for more information.
>
>> please state why, and document it (with the ack of all the maintainers
>> involved with that defconfig, obviously) so we don't have the same
>> argument over and over again.
>> 
>>>>> I kind of repeat comments from similar patch earlier:
>>>>> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org/
>>>>>
>>>>> About XFS: I don't think it is needed to boot anything.
>>>>
>>>> Just like 9P_FS, NFS or UBIFS.
>>>
>>> NFS is often used on targets, e.g. my board farm, but also by other people.
>>>
>>> UBIFS was added recently because one device was using it - you needed
>>> it. 9P_FS looks unnecessary.
>> 
>> So all we need is one person or use case to require it? Sounds like
>> we've checked that mark here.
>
> Use case of given type. I would disagree for SMBFS because we have NFS.
> UBIFS is hardware requirement. 9P_FS seems like virtio case.
>

So that means that for aarch64, some filesystems have more precedence over
others? It's OK to have ext4 or btrfs but no xfs? Honestly it seems quite
arbitrary and subjective for me.

>> 
>>>>> This is a defconfig, not a distro config. Please don't make it distro.
>>>>>
>>>>> I will gladly support things needed by systemd or equivalent, but not
>>>>> unusual filesystems needed by distro.
>>>>
>>>> It's a defconfig. It's whatever people want it to be. Or we need to come
>>>> up with a clearly defined set of rules of what is acceptable in that
>>>> defconfig or not, and prune every option that isn't.
>>>
>>> So that's the rule I am commenting from time to time. defconfigs are not
>>> distro configs. These are reference hardware configs and debugging
>>> configs.
>>
>> Supporting a board farm is hardly either.
>
> Debugging purpose, but I agree we can drop it.
>
>> 
>> And again, I've never heard of such rule for that defconfig in my ~10y
>> as an ARM platform maintainer. But what do I know, right?
>> 
>>> I was working in distro so trust me - they do stuff differently
>>> and they not need XFS in our defconfig for anything.
>>

Which distro? Every one uses a different filesystem. SUSE uses btrfs,
Debian I think ext4, Fedora uses xfs and so on. It's OK if the policy
is that the defconfig should only be compatible with Debian, but then
should be written somewhere.

>> Sure, but you're not just arguing for XFS there.
>
> I raised need for "why" for ZRAM and un-necessity of XFS. What's wrong
> with that? I should send separate emails or what?
>
>> 
>> What I really don't get is this: this makes the life of people easier.
>
> Again: this makes my life harder. I cannot be buying new machines every
> two years to be able to compile defconfig while testing/working.
>

And not having it enabled makes my life (and other fedora users) harder
because xfs needs to be enabled every time that an upstream kernel needs
to be tested.

>> 
>> Being able to test an upstream kernel quickly when you have a bug in a
>> downstream distro is super valuable for any distro developper. And on
>
> That's a distro need, not relevant. And even if it was, then your
> argument would be "let's enable everything distro has!". This is not a
> distro kernel.
>

It's not a distro need in my opinion but an upstream kernel developer
need. If I have had chosen xfs for personal preference, would that be
any different?

>
>> the long run, if we don't make the switch from a kernel distro to a
>> mainline kernel relatively easy, we're the ones that will lose out.
>> Because people just won't bother, or be frustrated and thus super
>> reluctant to do that work.
>> 
>> That's the part I don't get. Why do we want to make the life of people
>> harder. This patch has never been about making the defconfig the main
>
> Because it makes my life harder and I don't see benefits. Quoting Arnd:
> "Unfortunately this will increase build time noticeably, but"
>

The benefit is for developers who use Fedora to be able to boot their
kernels built using defconfig, just like developers using other distros
can now. We already have ext4 and btrfs, but somehow xfs is not OK.

> Best regards,
> Krzysztof
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


