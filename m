Return-Path: <linux-kernel+bounces-135862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC4F89CC2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F329F1C221D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88337144D3A;
	Mon,  8 Apr 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhSntl8j"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AAF51B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603142; cv=none; b=lL1twnSL+bPdVhOpxg4JbVxN320I32JodPSZoD35zUVCM7hAi0ZCEZKbG+ds+rOOQVJe1cFdptsqZnJxG16O3RzISO92b+YDpPakxL08T1A4rNgJ3W+WooKQlrvXAHG+KoRUorUuiNx2+AJnqwxooZLXEXZwyR/x9a6jwC7+uwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603142; c=relaxed/simple;
	bh=lbRobwJw3OdHZdZ4P+7nlZtLBU8BwFDhwjultMzXnbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDgVWqlc/iHMvbJkzjpeYooCsdxm0l8aoYbkooHnRQCVgHnIdshdWdgoysyS/fqdvJmjw4KPTR0Pz17Y1R49oYmYKBp3l7c2pXm62osWGNw9dEHEhNCgyS3s2cs4J3BNzO9uY+MJHxn7bQEAc+c7FgkFwsmxJofqzzTvTuRH/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhSntl8j; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a0c8c5f18so27795ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712603140; x=1713207940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbRobwJw3OdHZdZ4P+7nlZtLBU8BwFDhwjultMzXnbA=;
        b=rhSntl8jtQv6pcCjzJaiPNUmQ0hI6KkwSjcc8FfoI2EN/r9zIJxAF+gFO8Umr7umv4
         PoBqFzjSjBKwZgSk34sv8szOPMDmzpXmLh5/lt2PN3+bRhT3ZtXqsyKYxFbG37b7n8lZ
         Z1E1BwuI8jAnMua43tHBpA+8+gH4YKZ4Imhb4U5zMcPJ4KtRzAqwWer/RyeEnHIOV/np
         qhyzuL/i1sScRSGgudr7emjjLkZxwTWbyAZr8Hu/z8Cprb1RYcJANfgi7+5Z8h5zU3xr
         Ue8+j9fbnr8y/EDoO/89+lAnI9tNTqD0lrejwD/kxi1zqIUrFrix+wK7XWFE/lrbK2t0
         1BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712603140; x=1713207940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbRobwJw3OdHZdZ4P+7nlZtLBU8BwFDhwjultMzXnbA=;
        b=J4BLNoR3gh63Teq0qmwNS6L3zc7mkjSrWX+FEUkhXX/ANtVF6G0B5xm95KGnuomcTi
         cCGf+RV56TaSBgyrv9xSJDKMBtBTVflNlPOfEcJo0o2/zexUqqhTRbhk7eYjCgiSmJ1d
         T5ZUhiCl6IehmMd48R1Zh4IFPq2cgzAT5X+wNxzgVBZMgOY7O5VUNr12FzDf1x/xoIG0
         9aWRTG0pDOBybgKgQL8gzapdvNUadDSgvQK30awdFGWEjOhMh8GmZvLAnQFDK4kdPH31
         iqqU3FxOpx929xDXUrp9qdm5tCmxi5FGkgulMgl0MTtwY/XSFCku6AFDdYTvQ/udu9sQ
         irAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgOUQiYe7BE04VpR8lf5T/8Gf32Oeg7g6zYzFet0DOsS2NQsg8NPnGJzGwR6cx/PeKWQyLomLoMSDJvRlG9kQ5WPRAjA0BjqU3LLYt
X-Gm-Message-State: AOJu0Yz7ymx9+3t31Gj1jcaFQv9OwAYOEENPkHhkRHL9Pamlytm/bhp8
	6ro3t4fENamT3/uHysIH3t+zcKeaZ94B+Adp5wWtPzj10pXVV6LTmo9f6Xv+10tLcxBmmNSutkx
	E60zWOTDvs5jESKzC1UXT+Zbm1aTYV8fZ+XBX
X-Google-Smtp-Source: AGHT+IGR+FIKzI/wcrtDoU0xKLEuaSNo1Pi6seLc7A+z/6gARPeaAQ5FJJk+MjgyeXeKOmhZJkn1XSHB3RlSgGvlpsE=
X-Received: by 2002:a92:b70c:0:b0:368:4204:7bf2 with SMTP id
 k12-20020a92b70c000000b0036842047bf2mr33697ili.12.1712603140332; Mon, 08 Apr
 2024 12:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-2-peternewman@google.com> <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
 <CALPaoCjWDKM9VYXexDt2+zh2srTotuaErFHXkWzH1w0c_KWDjw@mail.gmail.com> <d3ef1a5a-a7ee-477c-8697-d64b91726d91@intel.com>
In-Reply-To: <d3ef1a5a-a7ee-477c-8697-d64b91726d91@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 8 Apr 2024 12:05:28 -0700
Message-ID: <CALPaoCieXQfgEL-7CK2pB5xgrRzTTWBkbic7OXxdKbh-ipWTpw@mail.gmail.com>
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

On Sun, Apr 7, 2024 at 12:21=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> I think this needs more thought. rdt_enable_key is x86 specific now and s=
hould not
> be in the fs code. Every architecture will have its own task switch code,=
 with
> __resctrl_sched_in() belonging to x86 and thus not something to be direct=
ly called
> from the fs code.

I think we will need to discuss whether __resctrl_sched_in() is really
arch or FS code following the changes in this series. This series
removes the explicit MSR access and James has already provided inline
wrappers for the mon and alloc enable keys[1], so I can only assume
they are architecture-independent in concept.

Thanks!
-Peter

https://lore.kernel.org/r/20240213184438.16675-18-james.morse@arm.com

