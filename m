Return-Path: <linux-kernel+bounces-163265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6578B67F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39011C21F70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1912E63;
	Tue, 30 Apr 2024 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpaY8+TR"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728711190;
	Tue, 30 Apr 2024 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443806; cv=none; b=QcRtCvqNBJcet4MjwLQX/ZkerE4mhUL10D2Ytyqd+EWdY/AtekQVYtk0S9cs0JCKT3XQmxTIMOIh8g3ZoPQJIjuGzRdS8C6vbbgDmMQvA7C5207QScKy/9WA1UmQgvRiZ80TR49njz/r15eVL4LMrNcwDphyTTzYJPCyf3j1FXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443806; c=relaxed/simple;
	bh=IGgBq596yQ7Q4K8UjESZlYJ3xeery+nimuhJdjUq5cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFcCkV6RDgcCbk84KlJwlCj/HFTEBWALFwPfcklBEYM/iSDFVaBteJ6oMU9p/zm9hHRenGpSahNUe6+9gJN0qVg83wBrHz/P3lxSbdVtaDUbVlm32OQhgv9IKEVvIk+1liYZ9jtPnGmsaI64tpLCmxdYVDsE2fEMMdxtx4u8sGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpaY8+TR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516ef30b16eso5826487e87.3;
        Mon, 29 Apr 2024 19:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714443803; x=1715048603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrpVJHZ8Iq8en4huIRdH0o4wDX9FlC3Tn/A190bnRyQ=;
        b=QpaY8+TR627nusuKCZOza8kJe9ActU+i7D0dLYUyxFzu424BXMhlWWRUn7EUWndjX3
         Xbh9ai1o4wSBya+DVke+JBcTc9f/DzAIqtu0pzGE1EikBSKYFt/x7giicD4rYI5tACaj
         AztjEH8/MtfNcBgNhciaB0rskqsdVxCPcOIEv44UPKbgttyZlyhbceIIznswHxsHsYg/
         Ym1JJppdD3wYAVjEcwmZuo+pb5ovY91JHzNEJ0N2/F8pWAudpnRnhoU/kOTw+pQq9p1O
         a44RPXjlvXTbnA3VyDejEmdrps6Xz+c5q8P7p0qHy31d28tgTP1AQnENy1tPgSRBl7o/
         Lleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714443803; x=1715048603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrpVJHZ8Iq8en4huIRdH0o4wDX9FlC3Tn/A190bnRyQ=;
        b=JcRs6VwnfFhCSNmH6fTpQiwNF/XGCrDf6GS9ut53TuvpbPYm6hXEOtTQIaXIz1GROt
         4pKpTMtrTu/F4I+gLZSc9wennFtcEkvkpMI490dlF1RSNTqgTo6XoU/OHxxGye1J/rSt
         zcz7mE9h6ijzAfvH9HpiaGRWsnA7ng4H6lTGSIBePO9ol2wehFWj/gX7eKoCQRQqnLQo
         rv3mPxMnrOEduKw2md/COuSuTkrLQgZGZQAaKOkkO1P7fi6+zwVTsl/X1qg43HE6T3V8
         dt6FgUh9fYz7+Jic9uNG0+Pv7JCuRJm6dvXJ9k6ih03iDRxJ6oR1K7XgwTTjwyMlBtFF
         8djA==
X-Forwarded-Encrypted: i=1; AJvYcCVtX3n31zR0Rkra2hvZxBP8CjYM1ccD3itRL5ZOI9/JlDLfF//VIDtOFVmZhRHQenYxucSb4YLQCPXcZ0re0i8QnUscw0mnzFERvrkMm/JA5y7edt49J6BKzIw0zcTmW3vlHUYkQ5c0kQ==
X-Gm-Message-State: AOJu0Yyg+DW3pDaMcY0Jzy99qKhMa6nnC0LWTK//yUhwknjhHFe5ihPH
	7pcyaMJ+k+0nWIdWw+rstvBwLv04GzT0abgMpj7cy2iEuUOryZt4O3XrlCRo6M+fnwN2cGeiFPr
	rWDWk0djqK9i1lDdTjhhkvYPwhDlStqXBT1o=
X-Google-Smtp-Source: AGHT+IGd6efVEEtLRktL3PACpD8/1HoWemIMz1xtx8j5E37oHppml3AMHxtdp1dT/cs8AhMU4HpGM+2Tsh1ClaGOnb4=
X-Received: by 2002:a2e:8813:0:b0:2d8:4158:fa64 with SMTP id
 x19-20020a2e8813000000b002d84158fa64mr951636ljh.35.1714443802500; Mon, 29 Apr
 2024 19:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103811.6e313ce0@canb.auug.org.au>
In-Reply-To: <20240430103811.6e313ce0@canb.auug.org.au>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Apr 2024 10:23:11 +0800
Message-ID: <CAK1f24nPG0N9h=8zV4xM7xzkrig_McHdFxNbbWf0VOfw4QuOcA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Stephen,

Thanks a lot for reporting!

I'll fix this bug in the next version.

Best,
Lance Yang

On Tue, Apr 30, 2024 at 8:38=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the mm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> In file included from <command-line>:
> mm/rmap.c: In function 'try_to_unmap_one':
> include/linux/compiler_types.h:460:45: error: call to '__compiletime_asse=
rt_344' declared with attribute error: BUILD_BUG failed
>   460 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:441:25: note: in definition of macro '__co=
mpiletime_assert'
>   441 |                         prefix ## suffix();                      =
       \
>       |                         ^~~~~~
> include/linux/compiler_types.h:460:9: note: in expansion of macro '_compi=
letime_assert'
>   460 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime=
_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_O=
N_MSG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> include/linux/huge_mm.h:99:28: note: in expansion of macro 'BUILD_BUG'
>    99 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>       |                            ^~~~~~~~~
> include/linux/huge_mm.h:106:35: note: in expansion of macro 'HPAGE_PMD_SH=
IFT'
>   106 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
>       |                                   ^~~~~~~~~~~~~~~
> include/linux/huge_mm.h:105:28: note: in expansion of macro 'HPAGE_PMD_SI=
ZE'
>   105 | #define HPAGE_PMD_MASK  (~(HPAGE_PMD_SIZE - 1))
>       |                            ^~~~~~~~~~~~~~
> mm/rmap.c:1651:41: note: in expansion of macro 'HPAGE_PMD_MASK'
>  1651 |                 range.start =3D address & HPAGE_PMD_MASK;
>       |                                         ^~~~~~~~~~~~~~
>
> Caused by commit
>
>   34d66beb14bd ("mm/rmap: integrate PMD-mapped folio splitting into pagew=
alk loop")
>
> from the mm-unstable branch of the mm tree.
>
> I have reverted that commit and the following one for today.
>
> --
> Cheers,
> Stephen Rothwell

