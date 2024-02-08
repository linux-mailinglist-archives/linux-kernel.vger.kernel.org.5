Return-Path: <linux-kernel+bounces-58469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85A84E6E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91941F288CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245A823C2;
	Thu,  8 Feb 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZGcUihk7"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B981AC7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413971; cv=none; b=OtQ7BqJ2wJ9okazzniuuJ6JtPhCYCQe8RW28VF5Mfv45HexYMYVLNn7PA9AJcWgjarT0NkGF6DxY4skK54kAqa6yMHumYPKr9KNUn8WBhmPmE7yajXuZiKWLZyDrFyDsj68Dx0ysmkbPQsvL/K0PGOVNrBRSLt93gVxYvp1lEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413971; c=relaxed/simple;
	bh=lK/tbkSqE/sBgOS9MM7ieTUNviQqD9X/ACfXaaSlZ10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSNKDKFldaRheVe7PE0dXG3TYZ95Ikw+o1CSnurLVAR2oisgSDByzNWun2f7x7gVXgUDZZwzz+Py2fcALeH9HLzXDFoVc8Z6mGOQ1Grc8vJlnKDemsN8+al5yx2/3Mfa+a3Y1KpTQRXGRlv1jn6holchaDlw0+DDLOizMxPIY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZGcUihk7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116b540163so55093e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707413967; x=1708018767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/ASSALdlXfADx7dHfiQ8PKR/4AOTnL/3DT95dp/y7E=;
        b=ZGcUihk7zkiAcehGn439JtuTWDKMTNry//p54CtJGN5Qpgbe/uQprQXiBEwmzp+FUf
         1Lb/T8npSGtIEb7QniRuZjJILspkiVzJU5wKMOh2OpbUwlb8FM/jtOCiAt0qHMxD8WhG
         apNxd7awxt/xzsWoyr6Orgoql8yvGvT2VS7Qx4mvTc3zMiOYzniEI/Y08mharqLs/ZcX
         TsCSE56pEGwImDRT4eCtJOB5VgAyTLoTGy/iE5mq1mTpBmVv2RGh7PM63MxoFYaDwgxL
         yde4tDfcUspkjw1jOFZC2gQGWgjPqMoX28twmgEUqqixmAif1csAAUfV8i0beEeo3U7c
         2BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413967; x=1708018767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/ASSALdlXfADx7dHfiQ8PKR/4AOTnL/3DT95dp/y7E=;
        b=KHNd3sbVA/pYzzshwHfnANOdV7VQ2gOX010H/69uQoAkIyxLVDtMmnVNfHtRLxvG3t
         Qy433A3cqG6ZYx5fQvbhfjkVW9pOxJv44u/HzgEhM52vgAD1/gjnguXF15G4gwXHEhnK
         Cm6bu7zl0xVs96PT7ZQKUYdBI5P27z2MS/kcEY0o6RbLdmgYFnysTJX0PGgM0BbIBGxK
         IL14xiq80qf8s5qt1abiyhjWWJX8N01lvtiI8aGP3vvt+M1rryGXIQMSPMsj/RFULhKX
         BzKmLAgg+BmESD92AbIx7Tp4p0k82FpIT/xvsYLDxBUSj0ZgTh98X2JGA2vDUlldm+HR
         xwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkeui0BbagKpvHkvHvM3pq4f4Cr7eeEaTDNclaJLSLmVL/EjvyxXoKoVIcqEjDYcGIwb151A85WnIxNIyHp8TQVCIP4rzmj8Sp6Kbr
X-Gm-Message-State: AOJu0YxniZBcOfKZH0deW2BUnaJpJASrQTCYeJZZjZZJpieXanICZ61D
	0MFcQjRDB4+5TUpa7Wjl+WqJ7fQKOwueBYZo+OGr7OaQ7ack89TNLbpDpXrkRuFDATs9y5hKm2j
	x8ANzp5hI6GIh1mw6oZZAJgXQRJcsCxdVQDeBD08XZBTkTDEbE0s=
X-Google-Smtp-Source: AGHT+IGwCMDqEW0wuhc97j7Rj9nsHdqHllWC3GU8hBQNDySLDQUekn7g8gWsgr+2DfCc7Qm5sZ57sNwwMSu832lOQlY=
X-Received: by 2002:a05:6512:a8d:b0:511:19f4:e24f with SMTP id
 m13-20020a0565120a8d00b0051119f4e24fmr7928695lfu.47.1707413967429; Thu, 08
 Feb 2024 09:39:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204125404.2112384-1-hezhongkun.hzk@bytedance.com>
 <Zb_bhO8Z_d7VUCdJ@casper.infradead.org> <CACSyD1MEM+KnNMimmbdSFXOsok9S=vN=DxzS9x90_6+pt5qjFA@mail.gmail.com>
 <20240208032908.GB185687@cmpxchg.org>
In-Reply-To: <20240208032908.GB185687@cmpxchg.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 9 Feb 2024 01:39:16 +0800
Message-ID: <CACSyD1NDT9Thc51RHWjA7-mPbDtn==iBTiL-mB_N90ky2b_Lag@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/z3fold: remove unneeded spinlock
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:29=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Feb 05, 2024 at 09:08:05AM +0800, Zhongkun He wrote:
> > On Mon, Feb 5, 2024 at 2:46=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Sun, Feb 04, 2024 at 08:54:04PM +0800, Zhongkun He wrote:
> > > > There is no need to use spinlock in this section, so
> > > > remove it.
> > >
> > > I don't know this code at all, but the idiom is (relatively) common.
> > > It waits until anybody _currently_ holding the lock has released it.
> > >
> > > That would, eg, make it safe to free the 'pool' memory.
> > >
> > > > -     spin_lock(&pool->lock);
> > > > -     spin_unlock(&pool->lock);
> > >
> >
> > no,  please see the commit 'e774a7bc7f0adb'.
> >
> >         spin_lock(&pool->lock);
> > -       if (!list_empty(&page->lru))
> > -               list_del_init(&page->lru);
> >         spin_unlock(&pool->lock);
> >
> > The original purpose of this lock was to protect  page->lru,
> > which was removed now, so the spinlock is unnecessary.
>
> But pool->lock protects other stuff too? This doesn't rule out that
> there is some other ordering dependency on cycling the lock before
> freeing the entry. The person who would know best is the maintainer of
> this code, Vitaly. Let's CC him.

Thank you for your reply and look forward to hearing from Vitaly.

