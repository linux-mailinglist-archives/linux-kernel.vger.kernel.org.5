Return-Path: <linux-kernel+bounces-100142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE33879271
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C47B1F22C56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2D78686;
	Tue, 12 Mar 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9fb7J6P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EB2572
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240638; cv=none; b=J+gcuJ3pvRTN+OOHHv9z9uvK/D6nlx9afBvrjPjWNJBgr5yxXx4Ig1VHJkK9ShzjPph8L/wvSuobY0ddvHWRBy6/eky9LgehkhrSnlChzA+gLHqfVmMV2SI2QZfCTHcizGb+6goRrCLImYzqu9YPd1L+AMx1z9pvnsiODK2wIW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240638; c=relaxed/simple;
	bh=I2NqWB5cKvQto9fV3SpLZWdY5q6ODb3FJ2D3h10i79s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZuI4tIA93fft7aBC0lXvL5PQkTqdOf6ELy00iaS5v6ocLmhjddL9dV9BC20ptE7L+OxThH5XsHYm+gWzTWOJQMOaHhdD6Vd4UWF6Q/rZuh+Neel0GsfOSdb9Ncbu3tuwAvKMTHMY5EjLvjMAUI+nMiAdSGZA8odrz3U1TxGYDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9fb7J6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710240635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=svJBs6ZSFI76DADWJEw/YqilQwWjyKwiwB1uTQI4XK8=;
	b=e9fb7J6Pp9OdXqvjzOE5/e/JMjLOuxnoTCaYxYwE09K+XNLw9Of40m+buobdRVVwMJIFER
	vNvsnl105VJIx8nHWEj9AgbMIeX1mEMxrlSz3D9W7hWgT+4HQ28SEHp7m5GWBVkQyFbjib
	B2SEzeAvYAxrGErKm7W978xRc//74JE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-uN7hNRTPMqC48fHBoncYtA-1; Tue, 12 Mar 2024 06:50:34 -0400
X-MC-Unique: uN7hNRTPMqC48fHBoncYtA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56827399088so932674a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240633; x=1710845433;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svJBs6ZSFI76DADWJEw/YqilQwWjyKwiwB1uTQI4XK8=;
        b=gXfM6LiBH/H25XZOUPRkmSBEsWzbR5GltxjKtTmJJ++exnb4NJivKGCRgoyVS5ZpW9
         v4EyfRZf3x/BiZ/VWTODOdCkh9wDxb+msC0W6TClXTHE7g9quABhhjndNjpzJh5LzHcO
         MDSjrx49m8Yt7R5s6ZdQlvDrEHCuEvzSNgvT0qFQQQYiaCljUvZfwJxmFdf0pwTzveJ9
         zyyVsMYjcd4mp3xKCADOtDyvcxZY63fbnKMRRpv8QXLHahHOb3PT2ydIhI3dUAN4Z5HO
         BmI4WkHqbok4w7LRzJMUZ8YN03vPh6ibjXmB5AYTlOMYT0Y2VTD1RagZAOufCREeS8t7
         m1TQ==
X-Gm-Message-State: AOJu0Yz6O08rjERgdgrTiuCm1HER79U/aV4L2JRUnIwJv4NiZS9Xa2u0
	wmel+hbf1YqhjsEnAr/yC/yxzX2eT7fPajZfZcUXkMy1SVvpp9E08ngH1ZBKg0JjkcuOnnMrfLw
	/jpJVQRvKm0XMl4y3tHcgaXZ6YYv+3icj7ycQAH1jZOcj8Y+AFCLyreVHDKEIqQ==
X-Received: by 2002:a17:906:32c3:b0:a45:dd12:5e30 with SMTP id k3-20020a17090632c300b00a45dd125e30mr5999623ejk.2.1710240633351;
        Tue, 12 Mar 2024 03:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnr9LGg24EFk270v0L0Icz46pXvIKsHHvzlQoL7Ha5x66Egqq2zQ2lXh2tD1brF8F13sYTLw==
X-Received: by 2002:a17:906:32c3:b0:a45:dd12:5e30 with SMTP id k3-20020a17090632c300b00a45dd125e30mr5999597ejk.2.1710240632946;
        Tue, 12 Mar 2024 03:50:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id gt20-20020a1709072d9400b00a46025483c7sm3449266ejc.72.2024.03.12.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:50:32 -0700 (PDT)
Message-ID: <dc45f4f104a0d0691715398d2f7efa6a0a3447b8.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] net: ethernet: ti: am65-cpts: Enable PTP RX HW
 timestamp using CPTS FIFO
From: Paolo Abeni <pabeni@redhat.com>
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>,  Siddharth Vadapalli <s-vadapalli@ti.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>,  Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 12 Mar 2024 11:50:30 +0100
In-Reply-To: <20240312100233.941763-1-c-vankar@ti.com>
References: <20240312100233.941763-1-c-vankar@ti.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-12 at 15:32 +0530, Chintan Vankar wrote:
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/t=
i/am65-cpts.c
> index c66618d91c28..6c1d571c5e0b 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -859,29 +859,6 @@ static long am65_cpts_ts_work(struct ptp_clock_info =
*ptp)
>  	return delay;
>  }
> =20
> -/**
> - * am65_cpts_rx_enable - enable rx timestamping
> - * @cpts: cpts handle
> - * @en: enable
> - *
> - * This functions enables rx packets timestamping. The CPTS can timestam=
p all
> - * rx packets.
> - */
> -void am65_cpts_rx_enable(struct am65_cpts *cpts, bool en)
> -{
> -	u32 val;
> -
> -	mutex_lock(&cpts->ptp_clk_lock);
> -	val =3D am65_cpts_read32(cpts, control);
> -	if (en)
> -		val |=3D AM65_CPTS_CONTROL_TSTAMP_EN;
> -	else
> -		val &=3D ~AM65_CPTS_CONTROL_TSTAMP_EN;
> -	am65_cpts_write32(cpts, val, control);
> -	mutex_unlock(&cpts->ptp_clk_lock);
> -}
> -EXPORT_SYMBOL_GPL(am65_cpts_rx_enable);

It looks like the above chunk will cause a transient build break, as
the function is still in use and the caller will be removed by the next
patch. I guess you should move this chunk there.

> -
>  static int am65_skb_get_mtype_seqid(struct sk_buff *skb, u32 *mtype_seqi=
d)
>  {
>  	unsigned int ptp_class =3D ptp_classify_raw(skb);
> @@ -906,6 +883,72 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *=
skb, u32 *mtype_seqid)
>  	return 1;
>  }
> =20
> +static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, struct sk_buff *=
skb,
> +				int ev_type, u32 skb_mtype_seqid)
> +{
> +	struct list_head *this, *next;
> +	struct am65_cpts_event *event;
> +	unsigned long flags;
> +	u32 mtype_seqid;
> +	u64 ns =3D 0;
> +
> +	am65_cpts_fifo_read(cpts);
> +	spin_lock_irqsave(&cpts->lock, flags);
> +	list_for_each_safe(this, next, &cpts->events) {
> +		event =3D list_entry(this, struct am65_cpts_event, list);
> +		if (time_after(jiffies, event->tmo)) {
> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);
> +			continue;
> +		}
> +
> +		mtype_seqid =3D event->event1 &
> +			      (AM65_CPTS_EVENT_1_MESSAGE_TYPE_MASK |
> +			       AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK |
> +			       AM65_CPTS_EVENT_1_EVENT_TYPE_MASK);
> +
> +		if (mtype_seqid =3D=3D skb_mtype_seqid) {
> +			ns =3D event->timestamp;
> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&cpts->lock, flags);

Ouch, you have to acquire an additional lock per packet and a lot of
cacheline dithering.

Not strictly necessary for this series, but I suggest to invest some
time reconsidering this schema, it looks bad from performance pov.

Possibly protecting the list with RCU and leaving the recycle to the
producer could help.

Additionally net-next is currently closed for the merge window, please
post the new revision (including the target tree in the subj prefix)
when net-next will re-open in ~2weeks.

Cheers,

Paolo


