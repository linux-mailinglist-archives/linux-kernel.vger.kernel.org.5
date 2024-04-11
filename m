Return-Path: <linux-kernel+bounces-141676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1078A21E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923681F2505E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E747A60;
	Thu, 11 Apr 2024 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4tF4/mR"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441647A40
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875463; cv=none; b=FYnaCKVIZMXVgH4j+nl0SOlb0ps1afrM4b8ZmlmUi5rl8MXoZZHDpiQiXuWwebYfJ15gYMF8V/YX9Ga18QQ3HfX+8FHL4j7E4nTGsUQlNAiTzHAQHDsI3CpD7MBKYuVvKlrSpLupdreHeXf3qrN6VDNm2sWY0PxTrpJgeoGPY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875463; c=relaxed/simple;
	bh=ilRQZBQS3smaJaaasOsAmTKipdP3RLPWslWfu7o2kgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNEtgm1ylTrX3cdaL1XNkqEwO59fKDBn4+msUeQgdQUAh9iDleVmHfFFgufIWiQR9Zjz9X8p9q7HRSRGezZFhO/VihBiQsewiH25U/oBZCBRLIU+oIGOvHcNHXv5dtfVa8YpsbCFeXdgAKqHXWOh898LGEQ5P95izPGrzQs/xD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4tF4/mR; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36aff988d73so19655ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712875461; x=1713480261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilRQZBQS3smaJaaasOsAmTKipdP3RLPWslWfu7o2kgk=;
        b=v4tF4/mRN+bqL5TVG3CtqTCHGKH0k2z3QR1dnk7W4GkxgmmIA4wx878M15RGZzbbXP
         CwLAkcPP0YB8SEH7LQ5ULVoCfTlSdpnMbZvU3Lv9KiwYRH/KBhnLCyoz5HP2j+uZDQ47
         XjJTmB0gv40Ju4xV+CrFAj1HR2nCjkN7yFWW4bzCXZeMijR4FIg9Bandeopbw3GZfVcY
         F7NXTUpHv4/JF4vALXIEgBL7ibx9EbVolCYLZCSsK0Sf/v1RWbnT7V3W1FP+GrzbMCpg
         McxqPi9VXMipyZxssmojSOvsdQ6sMGtmlWRskIYLNO0SrjNSc7R7ewggHS762q3gxgx3
         o6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712875461; x=1713480261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilRQZBQS3smaJaaasOsAmTKipdP3RLPWslWfu7o2kgk=;
        b=wQJgyRhkNgD3ijDRdcekkREZHxPdWl3VM7MSZKFMhrE/Qxg2taxu+2VomfVuouCrO4
         Aah2qI478ptyW5T5+vnXOiwrFgLMCka24EV9G3HYH36+URYdkg9dKy+MyAfzxfzJTW/u
         UV1DlxO+/U62vUvHTlnFDlFWRVDYX7ZLg98r8n1HY0TCtRr94MRmGIyocPcqT6xMUGhJ
         qDyAODT5TlfPGqIsdInY2B8ivRJu9AYxTMT7xM0Jlcfck1yOlzUokaqdUyrzSEavDF8f
         ZM3yIUq5FcXoZvdbZCM3lnXRB8ORHK6F7hHmWDu8Pb4mxz2al+Nyo+tEP1Fvt1pR0Fs3
         1qoA==
X-Forwarded-Encrypted: i=1; AJvYcCUtB7bx8sz5PDAwHV27UFsilMfmTHdpWdUlznICYLuzZfYetmOuS/eijjdW3NzkntV05ligAe10TmZMxuaCZMI7i7wcBRZ8Af+Lx+/4
X-Gm-Message-State: AOJu0YzKxkg+YMYAeuSetrZaUjIVayga9S0SK5SEL7aWVPYqEyI52SfH
	DvFiMw4w+xX8t4IooCh75GJmliN6ISxBodsSp1uZ7qmDmJDk6SVrQyx2ZTsrYhuReNUnMNmF8VI
	s2me/qJb10ICqRQ+WeD9x1jGuXcmpMlDSbcUl
X-Google-Smtp-Source: AGHT+IHIE7V2MRjxHp4LnAhTuxSivVkqjy9LTFGXSJt4qDY0a21Dmsfzj8nlG61FTQkeYNr0bVZpxsaHt1ddEX9dcdU=
X-Received: by 2002:a05:6e02:1308:b0:36a:374c:4a5e with SMTP id
 g8-20020a056e02130800b0036a374c4a5emr75985ilr.22.1712875461385; Thu, 11 Apr
 2024 15:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com> <acac43c0-d688-dcfe-51ce-b292f3c522d0@amd.com>
In-Reply-To: <acac43c0-d688-dcfe-51ce-b292f3c522d0@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 11 Apr 2024 15:44:10 -0700
Message-ID: <CALPaoCj1QVtVYcVV2FS1muL9Lo7f1MXuXaQQ+WKRi8h42aCCjw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] x86/resctrl: Avoid searching tasklist during mongrp_reparent
To: babu.moger@amd.com
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	James Morse <james.morse@arm.com>, Stephane Eranian <eranian@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Thu, Apr 11, 2024 at 3:34=E2=80=AFPM Moger, Babu <bmoger@amd.com> wrote:
>
> Hi Peter,
>
> On 3/25/2024 12:27 PM, Peter Newman wrote:
> > To avoid this issue, this series replaces the CLOSID and RMID values
> > cached in the task_struct with a pointer to the task's rdtgroup, throug=
h
> > which the current CLOSID and RMID can be obtained indirectly during a
> > context switch. Updating a group's ID then only requires the current
> > task to be switched back in on all CPUs. On server hosts with very larg=
e
> > thread counts, this is much less disruptive than making thread creation
> > globally unavailable. However, this is less desirable on CPU-isolated,
> > realtime workloads, so I am interested in suggestions on how to reach a
> > compromise for the two use cases.
>
> Before going this route, have you thought about your original solution
> where CONTROL_MON groups sharing the same CLOSID?
>
> [3] https://lore.kernel.org/lkml/CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-Ddtk=
aQTfuxY4a0w@mail.gmail.com
>
> May be it is less disruptive than changing the context switch code.. Thou=
ghts?

If had I ever posted that series, it would have contained the very
same changes to the context switch code, because that solution causes
rdtgroup->closid fields to change on almost every schemata write.

-Peter

