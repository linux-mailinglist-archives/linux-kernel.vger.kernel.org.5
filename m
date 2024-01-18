Return-Path: <linux-kernel+bounces-30353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF19831D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC115B22F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61592C19D;
	Thu, 18 Jan 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqc6+6EY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E541E50B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595822; cv=none; b=s4LJOLJNCerGkJxTpabnnCgREya0XTtIisRrN6UeSTkbowxHHu/JC8tm1UFo4kmVaJzp3zQT1H93kSQJH3KHr67kDA8K6Fjjd01DCceK2WplyBnZyNoHSdAC1rMUUG406CDLmXM8q6Tw7vJGD4mR/4/7L27ygcz4IC0DvtOBHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595822; c=relaxed/simple;
	bh=QEi1bAcrixkAKE8mmHyxwQZeg4rqRgAAYgcOVq4gBHU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jt8eFpDRRIg9LTBg9JUTaXIPiHACQ025g6TCjYdFbPJIsKooVgoep9J8J8yVBB6WPZ4OqGDyrPQRfNqsaSSuOkxX0X/D9dTmFWjkVWdhKYsilJZzRUkCVJlquW7QHygQ6STXw8FcZ1SDuT5oj8YiudpGjIr0kOLUghHLtelRIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqc6+6EY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5ce88b51cso141155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705595819; x=1706200619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KlwC1tfLnVHaIlb0kP7VhmulPfiXSyngFVbxChaHqs=;
        b=pqc6+6EYQbiMxocEdczrDYyTAQyx2v2n/mtp19Y/tP3QfB7DuZ5UiVtomwvA3Itjmz
         N5ZPvPRKLTP+qvmKnyHx8fWwzYC5GIUaVZ1LADJkPf7Pxu1dk4IdVga9xoPzT76uaLnC
         cDJ9Jc+eWveRBgZLe2s2NAbomTWNjHoMxu+NOhuvpVifFXKbDGDa1yHhc2wiU+Dye1fU
         JOPclBsn9ZMAfRMIhLsJledaTsin+SWgMikjm8iJ3B37Q+yZlDcL0tPyX/LI5UDhsZcO
         lYeTf0wjTOuABOhxOZfKxk7JfdALmZPvkt9JiZCgDyObBJn8eH1evI4yL0TCcYP5itKL
         psJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595819; x=1706200619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KlwC1tfLnVHaIlb0kP7VhmulPfiXSyngFVbxChaHqs=;
        b=uFjO2sHeMYEoxfrF5YYXAcseoCbJe6zhiuBaET+M/W0DPFmh9NSvb+ZmyyDXHnvC05
         cFOyKVTbxzuELAVVl1/34vP8v7X4FXdpWaMGdzJS4PeRl8PqEcoz6ak5i5pdXN6pxNN0
         OcBSjAfLrIfFPVgEDF6BnXl9lX+zoz6qM/8xfoVtWg7auP4b+rZQ8A7z32n3kcBUWyL6
         xUO+sNWzn5tf946cPf5c9bliCMS6Gd5yw1V3E+6d8qrH5HIFJ9VZbruSA9/pIgR7xeBb
         /DhR7HnO0mdWXNa225056bOZPZL2HdnM64wSVBYxQmpaIpPXRT7a3wlvbcFy2myP7gxh
         FMYg==
X-Gm-Message-State: AOJu0YwXyOYrEAHNBdJcorTh2XrsglsqCisWW/46M6rqOvY3D1Ip4NL6
	Onw+r+G2Xx7VVWoaxeCkqEpPUpStZraWVxZtV7omHkHCnroQwEdsf2PNc0Rn7CFdetYGNr1cxyV
	otMKbrstwQOwg3cI3DOrY/RrBJUEH1d3VGOTx
X-Google-Smtp-Source: AGHT+IGD/GqPBe8Ph0aRgX54BTNg+7Cx7Om23uKeYBKXXKyqAnh8rtc1TbLbq77oqgH5JOz/+4JdTGDixjXjdz17RFE=
X-Received: by 2002:a17:903:2448:b0:1d6:fc45:d269 with SMTP id
 l8-20020a170903244800b001d6fc45d269mr104204pls.23.1705595819130; Thu, 18 Jan
 2024 08:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117062657.985479-1-namhyung@kernel.org>
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jan 2024 08:36:45 -0800
Message-ID: <CAP-5=fVwPUBAXcGB=VYVVDPEkGm_W5qAFZSAWb4yuJ0msodu4w@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] perf tools: More updates on data type profiling (v4)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org, Ben Woodard <woodard@redhat.com>, 
	Joe Mario <jmario@redhat.com>, Kees Cook <keescook@chromium.org>, 
	David Blaikie <blaikie@google.com>, Xu Liu <xliuprof@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Mark Wielaard <mark@klomp.org>, Jason Merrill <jason@redhat.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, William Huang <williamjhuang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 10:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> This is a continuation of the data type profiling series.  Now the basic
> part (v3) which uses pointer variables is merged to the perf-tools-next
> tree.  And this part is for memory accesses without pointers as well as
> small updates to handle some corner cases.  Still mores to come to
> complete the original series.
>
> There's no change from the previous version.  For background and usages,
> pleaes refer the posting of previous version [1] and a LWN article [2].
>
> Basically most memory accesses happen with pointers, but there are cases
> don't use pointers - direct accesses to global and local variables.
>
> Global variables are located in a static memory at a specific address.
> So the DWARF location expression for the global vairable would also have
> the static address.  And it's common to access them using PC-relative
> addressing mode.  Thus it needs a special handling for global variables.
>
> On the other hand, local variables are located in the stack which varies
> as program executes.  So the local variables are accessed either by the
> (stack) frame pointer or (current) stack pointer.  But sometimes DWARF
> location expression uses a frame base address (CFA) to specify location
> of local variables.  So it may need to convert or normalize the location
> extracted from the instruction to match DWARF expression.
>
> Lastly, there are some cases DWARF location expressions end up having
> complex (or not straight-forward) location.  In that case, it cannot
> simply match just the first expression with the instruction location.
> It'd be safer to reject them.
>
> The code is available at 'perf/data-profile-update-v4' branch in the tree
> below.  The full version of the code is in 'perf/data-profile-v4' branch.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Cc: Ben Woodard <woodard@redhat.com>
> Cc: Joe Mario <jmario@redhat.com>
> CC: Kees Cook <keescook@chromium.org>
> Cc: David Blaikie <blaikie@google.com>
> Cc: Xu Liu <xliuprof@google.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Mark Wielaard <mark@klomp.org>
> Cc: Jason Merrill <jason@redhat.com>
> Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: William Huang <williamjhuang@google.com>
>
> [1] https://lore.kernel.org/linux-perf-users/20231213001323.718046-1-namh=
yung@kernel.org/
> [2] https://lwn.net/Articles/955709/
>
>
> Namhyung Kim (9):
>   perf annotate-data: Parse 'lock' prefix from llvm-objdump
>   perf annotate-data: Handle macro fusion on x86
>   perf annotate-data: Handle array style accesses
>   perf annotate-data: Add stack operation pseudo type
>   perf annotate-data: Handle PC-relative addressing
>   perf annotate-data: Support global variables
>   perf dwarf-aux: Add die_get_cfa()
>   perf annotate-data: Support stack variables
>   perf dwarf-aux: Check allowed DWARF Ops

Series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/util/annotate-data.c | 119 ++++++++++++++++----
>  tools/perf/util/annotate-data.h |   8 +-
>  tools/perf/util/annotate.c      | 153 ++++++++++++++++++++++++--
>  tools/perf/util/annotate.h      |  12 +-
>  tools/perf/util/dwarf-aux.c     | 187 ++++++++++++++++++++++++++++----
>  tools/perf/util/dwarf-aux.h     |  18 +++
>  6 files changed, 439 insertions(+), 58 deletions(-)
>
>
> base-commit: d988c9f511af71a3445b6a4f3a2c67208ff8e480
> --
> 2.43.0.381.gb435a96ce8-goog
>

