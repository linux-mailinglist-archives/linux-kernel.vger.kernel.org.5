Return-Path: <linux-kernel+bounces-137773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D889E6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A9B1F24B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33B621;
	Wed, 10 Apr 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PngiYocr"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E530387
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709217; cv=none; b=BgXXMQVVQ9XIwVL6xiJzMq8KGndz7+ToGXGGoyBq7uRsF0TqsrbczHk4eWc8GN+pKnnVDTc8xjVwC/drtLH4hhIYP8ha4e8hRMv8xFsGvND5ULEYsq/5IFeyiEKV01NqM+luVmr1bxCX5T67/Ss+Oan0uKzR++ToZ9Ty5JrD550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709217; c=relaxed/simple;
	bh=0n2PhpDbpHhkl4Tsxkqnkn1+lJ7eLXgO6RMQRArIl9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRrEWmXOyDRKkT9dtP97eAKxrzVhuFhJBNMtu3Lg9mtYThUZgbt8y7fgvojgjIvkZ+SgP7ciaKfW+MkZEoQmxizjASI6CPj6ICG3hdkZPkf51l/98b3fWKukcgICaSdDl3bf0/a/LG4CKH/FkB+nzkx4rFZrvCZJLfjOJgg0ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PngiYocr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso18725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712709214; x=1713314014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wEMmLHqOpGDwOlJzhH8hYIl54XmGd01Duj/DhYEOqA=;
        b=PngiYocrG2ZS39bBzH9osobEu7su3tm3Lu04vgJje4Lj44Oxlv6yCNGY10fWqfMRLU
         iKa4Hj40mM2X02EQkDzZKueKvNfEIKr6PA+yUKBu+O1GMQ1mS49MBJPY1wh5wlEH9E47
         Bo8Y72MF5BYnRSQziq75b0+8rhV+7+zkeipkqVN3U72m0YKTrZFf0og/fIYAegoK7cXf
         czHGdaf+Roh+OG1oOYMm+9tcuaHdk+sL59BNxNaJR1RIa59AP5MNVn0Q3fc+IsDGJmg2
         PvC+9whgWc6eSbO6kDIWZYphO49X2NMPmubGyQHF4+6PJ90K4efk076PgRrxiQmGYf4U
         caCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709214; x=1713314014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wEMmLHqOpGDwOlJzhH8hYIl54XmGd01Duj/DhYEOqA=;
        b=mxapipD3o7mhAqIcqgl6+a+5+62d55d2I388RWl9xG/I0XpO7vPz7hW9fdLUQu7LQT
         xZxjaknuNR/qOe49RFxjpR9Xbar8RTdRBmJl3Vyl2U7LwYFTrIBGUtzjxODX+NffJpBh
         xdajDXPqe8EED/cIiSQCct9sNMlZiHdI7N5ZCN/YiTAVtQs+5H2I0mIM3S/bDBM/TtzF
         j5L/vzyHIg1IYHdeGRF/jO2CWhCPujotrIW8UF/cIVvZL1YRrPmEvzmE9qmJk8S2vffw
         7+ZXPO9bdg5e/EZu1gnn7k43a3zKRx/ip38pwinbgM9bf9FGGp6t5llPYKmF0zSCQP6M
         7SHA==
X-Forwarded-Encrypted: i=1; AJvYcCWp9oyb8rPkGWrIpO3E4Ob/mNV/ux70TMiuu6JY4AlhWA4navAljBFRiG04JnCBfU9fdGPiAYcZWFZO24bmPrLPv1sAmgMVen9il+Yb
X-Gm-Message-State: AOJu0YzQFfkDvNoKx5GGiyWpQJKOePB/YEH8xHj+5ibtEmUt9lTK8t/+
	1DTEnup+By+i0+lVa4i8IshJtUFYQPh3khlSYcBf/+rK5336B0JoHWxMOnht7AzToI9hFgNMpP+
	D00IRvwfMmEOEHaWnOxmbH82+EDNUlrCg7CLy
X-Google-Smtp-Source: AGHT+IHJRUrU4ixa9UyoYrtG8Ohe2yj9EFPZVOjGqVwWKdGcIRmnsKK05rsFXPS2VSEHNkJY+LyTU8bPcxUHcJ5+1vY=
X-Received: by 2002:a05:600c:348d:b0:416:235f:c41b with SMTP id
 a13-20020a05600c348d00b00416235fc41bmr83380wmq.2.1712709213721; Tue, 09 Apr
 2024 17:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009db84e0615a73698@google.com> <20240409164627.b4803e09c81c01ccb6f55601@linux-foundation.org>
In-Reply-To: <20240409164627.b4803e09c81c01ccb6f55601@linux-foundation.org>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Tue, 9 Apr 2024 17:32:55 -0700
Message-ID: <CAAa6QmQ-fSNHu0VWQod+Cz89zOtQ9Ayet_2OEQsrp2zeCfos3A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in hpage_collapse_scan_file
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+57adb2a4b9d206521bc2@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:46=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Tue, 09 Apr 2024 03:16:20 -0700 syzbot <syzbot+57adb2a4b9d206521bc2@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    8568bb2ccc27 Add linux-next specific files for 20240405
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D152f4805180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48ca5acf8d2=
eb3bc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D57adb2a4b9d20=
6521bc2
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1268258d1=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1256598d180=
000
>
> Help.  From a quick look this seems to be claiming that collapse_file()
> got to
>
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>
> with folio=3D=3DNULL, but the code look solid regarding this.
>
> Given that we have a reproducer, can we expect the bot to perform a
> bisection for us?
>

I often don't see a successful automatic bisect, even with
reproducers. Hit or miss. I will take a closer look tomorrow -- the
reproducer doesn't look to be doing anything crazy.

Thanks,
Zach

