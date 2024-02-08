Return-Path: <linux-kernel+bounces-57769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9984DD35
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4E71C26D53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3F6BB5C;
	Thu,  8 Feb 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVyJ5IMg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2B1E86C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385576; cv=none; b=QTsqCdLj9tFg8HziAH4p5ZhEeInb/wq3FXQ0CP3ZGQ5L3kYMT9w5cjsOKBbwWQdsSK7lLHY7iBwNljhwUB8lhNkWdIqCRPCL4aJg3Qafo1rpgkg94Cuu2xGmTQN3NOcE350y32Eve/l9ritcRDvO7YPRJTC4PwX5Vh/hJ6dCpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385576; c=relaxed/simple;
	bh=ShuMYLwpG7z5ZXy0ASsU6WDU+O3cLxWEJs2OmqmnOEQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhPn4PRX1CZs17jqxelIMVeQSOfUwePwBATJ8Texzz6QaqTJ9mTS5wKSgEZwNQ8Z4988w3Taz7sgurshFZx6S/K+oLUCzZCeJ/y/IW8y12YgAnCVTLD7dLtUheFo4B2+3AvDPKK8Ni+b2ineshkRXLqrZe4tTJ8SqKpk16G4kO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVyJ5IMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707385574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sgEKGCcDaKKLTB6kaCOCKXIT5KmxZaW+10B/SjlLFz8=;
	b=OVyJ5IMgJwmo0fDgRBD4mpCgGoO/k3kvG/QZFj1lGRFiw65OtXviioRq1WzzNVLZakHYA/
	6kX7XBigHXaovsl87SKBGu/tmDCYF2TnKU9R4q2Kzyoy7buHawYRkcBBYyDCAV/8byqiBW
	c5G3VbFsH4EsWJ312HYeCnkTT0wH4FQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-H91BGYEzP4WeVc8MMZuxEg-1; Thu, 08 Feb 2024 04:46:12 -0500
X-MC-Unique: H91BGYEzP4WeVc8MMZuxEg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so3745915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385571; x=1707990371;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgEKGCcDaKKLTB6kaCOCKXIT5KmxZaW+10B/SjlLFz8=;
        b=tvEGfdBg0/vbuvVfBeBxtzPFNPMteQth4P2CQaZiNOrg0ILrY4PgeaR/XejpxiE35L
         bp928BlKJxEre8xwuiwbZp1+mnDm4AZ2sLhLQdSO16oCoY/tHMIaEfPr87/USfacQGlO
         lj6rhDxwmC/jc1zRQxUbN+c7AojYEVIsYMDM3mAw4PTiVu9rPypf01j4fr6uzy7JujrO
         IJ7gLTE9xl3utMgC1MTJn+t1jq+valA50jQjIMKrWhPx+p2lZe4j+JJxnrDayG4TaAUH
         qonKnGz2Hx30/vpXQI0FcQjWixn6r/YqAjBer3cNwaXgRIPrE4rV0tKIwspjn+FZF2/4
         grNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXKx++IifnHdJ4+q69/hT+HTgxNq1XKnjrr5l4Apj2hR7nxfGf9WxxR3IfWndXw0exnATGZrCfqnb8tfBqTxj1cgYlXeWp+NbufVNO
X-Gm-Message-State: AOJu0YyZjRd7XiHnEmuZh5KEYBnJKvLRn8ahzpNTIs7qYp+/R2f6cBnx
	p4CFn40MEv249yugBw0OvHyXv8+00ea4rxqR5FhJy38t6iAR6MSOXFdjNY2Bk3JYMjSvQ54a0D5
	IvZ6OEOm+TKAOR/AiK4qwp7VWt3sVKPoVeoWg/jzPIqGN774D5XS529V2N7HX2w==
X-Received: by 2002:a05:600c:3b03:b0:410:1ea4:e24e with SMTP id m3-20020a05600c3b0300b004101ea4e24emr2300700wms.0.1707385571672;
        Thu, 08 Feb 2024 01:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdXa3DuGzZ68IF+J2RF4lNdOdLH+gKjDcrLi/Tvl4GehAy2I4cW2ZgpHnGnwwtCR+CgJOanw==
X-Received: by 2002:a05:600c:3b03:b0:410:1ea4:e24e with SMTP id m3-20020a05600c3b0300b004101ea4e24emr2300688wms.0.1707385571303;
        Thu, 08 Feb 2024 01:46:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+Fnt1tdmrAp+kjDwi2k/mDHsTjp97kCqtuSCrbsON808j4+NjNqRQCGx315Ec+WhkhU8Gemnh29+cKcP0s7JDAjiZlonHnQ7IC2hjdqrxaePjvdN3aaQ1qIxsguh30S+Sso+wtZhHJ4Rgf9oRuAfFczjnqBH5Dkcj9PjlpfTCu09Mbhlema/bVqdEZU8RP2SwmR4xQLjjRC0T6CM1JXERpoE522DGZhsvW4PWSPraRrHajlFyiXUAZqBSaQ==
Received: from gerbillo.redhat.com (146-241-238-112.dyn.eolo.it. [146.241.238.112])
        by smtp.gmail.com with ESMTPSA id bo16-20020a056000069000b0033b0d2ba3a1sm1035470wrb.63.2024.02.08.01.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:46:10 -0800 (PST)
Message-ID: <9191f1863f272c11703995aaf83814f57dd38327.camel@redhat.com>
Subject: Re: [PATCH] connector/cn_proc: cn_netlink_has_listeners replaces
 proc_event_num_listeners
From: Paolo Abeni <pabeni@redhat.com>
To: Keqi Wang <wangkeqi_chris@163.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
	 <oliver.sang@intel.com>, Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Date: Thu, 08 Feb 2024 10:46:09 +0100
In-Reply-To: <20240204082251.5118-1-wangkeqi_chris@163.com>
References: <20240204082251.5118-1-wangkeqi_chris@163.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-04 at 16:22 +0800, Keqi Wang wrote:
> It is not accurate to reset proc_event_num_listeners according to
> cn_netlink_send_mult() return value -ESRCH.
>=20
> In the case of stress-ng netlink-proc, -ESRCH will always be returned,
> because netlink_broadcast_filtered will return -ESRCH,
> which may cause stress-ng netlink-proc performance degradation.
>=20
> proc_event_num_listeners cannot accurately reflect whether
> the listener exists, so add cn_netlink_has_listeners() functon
> and use that instead of proc_event_num_listeners.

Adding Anjali for awareness, as the last active developer in this area.

This change looks really invasive for a net fix. It's not trivially
clear to me if the change of accounting schema will bring or not
unintended functional/behavioural changes.

What about a simple revert of the blamed commit, and target net-next
with this kind of change?

> @@ -396,10 +404,10 @@ static void cn_proc_ack(int err, int rcvd_seq, int =
rcvd_ack)
>  static void cn_proc_mcast_ctl(struct cn_msg *msg,
>  			      struct netlink_skb_parms *nsp)
>  {
> -	enum proc_cn_mcast_op mc_op =3D 0, prev_mc_op =3D 0;
> +	enum proc_cn_mcast_op mc_op =3D 0;
>  	struct proc_input *pinput =3D NULL;
>  	enum proc_cn_event ev_type =3D 0;
> -	int err =3D 0, initial =3D 0;
> +	int err =3D 0;
>  	struct sock *sk =3D NULL;

Minor nit: the above breaks the reverse xmas tree order

Cheers,

Paolo


