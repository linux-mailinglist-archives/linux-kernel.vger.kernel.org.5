Return-Path: <linux-kernel+bounces-157448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D18B11C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1904B26EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5C16D9C7;
	Wed, 24 Apr 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJYNSFF/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9716D329;
	Wed, 24 Apr 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982418; cv=none; b=SinPG01Z0Ebjra2DDAwP3ipOoMCLr+Y5IqekZsYUEHmsBb60AZO2IqH158zqezmrtJAqOc+TyJ/JdobMMVuSyVk4x+/iKALpqjzO57TkwZtDBSQr2otceoejV2pDf/7H7OKYwDlFRkiR2F4yLoPqflOpx8O47JfJz4iQSmr3404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982418; c=relaxed/simple;
	bh=81/fj7NjD+zEcRV5jk9TtHGDgfY372bpY0fjY6dUMzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JshbuZhOezV6cYTpSHyAm4baop7KOzbpxe55t4Dzd9oyqOtmnjdtQiomxWEo+0HgtvSqoOolJQF4ZOseCtZzzH4whbkKp7c2z0oAOB1suxtEr1OOvt+vtEUERwFkfJAVin3rut6f+xWTaJINiXwUFfkWz0QbXuY2xlYuBYLXIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJYNSFF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B371BC113CD;
	Wed, 24 Apr 2024 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713982417;
	bh=81/fj7NjD+zEcRV5jk9TtHGDgfY372bpY0fjY6dUMzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJYNSFF/BQfBxPV0nolpfeWaxorLN5m7KP81JBIPoFpCmnFlQzLnLIyCGw418QS8X
	 xGyREA6XP697XH5DM0tJtxpZBf2DlE/BM/YyQunhzZu6HrfTXpsZZQj5jzL7Y50gso
	 8cEK5NJfCLmNLFbEE/GR0a3pmBixj7t4LgJpFOnCH+OMgIfEAumIBrA+LU10P7R0R9
	 SegMtR69zN5sgRn6wU7Ig/XlEe9RFMw1CH+i+ORJv9ZQpkQqSrxQOX+ZTnPXxvFD0q
	 EVQ8O/J3qjb5TmHZYA95Fmznb9zwdsUCzpHcPM1bCQYmfMVVnGYclGuKRGbHS+wacB
	 yf452MPkLMdxA==
Message-ID: <8a01c6b2-ca30-448c-8ba8-34720891b461@kernel.org>
Date: Wed, 24 Apr 2024 20:13:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: pn533: Fix null-ptr-deref in pn533_recv_frame()
To: Yuxuan-Hu <yuxuanhu@buaa.edu.cn>, Yuxuan Hu <20373622@buaa.edu.cn>,
 gregkh@linuxfoundation.org, johan@kernel.org, davem@davemloft.net,
 u.kleine-koenig@pengutronix.de, Jonathan.Cameron@huawei.com,
 francesco.dolcini@toradex.com, jirislaby@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn
References: <f229256f-ceac-4a82-afa4-ecea67712ec3@kernel.org>
 <fdc7ada8-6ca9-4835-982a-3e45ee7ac009@buaa.edu.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <fdc7ada8-6ca9-4835-982a-3e45ee7ac009@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:00, Yuxuan-Hu wrote:
> Hi Krzysztof,
> Thanks for your reply.
> 
> On 2024/4/24 13:36, Krzysztof Kozlowski wrote:
>> A bit better solution would be to NULL-ify dev->cmd at the beginning of
>> pn533_send_async_complete(), because that seems logical. The complete
>> callback takes ownership of dev->cmd, so why it performs the assignment
>> at the end?
>>
>> However even above code will keep the race open for short period.
>> Probably some locking would solve it or checking for dev->cmd in few
>> places with barriers.
>>
>> Best regards,
>> Krzysztof
> 
> I think adding a lock seems to be a better solution, however, acquire a 
> lock on each access to dev->cmd does not seem to be an appropriate 
> implementation.
> I wonder whether you think it is appropriate to acquire a lock at the 
> beginning of pn533_recv_frame(), and release it when 
> pn533_wq_cmd_complete() is finished, thus ensuring that another work 
> will not start when one pn533_wq_cmd_complete() work is not yet finished.

I don't know this driver well enough, but it currently does not have any
locking around this so it assumes pn533_recv_frame() cannot start
concurrently, before complete callback finishes.

This could be solved, if it makes sense.

However maybe it would be enough to take:
1. Move contents of dev->cmd to another member in dev (e.g.
dev->cmd_in_progress), first checking if that member is empty (then
maybe wait? or return -EBUSY?)
2. dev->cmd = NULL
3. queue_work (see also explanation of barriers there)
4. The cmd_complete_work workqueue takes ownership of
dev->cmd_in_progress and NULL-ifies it at end of work + barrier.

Best regards,
Krzysztof


