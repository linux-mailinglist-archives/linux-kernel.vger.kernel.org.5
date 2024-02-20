Return-Path: <linux-kernel+bounces-73692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33885C608
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858961C21401
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CF14F9D2;
	Tue, 20 Feb 2024 20:47:13 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9A612D7;
	Tue, 20 Feb 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462033; cv=none; b=s0zToK+tK/er3EHUydFiqNpV9ebyGkNnmTgEI8DZMgx7BKETPKumOTGtVZU3cgC7AtsnvFKSds3sqFVv0JSxq3FpNIsWTdiCek7CZHksWOwsWkKd1+HejH/o5mzykmZiu7o4y4XBJeTFmPOCryAE4arLejHsLaJ6kUNbUemsGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462033; c=relaxed/simple;
	bh=UlmFQVKQFIKeaxAhu0UpvkO+T39cAw7EkBC3x/VsA9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqeEoNKp1vU4yLVtu7BsGjlSjHqyqTZqYLV9kXAEfHh2UKV95tcu8l3UUIoExlHnyBrBzRifm9Kbf/xUwfPvgiWj//Bon7XSmAJjh+crhTVnTIEzSnJIDBIDqhFt4h9U3aV/djiGx3a/zc+eEWhtKK0fQ2az60ctA43sRwHAFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6299620009;
	Tue, 20 Feb 2024 20:46:58 +0000 (UTC)
Message-ID: <ac11967c-3ab4-42be-86ca-0d40c35eee04@ghiti.fr>
Date: Tue, 20 Feb 2024 21:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] riscv: dts: Allow BUILTIN_DTB for all socs
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Yangyu,

On 20/02/2024 20:01, Yangyu Chen wrote:
> The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only. This
> patch moved this configuration to entire riscv.
>
> Although BUILTIN_DTB is not a good choice for most platforms, it is likely
> to be a debug feature when some bootloader will always override something
> like the memory node in the device tree to adjust the memory size from SPD
> or configuration resistor, which makes it hard to do some debugging. As an
> example, some platforms with numa like sg2042 only support sv39 will fail
> to boot when there is no ZONE_HIGHMEM patch with 128G memory. If we want


Orthogonal to this patch, but if needs be, we can fix this issue with 
128G on sv39 by changing the sv39 address space layout, we still have 
room to gain the 4G you miss, at that time I was pretty sure that amount 
of memory would come with sv48 :)

Thanks,

Alex


> a kernel without this patch to boot, we need to write the memory nodes
> in the DT manually.
>
> Also, changing DT on some platforms is not easy. For Milk-V Pioneer, the
> boot procedure is ZSBL -> OpenSBI -> LinuxBoot -> Linux. If DT gets
> changed, OpenSBI or LinuxBoot may refuse to boot. And there is some bug on
> LinuxBoot now which does not consume --dtb argument on kexec and always
> uses DT from memory. So I would like to do debugging on DT using
> BUILTIN_DTB, which makes it very simple, I can even install the kernel in
> the distro's way and provide a kernel package for other users to test.
>
> Yangyu Chen (1):
>    riscv: dts: Allow BUILTIN_DTB for all socs
>
>   arch/riscv/Kconfig                  | 16 ++++++++++++++-
>   arch/riscv/Kconfig.socs             | 32 -----------------------------
>   arch/riscv/boot/dts/Makefile        |  2 +-
>   arch/riscv/boot/dts/canaan/Makefile |  2 --
>   4 files changed, 16 insertions(+), 36 deletions(-)
>

