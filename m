Return-Path: <linux-kernel+bounces-162465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25B8B5B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13B7282F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E97FBD3;
	Mon, 29 Apr 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjWpkTwD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35097F7C3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401753; cv=none; b=NJQyEsSfixhbdjyaygK9kUiwtsm4/qCQf/wFA7WqPJJjIzek0iuSjF6QcFDq1dfu7DyvJbJ0RdQNiDb+l5sUVnALMsOk9stYQCg5A1WDdUfh6gHIvSEM/bCCjpNNSjrPL8BCeH17t++KgyUPTKMVOBYgcil/A+boGD70GT7fYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401753; c=relaxed/simple;
	bh=T92NaU3ReD2/fnkEdWIwmoqOz2RSZmJeMWeVVAK+yE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YzZwGHHhqVJ+tIK6PPYiMJ54Xy8Qp1fxnD81Bru7Trw+XDXRywQQIrtGtDaKF35PBKGigN6ZY98U+1lnQVqSCQ4aX0rMSBqh9Lt41gj0gL8mbUuh09XGNkAEL9l3GonGI7oBY3gaW5e9njJ368BFLKeNEQmsWwcHkyuV3ZrVG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjWpkTwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00776C113CD;
	Mon, 29 Apr 2024 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401753;
	bh=T92NaU3ReD2/fnkEdWIwmoqOz2RSZmJeMWeVVAK+yE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bjWpkTwD4eSDfStdQ1m4FdYpmAfjLkv6d5qNjnFzJ9phi9VYM10Nk//w7uYFzEmn2
	 nisxDg74vLHcvnLH+wPZ+uZs4p4EDLnLsjS2PuecadJQDfocMbY6HEyd01P+9pCHvN
	 aWSKiF8dBZlqMNtn5sq0AgruXic/1Vwps0NUtUH/QyO46vDdr1h6iUD0xPOHBa7dcm
	 V5gdxm/+DxaMdTKU6+E4jLoaRYWSsdOqCZA07pX8SuCfZi3tk7HIbOeOyyymQsiUQq
	 E1DlNmF1c9Mrpv+gl1JfRiPe5IrGdXHzp++RsEEvi4ts7FuR0k5/NxUdG+UZ13r4Ju
	 9EnpLHc8YMOIQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  "Dan Carpenter" <dan.carpenter@linaro.org>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: replace unnecessary div64_u64() with
 div_u64()
In-Reply-To: <D0WNIVK1DBL5.3KQOD1K2O128P@kernel.org> (Michael Walle's message
	of "Mon, 29 Apr 2024 15:47:13 +0200")
References: <20240429121113.803703-1-mwalle@kernel.org>
	<mafs05xw0cn8v.fsf@kernel.org> <D0WNIVK1DBL5.3KQOD1K2O128P@kernel.org>
Date: Mon, 29 Apr 2024 16:42:30 +0200
Message-ID: <mafs0mspcb57t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 29 2024, Michael Walle wrote:

> Hi,
>
> On Mon Apr 29, 2024 at 3:27 PM CEST, Pratyush Yadav wrote:
>> On Mon, Apr 29 2024, Michael Walle wrote:
>>
>> > Both occurences of div64_u64() just have a u8 or u32 divisor. Use
>> > div_u64() instead.
>>
>> Does this improve performance or is this only for correctness?
>
> See function doc for div_u64():
>
>  * This is the most common 64bit divide and should be used if possible,
>  * as many 32bit archs can optimize this variant better than a full 64bit
>  * divide.

Thanks. I think it would be good to add this to the commit message:

    Both occurences of div64_u64() just have a u8 or u32 divisor. Use
    div_u64() instead. Many 32 bit architectures can optimize this
    variant better than a full 64 bit divide.

No need to resend, I can do this when applying.

>
>> Patch LGTM otherwise.
>>
>> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>>
>> BTW, I also noticed that there is a do_div() call in spi_nor_write()
>> that also uses a u64 dividend and u32 divisor. I was wondering why it
>> uses do_div() and not div_u64() (I am not sure what the difference
>> between the two is) but I suppose it doesn't matter much since your
>> spring cleaning series will delete that code anyway.
>
> do_div() is a macro and is modifying the dividend in place, whereas
> div_u64() will return it. do_div() is using u32 for the divisor
> anyway.
>
> -michael
>

-- 
Regards,
Pratyush Yadav

