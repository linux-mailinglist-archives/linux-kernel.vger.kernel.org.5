Return-Path: <linux-kernel+bounces-131142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A58983A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27EA1F2164D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758FE73527;
	Thu,  4 Apr 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6AYak8e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5B71B5C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221026; cv=none; b=pN9ycp40R+SGooJ41cLws0/5yq28W3yi7JFiGvROwOkdwTuHuqFyL9V9U+jI+Zx7kiNBf633gRWaXKmPecnIOdgCv7aY4QcITC2c4v3CORCbt29o1fRb7nKF/5QKjRVPeafM4fO2oJ56Nz3LWDbosCPKoxy6MiY/bCTI0qH+sEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221026; c=relaxed/simple;
	bh=payVFyGnjrWONQxZPASD2sELUcqQAHBtglUmm0Lf5IM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHhM3I07+0wPFhvfeK8SLMAi5FWkpQThIXyWaa7GwBDlgFPulrSi/rkT3Gqab3kT0Pl1lTnEXSxPc9AZRSTJ5bt+0143vXroAokDSVSDqzX7WlIRfgsv1Fuv1Bz/z6zrNg7vvqpvmguEosiG4XLOR2nQZYv9NTK4LeJ20j1ZR0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6AYak8e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712221024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KaZjg34ixG35MC2J/uQFBc+0lATRGuM6qjOLyn811BA=;
	b=e6AYak8etWB0hs/BN7/o1nZ2ZDsxCmfi+C+p7zFmKNXWofLZBsmicE221e1gShioeHW1Dn
	ezGJ5P3+MAHA7ue2ToCnyYSNGE1XlkE/z6GxumQ93Bb7Fn7bKccaUu5XoBgIjQhA1AobWK
	+te2/OGLYeHEzD0MYjWrNYN8aHq6Iaw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-jrDPL7idMmKzTehil0FfDQ-1; Thu, 04 Apr 2024 04:57:02 -0400
X-MC-Unique: jrDPL7idMmKzTehil0FfDQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41543b57f2dso1767155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221021; x=1712825821;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaZjg34ixG35MC2J/uQFBc+0lATRGuM6qjOLyn811BA=;
        b=scystlq6wciMKx5xoYU1VcZdXzCuwcq6vZv1qkw8em6EVlIb0qxq09eHoWM2tEL4sp
         BhknF+IAHr0pE3XnqoJGRnRG7GAHekHxcE+kxiNMK7futM0YciQbru2ayFwDlP6nQ2MX
         sd88cNfS2GjxuBxv4n0CCdUZ7fG2oqKOzp9CGVS1eFcfudnUb/vfrJjN8rzAlWp/PlBE
         EAqwN/AR1YqXfFJFdzE6hpqDg7vDOusQZMqN+IQlXOeCaywrLM5861o47AohdYYHsCnL
         q0148PDrPl8pMoLz3RZk4huXPyrsUfdBgKcvdtRnUq4b2icTLvOcufgsbGvaqp8S0tNu
         he7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyRBnMZVCmsjFwNUt+T6OTIh1uROhviBYTlUDmpVfP41XhJeaCaOPCbAREBJgVKEl+oierOesTQPYi5mI72NZtxSo47d01s6wjxetu
X-Gm-Message-State: AOJu0Yzgv3VdrPpX4qy+GZTkfS6tJNQmCOYH/sqgEm3qIpk/AI5w8KKq
	dx/LZ3QKN42tv53WlACYmAFZ/saOeZSRbmdBd4AEvFmOJjSWlnNa5F6N830NvdCGCZWyLMLArBn
	0ZsO0VdVazIw6serlBc/qleo77ceh7TP8yJSezyyYAt1mqxQAcCnotKvUf33iWg==
X-Received: by 2002:a05:6000:1887:b0:343:bccb:af41 with SMTP id a7-20020a056000188700b00343bccbaf41mr1114707wri.4.1712221021385;
        Thu, 04 Apr 2024 01:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYoTW/0xnQmkFpE+2Z699+rByuCUrILQa6di79cHcS1c9qPyT5/db+Oox9c/qVG9EP1+H8rQ==
X-Received: by 2002:a05:6000:1887:b0:343:bccb:af41 with SMTP id a7-20020a056000188700b00343bccbaf41mr1114697wri.4.1712221021075;
        Thu, 04 Apr 2024 01:57:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4b8c000000b00343723c126asm6306182wrt.48.2024.04.04.01.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:57:00 -0700 (PDT)
Message-ID: <4726fefd2a710cbee0d1a7fb15e361564915e955.camel@redhat.com>
Subject: Re: [PATCH net-next v3] tg3: Remove residual error handling in
 tg3_suspend
From: Paolo Abeni <pabeni@redhat.com>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: mchan@broadcom.com, pavan.chebbi@broadcom.com, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, rjw@rjwysocki.net,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org,  michael.chan@broadcom.com
Date: Thu, 04 Apr 2024 10:56:59 +0200
In-Reply-To: <171222062943.6705.9843920756752610864.git-patchwork-notify@kernel.org>
References: <20240401191418.361747-1-kiryushin@ancud.ru>
	 <171222062943.6705.9843920756752610864.git-patchwork-notify@kernel.org>
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

On Thu, 2024-04-04 at 08:50 +0000, patchwork-bot+netdevbpf@kernel.org
wrote:
> Hello:
>=20
> This patch was applied to netdev/net.git (main)
                                   ^^^^^^^
Wrong tree, blame on me. I'm reverting it from net, I will re-apply to
net-next. Sorry for the noise.

Paolo


