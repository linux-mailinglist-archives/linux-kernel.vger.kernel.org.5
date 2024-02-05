Return-Path: <linux-kernel+bounces-52680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF9849B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096E52817DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F91C6A3;
	Mon,  5 Feb 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VwXgkThs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C941B962;
	Mon,  5 Feb 2024 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138351; cv=none; b=qB7o6xbG5aGoh1u3fmOzgnEDDF5SqwmglPlTiME+7ihbKNYeIspzktKdSEToxAuFqs7iO7QEIwVI4Zh3wj8Th5xPmRDj/tGba33MMJ4CV5o9arpWL52K9rMNkEQkMNmYOtqkMbk6j6A+MlhAeKPbVQODCG+R6i7JjzoZm5XxQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138351; c=relaxed/simple;
	bh=6V8uf0N3Xm/UvMoZwTYB06Qu615ajXrJkVS3vh+jkDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2fzTeaII6f2s1r/U2gxkkYRouyj3R65HeOd0fHZfGbHT7t38C2kPoQsSkNxJXK1sFEUfmTvp1/t061Q2pVxuk8cjNEfTLI0UqD1lbxu2WGqnyFhfZdIo+oBQHqp9FIppqpTMfuYUhcFM8rc//zeWZw5B9ita9Sjydx6RjcblQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VwXgkThs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 059A840E00B2;
	Mon,  5 Feb 2024 13:05:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z0d7F3KIc62J; Mon,  5 Feb 2024 13:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707138343; bh=enA/cpWfJIAhcvZX1vqODbUKVwndaQoP+ixMrDmiOqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwXgkThss17myyQa6Obw2oLVAhNHyeox+iAnF3X3Meg8uGX58pRTZtEyWkx51MVYA
	 6dqSLW02h8ecfIdxO1jpmDHAVi72c2xyEY4i4oGscZDiPcfz1JfKiCXxJhHMvK57/9
	 62t58SzRoCvCTbnFHUrl2O7yVYNDXGuUm7DEgzJHDbMcvMtevp3D/aUEuxOK/xdoRm
	 psDYLpjzY6m3cDJxQoXJEfosaQacatIzjF7o1gDS74ZbH1vPlnRBwsTtsfU/UbMfZD
	 aCpSiAtA2sW3/oTAuYvJS5ot/GX+GAjoEu6oQRjaTMs2vySJLYsOqyehrhJ9r+aa9I
	 osXT1kCFzc7eWWrnl0ET/qgITp68c4KHxCAG7D37sk9RX9+84iFVpPXq12JjSdDEjt
	 /I9lWeOfIV+a6gYi6bT2GVyLbt/HAAJi1znbndBbP6SbNE/eheg3BY6rN9/pQCkL++
	 T9UMtO8/6jzk1Sp+UR7/CQvm1nugLKbg0+kvfDg3gClSLerZ98mVV5mB7GjYXIi1Up
	 3Mw8bBOaEhSbKPWA58czok00L/H+AYvVQnon5UuHza56sra+VmvvVqC3mVsdmZ4O/R
	 EZCzzmFmf073IPBcT9SKLcjGew7T6CsLE0DXrz70RuMIWsVWGqphzKKqtotZKwq2Zp
	 9vQifc8wXDKOQOM9g2jonLv8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFE1940E016D;
	Mon,  5 Feb 2024 13:05:37 +0000 (UTC)
Date: Mon, 5 Feb 2024 14:05:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com, muralidhara.mk@amd.com
Subject: Re: [PATCH] EDAC/amd64: Add MI300 row retirement support
Message-ID: <20240205130532.GDZcDdHLp6GVaNER10@fat_crate.local>
References: <20240204155106.3110934-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204155106.3110934-1-yazen.ghannam@amd.com>

On Sun, Feb 04, 2024 at 09:51:06AM -0600, Yazen Ghannam wrote:
> AMD MI300 systems have on-die High Bandwidth Memory. This memory has a
> relatively higher error rate, and it is not individually replaceable
> like DIMMs.

..

>  drivers/edac/Kconfig      |  1 +
>  drivers/edac/amd64_edac.c | 48 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

