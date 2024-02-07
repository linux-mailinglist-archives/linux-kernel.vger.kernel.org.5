Return-Path: <linux-kernel+bounces-56911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD3584D13A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E3D28AB70
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E087CF05;
	Wed,  7 Feb 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEZqg9bo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC91D54A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330796; cv=none; b=TM0Q6fuHpQDXV/0F8YJPiR9t8d834GZDaKfTlwjy0MQLTvWFp3qfM8WlvdzC8ZXfl+lsHt6+iIMhRIJqyi1oY/iVpq3iL038WGv+VAOfy47XJZID6eUEfyGcP1mD9XuOd58AWT15nRctsv2Ri0sMy0CxyRc0UKL1vq4+dgtG+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330796; c=relaxed/simple;
	bh=vcbjnt5RH4cAV2tJXYgIsVQe1Lf+xy5epqYic0XC5Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdLS5GW/eCLwTgyWNYyd5XwcYEqaqQSMBEMrjjGMZM8tOJWkxmrpiktLyt0/wC1MVcIB5nG03Pjng+vQtAWhlJVjpQZ/Q7OIE99tiSleb7ajlw7KhGikXdlZZiD9iFVwoVukQCpONNFmrjAZ92OuBWgQcbm00QlY3Ky2UnR+qrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEZqg9bo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a30f7c9574eso129446366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707330793; x=1707935593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPN6YHmWuLd5MWUOmF+xJhqXptNUFEEGocEdREYkoUg=;
        b=eEZqg9boFAF1fBMIbYIqFLv+PK6/HVmjEHdQqmq6DQ00/wzgPrBWdaQcbIICub4rkZ
         PXb0EnU0uRcqfvMDO7GxCkUqSUUSA7CBN6xAU2kgIiJkmS/Ewr19lOeoKah8i9SRUspm
         EF/ZPnCc/ISTQO179vs2Ya/g5zzjXPsSMnqv0Agt02xlddwtu0wbG4pFnMSy+/wIPa/y
         fo9tHZm5JVm5buPxBiDsfScdURYFpVL3LaBxvZj7F4bBpdeprvAKHxhfLgjW8Se5tZYF
         1+uq9K/V2i1fj2Kq0q+MHcS/naHStsrVnhoRihp/+R1G5DYnLFIMMJfORjpoqya312Br
         Uauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330793; x=1707935593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPN6YHmWuLd5MWUOmF+xJhqXptNUFEEGocEdREYkoUg=;
        b=BSVT7UJC7K9AUYrcZwi3PpCzds1KJdKSopWSgSBf3Z8ts6jFOqaaANMCaSKVffV7A9
         zck5TMTW/jGlNl0p6z2LbRlVcFbZQhz43H90dvHxoWIkSEjN0pqgdX54okoFw/fp6qjz
         aRKPwRDrxckx/A2xTBzflYcpabs60pTtP0NPEHXRQEawhZvBFX3vfaEqcrp7vAfm6No2
         uBzbbYnphGPHKJz6Yvjcdtt/wbIGzltz/JWu46bwBr9K1ApS511EiiLR8tW0GmMbZnkj
         Vbex77mWc8pgtoyoxE8C63qo9AvaGXF3OcRd95+qZGijF81vgiZDNajyIsEO1p3J9470
         VvTA==
X-Gm-Message-State: AOJu0YxmgX2SfBG4Q4Tf7aAmCwuD8SykwZCtceyICo3epSe+otiKwwCY
	7GDAGGiSRC+1MAMT7Ay8dGQI+SZ5l6EpYDaXewU1x/Ps1LctfPv9VhBZ/x/RWQg5BMv2exPObBf
	tX70FndEJYpGk2B9NXKA59qs5TH8FHq+bvTbF
X-Google-Smtp-Source: AGHT+IEmincd4Fm+vxfFykn5vYT7vHDEMm4sKWDOLRSn5dY2DxhjYcMa066xPr14AMS0mJHD4AbsNPK3mEUonbBdGTM=
X-Received: by 2002:a17:906:4bd2:b0:a37:9c44:c5cf with SMTP id
 x18-20020a1709064bd200b00a379c44c5cfmr4748046ejv.24.1707330792878; Wed, 07
 Feb 2024 10:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at> <ZcNdzZVPD76uSbps@eldamar.lan>
In-Reply-To: <ZcNdzZVPD76uSbps@eldamar.lan>
From: Jordan Rife <jrife@google.com>
Date: Wed, 7 Feb 2024 10:33:00 -0800
Message-ID: <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
Subject: Re: [regression 6.1.67] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Valentin Kleibel <valentin@vrvis.at>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:39=E2=80=AFAM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
>
> Hi Valentin, hi all
>
> [This is about a regression reported in Debian for 6.1.67]
>
> On Tue, Feb 06, 2024 at 01:00:11PM +0100, Valentin Kleibel wrote:
> > Package: linux-image-amd64
> > Version: 6.1.76+1
> > Source: linux
> > Source-Version: 6.1.76+1
> > Severity: important
> > Control: notfound -1 6.6.15-2
> >
> > Dear Maintainers,
> >
> > We discovered a bug affecting dlm that prevents any tcp communications =
by
> > dlm when booted with debian kernel 6.1.76-1.
> >
> > Dlm startup works (corosync-cpgtool shows the dlm:controld group with a=
ll
> > expected nodes) but as soon as we try to add a lockspace dmesg shows:
> > ```
> > dlm: Using TCP for communications
> > dlm: cannot start dlm midcomms -97
> > ```
> >
> > It seems that commit "dlm: use kernel_connect() and kernel_bind()"
> > (e9cdebbe) was merged to 6.1.
> >
> > Checking the code it seems that the changed function dlm_tcp_listen_bin=
d()
> > fails with exit code 97 (EAFNOSUPPORT)
> > It is called from
> >
> > dlm/lockspace.c: threads_start() -> dlm_midcomms_start()
> > dlm/midcomms.c: dlm_midcomms_start() -> dlm_lowcomms_start()
> > dlm/lowcomms.c: dlm_lowcomms_start() -> dlm_listen_for_all() ->
> > dlm_proto_ops->listen_bind() =3D dlm_tcp_listen_bind()
> >
> > The error code is returned all the way to threads_start() where the err=
or
> > message is emmitted.
> >
> > Booting with the unsigned kernel from testing (6.6.15-2), which also
> > contains this commit, works without issues.
> >
> > I'm not sure what additional changes are required to get this working o=
r if
> > rolling back this change is an option.
> >
> > We'd be happy to test patches that might fix this issue.
>
> Thanks for your report. So we have a 6.1.76 specific regression for
> the backport of e9cdebbe23f1 ("dlm: use kernel_connect() and
> kernel_bind()") .
>
> Let's loop in the upstream regression list for tracking and people
> involved for the subsystem to see if the issue can be identified. As
> it is working for 6.6.15 which includes the commit backport as well it
> might be very well that a prerequisite is missing.
>
> # annotate regression with 6.1.y specific commit
> #regzbot ^introduced e11dea8f503341507018b60906c4a9e7332f3663
> #regzbot link: https://bugs.debian.org/1063338
>
> Any ideas?
>
> Regards,
> Salvatore


Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
and 6.6 stable branches,
it looks like there is a mismatch here with the dlm_local_addr[0] parameter=
.

6.1
----

static int dlm_tcp_listen_bind(struct socket *sock)
{
int addr_len;

/* Bind to our port */
make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
   addr_len);
}

6.6
----
static int dlm_tcp_listen_bind(struct socket *sock)
{
int addr_len;

/* Bind to our port */
make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
   addr_len);
}

6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on heap) w=
hich
changed

static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];

to

static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];

It looks like kernel_bind() in 6.1 needs to be modified to match.


-Jordan

