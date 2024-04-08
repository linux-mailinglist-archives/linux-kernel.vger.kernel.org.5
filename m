Return-Path: <linux-kernel+bounces-135950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0D89CDB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAFA284230
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109914884B;
	Mon,  8 Apr 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeAbti82"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42E11725
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612497; cv=none; b=CPWpM1ZjWsBlk/vlOYUOe9VhSL0u6CDQRvE9h+kcdpAE6EhjIRfGvkhlumK4qfvIzFNmq1PigyROYwS6QJs1ptf9Hfhj7xXA8gRP8wq1pCqP+CXOJdJahBSsbAiyn71o8lVfDSMPr+meTOo8InYERXCxWxKRwZU6uobmnUuQHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612497; c=relaxed/simple;
	bh=zGzdPYfL/c8Ea5uNWczPdOvsGzbwE0PAwdeA2738iPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJkUwSDRjNKhbrlmUCvobvvplF4cv7X0GepbGjEyc48hHMKAcKWpguYsxBD+IxZmjtOXt7O83yCifYT9273mBEzt6SPHWeZTWRbhD3pz4MUmlamjMaD5yREdfbiByRVaCDyFf0cJzbjT+9x/IJz2jEhO8IQABsMJ44JaTQt4zEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeAbti82; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4348110e888so32501cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712612494; x=1713217294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/KwUKK4VTN9LaZYptdzXdjKND0s79NzDzuW3iwdKck=;
        b=QeAbti82LTi5viXa3RChr2oh2kdFmqLTNDiuZV6hhvKbje3W7WR0bDFEkKIyq0L2yU
         PkLUgQSBLHAFHWyd1aFctR1jg6UgJ+s8LyaoP4wTFJH7UWJeFTBSjEo27r5HGIUJMxag
         ezrtHDQwS9Nk9YkWddxWBVOmaElPn316ejl/fBa/x2xcjf5tOd8XD0mYteTM2G3cdYYF
         v56tkpVyX6iW/6H2pRLfBfTcV5rJbPrLxa9Ui7TefTP5STppCnazIkEXIa2HXsOgqd55
         j2lNyU+c1Nv+F5aCro7XG919iXXV2CDaotwhfc/VcCepQccOdOFeYfsy8fpBBx6jgBpd
         Vf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612494; x=1713217294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/KwUKK4VTN9LaZYptdzXdjKND0s79NzDzuW3iwdKck=;
        b=Gg2bUZwuJgefVU+HdH6idgOmY/ACXEXaJv0q91dMiO49SKy4EQC2h2ly4fzwG7m3CW
         JtaituMYKek50KkawgfkEp2V2Dt+zLUFONpoDVPz7P6ERKsLaCIHSrv7syK1/DTe8Nub
         PizxWfgRClBrrj/7V4uA6l2o3gnYtHd6e58DLHy2caIcXIUcyj7LEQBwBa4qkrvE+SOF
         KFD18nKfnK18j0v81V1YKFxvNAITDM+PxjaEgMDmoqOMlJ2u8nGMPkRDmwW4J7g7H+QQ
         kHLd7PJvQe3PpzMRha2kndJMWjOZ/xILs/pt6ulUtQnnGL2X1am6q+8yKtSi1VyQaYSk
         URzg==
X-Forwarded-Encrypted: i=1; AJvYcCUazevWL69cY57R/fylKQW5Fj1HEVgeokTh2YvOVB1QU/HDpxkRJAKojq3b+YdhIE0/C6OEBEsQxBdSDE7vJ3UJXAqG0xx79vY/3aE5
X-Gm-Message-State: AOJu0YzoO9JuMUUgpWmj23PPS5lmKSAdaUU12fB2cNpvAUW77lIDpDv5
	gyCI7fgUDr4nxnelcCQaOoHm0a/eb0UbomKC4L7tZ44hJcoHuULDtvJwFPAPgqnj8Ywnc3WLRY9
	YMOtPP9NMGAwrsHcUZdafk/7DpoT5/PEOP8m1
X-Google-Smtp-Source: AGHT+IFXfbH/7BBRbtYjOMQ5vAbQfUI7aHD0gGm7MqPlKn+0yqLn0D87RQWIp0M0VDIPwY26PnFVlhCw6tVq0A4XLi8=
X-Received: by 2002:a05:622a:59ca:b0:434:47a9:95dd with SMTP id
 gc10-20020a05622a59ca00b0043447a995ddmr24995qtb.1.1712612494047; Mon, 08 Apr
 2024 14:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-2-peternewman@google.com> <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
 <CALPaoCjWDKM9VYXexDt2+zh2srTotuaErFHXkWzH1w0c_KWDjw@mail.gmail.com>
 <d3ef1a5a-a7ee-477c-8697-d64b91726d91@intel.com> <CALPaoCieXQfgEL-7CK2pB5xgrRzTTWBkbic7OXxdKbh-ipWTpw@mail.gmail.com>
 <17264fcc-5db9-41c8-b57c-9bd62ef544ce@intel.com>
In-Reply-To: <17264fcc-5db9-41c8-b57c-9bd62ef544ce@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 8 Apr 2024 14:41:22 -0700
Message-ID: <CALPaoCiX-EZu-SNt-1A9QNJyc27jqmr9LNJ2r4Eq_fChGhgscQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] x86/resctrl: Move __resctrl_sched_in() out-of-line
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Mon, Apr 8, 2024 at 1:59=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 4/8/2024 12:05 PM, Peter Newman wrote:
> > Hi Reinette,
> >
> > On Sun, Apr 7, 2024 at 12:21=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >>
> >> I think this needs more thought. rdt_enable_key is x86 specific now an=
d should not
> >> be in the fs code. Every architecture will have its own task switch co=
de, with
> >> __resctrl_sched_in() belonging to x86 and thus not something to be dir=
ectly called
> >> from the fs code.
> >
> > I think we will need to discuss whether __resctrl_sched_in() is really
> > arch or FS code following the changes in this series. This series
> > removes the explicit MSR access and James has already provided inline
>
> Indeed, I missed how resctrl_arch_update_cpu() introduced in
> "x86/resctrl: Abstract PQR_ASSOC from generic code" results in
> __resctrl_sched_in() being architecture agnostic.
>
> (sidenotes ...  it is not obvious to me why resctrl_arch_update_cpu()
> is not consistently used, for example, in clear_closid_rmid(),
> and it also seems a better candidate to be inline within
> arch/x86/include/asm/resctrl.h)

I must have renamed resctrl_pqr_state to resctrl_cpu_state after I
last looked over clear_closid_rmid(). Now looking at the function
again, it seems clearly portable now and should definitely use
resctrl_arch_update_cpu(). I need to look over the accesses to
resctrl_cpu_state again to reconsider whether they're
architecture-dependent.

>
> > wrappers for the mon and alloc enable keys[1], so I can only assume
> > they are architecture-independent in concept.
>
> The wrappers are intended to be architecture-independent, but the keys
> are architecture dependent. Quoting the commit you linked to:
> "This means other architectures don't have to mirror the static keys"

The static keys seem to exist mainly for the benefit of
__resctrl_sched_in(), so if it becomes architecture-agnostic, I think
it would make sense for the static keys to move into the FS code with
it. I don't see any other usage of these keys in the code that
remained under arch/x86 on James' latest series.

-Peter

