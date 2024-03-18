Return-Path: <linux-kernel+bounces-106405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A187EE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D727D28161E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4354BDE;
	Mon, 18 Mar 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9yINx+z"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2EA524CE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780971; cv=none; b=gG9Mzz8DSpq+wQwUME5ivFiNlsqOTO+hyNGbrJNkbkhAtfcxqM6Q4EYN0niSEVkg944+5m7xvKr1vL2tNIDWuNG3tDwluZjS26eovBLlLdJuRnaHkUndEexeqR3QT2xNmcXtHeCsgBTvbctNEdW6/v/9yvn4l+aZZ6FzqL/R7PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780971; c=relaxed/simple;
	bh=93T3v7zdQM8LwuRZeaBuS6bF9LV3COVtnygXdjEHoF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQfKAvwQbD3Ic5Db9bUaMW/OnzT0UYIua2TiiymhlECbhjITWUqTOA8VJNB1ADmamRoWY8ltbezxj1Go+85B9cDri/ne1A0C7fLutr1sjRnsGndkgBxSZl1yABZIiivV/dZ/X8wUh+eXDt937g7FOgXGCzK69eqsLtSj5nwhMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P9yINx+z; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430c41f3f89so14184271cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710780968; x=1711385768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo3Mf28h0hvfULFUHkEEElY4QAOQtb2yRCXqjQBuiPc=;
        b=P9yINx+z7d9BWSRPC54mGfprqYXWW2tjgH+MpxojYce7BCWI0FTVLsDggyJPAt25gS
         XbUAK+qYjyjMFCDG9oP80PlFJv8LkfMmzWy3azgJGRkTDSRImdEwjvR+PVMW8tCcolSH
         yMS760Th24f1ywfJC62zxccSkUP0iKigshvLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780968; x=1711385768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo3Mf28h0hvfULFUHkEEElY4QAOQtb2yRCXqjQBuiPc=;
        b=BsemXUdDotwryHIzfdJaBFCdzm/nJryzBHBB8j29bG3VHozvYHrpenCvswqA1jhOET
         LuyTqov9L0T/YS/zR2IhFAXJTluSPQeJ+KQQkqi0KivAP+5P760GjjNd2TG8v8IvOf7v
         IAdDqufuGuwADajgOPcNRWeL2IpHWzHXNA+TKNVAi8HzdaOhESl6ODE2Q3uizx78iGH5
         GY3BaZy3nxrfcEOXZKxWBbjtytyb/8bUcmH60PfWlovqQFREbXztm2tPHvX5HKdIJQw5
         Xh7OySjjC5+pI00UFxSY0PgxFfK3UJOVCD6trCOa5up9UdBkcUGllOFd11Z7/qNINfnQ
         JU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXNm5SfuvW7ax+EgXmlWmAQgZuJQbWyg2lfPIpUxyqQIVRa8oL+Lj0rYoQm8vyzKBQr1Fa0913LenfL3c5ud6neaYFOddkEOj8r21kj
X-Gm-Message-State: AOJu0Yy+j0UbOKecrvGlPpafhFQcd3e9USonXFRbgdeoTJN14E1ajMeQ
	YH+QoZa7oD6Gh8+OdfyivR+eNAHtMS2zpr4yrdP2w6JxHLCfkbBPxOtkonKsyGzpJ1/WUGcFiPI
	=
X-Google-Smtp-Source: AGHT+IESni4IVMfOiL5tegk4cZ1r9WfSGUFOmHNHVJXASmUnF7E3nnjjQ9gtSXsDT1qv8TvA7acBEw==
X-Received: by 2002:ac8:424c:0:b0:430:c2dc:a5e2 with SMTP id r12-20020ac8424c000000b00430c2dca5e2mr259859qtm.25.1710780968440;
        Mon, 18 Mar 2024 09:56:08 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id fb19-20020a05622a481300b004309cf16815sm1431556qtb.39.2024.03.18.09.56.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 09:56:05 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-428405a0205so546491cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:56:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpWKoOSc7QZuPG8RNPTrbQ2hTUIIugcz97L79rriXlBRTS3QpaQ8H1lXHxtheD+dglK9fWay1nTXvsPfoWEmALHrlPvW6oyAaskz5g
X-Received: by 2002:ac8:570a:0:b0:430:a827:cdef with SMTP id
 10-20020ac8570a000000b00430a827cdefmr117qtw.23.1710780962829; Mon, 18 Mar
 2024 09:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315091434.10622-1-dmitrii.bundin.a@gmail.com>
 <CAADnVQ+o9WQNdY2iApYMN=KnKSxnKGb6NcYzYkDD9V36Di6bCw@mail.gmail.com> <CANXV_XwaPOOYuAsveVbfNU4tFbw30rkX3AKrBdKzrNNsUxer+Q@mail.gmail.com>
In-Reply-To: <CANXV_XwaPOOYuAsveVbfNU4tFbw30rkX3AKrBdKzrNNsUxer+Q@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Mon, 18 Mar 2024 09:55:49 -0700
X-Gmail-Original-Message-ID: <CACGdZYLn5pokOQN-uqeaVPSOtVUHy+CGmuBduhgtV+Vft8WxbQ@mail.gmail.com>
Message-ID: <CACGdZYLn5pokOQN-uqeaVPSOtVUHy+CGmuBduhgtV+Vft8WxbQ@mail.gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: Include linux/types.h
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 10:09=E2=80=AFAM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> On Fri, Mar 15, 2024 at 6:41=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > No one reported this, though lots of people
I'm also seeing this, on clang.

> > are building resolve_btfids that uses this header
> > as part of the kernel build.
>
> GCC version 7.5.0, GNU Make 4.1
> Steps to reproduce:
> 1. Check out the commit e5eb28f6d1afebed4bb7d740a797d0390bd3a357
> 2. cd tools/bpf/resolve_btfids/
> 3. make
>
> The steps above produces the following error messages (similar error
> output truncated for clarity):
>
> In file included from main.c:73:0:
> /linux/tools/include/linux/btf_ids.h:7:2: error: unknown type name =E2=80=
=98u32=E2=80=99
>   u32 cnt;
yup, that's the error I'm seeing.
>   ^~~
>
> The other sources including <linux/btf_ids.h> usually includes
> (directly or indirectly) <linux/types.h> before which is not the case
> for tools/bpf/resolve_btfids/main.c. So that looks reasonable to me to
> bring all the required type definitions into scope explicitly in
> linux/btf_ids.h. Any thoughts on this?
>

