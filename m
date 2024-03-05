Return-Path: <linux-kernel+bounces-91606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E135B871431
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D10B20A21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66E376E6;
	Tue,  5 Mar 2024 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VorYs+JN"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639551865C;
	Tue,  5 Mar 2024 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608865; cv=none; b=gi9axCILxXl0ph2LISaIhagLxv3mF2K0Z01JR12ZHjbrdkZB+0t/PIrungvX2cNG23+vUV84iigXE0q6LFDQ1h8SI99VTRXZknqHtUAcdimfMSchUFDx92S2E/N6330uuznyA+V5PmgwPM+Jh49aMsh0mPCht3bnPCnfs1SIE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608865; c=relaxed/simple;
	bh=fQxFj9FoBmTJzV/ZouAXdSy2rLJDNB1eESe76AOrgDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1UhsJnx8FhzO3RPvqpkDjDGq2NAsckhOpmuubF8zd9s46zUthukW1kuBvREfJFsP69TTjHc8LVd/2ej8GpY+auvprjZtk+3hlVsfHneCY0IWHWeABHULLIb1LvqP42DIAStCV0X9t1OwNDRBybK/7ycisE9T2kynUsYlrSIwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VorYs+JN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44e3176120so287588366b.1;
        Mon, 04 Mar 2024 19:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709608862; x=1710213662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5OTOZkvI1iKHRZFDGgAFNCyc+OZsWpdVdz/BEQBjP4=;
        b=VorYs+JN2iMVeIIpUm2WyXOPxI9BqGZYMR0xb3smQhOsDa2/EwJd7uZVlZpvbX0SUy
         EZA0bhdJgqEZi1G4blynLdm+Rw2x3W9JIVEtutBI4LwPVYhapnmOIRfeOQ4/do5cHrav
         m+22DLIUtpiqGKrpvCFPqaXGsTa6HouZXDzfMgiuMVuZsSZEqLGgjBOQmu7u5/a3ZB1E
         VtgdJga+VmCJH65H3uVW/UGJQ8uzlf+LoTKGDK7C8g1U//FSmqKmjEz0SikrV8GJj12t
         VEKFGVd7QGP/oMm6thIqJ0QVJBL4bPhobG0yup0sLaEsghBZognPhC5tsbtmRwLHp4/u
         Hhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709608862; x=1710213662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5OTOZkvI1iKHRZFDGgAFNCyc+OZsWpdVdz/BEQBjP4=;
        b=nXB2BQepfx86suOAnDWTVdQYZ3lNcjuiA5A/EZovkV85la8Ti+yYPF6ysmJqb8YYDc
         gNmnSnsUQS0KYOvQqylSA5Up8LIzFCctqhiYzAQMItxE0ateQILLxPPpDI86piRK/fKR
         sL4eYeqv3dyexJrPDYbxr4G3JKW2E++FGuuUnJAh82liUItmJh5wYPkuhpaEXfqjXWPs
         y6tq4lWGyOfwD+yLMQdLv8NFSV8swKwnkTz27sFeBmhHdz3eBm4K85trHDZ4bPjVGhYH
         7fbBxTvJAj9Wb7Fd34AtQv0rHh35yKS42qZY0x7sOVYsJAN8dG/Pz45yQZO2PzEajmnw
         Or0w==
X-Forwarded-Encrypted: i=1; AJvYcCWxDdfj00LLNyrRHOIWjzuQ7lX+ElQfu7Q7KDcgewjgBAI6gQK38rBdoZ0ptnfqXp0XbH71NTVDgNyRR5B72xr6WygniLeu
X-Gm-Message-State: AOJu0YwW/cQZMjzroGrQtWGO7CF867yu+b/p6Kd1fPRNicUbDR5l1IPb
	NrJI7Za3nciYMtrUXHQdBH4YgTqK7VuqR/0mLCbjX2WfaZhj8lGtWvPVdobaqHTlXKCwjdgqUZh
	uzqgnPKdn7u8SZHZIFPhgCiqgonM=
X-Google-Smtp-Source: AGHT+IGzCLorvfjl+krG6qfJI1O1/54XBrFfAYojjAa1cbuFXNug7cFrg5Gpu1as2dW/gXgop0TWPItpHFPcwFW/VFE=
X-Received: by 2002:a17:906:695:b0:a45:1850:e6ed with SMTP id
 u21-20020a170906069500b00a451850e6edmr3968306ejb.6.1709608861517; Mon, 04 Mar
 2024 19:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYP5T4Xv7vn7GZnQ7ig6_QZB8B_g-DS9dk7xhxRntYNY7g@mail.gmail.com>
 <24641.1709606824@famine>
In-Reply-To: <24641.1709606824@famine>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 5 Mar 2024 11:20:49 +0800
Message-ID: <CAEkJfYMfU8bSrvpgSCgCG4-canwkq3dZKSUKbd0xsjLuLPGMQQ@mail.gmail.com>
Subject: Re: [PATCH net] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andy@greyhouse.net, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:47=E2=80=AFAM Jay Vosburgh <jay.vosburgh@canonica=
l.com> wrote:
>
> Sam Sun <samsun1006219@gmail.com> wrote:
>
> >Dear kernel developers and maintainers,
> >
> >We found a bug through our modified Syzkaller. In function
> >bond_option_arp_ip_targets_set(), if newval->string is an empty
> >string, newval->string+1 will point to the byte after the string,
> >causing an out-of-bound read.  KASAN report is listed below.
>
>         Conceptually, the change here seems fine.  However, I don't
> think including the full KASAN report adds much to the description
> above.
>

Thanks for pointing this out! I will remove this next time when I
submit a patch.

> >We developed a patch to fix this problem. Check the string length
> >first before calling in4_pton().
> >
> >Reported-by: Yue Sun <samsun1006219@gmail.com>
> >Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> >
> >diff --git a/drivers/net/bonding/bond_options.c
> >b/drivers/net/bonding/bond_options.c
> >index f3f27f0bd2a6..a6d01055f455 100644
> >--- a/drivers/net/bonding/bond_options.c
> >+++ b/drivers/net/bonding/bond_options.c
> >@@ -1198,7 +1198,7 @@ static int bond_option_arp_ip_targets_set(struct
> >bonding *bond,
> >     __be32 target;
> >
> >     if (newval->string) {
> >-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
> >+        if (!strlen(newval->string) || !in4_pton(newval->string+1,
> >-1, (u8 *)&target, -1, NULL)) {
>
>         The text beginning with "-1," is a separate line, and something
> messed up the tabs.  Also, this should be rewritten as
>
>                 if (!strlen(newval->string) ||
>                     !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, =
NULL)) {
>
>         to avoid a long line.
>

Yes you are right, I should have used the checkpatch script before
submitting the patch. Sorry for the inconvenience.

>         -J
>
> >             netdev_err(bond->dev, "invalid ARP target %pI4 specified\n"=
,
> >                    &target);
> >             return ret;
> >
>
>
> ---
>         -Jay Vosburgh, jay.vosburgh@canonical.com

I modified the patch and it is listed below.

Reported-by: Yue Sun <samsun1006219@gmail.com>
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
diff --git a/drivers/net/bonding/bond_options.c
b/drivers/net/bonding/bond_options.c
index f3f27f0bd2a6..7f765b42fad4 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1198,7 +1198,8 @@ static int bond_option_arp_ip_targets_set(struct
bonding *bond,
     __be32 target;

     if (newval->string) {
-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
+        if (!strlen(newval->string) ||
+            !in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
             netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
                    &target);
             return ret;

Best Regards,
Yue

