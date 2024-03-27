Return-Path: <linux-kernel+bounces-121353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C552C88E69E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C141C2E19E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C9157E6E;
	Wed, 27 Mar 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E7MmN36g"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EA13A3F7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545178; cv=none; b=gHPb3xjNg13miS1T0hAk04AzmGqNi8XvxDdeIwcp2+H06+82naThiNZRhPTceTxmbsxh3+W4nLcKbyuJG3+kjxUqD57Wnp6DDTxIDpWkB/DMIGVwAv8c+G1vbFHLXmCbU5F3ZKdIfgCeToK8oDXrp1l6Lb53JIElycQzFp/7xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545178; c=relaxed/simple;
	bh=7jYGQE/Sq6zQQ7I/lci/AqG3dRtS+wbk4l5Iv9S3DkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHTUEoA1kZimP+EqZEz3fBTr5xWfVczdsoizdbMvmyUPzA2bNuBaiGRuJOEV4eHrrlnPklWO3h/efsWC/la6/QUpyqUvOP1kLUEpIsmIY5zBRu7guUTrljnt46WXxalBCk4ic52OY93NNr+77rP1ubzTaacpbxpzbdXzA70CX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E7MmN36g; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61130dd21c1so45784527b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711545176; x=1712149976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl8kc5DDzw1UCsj7H0OiwEAFqFJFC9LP/5UvI/M+Yjg=;
        b=E7MmN36gG9eHassxEruVGT5a9SJ7HIN1ZupU6gnFwxmzFwmaBaPaTSJN47uwi1p74q
         zhwmrRGdqAKH35L3Q5NtFonNWWWd/3W8F8W0TWdh0GwXB3HjWmizcCRZnKx/GsM43rGU
         hwaHSx3TACrKeum21NSKTq4BQZ3Xs05CohfN37id/mOx2UnYnRfgLFTA/WenLTvPxTwr
         Q0+zoMcUS/2MXMLCDcOqu6KNgsB6tnEAZz3hnAGDLa10wOs0GL2srUC2Gyul3h2jqESd
         AQ7CGYSQuYkkmor3grdTdgym/L9aUc2tB9PPrCtwbhxkb7bRvhrbO62AotxDq42tMldj
         Kk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545176; x=1712149976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl8kc5DDzw1UCsj7H0OiwEAFqFJFC9LP/5UvI/M+Yjg=;
        b=JryYwyE0THxOGzKIurfKa2N5NTyriG2Rco9QAR/WJwojCA4R9K2L+1FxdKfSMhLC2k
         a7cCOkBuJDPZltT5Xh4PQ0EvgSj/i6LqHifM4dYzpTy58zIJejF7fX1Lt5ZJ89mO4lrT
         jJu1tK2qrVt7VYivvwNQxdci2p+Z1Hr+xaFhSZbVWMcWOlqNsJ9dLCExgtz14uI215dX
         m7p2MEoSDSUw8RjW7HCML6vCj0WiJYrRuuU3W6zDlBTKzzeG0mYBl70UX2XsNPbjPW+U
         L73bA6WbwT/KJAn/lPRvwTEmqp/bsTqQnTVIcIyI0HQ4HcfVWICXeyGRUxin3u4WLrRe
         ce7g==
X-Forwarded-Encrypted: i=1; AJvYcCXogOBCJL96fbXTdy5GqQ1Lmw5Wl9bY/0LuYz5SYwVIiUHpiUjzB74XEqB0QTe58T2mUAOMOzUwdhNpfXwEiYwqxmU48RY2KT5gfPui
X-Gm-Message-State: AOJu0YwVj34PHtJ2SSyxGap/M9J+hrqYrQK6yZlf3cID/MFH8uUnssON
	qRj84uue7oPJRgbEMZEy/v8mdTLEkKVEIGQSTduHhif8caqm7iUtwC3zqSG0G3U+2H7QWmPwaHU
	LBOLiTrOclBdZgqtxJAUQvhqpaZOIjLYYgPdh
X-Google-Smtp-Source: AGHT+IFnViE46hUFxNhS96CiitdKwqazrOx73uxR/QTBc21cTRvG54b6wKCZP+b0faw/yql5ruAenNvedVuUNjr8JY0=
X-Received: by 2002:a81:5c44:0:b0:60a:379d:2bb8 with SMTP id
 q65-20020a815c44000000b0060a379d2bb8mr2389589ywb.35.1711545175822; Wed, 27
 Mar 2024 06:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327131044.2c629921@canb.auug.org.au>
In-Reply-To: <20240327131044.2c629921@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Mar 2024 09:13:11 -0400
Message-ID: <CAHC9VhTOb_mR67WK6pQJRGWFcFOwuTaHPd7_V9kAfZYcYMS9pw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the selinux tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:10=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> After merging the selinux tree, today's linux-next build (i386 defconfig)
> failed like this:
>
> In file included from include/linux/kernel.h:31,
>                  from security/selinux/ss/ebitmap.c:16:
> security/selinux/ss/ebitmap.c: In function 'ebitmap_read':
> include/linux/kern_levels.h:5:25: error: format '%ld' expects argument of=
 type 'long int', but argument 3 has type 'u32' {aka 'unsigned int'} [-Werr=
or=3Dformat=3D]
>     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header =
*/
>       |                         ^~~~~~
> include/linux/printk.h:429:25: note: in definition of macro 'printk_index=
_wrap'
>   429 |                 _p_func(_fmt, ##__VA_ARGS__);                    =
       \
>       |                         ^~~~
> include/linux/printk.h:500:9: note: in expansion of macro 'printk'
>   500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~
> include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
>    11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
>       |                         ^~~~~~~~
> include/linux/printk.h:500:16: note: in expansion of macro 'KERN_ERR'
>   500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |                ^~~~~~~~
> security/selinux/ss/ebitmap.c:464:17: note: in expansion of macro 'pr_err=
'
>   464 |                 pr_err("SELinux: ebitmap: high bit %d is not equa=
l to the expected value %ld\n",
>       |                 ^~~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   0142c56682fb ("selinux: reject invalid ebitmaps")
>
> I have reverted that commit for today.

Thanks Stephen, if I don't see a fix from Christian soon I'll patch it
myself.  It should be resolved later today.

--=20
paul-moore.com

