Return-Path: <linux-kernel+bounces-22574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B475A829FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C562A1C25E28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD184D5AD;
	Wed, 10 Jan 2024 17:53:33 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F64F214;
	Wed, 10 Jan 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdfed46372so3374214a12.3;
        Wed, 10 Jan 2024 09:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909210; x=1705514010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quyVSdnppz8w0YPUQzzVyzANCKAuU/PcHNsts+I2z4s=;
        b=to2rs60UWTq8fJlYH3xSIC3I1YKncxbGk3KTWTXKs4eZ5Xz6wWSBEverjkAg2QWjrE
         wacfzElSi83Z3Uf3hCPjXXo4c9s8B35NtmNooyEjcIAfxHookGuPk0vRMy9lH2hY220F
         01SELbBb3fAvAUbkhMaT+HfPneDOcVvP6kwr9ayxyis9NXMUYU2z/+fW+Pao+POSErgp
         cRuIzlMWy4HownHEyEviXDAQzww9xBeUM0ylV5JlEsrDuzydm1zNOkRlq/zrysvcK/5o
         BEL8L1XECGrj4Syddntcr30mkiIyXAMJ/K/aXrUL518tDcLH0TLB6q4kjKwyoY5Lvx5h
         FNYw==
X-Gm-Message-State: AOJu0YzQvPIT4tEO07H7jzjTTMq4xYm9CISS0WBT0QF8CugchD1x7/fV
	xaoKcpcTGDkXJCCq1Z2BrSSHtgAjNbtnMWV8L/4=
X-Google-Smtp-Source: AGHT+IHrKEA9A15zuS4dmV0QjZovE8jdobS9FxQvBvDSb65iQnzMpB77JE1mM0dshtFLLIWhQCIQDpT2PIjEgJn1vu4=
X-Received: by 2002:a17:90a:9746:b0:28d:c3ec:8028 with SMTP id
 i6-20020a17090a974600b0028dc3ec8028mr869411pjw.12.1704909209857; Wed, 10 Jan
 2024 09:53:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024010711-skeletal-material-15e8@gregkh> <20240109214955.451513-1-namhyung@kernel.org>
 <2024011043-unearned-manned-12b7@gregkh>
In-Reply-To: <2024011043-unearned-manned-12b7@gregkh>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 10 Jan 2024 09:53:17 -0800
Message-ID: <CAM9d7cj3fdaKVehz+E3Fd_Zf91hy31z19goM84qq+cc8WZe7RQ@mail.gmail.com>
Subject: Re: [PATCH for-5.15] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, 
	Vegard Nossum <vegard.nossum@oracle.com>, Darren Kenny <darren.kenny@oracle.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, Lieven Hey <lieven.hey@kdab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 9, 2024 at 11:59=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 09, 2024 at 01:49:55PM -0800, Namhyung Kim wrote:
> > From: Adrian Hunter <adrian.hunter@intel.com>
> >
> > When a program header was added, it moved the text section but
> > GEN_ELF_TEXT_OFFSET was not updated.
> >
> > Fix by adding the program header size and aligning.
> >
> > Fixes: babd04386b1df8c3 ("perf jit: Include program header in ELF files=
")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Lieven Hey <lieven.hey@kdab.com>
> > Link: https://lore.kernel.org/r/20221014170905.64069-7-adrian.hunter@in=
tel.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > [namhyung: use "linux/kernel.h" instead to avoid build failure]
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/genelf.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>
> What is the git commit id of this change in Linus's tree?

Sorry I forgot to add that.  It's 89b15d00527b7825ff19130ed83478e80e3fae99

Thanks,
Namhyung

