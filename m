Return-Path: <linux-kernel+bounces-86324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77686C3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACCE1F23BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5544391;
	Thu, 29 Feb 2024 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW9qslLd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873024A19
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196192; cv=none; b=gNGwzfI5TKDAT9vj+wlwfHasFts39itRh9zzNDHwfDYlBc2L8v75NTxEIOpn/K6HwdLTrMF3KwnyQ/cy8H5MtsZGDhNiy8AHJWU/fb4uALNKp9+D1gDI9UorU5ugrM8W3lCteysPcdYk67OnBLwO18JtVjazYzrWN9o/4uXJd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196192; c=relaxed/simple;
	bh=hikBQBwK+HCibV9Ay+uw3hwq6fhlJ+kbZbSIdNLQbuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmemDDRaEepIVe/ABohlIkoTCL01tABuGEoCcdpXOBeGatOYdMEwj43FgKigQF4JcJTwVZgtjUMtukhWvKWSjeaAEO9ST49HPHogUX+VXdtOtBJOYnxisouLr/xAs8lW9kiwELxuL0o0t3pup9guf14LLVH6Rzndzt2a63wdsX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MW9qslLd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEuBlHD3kgoIX0ziveljn5872wJi8XDsY60eCgSwad4=;
	b=MW9qslLdZwCW3fRiPfuIk56YiiyYuIdZhYkCK9JiFrrlCDca3VDd9haUpsWxEMHh6R5Qx7
	IDxnwBPFM8sD8woZOPSGAXN76WDgg205MjAKkilhJK+GryPELnhSjE/NyZ0J/RpZwzd8vV
	k+cDPsG5EUQeJ7CQ1qG9hTwVtxEgmF4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-FcqhayKvMoyMHcmJFL_Rzg-1; Thu, 29 Feb 2024 03:43:06 -0500
X-MC-Unique: FcqhayKvMoyMHcmJFL_Rzg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dc685df4adso5312335ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196186; x=1709800986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEuBlHD3kgoIX0ziveljn5872wJi8XDsY60eCgSwad4=;
        b=J/2ch0wz/tFKvGlVOF1Urh5l3o5X7/xWD82r3JyroTAlOE9fdlu1qVH/yfO23rAvNg
         oTXXhTZh06q47QvPGh93E+xURgebuhu+9gFN4P7Fd4hImd1uhC3pq06jAwSG/f+JO+cb
         x1eBs+2mOXJ3pxI6Ex/gIX48i4k7rvHFr6V5q2wfuk+iInCfhs0Z7eL6MRLOyNwWWJlw
         7P5j37TSdEEz24N1Y2tKBRxvyeID6AHZjR3yHrLl2Ba64x2C4AfsVmaYYshruGyiG5d6
         zpAOwXk6Lpt665bwsDzcvFLoa+0Jl9MM+XKd1ZefiyJi+uZrFWkYPGMvR0z4cpbGzppO
         DbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUciS2BkKsHjdjpWj8ehcl/KETxwib79hWz21bhjXTBNvjp2KGH/ONsEL+3I82m+aieL4jnQFRJzlDERzLZ4SsAV2Ti4vrcyFWhzflJ
X-Gm-Message-State: AOJu0Ywe6uEVFYfvp9cvn+R02Z/VBs3a1tcrFwcbad81PIRhrRF/3XQm
	uyXrwJGRa3DGqlEvEfzfjgsswyWw8izOaMk76ddxovf2g27qNxp4cwSF+5a5soAEDgix1tTj4By
	KknXvMKmW5A7Fdp5xhCk+nOcUCmOrYqAbhx/UvRRxwPY8ZJi/NDPu2lHyOz9NDykb1kyeFJkd6N
	MnOiz8MAKp1RjeXYPLASY+1hTY0rzVZKSSGD5/
X-Received: by 2002:a17:902:da8f:b0:1dc:ca09:6b7d with SMTP id j15-20020a170902da8f00b001dcca096b7dmr1826112plx.2.1709196185777;
        Thu, 29 Feb 2024 00:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRJixUvjUtpkuPEzMa01pFKLhC0GOFKYvulFM09afef/K1eyl+EDf7oLoFQwQVwElle44GHMlouy/Ss7TyUcc=
X-Received: by 2002:a17:902:da8f:b0:1dc:ca09:6b7d with SMTP id
 j15-20020a170902da8f00b001dcca096b7dmr1826093plx.2.1709196185336; Thu, 29 Feb
 2024 00:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000029b00c05ef9c1802@google.com> <000000000000cf2d2d06127def32@google.com>
In-Reply-To: <000000000000cf2d2d06127def32@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Feb 2024 09:42:53 +0100
Message-ID: <CAHc6FU7GqeMROfnoFLbTaNnoDhwr1+eFAsP_=rQD_JkfF__AqQ@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING in gfs2_check_blk_type
To: syzbot <syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:46=E2=80=AFAM syzbot
<syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D108aa9ba18=
0000
> start commit:   861deac3b092 Linux 6.7-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D10c7857ed774d=
c3e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D092b28923eb79e0=
f3c41
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1440171ae80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11b1205ee8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices

Sounds reasonable:

#syz fix: fs: Block writes to mounted block devices

Andreas


