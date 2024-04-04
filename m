Return-Path: <linux-kernel+bounces-131518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8158988F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874E2281FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253512838B;
	Thu,  4 Apr 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhqP0hek"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F19086630
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237989; cv=none; b=JLQOxMvFPGRM5QlMJDv6Huuddzv06DKygt5gOmPAw6VNcycSHriXiXSHP1QuDvoRSS29u0c16/QptyQb8mqAMDYEN6SHASqyAHKUeXZUkqP2dDvrJIp9QQgH0l5j3SMLro+iIU0UDB328T+2hOVTBhO+HinDmhILPde+fcsRPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237989; c=relaxed/simple;
	bh=iYftZ0+LaPHkXuNAZXjn3s5QsFloR9tJTymonE9sXXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hg4ZlJsme6XEnlIJJgtnOj8Fjnf/IwgWiDeqpUTGmH0oSKUEeuA8X0qKREjjxbIaKVhZ9Fw9E/FM/ffEwTpXZTselqDS+V2jG3Ei1FX5+eA895tdw7JZM9RgnJrxxHwUn/iCwsktu1aQlqUI9A511cjAfM8/PcSlyiNTbUKlyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UhqP0hek; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516c3e0e8d7so2655e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712237986; x=1712842786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gxf/q8h91wmoUfIFbo/DD5ZINeNSkiIb7XwE7dW0D3U=;
        b=UhqP0hek6RwkawX9aIu/e37M+UcewsMlPLaELM3CC2eHTKJ2VQ0V97L1KSO+LqBwTb
         T9rhU6Jqch8/gcUMM1PNs/dJEYznvDMxAMH9V7KVWuE1EBY1qqTgLfV7iyy9puAOdr2o
         l83DLuK+3WATOh7bxUVLnVW0cAyr0t6PFP5NOue6fiByp+HPLCAPdd+FJiyWnUiE5QZY
         VvhyUWAwuLjuFgS3Zgef2UBECgJxVPfgfLivH4CXPbNqKloBFy34Zw23HN0KONtItnli
         TiyEgJ7kMOv3KyGRC2xKSLKoZLm5sMjFtunpIiyDkdvfsJqt0hfzP14NRF2rRRD9mpMS
         oKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237986; x=1712842786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gxf/q8h91wmoUfIFbo/DD5ZINeNSkiIb7XwE7dW0D3U=;
        b=qoOsdnrB7UOTqHxYZyJTkcCB8fAjbYkz8EpT41Num5LS3QWAzpCQ8WGGgj5tpVfhjd
         wFeUZ8t/HHNjSYXPGa7SSTMPObH9aWae2sbdHAVqUUGsQW6THBBTi3CwgcjctecUqrPV
         SvRk8cfunr2Z6P7wc19HwF8/2UdGL7jOf8BHb0XrTQxkJfqwrwW23struriTGmZqVYuJ
         WDoO2K+36b7toVEf0ZS/KnxuPV6qJiYPmlyvwuChsYFDlFtvlr9MgBEiobLzAhAyVqMC
         S3wOxl1IAHNhoTBi/56z1huBFi47rFCrLt3KZg145P4k/DyiiCvh8iORb1PbKsfkcXjc
         oCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCHN7tFvEjCyWcbaxpjM3m+bpBxasxqGlJ3Et+eiNr5GH9+ou0kg5zkWfyhWSy6DNhRzM6W3+2dWLlQENH3KyG7lV+HYon7DAg84Mq
X-Gm-Message-State: AOJu0Yxeu2u5X00U1/MW4dXtjE7gjzQrJqMOGf9voM1L5bwtdiHRFe9y
	lCB3usD7d7MdQkun47Li2ywjrSXaNK48CA5u7hPOe/nrEz/DbdlwrihVE+b758vzWqJ0mzwpMi6
	HTwoUD/2S0mgUBgxw0s9EhNUzDoFpiMBka3np
X-Google-Smtp-Source: AGHT+IElGgGjrp6smPidvhQnabJPU523EKuFysRr6L+HxagQCbtXvtU6HkkMq6zk6+k9bk8gS2Z2FjLv1dPU/IQLrhQ=
X-Received: by 2002:a19:9108:0:b0:515:c2ad:6cac with SMTP id
 t8-20020a199108000000b00515c2ad6cacmr54444lfd.7.1712237985332; Thu, 04 Apr
 2024 06:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326151909.440275-1-kyletso@google.com> <2024040417-ice-decal-b37e@gregkh>
In-Reply-To: <2024040417-ice-decal-b37e@gregkh>
From: Kyle Tso <kyletso@google.com>
Date: Thu, 4 Apr 2024 21:39:28 +0800
Message-ID: <CAGZ6i=28pf2DARJ_23Bmtx4W8LEb2f_rW_Y9ziyi85txkajvGw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Correct the PDO counting in pd_set
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, badhri@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:22=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Mar 26, 2024 at 11:19:09PM +0800, Kyle Tso wrote:
> > Off-by-one errors happen because nr_snk_pdo and nr_src_pdo are
> > incorrectly added one. The index of the loop is equal to the number of
> > PDOs to be updated when leaving the loop and it doesn't need to be adde=
d
> > one.
> >
> > When doing the power negotiation, TCPM relies on the "nr_snk_pdo" as
> > the size of the local sink PDO array to match the Source capabilities
> > of the partner port. If the off-by-one overflow occurs, a wrong RDO
> > might be sent and unexpected power transfer might happen such as over
> > voltage or over current (than expected).
> >
> > "nr_src_pdo" is used to set the Rp level when the port is in Source
> > role. It is also the array size of the local Source capabilities when
> > filling up the buffer which will be sent as the Source PDOs (such as
> > in Power Negotiation). If the off-by-one overflow occurs, a wrong Rp
> > level might be set and wrong Source PDOs will be sent to the partner
> > port. This could potentially cause over current or port resets.
> >
> > Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> > v1 -> v2:
> > - update the commit message (adding the problems this patch solves)
> >
> >  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> This fails to apply to my usb-linus branch :(
>
> Can you rebase and resend?
>
> thanks,
>
> greg k-h

Just sent v3

