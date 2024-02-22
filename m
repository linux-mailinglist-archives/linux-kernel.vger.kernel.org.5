Return-Path: <linux-kernel+bounces-76909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276A85FE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5809B2170C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649D154445;
	Thu, 22 Feb 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="NlouxiFP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oxPaP+Ug"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448518657
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620854; cv=none; b=S4ZZqnO71VE1hbAGz3pDCB9V8UlmYJZpjgf6wE4WOUGkOMcBRBcAseHIy1tHZ1aAnXGIQ0RKjgeANEuEBIrB62nDGtVMLHlHcWHODiE4QYsjbn8f75HiA0R1noWRKxPKO+YsiNcaAtYySmG3WK2zfqlqspexAyX1cbvfdsv++Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620854; c=relaxed/simple;
	bh=vDoQ0aZbTs8ZLCh+uLJfUxNhj3TaGAQaNzYPkZ8iGCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKYeYoEpC3jyByxeKVsbInnU1ZKQtxsYrgTsHbC+7y13uM1LPqN3CrbJBm1l04s4Jyt0UwuRljVtR4EB5LDY5nE6oQTtLUwJfF9HbYQ0smF4GZ17Tthcl4Jta1oBPD2Xw3lNnH770T1C82hGPPMhKGAL1grPwEakUMLKhegoS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=NlouxiFP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oxPaP+Ug; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A7A261380095;
	Thu, 22 Feb 2024 11:54:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Feb 2024 11:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708620851; x=1708707251; bh=hqDRJV0DN2
	B7E3tvQrfx/1Luut6HMg4FaRuM4DS0KaA=; b=NlouxiFPbV2TARaux11uWq6dUI
	bkUbvBmcBDmga0gZg8kbx7hMoZ0JMqRPafOXzbRStob+8TdtAMJslENFPKpx3GIh
	bB97s7TPFaWV2ObNJ7pCUpqFe4giEElT4IZCAraKdPAtlPQlIQvlGGww9zrAuoWb
	eS9Grx759gJ6nH5ROvk7fxpjR4zQacmw9Dxlwah3SWzO3ZMC6Gr6g9lt3YAog1Sg
	FSYjgKZA751nffP09YpR7E1yYEfR/HFXCDh3rVbxylqfZhT2W3LN1Cbsgv8QC3mw
	AeX+c4ffwlSun7t0LpsezotqW4obs0LlfoXqrknsXVxl/3QO8+PWBmYvvcYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708620851; x=1708707251; bh=hqDRJV0DN2B7E3tvQrfx/1Luut6H
	Mg4FaRuM4DS0KaA=; b=oxPaP+UgUwiZDlHbKg1ZjeTTxj4TUkjM95HguTL6i3+0
	cv6lYdZ9OnmIp2BwjpKH0HsWkVNf+zrbBe2pi74waZKCyyjmSlkLW7DVET5Nt4fq
	sMVm9+o9DXEmqsMUCq/lpngmtyOz4VCr5S4NyCuOuYkY5Fzdp7sO0jLpDtSccJ4r
	x4qHp+bNnReK6YOGAhNEFSSaxmalLOY7FcFVfbvWUydvSyOEA4Yjuk07zQuvebmy
	fUjKegspBImEjX0z009LOiVfcAWUzRARkF6Rk4WE+0erJTSxZ2YdX7SGzy57IDc8
	OyrBJkSKwil+Ry4S01G9XFKO3MGkaMyqAaNxnFjf5g==
X-ME-Sender: <xms:M3zXZYdj4AmnCTS_S3T1UUxFuxx4IrtcL-jpYeeGBva8FeuAx68haA>
    <xme:M3zXZaPGX-jLumteZDwuuQM3nDtgjC4RmSbEWv18UNQZWaHN4b7K_Tiaj26mvqQkM
    8NdS3OuAPg4EeRi3zo>
X-ME-Received: <xmr:M3zXZZhd4mxH8DuSWFq9xh98_p0gF6U_3TdUknDJ0TSyEE-rly0rQDfqZRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:M3zXZd_VexkW1X8GUffLjYAc4qPGjO0Y6aXmfHq7Da7bqRaO7Y_fiw>
    <xmx:M3zXZUsuuOP_eMBPNSMqU7s7z5KxMnvH88bPDlZ7kReyBq00hRGcLQ>
    <xmx:M3zXZUG0DadupP3jF5YBxx0-lhd90sgQS8tuxEQR7nExkT1uaQyNdA>
    <xmx:M3zXZYi4WadPUMsB4hjRt9Aib40vld5Mv13uEOgLwpIMpivlvvc7_g>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 11:54:10 -0500 (EST)
Date: Thu, 22 Feb 2024 09:54:08 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: brauner@kernel.org, stgraber@stgraber.org, cyphar@cyphar.com,
	linux-kernel@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
Message-ID: <Zdd8MAJJD3M11yeR@tycho.pizza>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>

On Thu, Feb 22, 2024 at 05:09:15PM +0100, Alexander Mikhalitsyn wrote:
> +static int pid_max_nested_limit_inner(void *data)
> +{
> +	int fret = -1, nr_procs = 400;
> +	int fd, ret;
> +	pid_t pid;
> +	pid_t pids[1000];
> +
> +	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
> +	if (ret) {
> +		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
> +		return fret;
> +	}
> +
> +	umount2("/proc", MNT_DETACH);
> +
> +	ret = mount("proc", "/proc", "proc", 0, NULL);
> +	if (ret) {
> +		fprintf(stderr, "%m - Failed to mount proc\n");
> +		return fret;
> +	}
> +
> +	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
> +	if (fd < 0) {
> +		fprintf(stderr, "%m - Failed to open pid_max\n");
> +		return fret;
> +	}
> +
> +	ret = write(fd, "500", sizeof("500") - 1);
> +	close(fd);
> +	if (ret < 0) {
> +		fprintf(stderr, "%m - Failed to write pid_max\n");
> +		return fret;
> +	}
> +
> +	for (nr_procs = 0; nr_procs < 500; nr_procs++) {
> +		pid = fork();
> +		if (pid < 0)
> +			break;
> +
> +		if (pid == 0)
> +			exit(EXIT_SUCCESS);
> +
> +		pids[nr_procs] = pid;
> +	}
> +
> +	if (nr_procs >= 400) {
> +		fprintf(stderr, "Managed to create processes beyond the configured outer limit\n");
> +		goto reap;
> +	}

A small quibble, but I wonder about the semantics here. "You can write
whatever you want to this file, but we'll ignore it sometimes" seems
weird to me. What if someone (CRIU) wants to spawn a pid numbered 450
in this case? I suppose they read pid_max first, they'll be able to
tell it's impossible and can exit(1), but returning E2BIG from write()
might be more useful.

Tycho

