Return-Path: <linux-kernel+bounces-82871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07F868AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A93285457
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792F132460;
	Tue, 27 Feb 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bb5nCDlg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE5537F4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022990; cv=none; b=VTqA3OEREJD6wK2bp2X8Sc2ISghRJrWMiGii3fy7jfaU5EOPZJUlksmCiX7Q86vjbPrRoA0S/d2rlozX1R2IFXXTZBCo5uURIxZZ4FLzypKdHebsVZfe72r8y+ETBf3L4zn688grc/SWRePNz26kw8du88uyrkOzjlTSbEtbEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022990; c=relaxed/simple;
	bh=wLFTM0gT3J6Y+QUR6schITJJke+c3UXPTTtLM7zsYtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ruzdP9PFsw0MRFsWOsza03VOl7/JcGMqsWDX87xmGUIxK95NCwOny8G6YrHTBGoKMMC9LR10YNuHzf7kO1jXjW5IQQJ8qgKZz12PUn7kgfpjf07Tiv4rw+9HeTrotdAA9yaqcjMUo47jOgjeMPIT/xiZYRJhdfh+eZf0fD+RKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bb5nCDlg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709022987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8Q/7QW7ULeInBjBQEsQG4XWS/a6QIwtjQY700E3RuE=;
	b=Bb5nCDlgyH0npgpHPuhJUB3G6UEST4GQ5EVEDqR3tfxbut4EhCw/m48grQO8F07+f3feiz
	zlM0O3l5oa1dV0XwVETzlOmJjNhxaHElBJBU8w/5iTuSY+UHjwx/SgaZKu53fJu3na+wzy
	vKW0dn3XYfyhEV3AWA9TyL3yCmUVR4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-xktZFL9cM0ezsfxEw0wFuw-1; Tue, 27 Feb 2024 03:36:25 -0500
X-MC-Unique: xktZFL9cM0ezsfxEw0wFuw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412abf5cd6cso469925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022985; x=1709627785;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8Q/7QW7ULeInBjBQEsQG4XWS/a6QIwtjQY700E3RuE=;
        b=rd6y//h1keUt76kvgwsPAc9l/fsmLSyRJKD1l+cCqUFySIODQNm0LiE20QL6000kIL
         60QWmoFijyOGqo3kt8V8l6mTEg14qcDcZ7Ps56tXB6ybBOsQB8zHL75ALwl4d7xZLC4G
         ikIzIqERj8adj8hjSYJrR5eiox2F+Lid6Zjl8Ta4neN/GzXMec0mcL3mUM7dIOap9972
         lYZUtLQTlZqa3OQWL3nKRx969NL9TJyKUQa9Y5YhkOoNOprBz7/jtB1SDgG6kiWoZ6O+
         S3/SXZ1soLu4yiwSPwJrP6NUVJoB7CtXK+mGeLtM1ixShV8zQ4VWIf8algWCU2wU1yYZ
         N/lA==
X-Forwarded-Encrypted: i=1; AJvYcCVSX3TRLb9OrVlBedlbrnqW/iArCgr7dp1uOygpB9MKlzvyqaJo/xMYLsRicSj+4RwwZo7VXPFiziYVGfkIwIn5VfJJEmKWE3F1XqnQ
X-Gm-Message-State: AOJu0YyiXsAhSnbWxAkp2mojJ9Br5251QkN2VbVJOxanf9O/ISUfgd5T
	1o54TASQT2T2n+iWeBNbVrdUIn4f6SVDsyYGb6TWNxBJ++mgHlrjLqh0QSd5vfMU1IucW5s2xny
	Wo2bj00DlIgRj8nPF5xx5ErlLkJd0/TIwsCIcWJqWAvtGdKlnHvjwRnUoi4b6BQ==
X-Received: by 2002:a05:600c:1c05:b0:412:a1c1:2d9f with SMTP id j5-20020a05600c1c0500b00412a1c12d9fmr4476942wms.1.1709022984746;
        Tue, 27 Feb 2024 00:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxRiNPkkEp0X0EbPC9kQa9ca3xf+pwVoKCiXiZ1/TJgyykECR7L0u/mlWIrUOurhRe9Hhj6w==
X-Received: by 2002:a05:600c:1c05:b0:412:a1c1:2d9f with SMTP id j5-20020a05600c1c0500b00412a1c12d9fmr4476935wms.1.1709022984396;
        Tue, 27 Feb 2024 00:36:24 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c4f0400b00412aeb77bbcsm618503wmq.19.2024.02.27.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:36:23 -0800 (PST)
Message-ID: <35ba7c2cb75bb8141eb518c764ad8975054f0463.camel@redhat.com>
Subject: Re: [PATCH net-next] net/core/dev.c: enable timestamp static key if
 CPU isolation is configured
From: Paolo Abeni <pabeni@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker
	 <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, Willem de
	Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 27 Feb 2024 09:36:22 +0100
In-Reply-To: <ZdeSHbRa3rtHE+2E@tpad>
References: <ZdeSHbRa3rtHE+2E@tpad>
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

Hi,

On Thu, 2024-02-22 at 15:27 -0300, Marcelo Tosatti wrote:
> For systems that use CPU isolation (via nohz_full), creating or destroyin=
g
> a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
> static key to be enabled/disabled. This in turn causes undesired
> IPIs to isolated CPUs.

I believe Willem is correct, the relevant flag is
SOF_TIMESTAMPING_RX_SOFTWARE, see:

https://elixir.bootlin.com/linux/v6.8-rc5/source/net/core/sock.c#L938

the example you used is a sort of API misuse, placing flag where a bool
is expected.=20

Please send a v2 with the updated commit message, you can mention both
SO_TIMESTAMPING (SOF_TIMESTAMPING_RX_SOFTWARE) and SO_TIMESTAMP.

Please also include Willem in recipients list, since he gave feedback
on previous version.

Thanks!

Paolo


