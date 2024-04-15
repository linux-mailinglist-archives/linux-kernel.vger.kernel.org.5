Return-Path: <linux-kernel+bounces-145456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BB8A5659
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEED1C222F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9378C85;
	Mon, 15 Apr 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVMtViJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21E75818
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194780; cv=none; b=DpULYC7Filydg7LzOx1H5iQlodJCJ272HFrhFMre+WwB0lMWVwo6b+LdxGh1dUttiVYQcbyd08ogm28b7Tgb3y1qjPNUDUyVED7yQtysE7n+fr+dzmM3S+DQlMpQW8p5ZFCzOB16eZKZT2XDySP4AMoMMXyy0nxH35+0U3ZA2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194780; c=relaxed/simple;
	bh=c5A2ZbFFlaMWCo1btByGYDCqOF3ITNaXb24+w/6iX1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXvSpdA1gMyUYIqLCMfVPj42+HwgXyRZVybVb8OKCSC/K7OwNfh8g68N6EQII2Ytxs0A/HbUInEbyf9ieexSVAGVnjI/3TU18ivG5TS+/H/sy6nYayNyvQQQhbLM1Nq79XD/sB/JAQXpkPwWjABmKNw+idtZPZZnkHVZyTWx27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVMtViJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D21C113CC;
	Mon, 15 Apr 2024 15:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713194780;
	bh=c5A2ZbFFlaMWCo1btByGYDCqOF3ITNaXb24+w/6iX1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PVMtViJ1lUVqr4hJO1GaQV5frmWssd3EVGySDFeIvq3f0ms/PpMHxtOHS5sVGKT7B
	 7bICcbk7Znj904jgQck54gQEf9SKYhXLqZaOLcNaueJrzdtI8cz0Z77eyHMP7t5arf
	 G1PNYYZMS3jQHzYE8lfvZ5UnmWEKhlMkicNBqy/l63PIvy7zEWPEyaxf2riTM6UZFZ
	 KJmaws70LCvXqrnZtHKG7u+m195ROdk7HVU8RFKww1339z5dWZHTN/OET59c/QZ+tc
	 vued91MarqPEILWfD7TDZmtRX0tCmuvbmKXdqAsePWo0koZt2SfQTmvHY1c8rR/a8Y
	 gocwDlyZYg6Tg==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 1/6] mtd: spi-nor: Remove support for Xilinx S3AN
 flashes
In-Reply-To: <D0I76PPKBWF9.X2XFZAO5OE7S@kernel.org> (Michael Walle's message
	of "Fri, 12 Apr 2024 16:01:43 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-2-mwalle@kernel.org>
	<7b2fc5cb-d1ab-4e9d-b955-b88698322057@linaro.org>
	<D0I76PPKBWF9.X2XFZAO5OE7S@kernel.org>
Date: Mon, 15 Apr 2024 17:26:17 +0200
Message-ID: <mafs0a5lu8x5y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Fri, Apr 12 2024, Michael Walle wrote:

> On Fri Apr 12, 2024 at 3:53 PM CEST, Tudor Ambarus wrote:
>>
>>
>> On 4/12/24 14:44, Michael Walle wrote:
>> > These flashes are kind of an oddball for the very old Xilinx Spartan 3
>> > FPGAs to store their bitstream. More importantly, they reuse the Atmel
>> > JEDEC manufacturer ID and in fact the at45db081d already blocks the use
>> > of the 3S700AN flash chip. It's time to sunset support for these
>> > flashes.
>> > 
>> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>>
>> Good, I'll let Pratyush review the details:
>>
>> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>
>> Please resend once you get enough feedback and include in To: all the
>> contributors to this driver.

+1. It would be good to hear from past contributors to see if they still
use it.

Also, I think we should let this patch cook in linux-next for some time
before merging to give people a chance to complain if we break
something. Since now there isn't much time left until the SPI NOR pull
request goes out (around 2 weeks I reckon), it would probably make sense
to merge it in the next cycle.

Otherwise, the patch looks good to me.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>
>
> For my future reference: This seem so be the only interesting
> commit:
>
> commit e99ca98f1d7190c16601b00d0c96212d7c00577d
> Author: Ricardo Ribalda <ribalda@kernel.org>
> Date:   Fri Dec 2 12:31:44 2016 +0100
>
>     mtd: spi-nor: Add support for S3AN spi-nor devices
>
> -michael

-- 
Regards,
Pratyush Yadav

