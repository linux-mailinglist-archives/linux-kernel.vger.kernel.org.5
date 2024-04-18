Return-Path: <linux-kernel+bounces-149740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB08A9543
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B671F23DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2C47F57;
	Thu, 18 Apr 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVvXFhss"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C17B3FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429967; cv=none; b=SKXEn4KD4YlEawjSDl6xsQfilrvn4rV+yTVhPcNWEJL1741uUgrn7jMEJ/1CzoCb28kwIvJYsKK2dJi7pvzMn9cnP6JfSn+djVmxyXLhplpLsavUeyRVAnqm3fvQvbSn8kdiDQ7O7GbuFuQa2vR50P1Iws63TvBRzrXjBbYaDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429967; c=relaxed/simple;
	bh=rL4vv1rvEdxBdNSd4B9Z2Db4xJsvrctpqJOSUdkm9AQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sCTTR7Q7j3qLCJg1WlInn+/8Xxt04DLWjPIq0yJsfj4H9fjZo8/gcH+pcJsuYgM7tyMRNJcBeaX+kAVCiTCjHtbbGN35CHyutnvGmEBR9bO8K76wInQGtPO3yZ8eFelK7Kfi9LJAoWvV24u7Es8c8hVlbEfpxBIJmLQdcxMgueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVvXFhss; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713429964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hbetPfAl7oGIPhY12AHVrIYHy5IAQIxNhlC8CnnpFIU=;
	b=dVvXFhssE8h3G0f8sKPAAbD0Dk8WqfK/CuMzsF/TcwWiMWVpqtZpMOq6NvYT+0DKSME+Du
	Y/dNgZ3MBeoEb4S5MRagQ4aMwzUJMNvVlvL6SywUM0EDM1B5QZydirkWh7gGuxUZMB1W52
	5Aor2ISWDIjRdZyR2UHsgi7nZpMmmOI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-_6v4nhbTNtSnrHZ2rv_JgQ-1; Thu, 18 Apr 2024 04:46:03 -0400
X-MC-Unique: _6v4nhbTNtSnrHZ2rv_JgQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349d169170bso86807f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429962; x=1714034762;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbetPfAl7oGIPhY12AHVrIYHy5IAQIxNhlC8CnnpFIU=;
        b=FR6kv/lFDXjuHcrdAsffjgiWdq61Dl89dWKwtDlJNguziwDgR8X5tXaPMpXOwNdEix
         4CDir/idWshH+bDmLHMOj38F0M9P3b/doEECTP0oFDyIGH5zLaNDMGr0CnwyzIjyEWfu
         4P6NXLMol0eRxVTesqzwXPPFynE0AKGb/RqmtEH4C+AuZ+gqHyfiYmeoMfu7jM2eoj6O
         oTGr+wlRe30vukX0eKUwi8cw61dPgV72JJ14UTPQCXMyN9KOiGVHN/bQtdiIfzMBy4cy
         xQldzveCxUWRVxFJRGIiHv1glOfq4xYTOtiRTA8wDpE0g6879jwqiZKSvXgn0AYZPv/7
         d6TA==
X-Forwarded-Encrypted: i=1; AJvYcCXnAGpWzcEHVB0nu8b4TEzQBQMtcTorQoS0zT+GTUOHmAeyhSCqOSTMIVpBqGFF6j/NNbIMwmoUdmJxfpJjCYOta5iMK3CQFpvfuaKA
X-Gm-Message-State: AOJu0YwldSHZrw03nDwkW8ZHmZUBDClb/9iZaeKyicdh1uW3V/tBxa0j
	9N2rYkPK6YphLoDRfw1CEjB3jdGvHbkls0rQqlKkSl9EdiLS48zXJjSSYVwEkZv9+S1mCQvIN8S
	2xCBVp8LdgPrucNWZuU1DUtLVrBQr2+D7ESM+lC+xCC2OhNNX8BcW4x8I4+mwQw==
X-Received: by 2002:adf:f305:0:b0:346:408d:42e6 with SMTP id i5-20020adff305000000b00346408d42e6mr1248466wro.2.1713429962008;
        Thu, 18 Apr 2024 01:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnHJu3z9OnQYOOWl7b60chAM8RcZt6RMjE51ap4fmdPWnpBnAgZOKd4GkIiihkGYp2Rq7Hew==
X-Received: by 2002:adf:f305:0:b0:346:408d:42e6 with SMTP id i5-20020adff305000000b00346408d42e6mr1248450wro.2.1713429961623;
        Thu, 18 Apr 2024 01:46:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id h16-20020adffd50000000b00346d3a626b8sm1282279wrs.3.2024.04.18.01.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:46:01 -0700 (PDT)
Message-ID: <d19b1702cf9f41b6996fcc9f10689eabf2a5ada5.camel@redhat.com>
Subject: Re: [net-next PATCH v5 2/4] test: hsr: Move common code to
 hsr_common.sh file
From: Paolo Abeni <pabeni@redhat.com>
To: Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,  Oleksij Rempel
 <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Simon Horman <horms@kernel.org>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Jiri
 Pirko <jiri@resnulli.us>, Dan Carpenter <dan.carpenter@linaro.org>,  Ziyang
 Xuan <william.xuanziyang@huawei.com>, Shigeru Yoshida
 <syoshida@redhat.com>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 linux-kernel@vger.kernel.org
Date: Thu, 18 Apr 2024 10:45:59 +0200
In-Reply-To: <90c5d1b6747d7699ebec50168672f1c435269e7f.camel@redhat.com>
References: <20240415124928.1263240-1-lukma@denx.de>
	 <20240415124928.1263240-3-lukma@denx.de>
	 <90c5d1b6747d7699ebec50168672f1c435269e7f.camel@redhat.com>
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

On Thu, 2024-04-18 at 10:41 +0200, Paolo Abeni wrote:
> On Mon, 2024-04-15 at 14:49 +0200, Lukasz Majewski wrote:
> > Some of the code already present in the hsr_ping.sh test program can be
> > moved to a separate script file, so it can be reused by other HSR
> > functionality (like HSR-SAN) tests.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  tools/testing/selftests/net/hsr/hsr_common.sh | 96 +++++++++++++++++++
> >  tools/testing/selftests/net/hsr/hsr_ping.sh   | 93 +-----------------
> >  2 files changed, 99 insertions(+), 90 deletions(-)
> >  create mode 100644 tools/testing/selftests/net/hsr/hsr_common.sh
> >=20
> > diff --git a/tools/testing/selftests/net/hsr/hsr_common.sh b/tools/test=
ing/selftests/net/hsr/hsr_common.sh
> > new file mode 100644
> > index 000000000000..822165391573
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/hsr/hsr_common.sh

Whoops, I almost forgot: you need to add hsr_common.sh in the
TEST_FILES list in the net self-tests Makefile

Thanks,

Paolo


