Return-Path: <linux-kernel+bounces-125320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D58923F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF65B21CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039E13BACB;
	Fri, 29 Mar 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BxkSCmqH"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0081386A8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739591; cv=none; b=cMX1apxQN5ZGc6YMdvZfy1KxYet8s/4xrf1KR/BPhBvFHGW+51u7hhuHzWDUnDjlve00NyDDK3Q3lc8rsr5Si1KUxUdz4f2Oj/ZOgW7hlxp/cddXOEXduBIPf8VtKNSMqlVsBjXNBAC+ODlTrYpXPUyziNiVbWi/+c2sggoo6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739591; c=relaxed/simple;
	bh=KlO9M95dbXioJjwabMTZkCSBBVLvvf8dKA6fibf0Fb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1+UZJsTadwbNloKs3lca9cs45qOyqsY4hCYJKiAtOh2vWLTEUSzT0WyD89iBQ/weLhsILhaoKcgEDKTKdo13fED9Qb24rhQMcLYLVNkHLF5YryLFU/tXWekgoHg5a4kjFrFw5bAFswfRtLlWKtduxjz/AIFCozXXWOVZSwOMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BxkSCmqH; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso2192562276.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711739587; x=1712344387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GANtgtiBttY0+ggrT+rX/zOqSgUS0IxHWYjZGlwBuE=;
        b=BxkSCmqH8TZ8d/sRn+k1j6BoOIib9QO36ms9BIutDyjC1eV6JBcPaxaXmFy76gPJKm
         x45DMPlz8Sfx7VXgder80QfN3n9XBFri7FTGRkgiTRgpp6qBn9311MeKjRCXYwnJVYYM
         1+MZRloC8paUhZN9hk5kTeWk1qOqDC7ls1VCMiap7dPn3H78/6eUGGUlYSvLdyR/ebxd
         1PxmGJeqBbl9QWGMgMSz+bWDhziw+Qu2TPHA32fLrm5ABlvtWsUHSl1zzLQSYNIEnaNX
         873PacDX3/LFS17eZNTcsonIIzNmSZuhfBEHSfIwJ1mXjvst694qDwKufJg87oTkxbi0
         3Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739587; x=1712344387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GANtgtiBttY0+ggrT+rX/zOqSgUS0IxHWYjZGlwBuE=;
        b=a4H21xk6+RySXCmhUoIVh+WQcBg9COKxyDTf6wBl5xagn6aKaMccptaHZaoKfTnUPV
         1cipz9YsM4R6OUdaaWjWmSzkvh9p6xHy/ijpjBohB30/OIW75u4cYybpGucsO4JZZVVa
         1wRYGdWRyYlEqqhp/0yDALSN+fXl0wgcuMmQ/EtL+YjxrSVPczXQNiFMXy+k7VYW9gIf
         iZbCm01YeBYBcW/KzX8UaAVUO5+3bNZJFBxLyOMh5I4ll3cG1syljGjG12FaKAUkjphu
         K7CYiPheI7blB7cHsYO7pPjygzmOr9Y7ABpL+WGrfEStR4Rb8S7eVuw7XU63FNtfNdUT
         S1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVrknpmxKYxPdU35NqLGH2hLSmjfwgCe/yqrQ8JEmbkGPml/xwfz0JOW+UAsBeTqcCL9aZ1+uabh0ju7BnHEJZdHBv2efyo7kyMWWys
X-Gm-Message-State: AOJu0YyZEjggZGeDmkPLtCTs90bcP7FOmrkKCpVUAQpS9wtGlvreWPYQ
	ifzGvtxyM/Rjb8nvgLnmmzvDbw4KYY0OdyJe2VYyzhXkXP2BDr5H10F2h4VpWJ3mL86N4TrcSZF
	ug0Xwnz02KLXBHgmdELiyoTtj6fFpaE7aJ2jP
X-Google-Smtp-Source: AGHT+IF6bGOeX7gUKGAtS5mDjau9RUMnjocg9FrjpHi6DlCICMIbMhN5NiKHW+DNPuwpPpupHnUnX91f/yBI8gN9nyE=
X-Received: by 2002:a25:b225:0:b0:dc7:45d3:ffd0 with SMTP id
 i37-20020a25b225000000b00dc745d3ffd0mr3411457ybj.1.1711739587638; Fri, 29 Mar
 2024 12:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
 <20240329105609.1566309-2-roberto.sassu@huaweicloud.com> <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
In-Reply-To: <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Mar 2024 15:12:56 -0400
Message-ID: <CAHC9VhS49p-rffsP4gW5C-C6kOqFfBWJhLrfB_zunp7adXe2cQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ima: evm: Rename *_post_path_mknod() to *_path_post_mknod()
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com, 
	christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:17=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Fri, 2024-03-29 at 11:56 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Rename ima_post_path_mknod() and evm_post_path_mknod() respectively to
> > ima_path_post_mknod() and evm_path_post_mknod(), to facilitate finding
> > users of the path_post_mknod LSM hook.
> >
> > Cc: stable@vger.kernel.org # 6.8.x
>
> Since commit cd3cec0a02c7 ("ima: Move to LSM infrastructure") was upstrea=
med in
> this open window.  This change does not need to be packported and should =
be
> limited to IMA and EVM full fledge LSMs.
>
> > Reported-by: Christian Brauner <christian@brauner.io>
> > Closes:
> > https://lore.kernel.org/linux-kernel/20240328-raushalten-krass-cb040068=
bde9@brauner/
> > Fixes: 05d1a717ec04 ("ima: add support for creating files using the mkn=
odat
> > syscall")
>
> "Fixes: 05d1a717ec04" should be removed.

I'd take it one step further and remove both 'Fixes' tags.  A 'Fixes'
tag implies a flaw in the functionality of the code, this is just a
function rename.

Another important thing to keep in mind about 'Fixes' tags, unless
you've told the stable kernel folks to only take patches that you've
explicitly marked for stable, they are likely going to attempt to
backport anything with a 'Fixes' tag.

Regardless, since I was looking at 1/2 I took a quick look at this
patch and it looks fine to me once the comments have been
incorporated.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> > Fixes: cd3cec0a02c7 ("ima: Move to LSM infrastructure")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

--=20
paul-moore.com

