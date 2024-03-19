Return-Path: <linux-kernel+bounces-107980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0421880464
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBD82841E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE12C19D;
	Tue, 19 Mar 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0DENtvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A52D046;
	Tue, 19 Mar 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871778; cv=none; b=rgabei+1QW4uifKHY/st4mygLiFU9euIr8PaEtyZ+4pUb/uzoTtTth0eLklLnsvl6YDJIpqktXZT67umogMhvI7sD4d08M88+YH0zkPOgEhXnu2qnjS0QCHN1GgmWHvcglNFymxspfnaE1axGLNxGnP68lvQFrDVBmz9NGXxGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871778; c=relaxed/simple;
	bh=ugoMpbER9K+KatX2IyLi4yOo5eMLV9vLE9hxz5xaacw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTlRrwB7rgJDG6LLarSAlWtLpC6r+cfh9SlX8SCSIF9gWbaaHyxkQONI+07SANv+JbRWc8NCunGHM5KGI9TSDjvuAnBbgmke86l/z9XuATSdvyZQjLA2YBhAQLdm0JV3QLZ74RCrXQx3d+t9clWy0lyb3nzmLkD4YSftC9k42IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0DENtvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A60C433C7;
	Tue, 19 Mar 2024 18:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710871777;
	bh=ugoMpbER9K+KatX2IyLi4yOo5eMLV9vLE9hxz5xaacw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0DENtvZOR3Om08P/g36xouiKADw24Pko0NrJeElpXbj9buRZzo69E7ryPsyiP85Q
	 qBDMY+TurVzuvj0YEVk2K4UxIEit8SYsMnF/JLcyocglQZF8LxTZHIzwppF693HT+V
	 SHg/pB2tV4FmduLbo6sYidSdAND0F6OVRq0+/FXxIyqs1WMNO1hYzLnufDvIB4HUku
	 OoyJAwJrCqNrMsziDA4A+1ksYPsD7j0Y/qKoHxzJfUFQ+hawtlhhEP3Hrj8yKxB5sx
	 Y+HiQ3WqGe2mpFZlwQxwn6vdcdZtp/owmEZ2oDnyRFk7l1kXcaI2SSUckfoQlrqfzb
	 zmLJOqkxIG4Pg==
Date: Tue, 19 Mar 2024 15:09:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 22/23] perf annotate-data: Add a cache for global
 variable types
Message-ID: <ZfnU3DOZIPqlPhHf@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-23-namhyung@kernel.org>
 <CAM9d7cjhuxB_iWPPWgFxK1_oBaYqF=MgthV=EBG0HeyJ9-ONXg@mail.gmail.com>
 <ZfnUUqWozFf55eyx@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfnUUqWozFf55eyx@x1>

On Tue, Mar 19, 2024 at 03:07:19PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Mar 19, 2024 at 11:05:04AM -0700, Namhyung Kim wrote:
> > On Mon, Mar 18, 2024 at 10:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > They are often searched by many different places.  Let's add a cache
> > > for them to reduce the duplicate DWARF access.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/annotate-data.c | 107 +++++++++++++++++++++++++++++++-
> > >  tools/perf/util/annotate-data.h |   7 +++
> > >  tools/perf/util/dso.c           |   2 +
> > >  tools/perf/util/dso.h           |   6 +-
> > >  4 files changed, 118 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> > > index 633fe125fcd8..4b3184b7c799 100644
> > > --- a/tools/perf/util/annotate-data.c
> > > +++ b/tools/perf/util/annotate-data.c
> > > @@ -433,6 +433,91 @@ static struct type_state_stack *findnew_stack_state(struct type_state *state,
> > >         return stack;
> > >  }
> > >
> > > +/* Maintain a cache for quick global variable lookup */
> > > +struct global_var_entry {
> > > +       struct rb_node node;
> > > +       char *name;
> > > +       u64 start;
> > > +       u64 end;
> > > +       u64 die_offset;
> > > +};
> > > +
> > > +static int global_var_cmp(const void *_key, const struct rb_node *node)
> > > +{
> > > +       const u64 addr = (uintptr_t)_key;
> > > +       struct global_var_entry *gvar;
> > > +
> > > +       gvar = rb_entry(node, struct global_var_entry, node);
> > > +
> > > +       if (gvar->start <= addr && addr < gvar->end)
> > > +               return 0;
> > > +       return gvar->start > addr ? -1 : 1;
> > > +}
> > > +
> > > +static bool global_var_less(struct rb_node *node_a, const struct rb_node *node_b)
> > > +{
> > > +       struct global_var_entry *gvar_a, *gvar_b;
> > > +
> > > +       gvar_a = rb_entry(node_a, struct global_var_entry, node);
> > > +       gvar_b = rb_entry(node_b, struct global_var_entry, node);
> > > +
> > > +       return gvar_a->start < gvar_b->start;
> > > +}
> > > +
> > > +static struct global_var_entry *global_var__find(struct data_loc_info *dloc, u64 addr)
> > > +{
> > > +       struct dso *dso = map__dso(dloc->ms->map);
> > > +       struct rb_node *node;
> > > +
> > > +       node = rb_find((void *)addr, &dso->global_vars, global_var_cmp);
> > 
> > It seems to cause a build error on 32-bit systems.  It needs one
> > more cast to suppress the "pointer cast w/ different size" warning.
> > 
> >     node = rb_find(void *)(uintptr_tr)addr, ...);

                               uintptr_t
> 
> I can add that, to speed up the process, ok?

Done

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4b3184b7c79942b4..969e2f82079cdec5 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -469,7 +469,7 @@ static struct global_var_entry *global_var__find(struct data_loc_info *dloc, u64
 	struct dso *dso = map__dso(dloc->ms->map);
 	struct rb_node *node;
 
-	node = rb_find((void *)addr, &dso->global_vars, global_var_cmp);
+	node = rb_find((void *)(uintptr_t)addr, &dso->global_vars, global_var_cmp);
 	if (node == NULL)
 		return NULL;
 

