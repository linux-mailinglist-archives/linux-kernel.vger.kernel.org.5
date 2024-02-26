Return-Path: <linux-kernel+bounces-82138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D650F867FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C83BB2615E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7B12F382;
	Mon, 26 Feb 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIgrb9UE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267B12E1D5;
	Mon, 26 Feb 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972016; cv=none; b=cdNHIEmoB41f5DTBMEg5TK+mDeHyHF70McBUfOkoWnBT1s0E1EuBM+NC7uX0dj6ohHa2Qdwa1f6r2lKtWADPtnawJWQdTIhtDOo+8LjGSAdE3ehIPYQ4VL1nFR0XPe+aFj8E+jvbyhDda6RudUgXneN+AAr/Mlks5UW7KWqpfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972016; c=relaxed/simple;
	bh=OTxvF98lM2wvLgv0ClcVHjVFjeuU5uCdkdQwK6EWat4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usIL04tIWYxNxSKL4690D0TGh2TC+imXdWLS9tRGCJTB1hlEhzOIpqmwH3NXd4l1qGcxMa96WJv7fBFwg82b/GoIcO8sDsyyglFtdAKg0PjU0iTkjnblgSz0BD1Xzztk4L3arxjcFrhkEWoYGwiw5HQ8fSB+BSVfyJPQFqITDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIgrb9UE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9919C43390;
	Mon, 26 Feb 2024 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708972016;
	bh=OTxvF98lM2wvLgv0ClcVHjVFjeuU5uCdkdQwK6EWat4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIgrb9UELylu7ArM6YZNsOH5YDhIEIFuF5rm04hfK7/ZI442HhovZnrY1lHYJpFIB
	 mJ2d0RHqgomX7D1M9EHMQoiSDU4UrTKdAE612mLR9UUoMkR2kH13lVcWOg442fKNfU
	 OeiW+4HKyukOlmbU3nIs/RRWbjoGkSEkA15Au9erqXnbJYpRIKTsQSSP6+TNJr5KNq
	 L7zzJf9V8WiryBd7DmZz6o9Va66/YDIDihR3UVKjbs8YHfLBTH5V0K6pc1BEEwt3v+
	 J+wk9z5grS7W6XJwZrKTdVT+ct2BCyRNFDuucB+3eFQ/2JDIR1yPL2p45d1yGHsLR/
	 jYjboCbYyqWxQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1refgj-006zTZ-GD;
	Mon, 26 Feb 2024 18:26:53 +0000
Date: Mon, 26 Feb 2024 18:26:53 +0000
Message-ID: <868r372iaa.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Walbran <qwandor@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/8] arm64: KVM: Write TRFCR value on guest switch with nVHE
In-Reply-To: <20240226113044.228403-8-james.clark@arm.com>
References: <20240226113044.228403-1-james.clark@arm.com>
	<20240226113044.228403-8-james.clark@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.clark@arm.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, suzuki.poulose@arm.com, acme@kernel.org, oliver.upton@linux.dev, broonie@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, miguel.luis@oracle.com, joey.gouly@arm.com, ardb@kernel.org, javierm@redhat.com, mark.rutland@arm.com, arnd@arndb.de, qwandor@google.com, vdonnefort@google.com, ryan.roberts@arm.com, tabba@google.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 26 Feb 2024 11:30:35 +0000,
James Clark <james.clark@arm.com> wrote:
> 
> The guest value for TRFCR requested by the Coresight driver is saved in
> kvm_guest_trfcr. On guest switch this value needs to be written to
> the register. Currently TRFCR is only modified when we want to disable
> trace completely in guests due to an issue with TRBE. Expand the
> __debug_save_trace() function to always write to the register if a
> different value for guests is required, but also keep the existing TRBE
> disable behavior if that's required.
> 
> In pKVM, the kvm_guest_trfcr can't be read and the host isn't trusted,
> so always disable trace.
> 
> __debug_restore_trace() now has to restore unconditionally, because even
> a value of 0 needs to be written to overwrite whatever was set for the
> guest.
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/debug-sr.c | 53 +++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> index 4558c02eb352..3adac2e01908 100644
> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> @@ -51,30 +51,39 @@ static void __debug_restore_spe(u64 pmscr_el1)
>  	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
>  }
>  
> -static void __debug_save_trace(u64 *trfcr_el1)
> +static void __debug_save_trace(struct kvm_vcpu *vcpu)
>  {
> -	*trfcr_el1 = 0;
> -
> -	/* Check if the TRBE is enabled */
> -	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
> -		return;
> -	/*
> -	 * Prohibit trace generation while we are in guest.
> -	 * Since access to TRFCR_EL1 is trapped, the guest can't
> -	 * modify the filtering set by the host.
> -	 */
> -	*trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
> -	write_sysreg_s(0, SYS_TRFCR_EL1);
> -	isb();
> -	/* Drain the trace buffer to memory */
> -	tsb_csync();
> +	u64 host_trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);

Ah, and on top of that, this is already broken with hVHE.

I'll send a patch.

	M.

-- 
Without deviation from the norm, progress is not possible.

