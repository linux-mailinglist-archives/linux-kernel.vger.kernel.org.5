Return-Path: <linux-kernel+bounces-127473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EE894C35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01010284010
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A05383A4;
	Tue,  2 Apr 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DG31QAiS"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F33BB21
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041752; cv=none; b=DRG4+EQInljyRK5BI0IqrM+rqhKzNw/OhE+QEI8Bs2sOQOlXC/MCjg4ojQBOue5k+02ocqLa4dg919nMyPluC6SPQ+Xwh9ZoMWXEgSrBSafY/RAIrdvNLL5pvk+8KLgbMREfGEmUrij4YaeoPvrNtLsjOQpdQwO3tev51A1v+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041752; c=relaxed/simple;
	bh=haQJ60gcyfzT0PPIcpufheaE0XM4vQtB9WG6Oc5rEk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH6/kZ7rhfkFsbLClhS/bX6oPsdLFwR1zi0qt9Ao6WucCjUCAc4T/TOOW1bqJxCP5tqipawr/6gZ06cTIhfvLNM0MP+PYxL7pBqxw1nhp6nb2Voa7RZoVijTCOpOZOeAqfNIXdxpNv7mdWmf8ZJHIKZE/fBOB03kDCPgAYNepUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DG31QAiS; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4766e56ccccso1852214137.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 00:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712041749; x=1712646549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haQJ60gcyfzT0PPIcpufheaE0XM4vQtB9WG6Oc5rEk0=;
        b=DG31QAiSMDm4KKa5gtnuNa5UgLI8j9aONn9lASmmMdL54yphYTVtvVzvmUhgwMrxy4
         tROlerAHCBNw0RPMVtLy+QtPE8OpKgvh+4j4XErf4O8q9Cvp1q29v/Fxee7oAJMlB07D
         kHXeKCNbwFQs1yspIXFJIhSwiVJltclKlF9nlT0yI+rdaJu/VleOVzrANh9zgOt5v9xV
         8lYb0h7MqpJBNRwXf2xFU/gmxbRGGInzkikDoUJzese0k47PRL0SpzP82391f/91+GKj
         eAbZgNqvF7bSPsviuXenecw+1i9ykTVsGVyb8a5QNtA73Eslx8936K1OIZ3ZdfpdeYs5
         4OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712041749; x=1712646549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haQJ60gcyfzT0PPIcpufheaE0XM4vQtB9WG6Oc5rEk0=;
        b=bsxQDYBIB6uEIi2YExs4U+UDQSnYtt1kqG+tYnxKl0Rga8h79ZTXr0cM/npRYosGpd
         TsykVayg4MsHa2sOjI65dehmHY+5IDwvZbUrzIcu8zP8G6eVGScL1fHUFy2MEolCjkMu
         I18OIYYWA35+MwdP8QoVdtC/o/Sv+9DzFIUk8MT/yQHr064Ym2nYlhPX3besFIOMhfxo
         wB/9rO8u5Ez8xL40Ls/X+lB1aM/aEjzS68JDEfyl6d2mJOuPCKWTQVkBxJE0jmIa4PHC
         Qj72W8QJmfQ81mP9I6MDA+c4mUWIn3DjLg4mdYe5JQOJJNEfRfELvlY15Rrchbb2Qw2G
         QROg==
X-Forwarded-Encrypted: i=1; AJvYcCUF+r6P1W4tslwj81FPgLZliApLpUknlHCKs+Z7fgO/HIF1uBnU8/1WITVDVyCpTmaA1jk5qopGdwtE54vYaK7SSwAhu02KPOUUrtpC
X-Gm-Message-State: AOJu0YxPoNosZZePHJIGKJcv1g2McwsjmyMERXYHwLS200apHwWyAT2u
	2oxTiSuNLXHJCB71TssT+Hf2x+fSAe+7M8Th12TmTvtqRFezB0//QEvZHIclRXqPqDsAKpaTy3/
	3CCFRA8/XoPqLS8l7DYq9i0SsZfWc+TTaFJRH
X-Google-Smtp-Source: AGHT+IE2XWNUQP5fyiz0lDixSxBA7dWCXgQaoBsbs3BFpiwhXmOCEUELRrpL2YEHmRxtWGfATq8KbUE+fHeXzNF/yC0=
X-Received: by 2002:a05:6102:4a11:b0:478:52cc:fc42 with SMTP id
 jw17-20020a0561024a1100b0047852ccfc42mr9301382vsb.10.1712041748682; Tue, 02
 Apr 2024 00:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402001500.53533-1-pcc@google.com> <b939165e-a227-4b96-bdc8-12afba801c03@suse.cz>
 <CAG_fn=XL7tSuCuBXKf1YDiETkFMte7JyLrSE+saDthtJj==hUQ@mail.gmail.com>
In-Reply-To: <CAG_fn=XL7tSuCuBXKf1YDiETkFMte7JyLrSE+saDthtJj==hUQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 2 Apr 2024 09:08:29 +0200
Message-ID: <CANpmjNOonPXC9JzMJ2spmTU+80pYJJzW90omy2pvF7=0qNJU3Q@mail.gmail.com>
Subject: Re: [PATCH] stackdepot: Rename pool_index to pool_index_plus_1
To: Alexander Potapenko <glider@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Peter Collingbourne <pcc@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 at 09:04, Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Apr 2, 2024 at 8:54=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> >
> > On 4/2/24 2:14 AM, Peter Collingbourne wrote:
> > > Commit 3ee34eabac2a ("lib/stackdepot: fix first entry having a
> > > 0-handle") changed the meaning of the pool_index field to mean "the
> > > pool index plus 1". This made the code accessing this field less
> > > self-documenting, as well as causing debuggers such as drgn to not
> > > be able to easily remain compatible with both old and new kernels,
> > > because they typically do that by testing for presence of the new
> > > field. Because stackdepot is a debugging tool, we should make sure
> > > that it is debugger friendly. Therefore, give the field a different
> > > name to improve readability as well as enabling debugger backwards
> > > compatibility.
> > >
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/Ib3e70c36c1d230dd0a118=
dc22649b33e768b9f88
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Alexander Potapenko <glider@google.com>

Acked-by: Marco Elver <elver@google.com>

