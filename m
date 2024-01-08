Return-Path: <linux-kernel+bounces-19901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C891D82766E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B5F1F222DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25C55577B;
	Mon,  8 Jan 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="m5ajLXJk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A15576A;
	Mon,  8 Jan 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [192.168.1.54] (unknown [85.30.205.207])
	by mail.ispras.ru (Postfix) with ESMTPSA id 286DF40F1DEB;
	Mon,  8 Jan 2024 17:34:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 286DF40F1DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704735275;
	bh=hRWuIE+2qFwu/n+vsFXIu1/VBVgfBej0lvtPdg99qfs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=m5ajLXJk2I7FoFz07Q7nQtLAg9Q/ozw+ilu15EXO/B2u6a8Pr8ygdcZ5hyJeu/Il8
	 +GWMZW/ucsbpsxOb6kDBQXZRXWoS10dJhiYGJYJtip0UR/DfC/pBJZr8BVoith1o1z
	 yKuvp1wmHWlp6JppHO5aNHTahmvECuquP8M3yc9c=
Subject: Re: [PATCH] iphase: Adding a null pointer check
To: Andrey Shumilin <shum.sdl@nppct.ru>, 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20231107123600.14529-1-shum.sdl@nppct.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <d8884b3c-bef4-7042-934b-0bcdb4347b97@ispras.ru>
Date: Mon, 8 Jan 2024 20:28:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231107123600.14529-1-shum.sdl@nppct.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Proposal for subject:

atm: iphase: Move check for NULL before derefence in get_desc()


On 07.11.2023 15:36, Andrey Shumilin wrote:
> The pointer <dev->desc_tbl[i].iavcc> is dereferenced on line 195.
> Further in the code, it is checked for null on line 204.
> It is proposed to add a check before dereferencing the pointer.

Line numbers in commit messages are not welcome since they are subject
for change and a reader of the message likely has other code at that
lines in his version of the file.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  drivers/atm/iphase.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
> index 324148686953..596422fbfacc 100644
> --- a/drivers/atm/iphase.c
> +++ b/drivers/atm/iphase.c
> @@ -192,6 +192,11 @@ static u16 get_desc (IADEV *dev, struct ia_vcc *iavcc) {
>             i++;
>             continue;
>          }
> +       if (!(iavcc_r = dev->desc_tbl[i].iavcc)) {
> +	   printk("Fatal err, desc table vcc or skb is NULL\n");
> +	   i++;
> +	   continue;
> +	}

Error message should be fixed, skb is not check for NULL here.

>          ltimeout = dev->desc_tbl[i].iavcc->ltimeout; 
>          delta = jiffies - dev->desc_tbl[i].timestamp;
>          if (delta >= ltimeout) {
> 


>           if (!dev->desc_tbl[i].txskb || !(iavcc_r =
dev->desc_tbl[i].iavcc))
>              printk("Fatal err, desc table vcc or skb is NULL\n");


The existing check should be fixed to check for skb only.

--
Alexey

