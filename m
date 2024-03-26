Return-Path: <linux-kernel+bounces-119159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C088C4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392AB1C20FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA612D751;
	Tue, 26 Mar 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYpozZ5W"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A96762F7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462511; cv=none; b=ddCPb/7GTZnT0RjZSF4MrXqML6e0dCBuiUPCqrKJjPpYEZXg3hBxlxMlUx+zvv85FGIwBar3TkmGORuPRLcUwcrOHFnx+2zuuBb9Fv7PIt4mv63l5Ac2PSaOc2INqcdfUu+3fPTbpDhgJE1IIgjSm/lMCfzcz+hrkexcAEs8q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462511; c=relaxed/simple;
	bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmiB61qDcHr7b77/PXMga4pxWH9pAZvq88aJkt8YYUVVMJUaogTjK3sYWM0eU5zTzZeSZcdjo61KZoFgftrHUDUBXbvRGM867zgq1EyzyNUA6c+W6KLJ7u+e0TGBAWXx2jnD9r8ERa14e59645s9iI10b9/tdaYz3tskAU2zZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYpozZ5W; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso8107a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711462508; x=1712067308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
        b=oYpozZ5WtSu5jpwmjGNry233tkGvWmCZGnMTsXOshJg7f2xuyDkqX4ioUXEr/V5zi7
         Jkk/4rNN6PeQq0XaOrHfc6RCnnVVRPMMJ9J2deCTv1qTealooa3QBAbbRDqAZDTqAZqA
         kSyTg65m/J3E+6OfmFajm+gxeEJwppcY1tr+yAipufDVQjl4aq8Pc1r1mvt2zXfpXwyG
         q6Q+dUPbNG63Zk6/42yX4U7LjydeqSxgz+uumlvXleas3gjTNQjjrphDepTjrvuD7YMS
         coEzl7ohFFmpJMSI3kjyP9/iSaWbqW+ScUU+jh1xtRqSKAG5DIZdWnCqNjF5QvKJ98MP
         bb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462508; x=1712067308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
        b=BokHt3TV1FMl1tGWwULlQzh6tkGp7r0eYxMr/0TKjYCIXo3HNcXM/ws4NzJIuW3pw+
         y0Q5J0z+ptnd8ddMYn7Jo4wUcpHvDtAdelUnLNkOczc6HxltAipC8jRzrvQ67DnuINwb
         xTblWvvSRE533PBEgc0JaxP0eozXMa9bGBZoHx1yceGwYZ2mCyt75+HV9b+4zoMb3fxa
         lhQHDu4JYxmf5+JhDZ+NKjdixVBTdfuMOVKVK6O/XGWd2c4fiPMai6PgvLplvaXcfds6
         mBvpzMUUCIKX7Cqd8R0EGm3xISmBwoZVAPy81oRaX6d5vI2z58JbeomvXIPAeZVJRl2R
         C+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSPKyscz/bgE0CKZ5K+VT1TnyKgjxL6Y5NEUHMndIFTuIAC+pNdYM8A6VIsSQS53ncAyqlMDOFoNTj1QNw9fplZE7gfUZwZzUMmnn4
X-Gm-Message-State: AOJu0YxYEeviLAnvS6L0pQgJH9RMkdj5d3D19Dn39woeChHrYHUQ0vAu
	BU2e/gCwIp6Zua2Gpgtx/UUZwEjdS18NQ+hAn22ez0U3GVEqZgM6GF6f31JJA3e68j3lUmwQaFe
	1bHSAFe83yOzVxfrn97ZmLOZUmOu1TWDBDSYA
X-Google-Smtp-Source: AGHT+IG1Z+WPb5y1Nz3VMT4UqqtY4fpc8jx+h3qL2dywCVAyPOrhigIpDt4Vcw3QK9/kLtXuyctPdraZ6ZuleVPscws=
X-Received: by 2002:a05:6402:1a26:b0:568:ce1e:94e5 with SMTP id
 be6-20020a0564021a2600b00568ce1e94e5mr105879edb.5.1711462508403; Tue, 26 Mar
 2024 07:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325182543.87683-1-richardbgobert@gmail.com> <20240325182543.87683-5-richardbgobert@gmail.com>
In-Reply-To: <20240325182543.87683-5-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 15:14:55 +0100
Message-ID: <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to tcp_gro_receive
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, dsahern@kernel.org, xeb@mail.ru, 
	shuah@kernel.org, idosch@nvidia.com, amcohen@nvidia.com, petrm@nvidia.com, 
	jbenc@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	liujian56@huawei.com, horms@kernel.org, linyunsheng@huawei.com, 
	therbert@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:27=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used
> currently only in tcp flows in GRO.

I think this is a bug.

GRO should not aggregate packets if their ttl/tos fields do not match.

