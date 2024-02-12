Return-Path: <linux-kernel+bounces-62519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02796852247
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EB61F2320A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0384F1E0;
	Mon, 12 Feb 2024 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2YqIc6C"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B148795
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779186; cv=none; b=Xi7y4PCxLnkMb9c21ITPxFB2REc685ah+msFH5wNXW3wiBqipSkQ98lHiT1kSzSpKodYOc9l/IdhPeRnHYPMDoS4oOGIjl0HT4ZZN3B6CtHVeBSKwdrreXuavjg9TG3u8hDKnyzES54kPRKaF1WDj3Ui9aLOZCx6Dyk47XAv7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779186; c=relaxed/simple;
	bh=xyJS4yDPKZrA2HdoXcsXz6GNBDwVIVv4GWpRJK3vmJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6g3+1z7gZlajbFsUliHIu0bIuEPJFo1hFJIuyOvHmy4yOmOUaM1bL8xjwG/9O8zb63U21bSkKpQNA18lgsnRlqOjDNwYnFVAmXR5up5YEB+1TdE1+C1Hf0p7a996Syu/xXu+XfnFXW2vUrUNl9cvjRKED+xuKR0PkOAO5FFFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2YqIc6C; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so48701cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707779183; x=1708383983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8bSh9OQLoWAq/ajMiSXj5T+yruvi0AGogBnnOcqqrA=;
        b=L2YqIc6C/WIr3CLYw6RHdVTKxFWpAdgxNyvGqylmjugvhGeqv+z7T9HvcBNa7g+SMu
         2UQK4w7WDejjXhNYihqC4sX0RPCYPihkGS9NWTB2xomwZUYZkM5K04TOU9tKn0EofKcv
         qYo/hU9U6hZlElgiowc6hJTfajvWfQ0bVRR8FEN907frjuaL+b95mOg1KOy2Cz/Q/5ft
         f1CMKJ59Vf/MDOjypsUu4m9L7wO0+XopbAgTptKeS5S+2pTnOdnNqZggFIOJdyB+JUve
         PiLNzSR4CCYDT6lFJ67X9jZKbqFkx7CnX2vgeuLdBvbHqAUCguvyHTg04bLl26nj2PRU
         RaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707779183; x=1708383983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8bSh9OQLoWAq/ajMiSXj5T+yruvi0AGogBnnOcqqrA=;
        b=HeO9VpBUhqnmZpK3+xYh8ycf3XNyY2eQAM4dYOKFfK8D3/tTdHqM2iyv0q95EIcUWM
         Inossvj26/qTI29su78GDC6f1oaO/TbXfhXnpftVNM+6a2soQ48zFH+9BsTAxA4NaP+5
         re6E4MyddO71qb+JRqaL/oIo4lM+IJhp3xqVtt7Ts5j4siqGzKTbkGmNnaU2ZwW1Ejjw
         B77Zm2LgR/JFIKtTbdPh80NasE3Jy34g9U7TjwDxeuEo9/tB8hbgU3Ucdeavt9wSTL9A
         15sBa4z/rZBObSx2GcFft+vuyBrpiwh+ZZ53+7VCS5Db7L4ILkzo0qiUnE/95w3VjM5G
         6kdg==
X-Gm-Message-State: AOJu0YxzDzYNqxMzZrtnjNn97ycwPLda7EGJuabPS/U5qm0HXHa1idLp
	cMNgemaQgYiLP/kVBnWb8/tWJF37iehPen7X2uSZQHYftiaW7pj2XjSNdahL0hErnF2Dacwhm05
	lA85XtdmcsnL+B8IwLa5xnSjQDVygJHubt3x0yF2gWAtfC34StQ==
X-Google-Smtp-Source: AGHT+IGLwPGjPlcidiwBmZE3kuLoR8uVLPyIRXUTeScX5Zmv0+siKRJVA8fBuiJgIKgOYS2Z5jzRoW/X6p9fOVKX7Zo=
X-Received: by 2002:ac8:1386:0:b0:42c:7de1:c96b with SMTP id
 h6-20020ac81386000000b0042c7de1c96bmr46715qtj.24.1707779182851; Mon, 12 Feb
 2024 15:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210231513.111117-1-saravanak@google.com> <170777778090.2688977.14804637560473102697.robh@kernel.org>
In-Reply-To: <170777778090.2688977.14804637560473102697.robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 12 Feb 2024 15:05:45 -0800
Message-ID: <CAGETcx9Aw8-Phc0MpNkRz6rGmvCzwBSxJgBahNQCUg-BBdNHzQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: of: Add Saravana Kannan
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:43=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Sat, 10 Feb 2024 15:15:12 -0800, Saravana Kannan wrote:
> > Adding myself as a second maintainer for Open Firmware and Device Tree
> > to help Rob out with reviews and other maintainer work.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > Discussed this with Rob.
> >
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Applied, thanks!

Thanks!

-Saravana

