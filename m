Return-Path: <linux-kernel+bounces-62946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D785283E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5971C23042
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D21171C;
	Tue, 13 Feb 2024 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQGKXsIQ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71A125B2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707802397; cv=none; b=tmrYtBGxwY6TuDoSky+aZiBEHHYWNsn6iGessAavZOsUTiVVoP/TymG7wuK0mqmq8UtTY3hzgXJIHtQNjPCzTTxI4iOPTwJkWXNKx0FnSWilriaYndOkPvpOvLYYpK2D0NkvTe62tsK/zsAT/UwZI42GA408wonJvqAsNKe3xMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707802397; c=relaxed/simple;
	bh=02Q8SrULMcBSD7ttAGWmB8PIKrympbUDiwhvHFHIOIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiekRuJyV2HYXJNV+Ybw1ubUu0qK9aP9K0vUGGdratI5o5b3CixyxKPZ5wSUBve4EHhhCNmJWF7Mquvx9qPViLHOirBz43kLUoUCYGAslqOuzdyPQcG/LvgAje4U1D4Bbv48jSIe8iAGjSMLapHl8pyv2JxYEXAofcXiHMvOTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQGKXsIQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so4239a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707802394; x=1708407194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XETlmfsLFShyCAFBnC+zhCwZVHqHy0Tkff4Gvlg5js4=;
        b=lQGKXsIQ1ODfP1giCizNWaMgDJ2MeF6EKFMjgd+fRG25TmE5aA6dM1EaWrSN6Lu6hS
         QLZJt97QDQBUGfqS+mDYBkoM4mpeSPaUn2nHKpmgyYT5QO31qXZ1tN71gokhv/DYX3F+
         il91Qt5vADjlSyWNaQiq5fhOT2uhCpDlCz9kP54xoEVkB6u7RjaoUH0LhXYo+byImY7V
         IyiydKkhtJEDi30I9pG8HvZPuPnNKpsahQHQ4+y8LyZZiz1whnvIHdF93OvePqmVw7uh
         kl/Cmqg0thcx3e5cZzOyIkIV8u+iNiQVuaffRqhJgyZv7ZmHgAIGcjjX0fpiPQGk+P01
         SBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707802394; x=1708407194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XETlmfsLFShyCAFBnC+zhCwZVHqHy0Tkff4Gvlg5js4=;
        b=mqw5FKWJRCVgXqHTyWF72L1l1DH+0FtPP5WGf7visBRQ7Fh+at9e0m0xJbEuGcVSfp
         YqyuRVE+ofuhtHabOPehv14tK3h3Kg6lX0+GtXwnUYfeicY7nPHNGAuy07/PrEgSuwzB
         R2DC4KmaQb1OqgChVV4jRfurt8YHhvulRzeiM7K98DvfiROtoCtEgL0fImAjbVCFFob9
         xOBmUufEW6K3PWgsgDm0+C3e1crdJVImCyKSXx+2dOqkAfLrvA1yOsBf1imnBH3Jquxk
         WSB445Z1o6lbO8x5FJKXvkF7XWqzsDFkNkrY/k4VmURWYh0con4dAhyGeZFGQ1Cjvg66
         P3Ow==
X-Gm-Message-State: AOJu0YzGHsogfs4vdoFRaegJ9GvkPdKGg4wxWhAbGg86NhMXAWlQqsLi
	JZZ8XYwdJayDOxpZjS3HXLrGqj/eI4x8c1/9y3sXbBU6CSdMOnfA8BVjys+1Ce/iv/ag5wocd4G
	2iyTdF/yHTU5vcKZt7+d8SZYw9bWcyllgd0dsH/rUGvxpNX4zviFMIp4=
X-Google-Smtp-Source: AGHT+IGZwj4j5QHgqbf9M6ktVVQXLrk8Drh5qXX7tCSAml5AXcdIY2mAHCO3BaKHjRfwXHDOxgMo1HGswGGrIk/pIvc=
X-Received: by 2002:a50:f615:0:b0:561:d84d:f6ce with SMTP id
 c21-20020a50f615000000b00561d84df6cemr80706edn.6.1707802393936; Mon, 12 Feb
 2024 21:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org> <20240207-s390-lld-and-orphan-warn-v1-7-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-7-8a665b3346ab@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Mon, 12 Feb 2024 21:33:02 -0800
Message-ID: <CAFP8O3KuJRuDFC3M=4DS2SVjzo-gcKzNYVAPLmsexnjEifOuZw@mail.gmail.com>
Subject: Re: [PATCH 07/11] s390/boot: vmlinux.lds.S: Handle DWARF debug sections
To: Nathan Chancellor <nathan@kernel.org>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ndesaulniers@google.com, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:15=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> When building with CONFIG_LD_ORPHAN_WARN after selecting
> CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are several series of warnings for
> each file in arch/s390/boot due to the boot linker script not handling
> the DWARF debug sections:
>
>   s390-linux-ld: warning: orphan section `.debug_line' from `arch/s390/bo=
ot/head.o' being placed in section `.debug_line'
>   s390-linux-ld: warning: orphan section `.debug_info' from `arch/s390/bo=
ot/head.o' being placed in section `.debug_info'
>   s390-linux-ld: warning: orphan section `.debug_abbrev' from `arch/s390/=
boot/head.o' being placed in section `.debug_abbrev'
>   s390-linux-ld: warning: orphan section `.debug_aranges' from `arch/s390=
/boot/head.o' being placed in section `.debug_aranges'
>   s390-linux-ld: warning: orphan section `.debug_str' from `arch/s390/boo=
t/head.o' being placed in section `.debug_str'
>
> include/asm-generic/vmlinux.lds.h has a macro for DWARF debug sections
> named DWARF_DEBUG, use it to clear up the warnings.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/s390/boot/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
> index ff8c62d84f98..83af17bfe630 100644
> --- a/arch/s390/boot/vmlinux.lds.S
> +++ b/arch/s390/boot/vmlinux.lds.S
> @@ -122,6 +122,8 @@ SECTIONS
>         }
>         _end =3D .;
>
> +       DWARF_DEBUG
> +
>         /*
>          * Sections that should stay zero sized, which is safer to
>          * explicitly check instead of blindly discarding.
>
> --
> 2.43.0
>

Reviewed-by: Fangrui Song <maskray@google.com>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

