Return-Path: <linux-kernel+bounces-63533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA3B8530D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EF828A336
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2B43ADC;
	Tue, 13 Feb 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKISP3I7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC442078
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828245; cv=none; b=gi+C2PhPfbrXvamObU1v+TE85UcG2z0GOKavCnvYfDtAKGTeFJDX8GUYGk1H7zRfTvt9wyQXSZH34/7ryTjv9GRqWD05taiA3tl5nzlWWAcPmE8N/6vnnyXojn1+9mM4L7weY7V6rUq8WznMubKsxNujbsLiFd59wpc8WygiyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828245; c=relaxed/simple;
	bh=WV7AenzBHwCuHxdRZfJJV1Su4NK7r2UNcztOBHaZti4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nSmxVhhMXJ/kYIezU4uaaS9+T6XNgmHRY+bFD6PLBKyTdTX7UGtt8vRyGxXAKBilvQkduWAeXZCnev1FFrOfqd8gZzoIyWrI77gLcK86q3hTtwh7816qnMhO/qXE2wlj9AhT0kFLvrKi4lpH/btWzOo45KgZxzOdKtocMcSINl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKISP3I7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707828242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WV7AenzBHwCuHxdRZfJJV1Su4NK7r2UNcztOBHaZti4=;
	b=TKISP3I7MUK3HuDX3U2EDaLqqsN2c4y5S12GEjrqzPQf0WO+tbgpbueQjwscmxY5+bY/YY
	5tVOgFres71cR9dLBB6c9pM9BzEjpsu62u2Fu8fztADrTTNqcTIFD+4F1bF07MrgLoWK3+
	bqBxnLB4XY5JhgfCFG/BIuwPuO0iVk4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-3NXjC1NMOg2oYWlzBU9twQ-1; Tue, 13 Feb 2024 07:44:01 -0500
X-MC-Unique: 3NXjC1NMOg2oYWlzBU9twQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78356ddf3cfso265668485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828241; x=1708433041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WV7AenzBHwCuHxdRZfJJV1Su4NK7r2UNcztOBHaZti4=;
        b=AjdwXFP6fv+uf7gVWODkJWs/+oITF/F19uML/EsA7OzN2SnvGI5bP7lsc11FBvYbSd
         2OzQdShpv6S9/6A3xZ3zQA1zQxnXeQ4jGvJs6z2YiKh3Q8s1c+7kpmU/IbWkjQp+P68z
         lRjgu5Yksi5ALPXbxFNTiZ28p8MSIM3OoyJRBAd7SakXOedsFxiZH3iJONZnZBrC6EvH
         +y3H27qgbq8rSke6freHynpzimH8WTGyCKdOx68CADtN200xunJYZChDUjV/JjaynVvH
         MEHZkTkabZ6EcEiesNiFouuAWfshtZonKjFUQzhVXhVNxQkqvDkSnINiXob6uJu8RTV0
         sLKA==
X-Forwarded-Encrypted: i=1; AJvYcCXOtyRa1UDsvx4kZ4l28iAy733tNTUg5SkWyAzMjLVu1AAE0msseeZD1bx8KGl2Rrw0wIftj6brswz1J7iaNmGGeFu5RO2QJDOCLR3u
X-Gm-Message-State: AOJu0Yy6CnCtdKJus5GZCn+fKW6tUsQrOEEeDTHJyiLwQCQgW4ycAko4
	ns7RM84Co5tnyBUINTwLDkySxIg8FKCu9MuFGo3hBeJJyRZeCVT9FHlz+1cN/59Hoa7tTQ4WLlA
	4+6LPEHLppLgtiJjRmNLi+MknFF3RYcZSqRE4+MYxHmR/j409QQ6d/ZH3jIl7zQ==
X-Received: by 2002:a05:620a:6845:b0:787:2405:cb36 with SMTP id ru5-20020a05620a684500b007872405cb36mr469527qkn.0.1707828240990;
        Tue, 13 Feb 2024 04:44:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHY8En9uvrMO7VPW6XxTnCs4He7ajvEA/No4uUFAjtgQfXLlH+j26/mV9Rjv9vwYBYKLnNr0A==
X-Received: by 2002:a05:620a:6845:b0:787:2405:cb36 with SMTP id ru5-20020a05620a684500b007872405cb36mr469504qkn.0.1707828240663;
        Tue, 13 Feb 2024 04:44:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFuieTSL2coOJKkA1OZuMzEQbiRNM1dhaDF2cbOSUm6S27jDJmwJ4T0WJYb97xL08ONSfKyphmXz6rSIAwwXEIA6MrLQDY7lIGCtO8u7NTtnENy3e+2keE3msT0sPnxrZAh/qZx4SXtutGfWP2e2KGlHaToA/DAcKiXjfjKGOnnxKW9KQc1XsGPuOW3wqWGUY6M3qvjCq+jby2aIPHjATQq9sm90869rELCSIE1H54ZVmVsEUiToCbJzZPOXyx6+QStL01Q5Lga9MU6KLGeX9Uabfyi5E=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id xr18-20020a05620a5cd200b00783f8693df1sm2918757qkn.37.2024.02.13.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:44:00 -0800 (PST)
Message-ID: <cae5b4d55770da3a1dc9678ffa55c9afb9c81723.camel@redhat.com>
Subject: Re: [PATCH] net: sfp: remove redundant NULL check
From: Paolo Abeni <pabeni@redhat.com>
To: Daniil Dulov <d.dulov@aladdin.ru>, Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Date: Tue, 13 Feb 2024 13:43:57 +0100
In-Reply-To: <20240211150824.3947-1-d.dulov@aladdin.ru>
References: <20240211150824.3947-1-d.dulov@aladdin.ru>
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

On Sun, 2024-02-11 at 07:08 -0800, Daniil Dulov wrote:
> bus->upstream_ops in sfp_register_bus() cannot be NULL. So remove
> redundant NULL check.

I'm unsure about that?!? in theory drivers could call
sfp_bus_add_upstream()/phy_sfp_probe() with NULL ops, even it that very
likely doesn't make any sense.

@Russel, @Andrew: WDYT?

Thanks,

Paolo



