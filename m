Return-Path: <linux-kernel+bounces-17220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66088249F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5991C24027
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD62C682;
	Thu,  4 Jan 2024 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6+cOFF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9C28E0C;
	Thu,  4 Jan 2024 21:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938ACC433C8;
	Thu,  4 Jan 2024 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704402193;
	bh=iQOQbNnw6/2BF+o+KYjZbimWhHuWoJoj9r6w19A08Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c6+cOFF9BDLrlSYc3qZUI7AKiQcq6LsIrFMMtAnuCMMRJ450x1FNs53xLGzuOv/CX
	 FsDQ+07EjW3GrVcU0x8ydkvU4VuwGiGRb0JXLZhepqBv2YEsNgdyGJBvufcMWj/VIN
	 fDdYm2oQrjobTuNcfy+ZuGaV2Xru5w4fnpOI52u8ZFe1pA+Nk9Vj+JuzIghWYeZniH
	 v34CFTu5+7SSo1pMiwGye/RXX7oVFbbOLzViaSpn6D81g6mw+6FXODllnoaWi6MxS9
	 KKLw/WBhKkQB+pUySFYQO0MEEqgOH0JAMfcmIyZac06ps3vAhpaJXd8WC0pKUABzsd
	 ys2C8nRmskHDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 3E467403EF; Thu,  4 Jan 2024 18:03:11 -0300 (-03)
Date: Thu, 4 Jan 2024 18:03:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
Message-ID: <ZZcdDyyADG8dP8LM@kernel.org>
References: <20231208000515.1693746-1-irogers@google.com>
 <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Jan 02, 2024 at 11:30:39AM -0800, Ian Rogers escreveu:
> On Thu, Dec 7, 2023 at 4:05 PM Ian Rogers <irogers@google.com> wrote:
> >
> > uniq will write one command name over another causing the overwritten
> > string to be leaked. Fix by doing a pass that removes duplicates and a
> > second that removes the holes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping for this series, no comments since sent.

I applied the first one, the fix for uniq(), but somehow the second
didn't work for me as in your examples, nor the third, the output is the
same as before.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/lib/subcmd/help.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> > index adfbae27dc36..8561b0f01a24 100644
> > --- a/tools/lib/subcmd/help.c
> > +++ b/tools/lib/subcmd/help.c
> > @@ -52,11 +52,21 @@ void uniq(struct cmdnames *cmds)
> >         if (!cmds->cnt)
> >                 return;
> >
> > -       for (i = j = 1; i < cmds->cnt; i++)
> > -               if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
> > -                       cmds->names[j++] = cmds->names[i];
> > -
> > +       for (i = 1; i < cmds->cnt; i++) {
> > +               if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
> > +                       zfree(&cmds->names[i - 1]);
> > +       }
> > +       for (i = 0, j = 0; i < cmds->cnt; i++) {
> > +               if (cmds->names[i]) {
> > +                       if (i == j)
> > +                               j++;
> > +                       else
> > +                               cmds->names[j++] = cmds->names[i];
> > +               }
> > +       }
> >         cmds->cnt = j;
> > +       while (j < i)
> > +               cmds->names[j++] = NULL;
> >  }
> >
> >  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
> 

-- 

- Arnaldo

