Return-Path: <linux-kernel+bounces-130238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45C68975D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77765281E31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558BA15219D;
	Wed,  3 Apr 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VSsW3yJU"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3948152162
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163663; cv=none; b=nuDNFGLleJh9+n491TjM9aekgH+rAf/Qg8sUO8yG7yBWq6l0QHpa6AlHsXmiKZSuyGzqosHuxT/QU4bp98IcueIekO0FuY+OrIrpCVDGt+pgbafiqlD/Jx0QMJI1tvyg3I+XzXewMiWlRHNJsun/0ct7860el3zrZKvmJBcCyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163663; c=relaxed/simple;
	bh=pCLNzzLPBjclBQkvMoJ+H7z2bFenb2zAQY9AAvNZjGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2MB4UwZB6d78l2F0Acx14viLLnr26e2NdmbQJ4D0dKeA11arm0Z3C57RfAYPp4O5Y11HD01PMVjh/WTr0nON2+wfXwIGaUXzNoaHcqe9hrScjanzwJsiYzGuxVIiKmg1eMtvcs76UppAQv5efctxk/Y1R0NdFNIwO8tyJhSoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=fail (1024-bit key) header.d=arista.com header.i=@arista.com header.b=VSsW3yJU reason="signature verification failed"; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so4333714a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1712163661; x=1712768461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eijqq1kellEja2nXJ0nGvTSxawC3HDrhpQA6YnGCSQ4=;
        b=VSsW3yJUleNGPeqHgxDeDpkKvQ851yLnVQChKjh/WFepnQIKGBr3AcuouwsLt8g3yX
         qHXUuHrXkCGs3XFGRly7x1uuyS0fjMU90tq1xQyjua5Uu0ZD3WdCRbsYhJLXN7moZp0U
         sHvBriemOyRI9oHzeT5W13Js9BeZ6o1wHsgORJ0Y23J0HZPfP6uq6smTglkbatOdq9Fy
         QpNGvvgR8AFbomu0OGmE1P7k52lmVTCM8eqpr0E97PTIAmS9zoePpJPx00F837RbZYRy
         OsfbWaI/v6usx4fy1GehqG/lwjMs8GiJs5zSUCWYhiXjM+rfnFASwCf1srQiSqjDDIkg
         7zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163661; x=1712768461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eijqq1kellEja2nXJ0nGvTSxawC3HDrhpQA6YnGCSQ4=;
        b=irAlt0rUTF8VTeX6Q4MplvAFY4H+CRAyuVn1IsIbomNmBi6dc3FBTx4nCm6vMt2xW9
         xA9gZVpElhiXs4aA3iX+sLpusEzcXFxo4NuYSM40+yIOAdxx6ovSK3USuUAfqyA1fA/D
         DZUqbDQN7csRG3dytm8ixj2tjq3crBYIHrDZmzRB4CNod0hCvzFMdWafh/enRUry0mKR
         Q/vKQZ5/fP5+5D41s5im3KrfZ0lyk1vRvh8KGj4dH18OLixf2TdCUI5o1e5CyKhzD4Eo
         KglNGC30FJIMUdC3054sNEHddg6iynryYVoVvD5sDrd9vpM1rCGn2Ni3Vc+xbKxazshU
         Ivcw==
X-Forwarded-Encrypted: i=1; AJvYcCXbhP2IBsdKHQVt1CugDBsn8N5Ox9bTz0sD3IYMcZkwhtbNCAcNXGbrLhlZlVEinMgms1Wtcv/0pNyh5tEgh4ubdkiRvwnbMkweD9pE
X-Gm-Message-State: AOJu0YwtUnz87QRXGI/YqfHZiWFAYmfilo4T7GYqEbNN1G0lbSQgBOfD
	oVveclHlEdtjqW4uT9bcuPLz05+ocCVLLEjXb7uzkd5avQI66BtiRiO34Yag6GL+574OF7hu3YB
	7ZsXuCqYZCXO/Nui+uOogia/iVtNfwpljodG/
X-Google-Smtp-Source: AGHT+IH+b/yzFFmXkyLOQ8e/HJ2CJOFKEsj8o894ViUToeucMYnGc5Ulmwpl7GyflCzMs9YbMXKZZLY6LiWJ86MkzmM=
X-Received: by 2002:a17:90a:ce82:b0:2a2:6a52:96f4 with SMTP id
 g2-20020a17090ace8200b002a26a5296f4mr118745pju.9.1712163660743; Wed, 03 Apr
 2024 10:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403132456.41709-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240403132456.41709-1-aleksander.lobakin@intel.com>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 3 Apr 2024 18:00:49 +0100
Message-ID: <CAGrbwDQ40DWXZ1AYesdXMXrb3HWW6bs6dAYVaUrwDriCekwg3w@mail.gmail.com>
Subject: Re: [PATCH net-next] net/tcp: move TCP hash fail messages out of line
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Francesco Ruggeri <fruggeri@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	David Ahern <dsahern@kernel.org>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Wed, Apr 3, 2024 at 2:26=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> tcp_hash_fail() is used multiple times on hotpath, including static
> inlines. It contains a couple branches and a lot of code, which all
> gets inlined into the call sites. For example, one call emits two
> calls to net_ratelimit() etc.
> Move as much as we can out of line to a new global function. Use enum
> to determine the type of failure. Check for net_ratelimit() only once,
> format common fields only once as well to pass only unique strings to
> pr_info().
> The result for vmlinux with Clang 19:
>
> add/remove: 2/0 grow/shrink: 0/4 up/down: 773/-4908 (-4135)
> Function                                     old     new   delta
> __tcp_hash_fail                                -     757    +757
> __pfx___tcp_hash_fail                          -      16     +16
> tcp_inbound_ao_hash                         1819    1062    -757
> tcp_ao_verify_hash                          1217     451    -766
> tcp_inbound_md5_hash                        1591     374   -1217
> tcp_inbound_hash                            3566    1398   -2168

I can see that as an improvement, albeit that enum and the resulting switch
are quite gross, sorry.
I had patches to convert those messages to tracepoints (by Jakub's suggesti=
on).
That seems to work quite nice and will remove this macro entirely:
https://lore.kernel.org/all/20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@a=
rista.com/

I need to send version 2 for that. Unfortunately, that got delayed by
me migrating
from my previous work laptop. That was not my choice, resulting in
little disruption.
I'm planning to send the new version optimistically by the end of this week=
,
at worst the next week.

Thanks,
            Dmitry

