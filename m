Return-Path: <linux-kernel+bounces-27490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851D82F0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE331F245EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854471BF46;
	Tue, 16 Jan 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2XMEwo4"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DC1BF35;
	Tue, 16 Jan 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7835aea8012so122991485a.0;
        Tue, 16 Jan 2024 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705417476; x=1706022276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcMOLqRkySsMBYup4NqAp95fYeAAkHFh6AZ6tAZhnBA=;
        b=I2XMEwo4UqlKTAnYXMjcHYybgzQ6V0tV8ZhfxdkQtbNccMf9Io1/1vRETxpT0+Lgxr
         nqa+MM4IE/iOnlqS6Ms59VDhVavwF/IZUMuYdXMOyLK2wDIrfuj2wiq4eMHR9Cd5gWwn
         irHkXpFkUwDGGJHp7YzFodOGGkQSDE2Yd84YL12prVoWIhBCNZfgnnb/NvDXH8gtUQCc
         vR09tievOvMXc1S49zVIsv/iPwCLMEZhI4zA1PYNgWLxCLWOvK4ZmsMF8jmdDGaE9aLX
         Gj1ZDxpgI13lB1Cco35TOazsEI/L4olNlF6K+s6hV+iczlcb32cOOuoWVGyiixdV/7QB
         Vw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705417476; x=1706022276;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcMOLqRkySsMBYup4NqAp95fYeAAkHFh6AZ6tAZhnBA=;
        b=SK5tU5M7uiyFZYgBZ3w60aBck+sDHyeXsoTvq6hqDaTJ2/bhOLX+kjnbxwejwZCtZE
         VfYMoU9NvK9xHFXj4eHrPJrN9K+4YJobIa/J/oSN+M8VrZomsuea+KhY6JfmfnzZWQe2
         deavmHmZA3Sse9x8jWmv8Vxmjw0qcdM09eNoqhU7OdX6kKE1hDah/0pU54TEerLL6UGq
         VlGSAjcsN4Vv7R8A2L5TXC/CzXMpqb7M+IJQyQHE/Ntvkz+w3/tgly71ZSHrFwv9pd1a
         Eo6pQH0T6fr6ADDZ7A/3VhTBG9RszGl7mBR7CwLSlFjn35tC0R44UA6/inPzv21AC2Pa
         VGbA==
X-Gm-Message-State: AOJu0YxSm7ZPhWOIR5kruNJYRaRf1kl6fLxkTGcqYYiWLQohOGAAiRx0
	bR4mm4bc+6N+y2k9HltXdtw=
X-Google-Smtp-Source: AGHT+IGm3NoD3ClR5vYFJMDqiBLlGhiwdNUFWBBFW5pgq2EIodkKnlH4UXcctJ4vjyDU5OH3w/xhCg==
X-Received: by 2002:a05:620a:430c:b0:783:3646:ea43 with SMTP id u12-20020a05620a430c00b007833646ea43mr9874545qko.13.1705417476253;
        Tue, 16 Jan 2024 07:04:36 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z18-20020a05620a08d200b007834386eeaesm3712051qkz.33.2024.01.16.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:04:35 -0800 (PST)
Date: Tue, 16 Jan 2024 10:04:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65a69b03875e6_380df029448@willemb.c.googlers.com.notmuch>
In-Reply-To: <1705409818-28292-1-git-send-email-wangyunjian@huawei.com>
References: <1705409818-28292-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net v2] tun: add missing rx stats accounting in
 tun_xdp_act
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> There are few places on the receive path where packet receives and packet
> drops were not accounted for. This patch fixes that issue.
> 
> Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")

Before this commit this_cpu_inc(tun->pcpu_stats->rx_dropped) would
get called, so that is indeed a regression in that patch. Please add
that to the commit message.

This commit also adds new accounting of successfully received bytes
with dev_sw_netstats_rx_add. I don't know off the top of my head if
other devices account XDP_TX and XDP_REDIRECT in that counter. Either
way, good to be explicit about such subtle details. Oddly, before
8ae1aff0b331 those, too, would be attributed to rx_dropped, because
after the out: label.

> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
> v2: add Fixes tag
> ---
>  drivers/net/tun.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index afa5497f7c35..232e5319ac77 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1626,17 +1626,14 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  		       struct xdp_buff *xdp, u32 act)
>  {
>  	int err;
> +	unsigned int datasize = xdp->data_end - xdp->data;
>  
>  	switch (act) {
>  	case XDP_REDIRECT:
>  		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> -		if (err)
> -			return err;
>  		break;
>  	case XDP_TX:
>  		err = tun_xdp_tx(tun->dev, xdp);
> -		if (err < 0)
> -			return err;
>  		break;
>  	case XDP_PASS:
>  		break;

err is uninitialized in this case?

> @@ -1651,6 +1648,13 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  		break;
>  	}
>  
> +	if (err < 0) {
> +		act = err;
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +	} else if (act == XDP_REDIRECT || act == XDP_TX) {
> +		dev_sw_netstats_rx_add(tun->dev, datasize);
> +	}
> +
>  	return act;
>  }
>  
> -- 
> 2.41.0
> 



