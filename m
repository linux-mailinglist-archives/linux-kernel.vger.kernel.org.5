Return-Path: <linux-kernel+bounces-54215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362384AC51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BB31C23A41
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C3F6E2CD;
	Tue,  6 Feb 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgL6Uwe8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EA6E2A6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187709; cv=none; b=amxLZB7TPqYv1MgWkqfMJl574hcz5KMw3zrijAghfOOEe00PMdpUMdjZ4aey3SxYZD9ObetHT6ardO+jMMCjY9SWfrgIFPb3m2c/dlW53QJDXhtvwYw+KErWvEcSzYs1N2s+83zQoVxBD2elrKTUp81aYkswuxr0TX4wIXtjVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187709; c=relaxed/simple;
	bh=ztwf0puyw2TDsCRrz3TlAqmaa620OVTaNmCiF7tFow0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agX0aFFmxrrBTM/dUuRjbk8/I3DKfsb1/t8SShmDEIL/HppY3v2rBhDpebz/uuF7S/9QOlcG0z9nelVC+epcURtLC4ZFc3drLpQwwQYYQBIgQTwtXKVxGMC+6Wrss5YhYxNnX1uVkGRsH6iCCNPpuYmGdfVAulCp5gKIkMzjXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgL6Uwe8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707187707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztwf0puyw2TDsCRrz3TlAqmaa620OVTaNmCiF7tFow0=;
	b=QgL6Uwe8YL4lfZoLjNZt4YDjhaaBTeNIU6CfTKdwMsZS2lfUi7h12YuB/8Ql0WQn3Rw14i
	Qqa6cWMzErW2SAPdTGj8P9lWnY4QaRD7HZDldzsGQfzfmWVEeUKg8GClxW0lnnVpQtiAhU
	meZ6wk+TBoXsyKfE5eHaO40sKqg897Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-KzOOj3FJN52WOgPhpJja5w-1; Mon, 05 Feb 2024 21:48:25 -0500
X-MC-Unique: KzOOj3FJN52WOgPhpJja5w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e04e1ac0d4so1119754b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 18:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187704; x=1707792504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztwf0puyw2TDsCRrz3TlAqmaa620OVTaNmCiF7tFow0=;
        b=HxDAIxSLtBWp2NzfUz47q1aNr2EElGEiZGNrtNZ2VfIq43hZD9FEF1eRffxYvcwVN2
         6S1Kl7TFE0NGaYe1jimVNozX0U1ossRoWR6yohW8niUbYTn49mI99ln3N5X8y8yyTJlu
         ZwVwlzer8W2fvHcbEHwgg1VUWX3IVAzvkNn9ZV5XC5Iiat7wbiHuNTgavsxAmD9Cc2xp
         7eym/BRaH+VLOi0NvcjmKgczKPHAyo4NaBzxHBNOj5sp4Vuy87KPR9b01pTzMewxTBMi
         869HjPzI6kVpJT/LLR/XQ+DUKz02Dr3OqlPg8Oq7uJ64eTWCG0ZSqDgNxxHSQgIPqoSz
         bKWA==
X-Gm-Message-State: AOJu0Yyc6IWN/t8sYQcdqzeEBv+UlBbrR9MJ2zo+6+zpLjSeJZIMhM40
	co4POKZJ0ME6gGkNZm2zMpi7ZZDIWMfiIHh3+4uJ4aiIkaTVtEMRFAv0I+Dq+Q0S2gofaC6o6zk
	IXMj6o6tlO/RekkW5OEl5aWx5UbiBH2YJ9d4xeGCplC568P/Y4AiMzTaHsIw1JF8F2UijrcNcZN
	/IzvIbOp0N5bwp1UFWcK24qygdJGNvpvClmwNC
X-Received: by 2002:a05:6a00:2d99:b0:6e0:4674:78c2 with SMTP id fb25-20020a056a002d9900b006e0467478c2mr1191455pfb.13.1707187704624;
        Mon, 05 Feb 2024 18:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6LEs4cSQQ7pPO6vnlICrTTJ6trV490iUuP593kPzMaV8ONfvf21ILMwECc8CTSanrUqlGbuOmZAhk8gIZeqc=
X-Received: by 2002:a05:6a00:2d99:b0:6e0:4674:78c2 with SMTP id
 fb25-20020a056a002d9900b006e0467478c2mr1191444pfb.13.1707187704363; Mon, 05
 Feb 2024 18:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>
In-Reply-To: <20240204-bus_cleanup-virtio-v1-1-3bcb2212aaa0@marliere.net>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Feb 2024 10:48:13 +0800
Message-ID: <CACGkMEvoRN13c9Do=HsNzxMaXd0=-cLdNKuU8P_Vdj-89fwJuA@mail.gmail.com>
Subject: Re: [PATCH] virtio: make virtio_bus const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:52=E2=80=AFAM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the virtio_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


