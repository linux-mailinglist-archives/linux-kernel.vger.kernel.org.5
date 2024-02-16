Return-Path: <linux-kernel+bounces-69136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A98584E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BC9283007
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6861350DA;
	Fri, 16 Feb 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciwKum2e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228C134751;
	Fri, 16 Feb 2024 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106882; cv=none; b=O0xjz/BBB3eaLx55Dq1hd8OMgECFRGKj5NDOZaa5T9EqV2n0MlhUw2nWVT3CvO2rLQ+cJTSVprRL8bHEMLe7o/GaT050MDQ10NwffQF+0+EOLKoSooWbrzxh+cK2vgG3xSoA8MFdAfNjgN1yx0VznJG19urGtBoVi01uHdXjaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106882; c=relaxed/simple;
	bh=tV3fUptqP9RE0j5RgKLziKA6wSJoQPcah2pWJdG9ico=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QzceuQseLKdMuxHOJ6UNBkCRb/c7hmVg34ujyJy4FnZ1tDdiOeWVhDZh1uleUDWshW7OKvExE9St402MbG/eTAMVOII8qpeBgmhSI1fT7AAXfaY6u/eC/gDc2CKUB9iDJ5f7uTiyHgoeTszUbNZwcwhkMCqleJhmip2yJpERvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciwKum2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB2BC433F1;
	Fri, 16 Feb 2024 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106881;
	bh=tV3fUptqP9RE0j5RgKLziKA6wSJoQPcah2pWJdG9ico=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ciwKum2eDZJZfLFHWAD49YFnhnK/MAIdrvKaQVYozM80ogQJkncFm5iNkPgVjO2ZH
	 +NDkG8srPW5uxC5oln1NpZXMkcH+Wp3l3pt0r7TYhylzFU/dHtnrhTvVSuvpzl+2bx
	 Rh6YQKRmrbcJSpL/WVhsLUJ3X1z6lLKNpC9+GHffxKHze30/qxV6YYPBPZ4MVf6G+c
	 ZDz5vMWES8XZE2r9oxuPNoja2unPWf0qimIvvZHG+IDKrTCacHf1/3xfYMl8rY3TOb
	 fq7Q8HQ1APb7KwwQbjV7TMVOcLXXBlji6YcmwipRDwmO2JZQs73i07LbMIi1SvCVLj
	 jq8SWhi+DLqAA==
From: Kalle Valo <kvalo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Ajay.Kathat@microchip.com,  alexis.lothore@bootlin.com,
  davidm@egauge.net,  linux-wireless@vger.kernel.org,
  claudiu.beznea@tuxon.dev,  thomas.petazzoni@bootlin.com,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
	<2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
	<081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
	<aac398e4-d870-4ba2-8877-b98afecb8d1b@microchip.com>
	<877cj4o0sv.fsf@kernel.org>
	<20240216-reckless-freedom-4768ce41e939@spud>
	<20240216-spinster-decade-e136ac3e72d0@spud>
Date: Fri, 16 Feb 2024 20:07:58 +0200
In-Reply-To: <20240216-spinster-decade-e136ac3e72d0@spud> (Conor Dooley's
	message of "Fri, 16 Feb 2024 16:55:16 +0000")
Message-ID: <87h6i8cmf5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Conor Dooley <conor@kernel.org> writes:

>> > So if I'm understanding the situation correctly Microchip's porting
>> > guide[1] doesn't match with kernel.org documentation[2]? I'm not the
>> > expert here but from my point of view the issue is clear: the code needs
>> > to follow kernel.org documentation[2], not external documentation.
>> 
>> My point of view would definitely be that drivers in the mainline kernel
>> absolutely should respect the ABI defined in the dt-binding. What a vendor
>> decides to do in their own tree I suppose is their problem, but I would
>> advocate that vendor kernels would also respect the ABI from mainline.
>> 
>> Looking a bit more closely at the porting guide, it contains other
>> properties that are not present in the dt-binding - undocumented
>> compatibles and a different enable gpio property for example.
>> I guess it (and the vendor version of the driver) never got updated when
>> wilc1000 supported landed in mainline?
>> 
>> > I'll add devicetree list so hopefully people there can comment also,
>> > full patch available in [3].
>> > 
>> > Alexis, if there are no more comments I'm in favor submitting the revert
>> > you mentioned.
>> 
>> From a dt-bindings point of view, the aforementioned revert seems
>> correct and would be
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Maybe an R-b is more suitable here, too used to acking trivial patches
> that are dt related..

On the contrary, I think Acked-by is the right thing here and makes it
easier for Alexis and me. Thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

