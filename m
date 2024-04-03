Return-Path: <linux-kernel+bounces-130014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB92989733B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA21F21A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A11149E1B;
	Wed,  3 Apr 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NTgGLUkm"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B730149C77
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156341; cv=none; b=Jn/EvxXvcV28gGsads32GNWwgBc7UR123OuY7T2Z8qDIwOFbSWxoYxd9RXi+hvgeCun3qg65cd7UChzNJuoxfhu0sDJ8EjbpMQ/xF6R5cgqipjt+W8kozkZarBHoBzwqFDO8HWHxeEtcSWdLqvrO8v8GY+hlIVQWOstMh3U9qP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156341; c=relaxed/simple;
	bh=bA08xc5rb3BdVwkyNJ3oXMMCv+codCJF7wxqAsTEmbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSZgbpjNS+wPODYr6giATIPf9y4jajKAd5OZ3DGWB5jwcd8MQzWJqJiWvWYxyhU6eqjCOE1kPkwoe2GNXXXS4VEWyHoSsTM+2RloUollD3fSVmWa5EMC9pqAePiHfcXQY/GcR/aPigzkM+vYNhWhvnLD7Zy8s6PBjrZPq1FqHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NTgGLUkm; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61495e769bdso31607357b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712156338; x=1712761138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6ozn8GWGaymICONfaql8z8aBGhL/vcq5PD2xm3yHTg=;
        b=NTgGLUkmp+mD862RxBHk1Uizuyvzo0bnE4KI+UdiJDaO1+vrbFUwPNSgGT5lOL/wvP
         aV2EW/WE46eGtubOBk10gQJ1m6nm0aCoQ+Btrc3bxvCS7WZr/kqsZ5CB0WcRqmvfLtoY
         8vv0D/2HFC4qr4kvXmD4aQ0qyeVEwSOQ49Kzhul3jd6F6yiz/SkGzSzPGPgkkMivA5M8
         GVYzVGzczxBfUBzjE5b83d5qJAlaVgSppSzmkzmmj9z1KWZLjI/fe9+trzKkns8IN4zt
         1foAqoJrbFc3e5+yVtOpEjVHAahVO2I3I3qJupKJGELRWPvqt9YbaEngxNgG3Co/W3W+
         0mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156338; x=1712761138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6ozn8GWGaymICONfaql8z8aBGhL/vcq5PD2xm3yHTg=;
        b=egFuhr6j2fLhZ4bf8IU4pfI55iBKnhoCQvTZ8V47hMZZFARjq+4b3TByvSlRZH8UPS
         2ZI9YXAyO8oPvtwSPGeR11GmweXrmRni/r6akOe5El2EBTn9iyJiL8lPSAdBQe69R6Xt
         SelTLDKb5h7h/+LTWVfmWgSKhKwz5meh5NsIQdI6GFUnwR5PdwuKxnr31mplvP9HeIDY
         NEQeDEdt2rDIKEp8L8QtkIt58vGnx8cWv40tKwpxsec6OFz96Vxd7m/7gBfHo7bUukxD
         rPJCiPXwD4n0ACg2Mait8Zq27ketXSnT9yVCbZ1qkhgyZXnUM3u3qdXRglAbaWMqSFFj
         v/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUuFHsGPQTfy/jY4VeGlJQcyIsSWe9DmptBb1CM18rS9TeNDFcOM0m/gVGeK5cOPF326jKXnqU8z5Lco5I/CPS/Q01pdcCwSbBQp5Vk
X-Gm-Message-State: AOJu0YwL2yZ5zMOMpxQN3U33loeU5RaVwsWrYQSeIS2w0J0Blh5N1CFP
	skwYnIQP5xwlx1yyjLt/sD7JL8rDESOg4DHy9vhjjxJzIdMnCO80BQFZd6n2V49ZeSFeS2qL/8K
	6mrVVZD7lf0rwVsJ5HErA4kBBHIvrj9O/B+EN
X-Google-Smtp-Source: AGHT+IGNgAodpsrYQT2AbEmyPbb+UGOULWYqBs8jhyUUwdxQtLywey14p1gGYRWmBh3FA7fTEozafbxC8444+PUG35M=
X-Received: by 2002:a0d:d5c1:0:b0:615:144f:1f5c with SMTP id
 x184-20020a0dd5c1000000b00615144f1f5cmr6498090ywd.47.1712156338103; Wed, 03
 Apr 2024 07:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403075729.2888084-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240403075729.2888084-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Apr 2024 10:58:47 -0400
Message-ID: <CAHC9VhRFsvBs0ysZ1rwqaz0TvMQf9JFQTBTA1cym08nbvoTVEg@mail.gmail.com>
Subject: Re: [PATCH v3] security: Place security_path_post_mknod() where the
 original IMA call was
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-cifs@vger.kernel.org, pc@manguebit.com, christian@brauner.io, 
	torvalds@linux-foundation.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:57=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Commit 08abce60d63f ("security: Introduce path_post_mknod hook")
> introduced security_path_post_mknod(), to replace the IMA-specific call t=
o
> ima_post_path_mknod().
>
> For symmetry with security_path_mknod(), security_path_post_mknod() was
> called after a successful mknod operation, for any file type, rather than
> only for regular files at the time there was the IMA call.
>
> However, as reported by VFS maintainers, successful mknod operation does
> not mean that the dentry always has an inode attached to it (for example,
> not for FIFOs on a SAMBA mount).
>
> If that condition happens, the kernel crashes when
> security_path_post_mknod() attempts to verify if the inode associated to
> the dentry is private.
>
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.
>
> Reported-by: Steve French <smfrench@gmail.com>
> Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHm=
BpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: 08abce60d63f ("security: Introduce path_post_mknod hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/namei.c          | 7 ++-----
>  security/security.c | 4 ++--
>  2 files changed, 4 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

