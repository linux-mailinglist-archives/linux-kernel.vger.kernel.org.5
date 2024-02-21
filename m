Return-Path: <linux-kernel+bounces-74271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD985D1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546151C2335C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9C3BB55;
	Wed, 21 Feb 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hTRhnfjB"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E963BB43
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502165; cv=none; b=c8BNbnbTAe7231AEDHR1MsQEjae+6fkR97J31vHyNT/mSl5gmlgh/M306nVq4PVizzD3+RVO/UbwPTK4LrRnfJT5LhRwTjYFmyhDKhji6frvEjyCvcCYg3u2HQAGkIZeFzd1UMc0Tk73pJdqdAecMCzl/YnV1CyJJO+HudivD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502165; c=relaxed/simple;
	bh=YzYwl8YMGXua6CQa68UF9a5u/8CEn2EQrELUkuKJmDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eakYbGUCHoEWp6C2FbJUjl0Nit8E3JePXT3/4OYF1H93uCPek/OsWGpQKF+DXCO6wDFaYrZluWHMuehCNfqbVAdV/d9jr3SurS/NDODEeSeqpwb6sRbMBHh6UzBzqyIphZ93hH06yiYqZQEUDggjf8hca+aGLiQSq5pxMuLjnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTRhnfjB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so807a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708502162; x=1709106962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzYwl8YMGXua6CQa68UF9a5u/8CEn2EQrELUkuKJmDc=;
        b=hTRhnfjB52h3gEsDcN91+SRKHPF9y3mX1SbAEcuC1dGpkQD/AXPuqFZ2BQzN1/iEN6
         LFnVBVnKpLNakQZrcH+L3ddoHDuGzDGW/IJw1M+FYEEi3al4FOEWsYHajVxZMy/6kHeV
         XQ5VB3mjR8eKSkkGGH4gPnrw3k8YXrWEenJAucK+PurHg/pZZT7WT27X2Utd5usm/92Z
         1er13htjmjIf4f6bbqb2fqnl6i/hP1EmJbj/Qeili43m4+H/H0G52wqFIFmo0H8qgHzf
         mOjqgo/s1QnRbfK+pApA7AIAUN+ibS1sYaavR38GPPD6KeInzkzN0hSPw1D7cZxn3eL2
         pF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708502162; x=1709106962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzYwl8YMGXua6CQa68UF9a5u/8CEn2EQrELUkuKJmDc=;
        b=U6AcUAZtI2OGJzt/dOD4hWn+/5cBGM0NHrPe+mI9ojHXywt6rOUUjnJNW8D3L9MuZT
         vG8Q2pquSS6muEa+nNAY1egtYyKRozkB//GsROpV2277vA6HPvuxgDDGR0QiWySAS1zX
         qUtj+Uezl0Z4rwbGk42BPUvNkK7s5FOUr59M7GVJQOhJnpQKW/u/gy+QnrU7mvP+LBeL
         Hw/RSDutSXTeiIjW832l28EYmaM1ZQjJWdHemmPdFYF7v488sS7ZSwwEmFWEIlf2o/QW
         pFjBuSuRk0ttMFq17hsB2Pg8EiiqIT4SVSoHJv0axeJOb7zUcvqXD/n3haALQiGOBf/5
         F7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWWy/2fWI7giEpOicA4lgYfy0Xbm9FRR1VoJsNHMZYZxNxPQNEOITE1kxxHrUoj9re6IzrAwXo3eLfjomBSEPlaeJZx0vWUmrqur1pi
X-Gm-Message-State: AOJu0Yz/4opqHF7eWI19l/SglZX6okZX7l1pWTNB3AURdITQ5zBO428Q
	WzIREPq2WvGJELkB4vP/FE5j4JL6G4dApbK/VVj3gIp/uOrbIXfvj3ZsyIXqCld6p38How4qef+
	GHxCkZo+2ozEjM1H699RssG/UbvVLPwglYBwe
X-Google-Smtp-Source: AGHT+IEZyK1I0Los2sCbs/M/7PLIrS5TIHZ/Hh2HuGzFydwv3VjJ5hM9ffQop/gnv7WwXjQ4ZoWbFXnKzj0WIMAjUSA=
X-Received: by 2002:a50:cdcc:0:b0:560:1a1:eb8d with SMTP id
 h12-20020a50cdcc000000b0056001a1eb8dmr65434edj.7.1708502162160; Tue, 20 Feb
 2024 23:56:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221074053.1794118-1-ryasuoka@redhat.com>
In-Reply-To: <20240221074053.1794118-1-ryasuoka@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 08:55:48 +0100
Message-ID: <CANn89iK0j6j+dvp0EnEzPi32-6nLaR2qJ1sHjPg9865TigzENA@mail.gmail.com>
Subject: Re: [PATCH net] netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	anjali.k.kulkarni@oracle.com, lirongqing@baidu.com, dhowells@redhat.com, 
	pctammela@mojatatu.com, kuniyu@amazon.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:42=E2=80=AFAM Ryosuke Yasuoka <ryasuoka@redhat.co=
m> wrote:
>
> syzbot reported the following uninit-value access issue [1]:
>
> netlink_to_full_skb() creates a new `skb` and puts the `skb->data`
> passed as a 1st arg of netlink_to_full_skb() onto new `skb`. The data
> size is specified as `len` and passed to skb_put_data(). This `len`
> is based on `skb->end` that is not data offset but buffer offset. The
> `skb->end` contains data and tailroom. Since the tailroom is not
> initialized when the new `skb` created, KMSAN detects uninitialized
> memory area when copying the data.
>
> This patch resolved this issue by correct the len from `skb->end` to
> `skb->len`, which is the actual data offset.
>
>
> Bytes 3852-3903 of 3904 are uninitialized
> Memory access of size 3904 starts at ffff88812ea1e000
> Data copied to user address 0000000020003280
>
> CPU: 1 PID: 5043 Comm: syz-executor297 Not tainted 6.7.0-rc5-syzkaller-00=
047-g5bd7ef53ffe5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/10/2023
>
> Fixes: 1853c9496460 ("netlink, mmap: transform mmap skb into full skb on =
taps")
> Reported-and-tested-by: syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail=
com
> Closes: https://syzkaller.appspot.com/bug?extid=3D34ad5fab48f7bf510349 [1=
]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

These vmalloc() skbs have caused so many issues, thanks for this fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

