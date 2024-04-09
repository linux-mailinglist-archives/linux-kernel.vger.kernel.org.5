Return-Path: <linux-kernel+bounces-137068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C489DBE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8F928317B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D212FF67;
	Tue,  9 Apr 2024 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmuoP5Nn"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308212E1C9;
	Tue,  9 Apr 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672047; cv=none; b=l+VvgmEfLItlNHqiwu3OJsOH7WJRYg4HdlLiBudUsXbe7TVZ3/ApDCGgacEWYvNPin9T7PMkRy0Bj68n3tr5Rz/SS1vA1yWh6gXn2ajtcJ+aF96M7kcGbTaSYwVMmCE/ACF+1gRRGkvOtxvT2dADSUZxrHq8Ef5wM1p21I1rcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672047; c=relaxed/simple;
	bh=iI6TUwJ+4xZZn35YTNr/rWQaQ7yJfKuSXYeSODViy0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO+yyck2OjFc1pPw4TwUvndB7MITWWdsUIZFT2+SNc9/ujTkhaJa9bcnPSOSoDkG148/irv/23cGs6CLq0pNJhyCkaP3gMsAOm+GsIX88HottgrOawGNj0hQCN4SSvMMQfSxfR3NkIpTsJAheDxN6p1ADtd7b0AEGVN+T4wm/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmuoP5Nn; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d485886545so99544411fa.2;
        Tue, 09 Apr 2024 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712672044; x=1713276844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzfyOHOSc6LNVDwhY/kA+Wui8S7EUeFyPAPKPUuG2fA=;
        b=BmuoP5Nn0nO001H5U38iBzU7cGHES+XxLH7VXTiLfnN1hSio+tyGpR3x62UCocyUGP
         k0w3IL6ItigjrAu86I9Tp/OunRKxpL4OvfuYU2FsKMv+pP+6k3Xjxsk7vG7YxobFBXfy
         EqPOGPDeB+C/S8vh8LfVVkqGDSYxkDIHbk/R44X3R6WCGCL4kNJyJU/9SKIs1ftxJUFb
         G9WRlnnGRQjoW5bCpbcrXM4hdHI5KRTJjCivq4gYs9Km00rkdTY/LFG2nRdXtBhzeA7S
         478DSNQ+Kcbgvh3gtm9MDc7OQqgKcjQH4229hblfti0n8GglCvFqi66bgWlHppdW4zTh
         DrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672044; x=1713276844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzfyOHOSc6LNVDwhY/kA+Wui8S7EUeFyPAPKPUuG2fA=;
        b=h9fEfK+fB3F3m4jyjYCMF/XmsiC2Krhi09IqfHw0QOOwtJbG4lFMxD4MLSF2Xg33IO
         6X0ZG3MSKSTuxN0RbiYWN/8dXm5P5+Zs05QX7p2n9yYSCNWKTlFFnr760+0QpT5ANnEY
         YpiUyaQ3Za2StJCVbEIjQ2z3y+HuFJlvBVlkuvRSeaJrZJIMjivvekXenLhbCtzHcXJa
         n3PRLz6mEaRbqtH2dXV8tjWK+vWy6hGUJQkqXeLrTTcVVrSd7daIIHsVqqJLRFzGmQWj
         UUFWBM5tF2CX4fb24qZaMb+kHv9j/LnGrMWRJ7tTeBf/ceCmd+SxFSEfmjNANUvqNtSR
         c5vA==
X-Forwarded-Encrypted: i=1; AJvYcCWmS8tFNGgK00v4CF44IHO0kPf1okxlM/QlHVAgGXSKBVW4duR4FslV0ij+P0FfBtuV8LCSkFqJUMhCf5ErYIh595ofhZPwoT2rSg5ud+7Mu2SMSZZzcSZi6QsFogaG0gpVw/aLHByaa0CB0kZaTnLBMLBJNbEHc20MCpH81GocSFZvNIwd
X-Gm-Message-State: AOJu0YxP+zJJmdInmh8lHxV3q0DEjLwcmal5WRx/ou/NxsIvLxR7WAmP
	UiyY+Gj7rq0tqc3+vzheQaaWhjzkr9CIxVqEWkHsbihUvBH2kh4wzIw36pszumegT0TcyaofNkH
	HDGGWyTcZrxI1jlUA8aamw2DhAFpqb8djsRA=
X-Google-Smtp-Source: AGHT+IGxWzHXNwA6fYq9XaMmgdIaj875VnQfp9L46tSmf2TReZ4lcOT4hRE+GOuiiRAFHCtJageC5nORvdk0S4x3lwM=
X-Received: by 2002:a05:651c:331:b0:2d8:5fe6:820d with SMTP id
 b17-20020a05651c033100b002d85fe6820dmr9978784ljp.11.1712672044171; Tue, 09
 Apr 2024 07:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b0848f061553f0d5@google.com> <tencent_D423A78448F764177A26CAB3716365096705@qq.com>
In-Reply-To: <tencent_D423A78448F764177A26CAB3716365096705@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Apr 2024 10:13:52 -0400
Message-ID: <CABBYNZJ-XJv8nLC9WMcMskYtAkzir5JC+wFNZwk+5k-85g2gRg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix oob in sco_sock_setsockopt
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Edward,

On Tue, Apr 9, 2024 at 9:49=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> If optlen < sizeof(u32) it will trigger oob, so take the min of them.
>
> Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/sco.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 43daf965a01e..815646d9e72b 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -890,7 +890,7 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>                 break;
>
>         case BT_PKT_STATUS:
> -               if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
> +               if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(u32=
), optlen))) {
>                         err =3D -EFAULT;
>                         break;
>                 }
> --
> 2.43.0

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D289bfd91fcf22f7864f3817acff5d8ce9fe73307


--=20
Luiz Augusto von Dentz

