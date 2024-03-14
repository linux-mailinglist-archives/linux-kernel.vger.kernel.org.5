Return-Path: <linux-kernel+bounces-103145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D387BB93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2EF284AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC2A6E61F;
	Thu, 14 Mar 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="WxhAGRs4";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="obhki2np"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E75DF26;
	Thu, 14 Mar 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413722; cv=pass; b=QjdrAcOujlDH6QM+GDArudxPLJQoBjswAV2y8dI0iejzVgcdZ357OVjW5SL3KEpaRqV6VWzzhkM2ULplIogm7dUiFDD4+aacjI1SqzzjhmVPzzlCbwCcvMyTf292otZ6htK6zsVFS4J3p576j57vZALIfpJExrXiqCT22/JT6Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413722; c=relaxed/simple;
	bh=5Mlh1dcRnKpNeVMcrPE+wtgDR6dHD0xA/6rSNkR/WPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXH5pasBN5OrtY5vYDr5FMM3f93Nd3FFp8yGIQmNukm3DjB8SkJDU3n0eBZeYPAdsmVdm212/uw7rfOzmx9Ft1ntjOnfaNUe/SUJbHWd+5tDAMt38nqAeHmIwn3Rj60ATV/LAg2r0adiN7BFZdJ2JpYzQfVytyMz1xobPp+zrVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=WxhAGRs4; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=obhki2np; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710412989; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gRH3y8Wad4o19BgEy7gsZdoGwhESoodVPrUJEbP6IJz3S46XWqY6uIKeYXVQA6DxpN
    pjnL5QHq96KBxyyaTbRmjjk0ovd+hT1wqaMOj6GIzJzn0cZq0qWNxJ0i9OFI6Ipi+3Nq
    QUUmeT4WlH2/EE4k6FI6q0g7ZDwUm9E7YJn68nvPU7M2/NdIg07oNVkRAJEDX59iGPJZ
    6hZNGoPmR7TZzkeWKXunRRTAEieIYia656y652o10u/aMjD/7eCHY+V1mhwYgPJHA395
    6GxC5lSH52UP5ujzPjK4LxxxzArTSQ5g+NgH8ImBHCdx9lYbi6uWRdz+GlxpYGUoTSU4
    NsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710412989;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ryy163wa7Qo8B3Bx14jA3mQ/ycTYjqbynQbd8t6adXs=;
    b=kgUnNGLF0f7Moc+6/rwpARmOYUaBHuKsduQH3PbAnVuPf78VDpSlpIFIltFI7vqmvF
    JG4eH/O/zGDo9/V6vcMBFH7UNCkp6UJaBL9pvIZwN1nzAMt4dkBq95R6O1+Ad/qqfg1N
    JIfVS8/sO5Rb9Ogi3TVDZFCwdyhyA5e++Ma3hp6FeJpAhVy4EuvJmFGz4FKmEpmpsolR
    TSbYEAJm42M28dc8QMgY7WaDXxiXUafIr+pOoqxABtNUKxjf7zxgym71NssDPOUcC6cC
    kqMN4nduv7/O6+t9Qw+iFrd1EfPnmPm1Lq3nC7ACGeTR6RwZi8vc2Jpn9CczvlkIcDHH
    /zGg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710412989;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ryy163wa7Qo8B3Bx14jA3mQ/ycTYjqbynQbd8t6adXs=;
    b=WxhAGRs4hiAgJnjfr3zwcw1BblYInnEOBtqPUkGRzVOdokUPP58WVNJpXkx4SYAYPL
    A5J5iulpmKWFlPaoIWGGGEkDauvj3F9wwfbA/iCXjqlkMwqd/ki9Lse7w+Q5FW9jXVUE
    ULz8gXJz+j9lHNwOPJQJR6P8TyES7kKQ17+9TxAclbJaEKgh3H2W8gNSS4fG7iFBy19U
    rMtdRGV4nWVqmyzHpfF6gqvkBmU39TLA7uqovpaoWJ1SyeyoUDfpIFUbDTeyhq9nYV9t
    IlO3zIAY6QE6KKAXLFLQUkVCQDtbAKvItoFV86MTTk06yWrPQ8Q7ohBKqNJ4YD8rajWu
    DTlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710412989;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ryy163wa7Qo8B3Bx14jA3mQ/ycTYjqbynQbd8t6adXs=;
    b=obhki2npfVLWqKBHiwN9sMlUoGuBG0oVOw3DifkqpK8YhTjC9QRuqJU0rochmKF/H/
    EOjlXpi9okJF0WH/FIBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.2.2 DYNA|AUTH)
    with ESMTPSA id Rf2ecd02EAh83Ub
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 14 Mar 2024 11:43:08 +0100 (CET)
Date: Thu, 14 Mar 2024 11:43:07 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, andersson@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, caleb.connolly@linaro.org,
	neil.armstrong@linaro.org, laetitia.mariottini@se.com,
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
	benjamin.missey@non.se.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Jagdish Gediya <jagdish.gediya@linaro.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
Message-ID: <ZfLUu6_Vq7MvG2G3@gerhold.net>
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org>
 <c0e10cbf-c6f3-4b0c-8616-983da2a40236@linaro.org>
 <CAFA6WYNMjCaa0FKjNv6a8VFkco3=GBfgWNDuckGZdiZ9dGmHgg@mail.gmail.com>
 <d82ab1f8-e677-485f-9a6b-4115acfd7239@linaro.org>
 <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNSumyScax=GkN42GJOG56T3odF5Ed9A2i1nk_exCyGtA@mail.gmail.com>
Content-Transfer-Encoding: 7bit

On Thu, Mar 14, 2024 at 03:02:31PM +0530, Sumit Garg wrote:
> On Thu, 14 Mar 2024 at 14:48, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > On 3/14/24 10:04, Sumit Garg wrote:
> > > On Wed, 13 Mar 2024 at 18:34, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > >> On 3/13/24 13:30, Sumit Garg wrote:
> > >>> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > >>> Box Core board based on the Qualcomm APQ8016E SoC.
> > >>>
> > >>> Support for Schneider Electric HMIBSC. Features:
> > >>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > >>> - 1GiB RAM
> > >>> - 8GiB eMMC, SD slot
> > >>> - WiFi and Bluetooth
> > >>> - 2x Host, 1x Device USB port
> > >>> - HDMI
> > >>> - Discrete TPM2 chip over SPI
> > >>> - USB ethernet adaptors (soldered)
> > >>>
> > >>> Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > >>> Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > >>> ---
> > >>
> > >> [...]
> > >>
> > >>> +     memory@80000000 {
> > >>> +             reg = <0 0x80000000 0 0x40000000>;
> > >>> +     };
> > >>
> > >> I'm not sure the entirety of DRAM is accessible..
> > >>
> > >> This override should be unnecessary, as bootloaders generally update
> > >> the size field anyway.
> > >
> > > On this board, U-Boot is used as the first stage bootloader (replacing
> > > Little Kernel (LK), thanks to Stephan's work). And U-Boot consumes
> > > memory range from DT as Linux does but doesn't require any memory to
> > > be reserved for U-Boot itself. So apart from reserved memory nodes
> > > explicitly described in DT all the other DRAM regions are accessible.
> >
> > Still, u-boot has code to fetch the size dynamically, no?
> >
> 
> No U-Boot being the first stage bootloader fetches size from DT which
> is bundled into U-Boot binary.
> 

Back when I added support for using U-Boot as first stage bootloader on
DB410c the way it worked is that U-Boot used a fixed amount of DRAM
(originally 968 MiB, later 1 GiB since I fixed this in commit
1d667227ea51 ("board: dragonboard410c: Fix PHYS_SDRAM_1_SIZE") [1]).
When booting Linux, the Linux DT was dynamically patched with the right
amount of DRAM (obtained from SMEM). So if you had e.g. a Geniatech DB4
board with 2 GiB DRAM, U-Boot was only using 1 GiB of DRAM, but Linux
later got the full 2 GiB patched into its DTB.

I didn't have much time for testing U-Boot myself lately but a quick
look at the recent changes suggest that Caleb accidentally removed that
functionality in the recent cleanup. Specifically, the SMEM-based DRAM
size detection was removed in commit 14868845db54 ("board:
dragonboard410c: import board code from mach-snapdragon" [2]), the
msm_fixup_memory() function does not seem to exist anymore now. :')

Also, the DRAM size is now always taken from the DT (which is probably
better than the previous hardcoded size in the U-Boot board code).

I think we should bring the dynamic DRAM size detection back, because
there are quite some boards available with varying DRAM size. Restoring
msm_fixup_memory() would likely be easiest, I guess the ideal solution
would be to parse SMEM in U-Boot's dram_init() function so even U-Boot
has the correct amount of DRAM to work with.

Thanks,
Stephan

[1]: https://source.denx.de/u-boot/u-boot/-/commit/1d667227ea512537b8453abeb49abbf19a1a18e8
[2]: https://source.denx.de/u-boot/u-boot/-/commit/14868845db54b4f64701977385dc9a6e951e4139

