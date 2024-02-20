Return-Path: <linux-kernel+bounces-73125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD985BDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E8289C22
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0493A73197;
	Tue, 20 Feb 2024 13:55:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3E6A8CB;
	Tue, 20 Feb 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437353; cv=none; b=uy8HdoPaIMTr3TDh0zSfdJfqMcta1HyIuWEmK2yU+QcISghoiNwPJoN0sZqmY0dHzWFv9QUmNkLd/4DpF+HFtx9iGNtr4IItX5Rr+WaFewIyjbKE5a3eaEUmU3SOgJBxAbOFN2texrB/oDWnRyIkGiX+LcvYhKGiR02NFv2leY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437353; c=relaxed/simple;
	bh=CFBAEkF/q8ncI+9sPI0M6RjIXSeHLouADi9KF1CiGh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThO3+11ZO/P7C1mYNYC0Q6/yGpmMC9RBTLX4ykvsVpe415jw2Kd3Ez6Gj0H1FGcgva1MTpfE287wWZSC/qHTnsQGkCXYp0ZPPI0hrV+vijgA+LnvNGqbS6eZGXLEHwxRBfNT6rutsbwyuIen57ZFU+ALaQ1CuQ2jobqJZ+gLmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7567DC433C7;
	Tue, 20 Feb 2024 13:55:51 +0000 (UTC)
Message-ID: <590107ef-16f1-4680-8fd6-11df838ce14a@linux-m68k.org>
Date: Tue, 20 Feb 2024 23:55:48 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/tty/serial: Remove unused function
 early_mcf_setup
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Thomas Huth <thuth@redhat.com>, linux-m68k@lists.linux-m68k.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240219164002.520342-1-thuth@redhat.com>
 <c44bfc7f-7b06-4985-953d-185f8b576a5b@kernel.org>
 <CAMuHMdXc=rR9udEmMsCJof+sCxdoJryF49-Gy9j=DJqiHyUsvQ@mail.gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdXc=rR9udEmMsCJof+sCxdoJryF49-Gy9j=DJqiHyUsvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20/2/24 20:23, Geert Uytterhoeven wrote:
> On Tue, Feb 20, 2024 at 6:11 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>> On 19. 02. 24, 17:40, Thomas Huth wrote:
>>> Compiling a kernel for the ColdFire causes a compiler warning:
>>>
>>> drivers/tty/serial/mcf.c:473:12: warning: no previous prototype for
>>>    ‘early_mcf_setup’ [-Wmissing-prototypes]
>>>     473 | int __init early_mcf_setup(struct mcf_platform_uart *platp)
>>>         |            ^~~~~~~~~~~~~~~
>>>
>>> This function seems to be completely unused, so let's remove it
>>> to silence the warning.
>>
>> And it seems so since the driver addition in 2007 by:
>> commit 49aa49bfd40d718095669c1c70c9d167b814e29b
>> Author: Greg Ungerer <gerg@snapgear.com>
>> Date:   Tue Oct 23 14:37:54 2007 +1000
>>
>>       m68knommu: new style ColdFire UART driver
> 
> Indeed.
> 
> Looks like the "changes to the ColdFire based m68knommu systems
> to use a platform model at init, and this is used there" from [1]
> never materialized on any public mailing list?
> 
> Greg: does it still make sense to add them?

No, it never really turned out to be useful enough to anyone,
so I never really pushed it out or progressed it any further.

So I am fine with removing this now:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

I can take it via the m68knommu git tree if no one else wants to
pick it up.

Regards
Greg



> If not:
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> [1] https://lore.kernel.org/all/47254BEB.2040609@snapgear.com/
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

