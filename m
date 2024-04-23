Return-Path: <linux-kernel+bounces-155435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2278AEA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB47FB21846
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3413BC20;
	Tue, 23 Apr 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4M4Wkov5"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71D136E1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885321; cv=none; b=RE8uCfYJPB67XwAj4anics+D32GqUzn/QUHeo2zFhJKbzjxfBnhpULYveAvG200FAy1pB3E20CD6SDhaI9eUIZO/qVC4p7jc4CsNLb8taDyWwC2GiS7Bn9x50z6qS85YC6sf5uqr8cl6C9OdYnJHJFggwQ9YlN7AvMLwAssYj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885321; c=relaxed/simple;
	bh=0SenlblrjMqan5Pcbzcsf/FKyDn1lUZo9dEh2XP0Z9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDXManOYiMFYhx88aYhSZAJJxGNhKF/1PxLxJHkfjO1vX0hpy1tWg6j/ayWDYOoc7ciDXaDH/nfR/v4EifyckSkbds1k7ykNJBNkGS/Wr7sY40sTHO+leoL8Ntt+wz5jF9cNYe6/qF1GZJ7QDCNjLxqIMNiWVqET+WGIE5UEIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4M4Wkov5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-439b1c72676so478991cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713885318; x=1714490118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SenlblrjMqan5Pcbzcsf/FKyDn1lUZo9dEh2XP0Z9M=;
        b=4M4Wkov5iosIaAr9HxKN2h/003c0jT7Y+iLULrRPu4nm/4YQAiRaE7aJDSxx4izvyd
         zeD6nnkXPNlSKZsNO7V5YMy5CJLIuD8kpkoX8y6lEtqNBjIIo8bC9F4xjtuIiyrdq3oo
         1ohK8PDgaGetp6FN06v6MkkdwT5ximkM0o8EosKD/UxwkXvfkFWeP4FSna/bctIuRloJ
         u2bIEj09rs7AIrD9YM5wywcqbNjy2gxCVncY5eRS0BvlseTOY/B1kYp4PVMiDYBjTbX3
         L2O+NY8LnCXu0F3IEDESVL1dBa+HlZdNhlQ4uOZwmVYMa/YiFSEoQydLTR4PMAJ8m8qX
         pAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885318; x=1714490118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SenlblrjMqan5Pcbzcsf/FKyDn1lUZo9dEh2XP0Z9M=;
        b=JjMJGHOlGm8If6Y0ysdqiEq0W59vEHkgjA3SArgamZ/mC7JTxdK/jOxnWVQPgwq8LI
         77gCGkjRboN+xXkI5UIIq+3O/aS50g2dbvhdeijxVJRk/rhjn1yyapH4grJru/5ZZ/hp
         UzfdzquDCYpm0sZaLFJO1PBInnUFBf8u6J3xwfMgdx0DkDEjKnl3GPlr0saWutGIx6uU
         27VpCqzFr2efVVAybszBWSiQZCanwBfOCVINKCRTdYMrodyyczhwDPQwmiPE7ydOXGxF
         7gecoGfEJCaUySa4zGlrUKLTkLpniRkXeh1gkR2zmdqSKQ9TUs120cDEcnP5DhnoCoa4
         0J5A==
X-Forwarded-Encrypted: i=1; AJvYcCXKdWnQ+i9k3TbXarpIBhsrosnQsUX8Kcr92TcllE6qNaTg4ppKrxMivD+LDKuX/qH3z/SHgU5D+YpdfcfSvlcsB6HEVU1oQply9Yqw
X-Gm-Message-State: AOJu0YwMafc0l+YL0XO5Y7LN40Nit8EGc1s+A61Brm+r+oZR+zXV2YXl
	NW8apP0VaJt+R+KUsrAIElWVu2z/lRm3SADD5yP1LpWY8oHxZvtbbAdS+erbZanP+8cZt17CPzq
	33iG9FTOGGYGWfP6qWTIXY0tyQQ8yFNz0v41q
X-Google-Smtp-Source: AGHT+IEmDbvhgmJutRXxF3MJaFpsjAadibBlJZsxjSUIBJXhn/ms41LXrsgezlKX1Aj3ErOqxfZQYsmePxgCn9a7wgw=
X-Received: by 2002:ac8:468d:0:b0:437:b3df:9ab9 with SMTP id
 g13-20020ac8468d000000b00437b3df9ab9mr224998qto.23.1713885318312; Tue, 23 Apr
 2024 08:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com> <c1c460ed-69c3-4fde-aa9b-be1051dae6ec@linux.ibm.com>
In-Reply-To: <c1c460ed-69c3-4fde-aa9b-be1051dae6ec@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Apr 2024 08:15:02 -0700
Message-ID: <CAP-5=fVrQJiFtLeYQqkKACHo_3ez9NEadYLcqy-UKk4i5dHSqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Assume sysfs event names are always lowercase
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:53=E2=80=AFPM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> On 4/23/24 05:17, Ian Rogers wrote:
> > By assuming sysfs events are lower case, the case insensitive event
> > parsing can probe for the existence of a file rather then loading all
> > events in a directory. When the event is a json event like
> > inst_retired.any on Intel, this reduces the number of openat calls on
> > a Tigerlake laptop from 325 down to 255.
> >
>
> Ian, sorry for the late reply.
> On s390 the events in the sysfs tree are all upper case:

Yikes, sigh.. thanks for catching this :-)

> [root@a35lp67 ~]# ls -l /sys/devices/cpum_cf/events/ | head -10
> total 0
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_BLOCKED_CYCLES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_BLOCKED_FUNCTIONS
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_CYCLES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_FUNCTIONS
> -r--r--r-- 1 root root 4096 Apr 17 14:47 BCD_DFP_EXECUTION_SLOTS
> -r--r--r-- 1 root root 4096 Apr 17 14:47 CPU_CYCLES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 CRSTE_1MB_WRITES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 DCW_OFF_DRAWER
> -r--r--r-- 1 root root 4096 Apr 17 14:47 DCW_OFF_DRAWER_MEMORY
> [root@a35lp67 ~]#
>
> Same is true for all other PMUs (currently 5 and growing).
>
> Is there a branch to pull to try out the effect of your patch on s390?

Sorry not, I think everything would break anyway. I'll extend what
I've done so that event names can be lowercase or in shouty UPPERCASE.

Thanks,
Ian

> Thanks Thomas
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>

