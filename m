Return-Path: <linux-kernel+bounces-128731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCCB895EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFEC1C23FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC315E5DC;
	Tue,  2 Apr 2024 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQUcnQkJ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6115AAA7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093658; cv=none; b=mgki0rTAVR9nmezETK79je2VaRgxeaJ8nGcBcBCZtpPg9Ta9QB2cczbOcVQrUozrzYMZr+8p2CB+7EyHrPQhR5zoxHv+ML3CKyR3hVyyRvQv1YhKADP21kB1QoNa3I0EXH6CGPWxAPhzpj9DeqABWXLZbkccPdXUL6/fxOkXSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093658; c=relaxed/simple;
	bh=gcw5VSt51SDYCQ0YKpOFrOLuCouvF14ktT27e0twceY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hXAgSz+My61tUuHPifJXVzXEGFCxGfpnZrNlFAQ4l5Bi/PESI+ZEzvv3MJGcz7BKB15mPicAhRb30Qz0M7ht7xR8nqiNjA7uUNgq+dGn7PpUqw9tUUB7PE6YeFHfiiB0clBoFO3P1ttr9j8tDTbfBAL9F5mqVlsXvH8fh1YC70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQUcnQkJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso8772687276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712093656; x=1712698456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcw5VSt51SDYCQ0YKpOFrOLuCouvF14ktT27e0twceY=;
        b=gQUcnQkJTMqZbHLWEwxjT2US6MGrTgnB8zr85uK38D0fPNmkkcteJ0zrw+qk/yPQsZ
         cGHn4rHjVE3DHgR0KZU0QF19qn6PYLBMVskTlZVOR5h8thf70tmRTctEwzUgMVYGpvvj
         enBjs/0uXRp2wpxWANfv4+bYMmy8Rd96ruYPQT1II+0SV4/Jx4k5zXCAujRr3LGkTrxd
         EfezhzIz7i5iPxcE8je7BUACHS3YXVZAyiy2E2Inb3SEWVaxgeLM4GUwFt4mIBqyC+p3
         63lUuN0RLr3ukAad6ibAYna9LaVJNWw3BjK8FNhDA2/61MNz0g6aEYfq66BZMaDKpHsp
         XTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093656; x=1712698456;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gcw5VSt51SDYCQ0YKpOFrOLuCouvF14ktT27e0twceY=;
        b=KUq78a7laxjvEvMAGgF7MCAa9SyhZvyfYdq5deltDYSpSB5eVlT9jRS2zVDEZxVDXv
         48rTzz7PNlqJDOxKF9+bkr18Ve5pVfFHaPNFcSntdBYJLtikQMvcNooG990+7PSt13f3
         KIsrypwZwURSnsHyxCq5S52TIZ3uLaSPnD4bwQ3n1gKGz+eSSDFsFpxnwFnjRT8OxzZ/
         czmEjYGmwyVEl60QojTx/0osmor/PYFbezcprJfy/KwBRCa1g1ZgaGg+7TbeeIc7laBL
         QBvJJxmETsPB/beh4YlI8oHzoRJm3IVGMOoii+Qu1Che8gdCA3tRz0At0Xr0kpUHXGzK
         FPIw==
X-Forwarded-Encrypted: i=1; AJvYcCV4gewcWWcgcBbEpbjG8X2QrDh3Gx3rkURZs76zAF7gUaCi5sDBc+qHC16MFWTB0Gwe29hTgYcHL6qYtIEtifkGjuye+edq6aQ3sn27
X-Gm-Message-State: AOJu0YwuNGQWz98u5W78CMi+MKsMmQAXfkER0vMh3AEdaurTCiZrjB5q
	sS4/eZrNz5N8DRYHbQjfzKTF/GXRLXxgRS/KVoMMBnFsu5R7KzSXLOtpdmdZdaD2yZkizN7L/Mj
	rFg==
X-Google-Smtp-Source: AGHT+IGPeWmjD4Xgh7kKBTPHE4qDiuffhLY+SxbwR3zx2Grc/+hNw2Ueg7Ap+gvXt9dIvnMxJEBht5qnaW0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:260b:b0:ddd:6bde:6c82 with SMTP id
 dw11-20020a056902260b00b00ddd6bde6c82mr4312438ybb.12.1712093656148; Tue, 02
 Apr 2024 14:34:16 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:34:14 -0700
In-Reply-To: <848d6bb6e4b0c53b6870bdc1cdf0c22e766313ec.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240313003211.1900117-1-seanjc@google.com> <848d6bb6e4b0c53b6870bdc1cdf0c22e766313ec.camel@intel.com>
Message-ID: <Zgx5xUg9VJmurrFB@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2024.03.13 - No topic
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024, Rick P Edgecombe wrote:
> On Tue, 2024-03-12 at 17:32 -0700, Sean Christopherson wrote:
> > No topic for tomorrow, but I'll be online.
> >=20
> > Note, the US just did its Daylight Savings thing, so the local time mig=
ht be
> > different for you this week.
> >=20
> > Note #2, PUCK is canceled for the next two weeks as I'll be offline.
> >=20
> > Future Schedule:
> > March=C2=A0=C2=A0=C2=A0 20th - CANCELED
> > March=C2=A0=C2=A0=C2=A0 27th - CANCELED
>=20
> If there is going to be an April 3rd PUCK, we would like to have a discus=
sion
> on TDX base series upstreaming strategy.

There will be a PUCK, I'll add TDX upstreaming to the agenda.

