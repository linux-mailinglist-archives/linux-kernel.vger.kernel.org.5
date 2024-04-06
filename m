Return-Path: <linux-kernel+bounces-134082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738A89AD02
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A5E2820A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE364EB2B;
	Sat,  6 Apr 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ND3qzpn6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8484E1A0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712438513; cv=none; b=K9YupqDM1tIDR3qZWQIjWC0FWKaIsSRJgEiBku1MxQ6orogffEapY6C9xiGzd9LzM1OSNhDjAYI1/b//mQceJKhqLqp9GXhLGU/bUqnJ5JRSNfaO7gZrdgXfWBRR3fbu3/Xe7VT6dRunj7eTxsuEIuvyyyfzXH627b53Pcqmw6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712438513; c=relaxed/simple;
	bh=y//Lh8Tr8uv2aV+WmYKxwzKjGldtEJe8+2y5s9hvN40=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pb9eC7pdCkCPcq9bH/sTGRAK/Y9vo57IUt7yUl0lUPuXntlMgRgyrcTrWfCfn8wnh/mgaEzLrzOunHH1t3VXsLC49id9+72Aw74TxbX7eXygB1P2IHbmNG/nEjLqqgQ8W+7nm1Nl0VEsMsyI4B3mEQA0u8hhltf+8vC4eZ9Ypec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ND3qzpn6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4162ad8ddd0so18592475e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712438510; x=1713043310; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyXlKEN39j2LXw6tJQQuTLODo/6T3jH4hJW4z2ZyOQo=;
        b=ND3qzpn6VYoxApjHAhaK9bV7KLLyA0m8GU19SIgykqk7gNSxxtDY3ZZzdAU3n2V6lg
         G1A93yvacXFVf2xLlcPaxjoEPaQbNqDcBaGqklCD8VZakfWKghSAWom3lpCW+IVOLtur
         4cdrvoQmzcElDAhSknpam8lzNT8dCc3I9nesWB6qLRSUtCfdRmHLeeEsPB7WcTHhsmlI
         SRqtUxLn7vPcjEHkmRIxWC6nFW//+AWhcUh0FhY8gHdRGe4dBVDrjqhJJoLrLEZV3FRH
         6HaS3TJJ5pzWfXzOvYQtGgQvwjGOYsiSrn4gesi8/PRLHGzitwioWy3NEO4jKk6ojMHU
         PhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712438510; x=1713043310;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyXlKEN39j2LXw6tJQQuTLODo/6T3jH4hJW4z2ZyOQo=;
        b=EVrQXcbugXPzNDRiNLIci81c+tUv6VvhwNfIJZOO2jC+l6CIRkClZS1M0+72p8k0MS
         7FHoJ/7Cen4xEehsn0TT6fnBt7Q1nedi/vzjJj5e/wh6pTnO/vZU2c5wnH1PWYyCpaZ2
         AVrpxylyvfwKzcVuNgU55yUA4aakS25EFo6SzpwKR47mmepv+SxRr2FMWolRfAw7ueLi
         3yuAo+EOEdz4lNQzZzF56kaVCLPYQqX/GCs6j8e4NmeG2Cen4oM4AOdNzlMBmOytDB5N
         52Djjue3FgIXn/TxjJulnI0cUGDLAtQKyCY4fMazdz/mO/L30nLVC7ywuE6ehFMzR7JZ
         jOMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT084b8PMf/2Pg0nxDYzM+nhFEQ79WgzWZ+jMaFGW+RK3M5ubKnIUfmrBi+lmNsc9gZxjAdrfgwYIENnsMe/aaMR6LxQjW1DHTFAJf
X-Gm-Message-State: AOJu0Yzuc4SYwLdZl/JAQuW4exG/ozgeIVPJdLC6PjTn0G3HYl3/DwSO
	wu4pa/xGfnnbYfDuEnH2GrUPRrOe66r+Alc8s6yRBgNmbe3OgMThJwZRYnfkZtA=
X-Google-Smtp-Source: AGHT+IEjV0U0KkcWPwvL/zTdku2P/I8C40e1EFFT1iQps4xd4LDMS9Nj3IIMWd4uTXK4+mB2spfzKA==
X-Received: by 2002:a05:600c:a04:b0:414:1325:e8a8 with SMTP id z4-20020a05600c0a0400b004141325e8a8mr4279849wmp.39.1712438509955;
        Sat, 06 Apr 2024 14:21:49 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:f18b:c867:4069:879e])
        by smtp.gmail.com with ESMTPSA id bi15-20020a05600c3d8f00b0041657f61f1dsm211660wmb.25.2024.04.06.14.21.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2024 14:21:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bcachefs: Rename struct field swap to prevent macro
 naming collision
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <wvui43l6pcfexoglhyy4xfdjs4mrjzmbcwupnb4djlgvrebn7s@l22gudock5d6>
Date: Sat, 6 Apr 2024 23:21:37 +0200
Cc: Brian Foster <bfoster@redhat.com>,
 linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5B1C1FA-0B85-49ED-8EE6-4F01FBA2AC99@toblux.com>
References: <20240406141919.248148-2-thorsten.blum@toblux.com>
 <wvui43l6pcfexoglhyy4xfdjs4mrjzmbcwupnb4djlgvrebn7s@l22gudock5d6>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 6. Apr 2024, at 20:48, Kent Overstreet <kent.overstreet@linux.dev> =
wrote:
>=20
> On Sat, Apr 06, 2024 at 04:19:20PM +0200, Thorsten Blum wrote:
>> The struct field swap can collide with the swap() macro defined in
>> linux/minmax.h. Rename the struct field to prevent such collisions.
>=20
> Same as in lib/sort.c, so what's the actual reason?

I included <linux/minmax.h> in arch/m68k/include/asm/bitops.h (to use =
the min()
macro), but received the following error:

fs/bcachefs/eytzinger.c: In function =E2=80=98do_swap=E2=80=99:
fs/bcachefs/eytzinger.c:128:69: error: macro "swap" passed 3 arguments, =
but takes just 2
  128 |                 ((const struct wrapper *)priv)->swap(a, b, =
(int)size);
      |                                                                  =
   ^
In file included from ./arch/m68k/include/asm/bitops.h:16,
                 from ./include/linux/bitops.h:68,
                 from fs/bcachefs/eytzinger.h:5,
                 from fs/bcachefs/eytzinger.c:3:
/include/linux/minmax.h:270: note: macro "swap" defined here
  270 | #define swap(a, b) \
      |
fs/bcachefs/eytzinger.c:128:47: warning: statement with no effect =
[-Wunused-value]
  128 |                 ((const struct wrapper *)priv)->swap(a, b, =
(int)size);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
make[4]: *** [scripts/Makefile.build:244: fs/bcachefs/eytzinger.o] Error =
1
make[3]: *** [scripts/Makefile.build:485: fs/bcachefs] Error 2

I thought about using #undef swap, but renaming it seemed to be the =
least
disruptive change. Maybe there's a better solution?

Thanks,
Thorsten=

