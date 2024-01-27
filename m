Return-Path: <linux-kernel+bounces-41065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A483EB19
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A17B224E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFD2134BC;
	Sat, 27 Jan 2024 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XnZwdjn3"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F4A31
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706331229; cv=none; b=BtdLIZlCFL6I5ORgBA4evdd4NwXHuSyKIZ6EbXVTSvJBZhAhS/+JGFv8enJP1YgkmtNe9MlSFaIjGh3VHpuWHq6iun07VcQe+ukaVRE51Tk7Yux04OCgcvirRU9H2jLDN+dIXVZ5TC3CMekj/xL2bsOmDFFCOa+Bw3gWkkUo0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706331229; c=relaxed/simple;
	bh=MdyZOJ2MLG45IFKa5afWhzsDm/JXXyjM9TF8krZvgEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTmYtyFIFkSjn1n209LLaapqTKuN6SHTJPRm7pLt368NTRuZNPL/X9u5fqsra0X7XRaRpWIljVkStSFDSAcMMq8u7ui2qZLoBGeUqYcTmFT3VlwGh99XU+wNtnqvDIzXLd377vqY0wUyLEYLHmdtzaXOe+KM5XhDO1w9SabNbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XnZwdjn3; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 34DD21D26FC;
	Fri, 26 Jan 2024 23:53:46 -0500 (EST)
	(envelope-from adamg@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=MdyZOJ2MLG45IFKa5afWhzsDm/JXXyjM9TF8krZ
	vgEw=; b=XnZwdjn3fAWvCGp+AUGGGeADMRoO8oon8+VOVkf8fcpr9o19obkkKiE
	PVFZr2ZLy/EuTQOCz0PtnSGsCBUOUgFOgKIFMiIcdAlwdkL95WnQ487HEqY2WLV4
	mVCXoOflWC+dmCpaNHjF1KvqjVCLBM83wMFAq7NgU4YS72dIWLRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B9971D26FA;
	Fri, 26 Jan 2024 23:53:46 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from pogo.deviceside.com (unknown [71.19.144.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7955A1D26F9;
	Fri, 26 Jan 2024 23:53:45 -0500 (EST)
	(envelope-from adamg@pobox.com)
Received: from iguana.24-8.net (99-122-168-208.lightspeed.irvnca.sbcglobal.net [99.122.168.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: iguana@pogo.deviceside.com)
	by pogo.deviceside.com (Postfix) with ESMTPSA id 45F81C09AC;
	Fri, 26 Jan 2024 20:53:44 -0800 (PST)
Date: Fri, 26 Jan 2024 20:53:42 -0800
From: Adam Goldman <adamg@pobox.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: mask previous entry's type bits when
 looking for leaf
Message-ID: <ZbSMVdOZB1zusXmo@iguana.24-8.net>
References: <ZbJQ0JdbGixJouvn@iguana.24-8.net>
 <20240126011705.GA22564@workstation.local>
 <ZbNyHg3TTWpjiieI@iguana.24-8.net>
 <20240126121917.GA99160@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126121917.GA99160@workstation.local>
X-Pobox-Relay-ID:
 0D2A065E-BCD0-11EE-95EC-25B3960A682E-07713566!pb-smtp2.pobox.com

On Fri, Jan 26, 2024 at 09:19:17PM +0900, Takashi Sakamoto wrote:
> I think we can handle the quirk of configuration ROM without changing
> the kernel API. Would you test the following patch? (not tested in my
> side).
> 
> ======== 8< --------
> 
> >From 83bf1e04d308ea89c76c64e3168b9701f9d9191b Mon Sep 17 00:00:00 2001
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date: Fri, 26 Jan 2024 20:37:21 +0900
> Subject: [PATCH] firewire: search descriptor leaf just after vendor directory
>  entry in root directory

Hi Takashi,

I tested your patch with the DVMC-DA1. I also tested it with another 
device with normal placement of the leaf entry. In both cases, it works.

-- Adam

