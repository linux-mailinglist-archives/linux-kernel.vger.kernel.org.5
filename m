Return-Path: <linux-kernel+bounces-109204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB688161F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B201F23643
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3569E0C;
	Wed, 20 Mar 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+7zz1pp"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342869DEF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954491; cv=none; b=kGAyXDWx0fIQ0OLxz0PtWrMSFK+vshvKRSwOUFrsvOSZEsQRBwmtaYrgy71bLlEbSAfi6azsBCYZuOdK6Z/S+T6ZoWbrqiOHTJMkiqrVAKX3sUdqdaPU42ZIc3dAZIhkxExXEK8g/JlutZCzXqg9rRCz+YkFYDPyaPJf+Ec+Pqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954491; c=relaxed/simple;
	bh=85r+DfNp8r2TD/2QmjSIEznYmx3IMc+tj2n1acPGGzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naJoEM80KMGtkrh8JKJFnS7QuZ1LR55oYKlouCBAVqNqZMFP2MquRhAgVOfwe1w5T98s+x2onOgCEcSuLHAwo17Y2OMK5R6Gq09W2v+SXDtaacWm66Q1K/pwqWyme9MNMozZ/6rWiW8LevlxsAATIJF5DnAxzW9Vsp3qBWuVgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+7zz1pp; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so3645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710954489; x=1711559289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMxo92nPL1tU74F7vzopWpNv7uTXZVq+Z4BSgnoG358=;
        b=X+7zz1ppBTY+732rUZT7CTV0CMd54y5AIEb35E+ZvzwB48JppbG7sZp2jkb80L4og0
         5jFSvr9R++OSIvnHwn5MDzIij11yciaGTnzHtNLoqC5vsPRLlRnzQ9iwPiNxDKayHudk
         2NgzvmMxQpS+H9YDpRPlv5Y8FbiQ69opj1ly14e965Ixca71Bv9DaBjg2kxPx70B//P4
         dIdin6Gf6RJK1g6O+DUFzGbK6S0A7mvYqshgxpcJBihT7Kdtk7nZdAUxCyCg0GyySZfH
         Nbp72crDGfR5IDk4Jz6XLNp4TShQM3Gl9tDhtk1HcLwjK6FlQMj55KqFlIqJWq7haX4l
         ik2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954489; x=1711559289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMxo92nPL1tU74F7vzopWpNv7uTXZVq+Z4BSgnoG358=;
        b=sZknXBlzSYuvaXeOLvuN758464QaBkxzw2b/xT+V/ZUDkpEaBb2g8Wc9bw3aEyZ65g
         53nj8lChdjHBYbos6GV3Nt+6bFR5ToNaypgD1QT6Pad84YaftoYUrszsql2Prdr1JSUB
         42nPO8ZJg9iBG6bE/P1WCXPeOK1v2hVcoKjSMMksNa6VFhR55tjrsKR98qYoUTU2eFk7
         H4dPKccIBKFuOMqBxI5Ed/dZF1Vkn8ZfSLKbbbnxCTa3aOvm1kzq+sjXWcLAeqx282H1
         oJcNrBeKDKGuYqq6MsZtSPoZbEb9nDDVjSFyBo0CQDcDV4QgLrWUFAvpH4yHcgVHkg9m
         UWBA==
X-Forwarded-Encrypted: i=1; AJvYcCWK1RwOClztzyMUTPhLVKp1mz7beCOpCD7Gcs/WayVXOz6wAYJDvmsZ9zXFoNkfCxfyr6Q9Iq6lZRokVIz7NrwSwG0hajz/p+pu7TUs
X-Gm-Message-State: AOJu0YzZmpFEt2HclFvmT9aEFm9rfgVlPKtvi8LsfMdIK/8osdx2MvUW
	v2+fMFZhNS1iHaYI5aki9ymy0Dj3RGElYpdwrb0O+mzsKFdJkkvRRCJ9y2XkaJms2ZZ3XwBBBL4
	mfH4Wnom3zzB6LmddnkFl0ru2/xaLQBZsXbMQ
X-Google-Smtp-Source: AGHT+IEKpU3MTlSc7cRMi4o36SLCrdLYi22Iqsn/nljIj023NT2fMYHM6r9jWIRJq1WhbHoH76YkxNWLXAoCXw/NIDI=
X-Received: by 2002:a05:6e02:152b:b0:363:db1c:22ef with SMTP id
 i11-20020a056e02152b00b00363db1c22efmr336295ilu.24.1710954489399; Wed, 20 Mar
 2024 10:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301201306.2680986-1-irogers@google.com> <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1> <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
 <Zfr-sQJPbZzbtk8K@x1> <ZfsBopALY3whsst5@x1> <ZfsDtr5ejAwGySOR@x1> <ZfsEWoi6eevwLRQC@x1>
In-Reply-To: <ZfsEWoi6eevwLRQC@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 10:07:55 -0700
Message-ID: <CAP-5=fUbiudT+ocbGEauca2aX8PJSV9rHQUCCxQ4bxWXL6eoyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:44=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Mar 20, 2024 at 12:41:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
> > perf: 'raccord' is not a perf-command. See 'perf --help'.
>
> This works with the second patch.
>
> - Arnaldo
>
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf ricord
> > perf: 'ricord' is not a perf-command. See 'perf --help'.
> >
> > Did you mean this?
> >       record
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf ricord
> > perf: 'ricord' is not a perf-command. See 'perf --help'.
> >
> > Did you mean this?
> >       record
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > So I'll add that and go on from there.

Thanks, let me know if I need to send a v3 with the 2 uninitialized
variables fixed.

Thanks,
Ian

