Return-Path: <linux-kernel+bounces-100792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449A879D54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A661C21991
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55B14372E;
	Tue, 12 Mar 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cljudx1v"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E798142913
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277906; cv=none; b=HlZPIsylyK45NhQW4atNkchb6uBAH79X4LAd/8Z+DDMPdoXz1nYhInU6Ohhruu8f7+u8dYLYd/AuPSTbErJ23RWTnFmPPGVBYFbwljnqAG87SEz1D6CCzte/FhLUzRYMx9JZaPpTAUT0wn7yy23nn5D+RKUSnKlXPwVHuwAlN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277906; c=relaxed/simple;
	bh=T3kzBY9GfAnM+q51fC0moJWtnEIIEoGiMeFr1W4OVzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9SY1+KiIvr4W8jDU+1V0TRatKIpAIz8wGoHrl7OdB0VDh9yUmcow2IuHEN5uFa8tQv4HBDdXNtNuvYVhMvQrGfOjoXcZlgewUhVaZACJ/IeyKw3RGVC3a5SgVrlF0Gdfmh3sRgsdaDXE1kDIs2JfoVSgIYBlMBOubMYZxMBi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cljudx1v; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-568241f40e9so6368262a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710277902; x=1710882702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBYUhCU7Eheux/pd0BVM48w4mv0asJqGomAvUXs2qr4=;
        b=Cljudx1vYJXDdMdiE3dye/gbHq8S4nyYIVFbs98B9Em7f/veNGS3Mx6HB5XC5+D2tC
         UE3wqGQBz8OR6KZ0fV5AFzkgl7a9NyogrPfZb5auuJ7Y5NgdE/ni/vJotZ72w0e7c52w
         5g9KTmq00zB+0BeKEvKQ9ChCS7rF9Szsj7vSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710277902; x=1710882702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBYUhCU7Eheux/pd0BVM48w4mv0asJqGomAvUXs2qr4=;
        b=jxmunzef8xvwTDE25vrT78yEqHj+7N/vePSXkKzYUQ7Cvcfrdy2PvDkj4eymJUdiiH
         Y07dJjg6v82rQi08j35CWv0lxhj9afMBQpanmYlB9meS9xUCGW/I1Vu3B36bT9FC0+YP
         dBTIs8+w4Po5Vk2fa6jxTVDRRMUxjSp0qkHRmXg0nSXZ/f1QkaovIS9cVYkrMajVy0yf
         wv/ABtCYH5SEow5Z3ICqw576OuPJY9yJ0mtNPU2Rq5md1gYHD0DKlHl4ul4m2pMZjm91
         tB1vhzlKoYUZno/tm5tP4vwyVskx7XgV/yK7PPyZafeFMWZeEswUkFGG46YjNHo8YdHY
         w3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVOr5lFoSL/8iFOJYgc5aZjJWO6SF6sal70v2Mk+HDzu5ru4yQbsyyhgST93TfpgKyUki65JsnLd4IKHRAhwV94yeFBkktnWiGVlp02
X-Gm-Message-State: AOJu0Yw3sOiVgfaT0K5ESwS92jd49zRYamIP6tTMlTebv3JDtnkP8neu
	8/ivG2mKbm3rGFOnNNfKlWV7sA6J3UyM10PmvVjUqzK1jIbc6z6E8jihRHKXp9aMAggo+0MKmbS
	QlK3Z7w==
X-Google-Smtp-Source: AGHT+IE1FLc8panA0w9SWA75ljM3UCX6zMlnr4BXzrQmSxH3BhAFReRubjw15jWbX2myu7CwapNw9w==
X-Received: by 2002:a17:907:c30c:b0:a46:2649:16f9 with SMTP id tl12-20020a170907c30c00b00a46264916f9mr6074358ejc.2.1710277902461;
        Tue, 12 Mar 2024 14:11:42 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id w6-20020a1709062f8600b00a46376965basm1563076eji.60.2024.03.12.14.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:11:41 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso465229366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:11:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsJdB5mIigMYlP2qe03+KZQ4Z/+nG2OMm3B5MLX1uo4AVHa1lvwcRJ/qgcTIHm0c/DyhWOSB8sWrvHjF0o41wuZ6lJ1ThHh/bdtCzy
X-Received: by 2002:a17:906:e0f:b0:a45:da1:9364 with SMTP id
 l15-20020a1709060e0f00b00a450da19364mr6434203eji.19.1710277901356; Tue, 12
 Mar 2024 14:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org> <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org> <20240312134739.248e6bd3@kernel.org>
In-Reply-To: <20240312134739.248e6bd3@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 14:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
Message-ID: <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 13:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> With your tree as of 65d287c7eb1d it gets to prompt but dies soon after
> when prod services kick in (dunno what rpm Kdump does but says iocost
> so adding Tejun):

Both of your traces are timers that seem to either lock up in ioc_now():

   https://lore.kernel.org/all/20240312133427.1a744844@kernel.org/

and now it looks like ioc_timer_fn():

  https://lore.kernel.org/all/20240312134739.248e6bd3@kernel.org/

But in neither case does it actually look like it's a lockup on a *lock*.

IOW, the NMI isn't happening on some spin_lock sequence or anything like that.

Yes, ioc_now() could have been looping on the seq read-lock if the
sequence number was odd. But the writers do seem to be done with
interrupts disabled, plus then you wouldn't have this lockup in
ioc_timer_fn, so it's probably not that.

And yes, ioc_timer_fn() does take locks, but again, that doesn't seem
to be where it is hanging.

So it smells like it's an endless loop in ioc_timer_fn() to me, or
perhaps retriggering the timer itself infinitely.

Which would then explain both of those traces (that endless loop would
call ioc_now() as part of it).

The blk-iocost.c code itself hasn't changed, but the timer code has
gone through big changes.

That said, there's a more blk-related change: da4c8c3d0975 ("block:
cache current nsec time in struct blk_plug").

*And* your second dump is from that

        period_vtime = now.vnow - ioc->period_at_vtime;
        if (WARN_ON_ONCE(!period_vtime)) {

so it smells like the blk-iocost code is just completely confused by
the time caching. Jens?

Jakub, it might be worth seeing if just reverting that commit
da4c8c3d0975 makes the problem go away. Otherwise a bisect might be
needed...

          Linus

