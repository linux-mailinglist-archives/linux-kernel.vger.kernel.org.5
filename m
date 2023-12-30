Return-Path: <linux-kernel+bounces-13601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010688208AB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883F31F224DA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F26F9C4;
	Sat, 30 Dec 2023 22:39:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D3E54D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2045bedb806so5269913fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 14:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703975963; x=1704580763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s95fd8CWPyRAX6w7x1MUkDahCkeW5Ikcu9kmhfogHKg=;
        b=IZO5FbBJF6JEN6sg7RTXo2IgRXfsgX97F7GNdr19ajqS/MGMuqXq8K/37+CyZj+2JF
         no47oiseeMZPyI7PoHw43Syz1Eeg9/Z5mKDYy1dQnGZkMBZBD7ocFXXPR5YnwePcC9Oi
         g8+uDqFJVFGYMMeWYg2l4PP5oU/VnbGeDHlg0jJjUHCrNvULcd46iOfCyqJuXLjGlk5X
         i2+6H0ZqYOTIh5LkXdsnmzsMTcHfYlmqQWllgrGTacRuEkLzf4HqbYttm2O+OUvT7CHU
         J5YuPPU1xd3Ibrke884u70MHb3vYcimsxKneFJ+9kf0YbhbCejHGYJWckQZY2eqQv+9I
         GqAg==
X-Gm-Message-State: AOJu0YxiIjx2o2oJAv2PMKhr8fXh5dDQKemequAJwBS8pb49R93r2XYh
	/WZhaQy/+M5lXUCMOWtmVGQ=
X-Google-Smtp-Source: AGHT+IFrO7weYWKnkqic556yhkSML59TQmslPEqzkVBx96V3jRUrKOBahBWgHXSgw4PuAoG+DF2AYA==
X-Received: by 2002:a05:6870:65a4:b0:204:805:54ef with SMTP id fp36-20020a05687065a400b00204080554efmr17861120oab.86.1703975963073;
        Sat, 30 Dec 2023 14:39:23 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id l16-20020a656810000000b005cdfa6f5aeesm12361472pgt.94.2023.12.30.14.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 14:39:22 -0800 (PST)
Date: Sat, 30 Dec 2023 14:39:20 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Dave Chinner <dchinner@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Ye Bin <yebin10@huawei.com>, linux-mm@kvack.org
Subject: Re: [patch 0/3] lib/percpu_counter, cpu/hotplug: Cure the
 cpu_dying_mask woes
Message-ID: <ZZCcGEn0DGm7Ks+F@snowbird>
References: <20230414162755.281993820@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414162755.281993820@linutronix.de>

Hello,

On Fri, Apr 14, 2023 at 06:30:42PM +0200, Thomas Gleixner wrote:
> Hi!
> 
> The cpu_dying_mask is not only undocumented but also to some extent a
> misnomer. It's purpose is to capture the last direction of a cpu_up() or
> cpu_down() operation taking eventual rollback operations into account.
> 
> cpu_dying mask is not really useful for general consumption. The
> cpu_dying_mask bits are sticky even after cpu_up() or cpu_down() completes.
> 
> A recent fix to plug a race in the per CPU counter code picked
> cpu_dying_mask to cure it. Unfortunately this does not work as the author
> probably expected and the behaviour of cpu_dying_mask is not easy to change
> without breaking the only other and initial user, the scheduler.
> 
> This series addresses this by:
> 
>    1) Reworking the per CPU counter hotplug mechanism so the race is fully
>       plugged without using cpu_dying_mask
> 
>    2) Replacing the cpu_dying_mask logic with hotplug core internal state
>       which is exposed to the scheduler with a properly documented
>       function.
> 
> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git smp/dying_mask
> 
> Thanks
> 
> 	tglx
> ---
>  include/linux/cpuhotplug.h |    2 -
>  include/linux/cpumask.h    |   21 ----------------
>  kernel/cpu.c               |   45 +++++++++++++++++++++++++++++------
>  kernel/sched/core.c        |    4 +--
>  kernel/smpboot.h           |    2 +
>  lib/percpu_counter.c       |   57 +++++++++++++++++++--------------------------
>  6 files changed, 67 insertions(+), 64 deletions(-)

This has been on my mind and regretfully it's been a busy year for me.

I know the merge window is around the corner, but I rebased this series
onto percpu#for-6.8 [1]. I had to massage percpu_counter slightly due
to some changes but other than that it largely is intact. I need to do a
little bit of a more thorough pass and re-send it out, but I think it
remains correct to merge. I can then pull it, give it a few days to soak
in for-next and then send it to Linus either in a follow up PR or in the
2nd week of the merge window.

Thomas, how does this sound to you?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=percpu-hotplug

Thanks,
Dennis

