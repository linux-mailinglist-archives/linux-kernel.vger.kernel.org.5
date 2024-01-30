Return-Path: <linux-kernel+bounces-43800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499E8418F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F93BB24D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7487B364D6;
	Tue, 30 Jan 2024 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTSzvIOd"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AAD364C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580754; cv=none; b=AYppnjvqrgFTjc9MqFr4bwrtflzEAjcLOKqDbrYoUR0ItReK6s8k1JGJG9bZvQ/ktJOODMj66BNAJ4Rqp7qoLOz3s5TY6dUP5lTI0+vkW4AFMDXygOs6QVP9lRti+MtAg3wxuRJoiSQzxu6+ubP+ksXrIgDecZOWSCPXDPwB87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580754; c=relaxed/simple;
	bh=oZNQuCd+KN+iEabO/fXy/33O6CPWq/hHiiIIZfw1y7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK5iK/09aHxWMbI4657f6B61Q7z7hfvAlmNdFWf6YPVA4XlqFPjvCF0+iEYgiYrYzOHY179BRpKFlayqthnz/mxOVY/pbPWafa6hHk1enaBEjKkmVDP8Im00OumjFI77jo1M0ny/Oz4D7iX7QUSncU2VDnqA5yiAVlqGcq1hbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTSzvIOd; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso4360745276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706580752; x=1707185552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZNQuCd+KN+iEabO/fXy/33O6CPWq/hHiiIIZfw1y7w=;
        b=eTSzvIOdCoaBGiBMzq1em/jnH+I/hhWvaboH2qNb1fXpwOHAOnhIz9973vtuMUtBYv
         doofVUQdnkiF/kbsKnDkJ4EhbHJmXFjc3c2AITu6yvjUIo/AzkY8+P1xGqfSOOKeeEyN
         hxZFxnyt5DbNAM0ffevG6kNtAl046k1sN10CvC2vAuSfyLXtd4T+2W4O7/rb6oReSPn+
         SebgyXVm3XJHhIDeUgb0YwJ2PAZ9qa4kLLg29Ve5MTLygcBa61/pHwOhXsjD92Wf45Mm
         kRGfHf9A3vaUPTSbebpF7hm4X5u0rRxP1QmZhDFPaMx1bYDdBNKtIyNb3VMty0n2/ZoG
         piUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706580752; x=1707185552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZNQuCd+KN+iEabO/fXy/33O6CPWq/hHiiIIZfw1y7w=;
        b=fsWgND0ruRqqfO8zzv1muoqtQBka0yNSG+2GTA47YZfTPXvaRJEysr1nUT+Mu79F3s
         pMWvjYElD1Ue1n5kx80aZj+dBDBnPrY+MMwqTEPdjaUkhxGzUe48OTMn5dANz5t3Cjn6
         F3mFoZEBKBgG4mjAdFBDkuI4LPGXtifGblLZz9fG1VUsUN8lOeQhz6/R7vxetH26YNxx
         6FZX7wjpb1QIKzBlkghW2bI7IHK2DRFRosBzPxkCvalQXRRSlneP2YoxhVbB2GsCGk4B
         K1aHHU4ZCCVdG0SlJdr2Thq8/65evSuclQeY9erWu9bo98fkDdkXqBuZfTEGjU9O4bH2
         yaMw==
X-Gm-Message-State: AOJu0Yz4RtYTrNuzf8xalNZ4lmxRh5W7MDNGWl3vLuG/UzBfQ7P46BvG
	lXJp5bKt2gtG99XjyCY7O77MYnmhioosBcemCpUtGK2s8A/rAR3cVcbhdHkjExuTGuYDYcjEg+C
	r6NmIVKg2oZiLy7CbAIXNuLW4Uig=
X-Google-Smtp-Source: AGHT+IH4YpNYxj/YTJJmjFy7lceiIFbPIZFioZHoUUoLFJYustUJM2yT8NHGwZL0o/WsHLV9Wd4Mfjx+GVfwnbRVfcM=
X-Received: by 2002:a25:f449:0:b0:dc6:4582:2bd with SMTP id
 p9-20020a25f449000000b00dc6458202bdmr5297622ybe.76.1706580752116; Mon, 29 Jan
 2024 18:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <ZbfSP6xt6JAE2NrH@tiehlicka>
In-Reply-To: <ZbfSP6xt6JAE2NrH@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 30 Jan 2024 10:12:19 +0800
Message-ID: <CAK1f24miiADZCpugOa4QUmerG70kOsMT97Zvmy=5ifOG4mW=+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Michal,

Thanks for taking time to review!

On some servers within our company, we deploy a
daemon responsible for monitoring and updating
local applications. Some applications prefer not to
use THP, so the daemon calls prctl to disable THP
before fork/exec. Conversely, for other applications,
the daemon calls prctl to enable THP before fork/exec.

Ideally, the daemon should invoke prctl after the fork,
but its current implementation follows the described
approach.

BR,
Lance

On Tue, Jan 30, 2024 at 12:28=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Mon 29-01-24 13:45:51, Lance Yang wrote:
> > khugepaged scans the entire address space in the
> > background for each given mm, looking for
> > opportunities to merge sequences of basic pages
> > into huge pages. However, when an mm is inserted
> > to the mm_slots list, and the MMF_DISABLE_THP flag
> > is set later, this scanning process becomes
> > unnecessary for that mm and can be skipped to avoid
> > redundant operations, especially in scenarios with
> > a large address space.
>
> Is this a real problem? I thought that the prctl is called
> on the parent before fork/exec. Or are you aware of any
> applications which do call prctl late enough that the race
> would be actually observable?
> --
> Michal Hocko
> SUSE Labs

