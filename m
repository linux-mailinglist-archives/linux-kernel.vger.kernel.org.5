Return-Path: <linux-kernel+bounces-143454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7A88A395F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DA1285DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D188E746E;
	Sat, 13 Apr 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayE24+QD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A24C7D;
	Sat, 13 Apr 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712968157; cv=none; b=HUyFMFb9bdT5OOKr3dhr9LSHUAHd2e8X6sKglYyxVLY21pfnMOwbere71lmkCocdjg/rcVBfCQlC26QUWW48q+07x4/eceH/g/N+aCSKgJZ68Ppz+5KeAa1NTQDfy6j6Bx2K06YbLazQA4ua+EyjhL3HPKt5wmDav5qGt2wtMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712968157; c=relaxed/simple;
	bh=YPNNZcGO4R2DMHObIt70evDXCGNHt0rGwdZD3wv0q2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGx/ZU9sx7t0vcBxS7oxOp3mOekfic077NNBgqM4K5SJIkaxj5CvEG58ucRz7G0R5vmhAzPGvmBIc4K4jvKIqXxXUL8kKpnbRN+2ZfILRrsmfU2PRdQM7M4+auko7DbHN8qnv9GNNAGV87ySCShvEQBbJJluVMwYFm34mpS02NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayE24+QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE47C2BD10;
	Sat, 13 Apr 2024 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712968156;
	bh=YPNNZcGO4R2DMHObIt70evDXCGNHt0rGwdZD3wv0q2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ayE24+QDoEvkEgu/Cbsu3cgbGiFpzbfO6+X0XHUzR2Zw30UYlbjk9dFOOMuUzi6tQ
	 NCLiaXER9eAM+4xqr/iOZ3tU3JJpi3KxbGJTGaYtIRu5keB6fHu2JNyr1wALB0+oUh
	 krlaJfaPaE7Sk89FjGRpq0L66HPJU+796Sy4qGZcbSXOpCetuBX6sbjYoC5FasssBI
	 gIuf4EmRlyPOIN2vVWtGCELHFtgd7udAvsEwkW5QZ6P9zWoQEDKyc9iuayOoCv+uYJ
	 ybMZqV6/Qf0d2O8X4d3OW0SGdN7NEcsmpMcm78vQW+iHjfd6K6zC3fcaD44WOpB3bd
	 +UvhcA8EgGf3A==
Message-ID: <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
Date: Sat, 13 Apr 2024 09:29:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
To: Gustav Ekelund <gustav.ekelund@axis.com>, cassel@kernel.org,
 hare@suse.de, martin.petersen@oracle.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240412134838.788502-1-gustav.ekelund@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 22:48, Gustav Ekelund wrote:
> Expose a new sysfs attribute to userspace that gives root the ability to
> lower the link speed in a scsi_device at runtime. The handle enables
> programs to, based on external circumstances that may be unbeknownst to
> the kernel, determine if a link should slow down to perhaps achieve a
> stabler signal. External circumstances could include the mission time
> of the connected hardware or observations to temperature trends.

may, perhaps, could... This does not sound very deterministic. Do you have an
actual practical use case where this patch is useful and solve a real problem ?

Strictly speaking, if you are seeing link stability issues due to temperature or
other environmental factors (humidity, altitude), then either you are operating
your hardware (board and/or HDD) outside of their environmental specifications,
or you have some serious hardware issues (which can be a simple as a bad SATA
cable or an inappropriate power supply). In both cases, I do not think that this
patch will be of any help.

Furthermore, libata already lowers a link speed automatically at runtime if it
sees too many NCQ errors. Isn't that enough ? And we also have the horkage flags
to force a maximum link speed for a device/adapter, which can also be specified
as a libata module argument (libata.force).

> Writing 1 to /sys/block/*/device/down_link_spd signals the kernel to
> first lower the link speed one step with sata_down_spd_limit and then
> finish off with sata_link_hardreset.

We already have "/sys/class/ata_link/*/hw_sata_spd_limit", which is read-only
for now. So if you can really justify this manual link speed tuning for an
actual use case (not a hypothetical one), then the way to go would be to make
that attribute RW and implement its store() method to lower the link speed at
runtime.

And by the way, looking at what that attribute says, I always get:
<unknown>

So it looks like there is an issue with it that went unnoticed (because no one
is using it...). This needs some fixing.

-- 
Damien Le Moal
Western Digital Research


