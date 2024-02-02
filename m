Return-Path: <linux-kernel+bounces-49916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC484715C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A391F24F43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609046B9F;
	Fri,  2 Feb 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSQUCLkO"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96E1FCA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881622; cv=none; b=Fg/s96+vME491sUt0RL/jgMLqf+BjSr0xsHBrvUL8aCGrBelIPuxfXV8qXZWkdlytwvXTVfma0EUWEG1jTISP3oDUPHWZKRh3wCPU/Fo4fE6okKQL806hADUTd41xwPUWMiQqHduemfwg0Ezkc2uGJjGPCM/zceNjHmkjteyOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881622; c=relaxed/simple;
	bh=o1y5HKtPqsFZrIHkvUvd/hYmvD5sU0rdmW57LkYYBH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+L20cr84VOvpPCSEkrFF7J1pKkpsR7qylyD+nFiQiyajTObBCpJtXAlUjU71Btw3+t/nd5G2CoH6YNYMBBpHYI+ZzCj3sNVf7PqM2JsRsn2OUf+hjBi/XFRrsdSDvLhKTyMQTzR1zsEVy+kcwbQAV9CLovif3VTb8YhDwS7Uto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSQUCLkO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso1774416276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706881619; x=1707486419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1y5HKtPqsFZrIHkvUvd/hYmvD5sU0rdmW57LkYYBH8=;
        b=VSQUCLkOIeBVFs6vhAbK4VoUgp1I9yVZnPMV/uvgePmniq9P/Tbf3aPnayB4hP6B+r
         D9GhA0YZ5w6QfY39aZltJeL5e7zcGMuPCgRku4tB7oANIgFDYVOlwwV7nPR2bjoZYw2P
         X/DGReYQoxAWGtYEnN9U/3ML7bG3zQJ9ZLWAyr1toYyETOokjoHN7Apl2nYMcT+VIUOf
         bPdaRVDPmTL6dgFjp3rn4hY499FlB27h+yD8T1SGlSuOC7XbhxZcbiabbwHFxmolXs+F
         kol/FCOWcZO6GUTHjjnO8A3mhEYw58SfK7xrGv7xaHtPSfNB6ENn5q9Ax5UBA8VXY6tO
         MAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706881619; x=1707486419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1y5HKtPqsFZrIHkvUvd/hYmvD5sU0rdmW57LkYYBH8=;
        b=E+g1s4/SRlftavyfexXRMGUEe50HIoQ3M04Akd4UbSqcctqLhd1R24MXhHCHCk8C4L
         wDZGg6i153J6eTGQKk5TkfyBWLY9uDydGmC1qkxBBW7dlZYL8aF/Z/R9b2YzYVhTZuud
         Zt2mb0rJhyH1cGlH4HotylIR8sIOG+lY57ikl92hvm30XOFVU+e03Db/Aa2Eu6djijpp
         fUmYN0FPY7rqcZnwFB1fyB0XJfSZPAwrq6i3/McjDcpsKGIF6pK+JPlp9NrsCXIhVTlJ
         tiNMOPvZREtAAzJ7UdTbti4RsRUpfXN6CrFcSooYKRRXNvgHPR5YfGCefJ8weVIX5a4H
         x8iw==
X-Gm-Message-State: AOJu0YwSDJmmAyO/HMTB+dfMeF0YGemp6YG+LcaxStKxqJEckKPqloKH
	J2GZADJZhb54OlcigZjripAwg+6uXV+Qsad3jPuzOPDLQRDHmvUhVhKxsnhaBZKF4NGgFnxrHv6
	G0yybSQuzI1Qa8JMdMEFIJQ6ntIM=
X-Google-Smtp-Source: AGHT+IEIAljnNwy7iRLrPwGbFDdOqoBDMZL/eLzmiiVSynaXLx28wc8lVJ5yULdyIYXoXsb93ZwHcFyEamusv2aJUxA=
X-Received: by 2002:a25:8701:0:b0:dc6:a128:55a6 with SMTP id
 a1-20020a258701000000b00dc6a12855a6mr2251493ybl.46.1706881619461; Fri, 02 Feb
 2024 05:46:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka> <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka>
In-Reply-To: <ZbzmvwyTGeW18nJy@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 2 Feb 2024 21:46:45 +0800
Message-ID: <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is a part from the man page explaining
the MADV_FREE semantics:

The kernel can thus free thesepages, but the
freeing could be delayed until memory pressure
occurs. For each of the pages that has been
marked to be freed but has not yet been freed,
the free operation will be canceled if the caller
writes into the page. If there is no subsequent
write, the kernel can free the pages at any time.

IIUC, if there is no subsequent write, lazyfree
pages will eventually be reclaimed. khugepaged
treats lazyfree pages the same as pte_none,
avoiding copying them to the new huge page
during collapse. It seems that lazyfree pages
are reclaimed before khugepaged collapses them.
This aligns with user expectations.

However, IMO, if the content of MADV_FREE pages
remains valid during collapse, then khugepaged
treating lazyfree pages the same as pte_none
might not be suitable.

Thanks,
Lance

On Fri, Feb 2, 2024 at 8:57=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Fri 02-02-24 20:52:48, Lance Yang wrote:
> > On Fri, Feb 2, 2024 at 8:27=E2=80=AFPM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Fri 02-02-24 19:18:31, Lance Yang wrote:
> > > > IMO, since it's treated the same as pte_none,
> > > > perhaps lazyfree pages shouldn't be copied to
> > > > the new huge page.
> > >
> > > Why? The content of MADV_FREE page is valid until it is reclaimed.
> >
> > IMO, if MADV_FREE pages are considered valid until
> > reclaimed, treating them the same as pte_none might
> > pose a conflict.
>
> What kind of conflict?
> --
> Michal Hocko
> SUSE Labs

