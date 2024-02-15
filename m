Return-Path: <linux-kernel+bounces-66565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E642855E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DE8282196
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D211B949;
	Thu, 15 Feb 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqbcpMwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5631B941;
	Thu, 15 Feb 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989871; cv=none; b=mqBphtoaNygibm+xEDSm0tggU5OOE9enhFCjwefhiEK48yxYc5WcJ3UXjXR2DigBdfdRZgkggEWULNnPreMQNg3AkjOrK2zkjbQFMbz/nOvLbi0GAPMd6ep6ertJavyhvtMwu1N7/G93W4x1XHjI2XX3MaaFIz4jSATauGPHyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989871; c=relaxed/simple;
	bh=XWzXYMIAl5du5PxNXpMtWrx/xUd9S1UtlNgDsdvpVYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT/GSWMgPusdLgE/4W42WfK9/qHWfhKGRVD1WVeGXE9wx3BXoSjNN5VWl5XWa1fuiL38HNsdioCVKZKCWzV7jB702PMCj+KhP9OZ+t+zUHplwVTr1jc5RxWAZoS+p4BzjHtzc8HYfs9Kc6Tp93SN8fHIF8CO7RFrKVu67sTgNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqbcpMwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A187BC43601;
	Thu, 15 Feb 2024 09:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707989870;
	bh=XWzXYMIAl5du5PxNXpMtWrx/xUd9S1UtlNgDsdvpVYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tqbcpMwt+RJK0bT7zP5Thwu2cDEM//NkD7FkrqHiee0uQahAhGkG2bKaJHrDnrOkM
	 /FVOdoC9PgkgNJ2liE5LmZoTTyQJ+S8LFWvEtyHL6RmenbCdbr6kBiHg+N2SzDWGdS
	 PoQ4kO/UbSgPGgUUDW9MgcCl1rL+6AVaYsCjvLL9GZjGqzf8gVZYtkV4T7LTC4/PUQ
	 3D2iXUaGlspgYCOy84t5gcugYZLsxQ9ZU/XJLWgaEQu0Ayjkn6NlG+M2EiP84niTsW
	 egnLzkuT+sXI/5tGJUhQG/+2nKlqSSaYJCgsT8FtO0+8+/84DFpidNICbscDf7n1G5
	 SDXRlw6yKlQ5w==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563a6656c46so880369a12.1;
        Thu, 15 Feb 2024 01:37:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAmedFYP1efxGdMvnx9c04A7cVya7J1mkew9lfzqurRXt+866NHkDrlYVK1aKXtfLempZ2maGWnVWoReJH8Ah/Gnbi61nWFPbPpB9/H7aEnFq7HBedAFd9tI2K0Le2QvnaxvKxZ0+MoIJawLafVrcOxLQigca0bhFnrQI6Njj5F6TE9uIJYxAlDyZBHo2Ga76WxxTt4J9NoWRrmmKmfqlAjN4=
X-Gm-Message-State: AOJu0YyJfpuXgRAlDj3eOelr3jSxb6k6eu/2NEuLACyWtWBF6XEGLCwi
	K+oITGevDmG1pHjNNbORL8Jep3/AD7efKyGDyEb/dKYpMFhNs7iGshI434IAMTLTygomzptYYu9
	LK6BplnaZS2CBugK0nRvKlcElWng=
X-Google-Smtp-Source: AGHT+IEmBloe5542STqKSjMgCQLk/2kmMzo0mUwVRqwPEAS+jeamlb9AXP+9iombv2qJdh1ZY+MCjKhV36aat8bfIJI=
X-Received: by 2002:aa7:cd46:0:b0:561:f211:fcdb with SMTP id
 v6-20020aa7cd46000000b00561f211fcdbmr871927edw.1.1707989869133; Thu, 15 Feb
 2024 01:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
 <1707524971-146908-2-git-send-email-quic_obabatun@quicinc.com>
 <CAAhV-H5f5e-cCaX7Gr20oG8F-aywJcosLn4ajxx2SQWoB8JtSA@mail.gmail.com> <03c2c48d-d05f-4906-b63b-711c94133489@quicinc.com>
In-Reply-To: <03c2c48d-d05f-4906-b63b-711c94133489@quicinc.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 15 Feb 2024 17:37:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7LjadN99OAdpX4OxU-bcjVC45iUwrzTfQz28UMc0K0JQ@mail.gmail.com>
Message-ID: <CAAhV-H7LjadN99OAdpX4OxU-bcjVC45iUwrzTfQz28UMc0K0JQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] loongarch: Call arch_mem_init() before
 platform_init() in the init sequence
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	robh+dt@kernel.org, frowand.list@gmail.com, linux-openrisc@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Oreoluwa,

On Thu, Feb 15, 2024 at 5:31=E2=80=AFAM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
>
> On 2/14/2024 5:03 AM, Huacai Chen wrote:
> > Hi, Oreoluwa,
> >
> > On Sat, Feb 10, 2024 at 8:29=E2=80=AFAM Oreoluwa Babatunde
> > <quic_obabatun@quicinc.com> wrote:
> >> The platform_init() function which is called during device bootup
> >> contains a few calls to memblock_alloc().
> >> This is an issue because these allocations are done before reserved
> >> memory regions are set aside in arch_mem_init().
> >> This means that there is a possibility for memblock to allocate memory
> >> from any of the reserved memory regions.
> >>
> >> Hence, move the call to arch_mem_init() to be earlier in the init
> >> sequence so that all reserved memory is set aside before any allocatio=
ns
> >> are made with memblock.
> >>
> >> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> >> ---
> >>  arch/loongarch/kernel/setup.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/set=
up.c
> >> index edf2bba..66c307c 100644
> >> --- a/arch/loongarch/kernel/setup.c
> >> +++ b/arch/loongarch/kernel/setup.c
> >> @@ -597,8 +597,8 @@ void __init setup_arch(char **cmdline_p)
> >>         parse_early_param();
> >>         reserve_initrd_mem();
> >>
> >> -       platform_init();
> >>         arch_mem_init(cmdline_p);
> >> +       platform_init();
> > Thank you for your patch, but I think we cannot simply exchange their
> > order. If I'm right, you try to move all memblock_reserve() as early
> > as possible, but both arch_mem_init() and platform_init() call
> > memblock_reserve(), we should do a complete refactor for this. And
> > since it works with the existing order, we can simply keep it as is
> > now.
> >
> > Huacai
> Hi Huacai,
>
> Thank you for your response!
>
> I'm not trying to move all memblock_reserve() to be as early as possible,
> I'm trying to move the call to early_init_fdt_scan_reserved_mem() to be
> as early as possible. This is the function that is used to set aside all =
the
> reserved memory regions that are meant for certain devices/drivers.
>
> The reserved memory regions I am referring to are explicitly defined in
> the DT. These regions are set aside so that the system will have either
> limited access or no access to them at all.
> Some of these regions are also defined with a property called no-map
> which tells the system not to create a memory mapping for them.
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/re=
served-memory/reserved-memory.yaml#L79
>
> Hence, setting aside these memory regions should take priority and should
> be done first before any memblock allocations are done so that the system
> does not  unknowingly allocate memory from a region that is meant to be
> reserved for a device/driver.
>
> Eg:
>     unflatten_and_copy_device_tree() eventually calls memblock_alloc():
>     https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L1264
>
>     Since unflatten_and_copy_device_tree() is called in platform_init(), =
this
>     allocation is done before we are able to set aside any of the reserve=
d
>     memory regions from the DT which is supposed to be done by
>     early_init_fdt_scan_reserved_mem() in the arch_mem_init() function.
>
>     Hence, it is possible for unflatten_and_copy_device_tree() to allocat=
e
>     memory from a region that is meant to be set aside for a device/drive=
r
>     without the system knowing.
>
> This can create problems for a device/driver if a region of memory that w=
as
> supposed to be set aside for it ends up being allocated for another use c=
ase
> by memblock_alloc*().
OK, then I think the best solution is move
early_init_fdt_scan_reserved_mem() to before
unflatten_and_copy_device_tree() in platform_init().

Huacai

>
> Regards,
>
> Oreoluwa

