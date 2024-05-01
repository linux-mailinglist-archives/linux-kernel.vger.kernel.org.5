Return-Path: <linux-kernel+bounces-165762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6638F8B90D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E211C21AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F27165FCF;
	Wed,  1 May 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gpgH3Rvt"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FE165FC6
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596470; cv=none; b=MEKMyzUe28EBdsSjLh2AGPeLvv4XHiLtOqSM/NeJTkhDj1akZluomMi8xRlZ5GoW9UTv2U9BSrwUhGBqm3CEOO+2SMOhoJ+HhBJGsyyPgnXDJFVhaoybM1PCVFGbhAg6j68LYjbtYoLJLpmlCm3WQ77GrAuvjC9BQJgk/2tUuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596470; c=relaxed/simple;
	bh=ra1d6k+dPLwUnrnNIckVGDJJ8lliajlQVTK90DkxH3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3A2UeGnd81QRjaIh9GRU1iLMGDrnZP3j6Cmvh4LCicrCL3a34yHqPobMfYK2tqblx/e93vFR3H6dxjM3eTJpY5nERORraWoQn763UyWzgavW/jbwJf74DWwFQIgzHwudHJEdM/eFzXkELGCqzZM3Mqn/E3TNyGawIrZF7gyG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gpgH3Rvt; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6153d85053aso59074047b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714596468; x=1715201268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+PTRDKy8eCh7IoM5KV0mi1ceXwqoykRHY4lJtZB0kY=;
        b=gpgH3RvtZYGw+ehS9sDjZywyTGvxgtr+CsG/iYIp1RP2kH9I5ZGN4Iirt8M6IbLEDd
         bS0N+UYIhG6F/JmgoaA1EyvpyN7jV/5HCgLSVhOSbcgJqIP1RhEOHICKCUY/gbHVzta6
         nfw+cRGHAWNv/p5i2tsDwfk8Klj+48tJnTmK21WsKLMCcnIWDz6HCVEbX4NVX88Ps/fB
         oNPigxEi3/l14dujgguG9nykyLMMekTAuW9pyaRhQ5KMPIvVmYj8VIA5JHtxqhx7c8IR
         WRrNqZG4YPacFIV4AiN95uj8cBb94VRX9LK5BGKvSCOu5kMF+fb7ZLAm34Jmh1XvjFaR
         BDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596468; x=1715201268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+PTRDKy8eCh7IoM5KV0mi1ceXwqoykRHY4lJtZB0kY=;
        b=n1TDLBFiZZCPeVKurYF1PEQEas+19RLvZfNkHvL3GKfXO/n8IIjBKAtL2smvHrTkxy
         Ng1mSuRryAqtxNFTSiDc3Guqw2EtlTl7+go4Y6c33tf5G0SQZRFTq+Uvr9qi6OvWyVvL
         3/eDdJurSU9rcV/hGMesb7pr8ootwIh+u1UjWA4z29PzDbVOerp0cCcRnBTXSok17FwY
         hRiKlq59GFkMK19FW7irjmW5jfrH7jvmMydMc62okuV9JroAH1T2bEGnKVjPftAWS9K4
         pMZ/Eb15eMA00XCPFX6p4vEm4jX1ShlGlwof7izbZxOkbMLo1wK3q6HOmdvFe+crjzj0
         j3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVa7308HqsJkxE1Vnt0D0Wr3/hoRO/eC0UuNx8XfOOyXCtBdgZJOSNyuPiY1fq1XMlvC5PbnSE/890/7aq0Qs5WxcQ6ZmaQ5nEcxSjY
X-Gm-Message-State: AOJu0Yzwe3O4xneGRGEtsoUYPQMo42u7mbg15Lx486qP19KF8hnzA/+p
	0vqW0HWjIxFVcsbL4wp6bTkQeKBhkI6J6sAYH609q2xlRk9l6+bG6+doLeoD964Qaw2RhIdNdWF
	n//mr1o7IBE7OkAzqo2V+MLPo73GYagvEHq2W
X-Google-Smtp-Source: AGHT+IHOwjK39aAkCf1U1a1zITPFDSZFgBnRkiLpnvhJSWgbMTwWHIaF/yZdq1CGwHLPTrZin8UvRonaWrA3BNBSiHg=
X-Received: by 2002:a05:690c:dc3:b0:61b:3356:a679 with SMTP id
 db3-20020a05690c0dc300b0061b3356a679mr69311ywb.17.1714596468387; Wed, 01 May
 2024 13:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429114636.123395-1-fuzhen5@huawei.com> <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
In-Reply-To: <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 May 2024 16:47:37 -0400
Message-ID: <CAHC9VhT0=Useuop92s4J9CGNpXa54r4NYnY9DOTnGmoo0hNv5w@mail.gmail.com>
Subject: Re: [PATCH -next] lsm: fix default return value for inode_set(remove)xattr
To: felix <fuzhen5@huawei.com>, linux-security-module@vger.kernel.org
Cc: casey@schaufler-ca.com, roberto.sassu@huawei.com, stefanb@linux.ibm.com, 
	zohar@linux.ibm.com, kamrankhadijadj@gmail.com, andrii@kernel.org, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	xiujianfeng@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 12:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Apr 29, 2024 at 7:47=E2=80=AFAM felix <fuzhen5@huawei.com> wrote:
> >
> > From: Felix Fu <fuzhen5@huawei.com>
> >
> > The return value of security_inode_set(remove)xattr should
> > be 1. If it return 0, cap_inode_setxattr would not be
> > executed when no lsm exist, which is not what we expected,
> > any user could set some security.* xattr for a file.
> >
> > Before commit 260017f31a8c ("lsm: use default hook return
> > value in call_int_hook()") was approved, this issue would
> > still happened when lsm only include bpf, because bpf_lsm_
> > inode_setxattr return 0 by default which cause cap_inode_set
> > xattr to be not executed.
> >
> > Fixes: 260017f31a8c ("lsm: use default hook return value in call_int_ho=
ok()")
> > Signed-off-by: Felix Fu <fuzhen5@huawei.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Adding the LSM list as that is the important list for this patch.

It's also worth noting the discussion below from earlier this year.  I
just spent a little bit of time working on a different solution which
I personally find more acceptable; I'm building a test kernel now,
assuming it works I'll post it as a RFC.

https://lore.kernel.org/linux-security-module/20240129133058.1627971-1-omos=
nace@redhat.com/

--=20
paul-moore.com

