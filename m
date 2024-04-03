Return-Path: <linux-kernel+bounces-130519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAE989795E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E06289CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754571553A1;
	Wed,  3 Apr 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU9dWItP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702E153BFE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173952; cv=none; b=aT+ExtoiFEhyYPAU0gdwwe6wfymyeSH1qlsRnbOrpZc+oolDFv32OL0ipBrIhGyCC59ntrDGmvEGwN6NSDIoERxuxE/tidKDL3NOngVgUo1R4AlelK+5ZPRaW9gXRl8fXqIoIfhFZw5lSantaGLKq7fds8jel1dtM0h9TbK4GwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173952; c=relaxed/simple;
	bh=O3WqaLqlUSgQE4OdAcJeqrcZ7Ltnz8VmOwxJv1vB65k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejLJKszhdDVqo7I6ULMgIqzyaSIT2eWyqWlblGj6lDU2THdlV9Fmbl4ahddwlS0c74eTjxofBShc7v3rlPCKGBBmcdznxeNtBINOAoELL2FvdIi8HraFH/JR+e1RSmMPFJizKWZq8pcDX/hdJAST0PeQcL5hln6m2q7OJyvLJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU9dWItP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B143EC433C7;
	Wed,  3 Apr 2024 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712173952;
	bh=O3WqaLqlUSgQE4OdAcJeqrcZ7Ltnz8VmOwxJv1vB65k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QU9dWItPR6m2v28c9DW2sRnuCe/4j4AKqo1WPwDPQlCKmqKl3Smi7X9tg9z5HGNo8
	 gqpkXh2N3hUB7QeWrLMJE2UugmZK34AjWu+6TdzHl4hthTpLkZeu3BXbROtU1MQHjS
	 /10esr6zDb8K466BFd7zmQgVpqXjrXC5o5q9Ni4sWGTJewutdlDlab/kkpk28rX6NS
	 Nze43t/Whs3tFWwQkJMompkWxrpKCLlf/lwhKdhTo1WgMWWO0FSdZ9gkhZf36iQ4sr
	 ItSEJMuTtdph6CJavc9HKILQVoekNIPD9OT8xA16DrLiChxMNwHj+wyLbbFNwbCYrr
	 Ik4k0skB1GXsQ==
Date: Wed, 3 Apr 2024 16:52:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf annotate: Initialize 'arch' variable not to
 trip some -Werror=maybe-uninitialized
Message-ID: <Zg2zfKFdGCJaYc36@x1>
References: <Zg1ywF7uRsfXYfYS@x1>
 <CAP-5=fUqtjxAsmdGrnkjhUTLHs-JvV10TtxyocpYDJK_+LYTiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUqtjxAsmdGrnkjhUTLHs-JvV10TtxyocpYDJK_+LYTiQ@mail.gmail.com>

On Wed, Apr 03, 2024 at 09:01:56AM -0700, Ian Rogers wrote:
> On Wed, Apr 3, 2024 at 8:16 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > In some older distros the build is failing due to
> > -Werror=maybe-uninitialized, in this case we know that this isn't the
> > case because 'arch' gets initialized by evsel__get_arch(), so just init
> > it to NULL to silence those cases.
> >
> > E.g.:
> >
> >     32    17.12 opensuse:15.5                 : FAIL gcc version 7.5.0 (SUSE Linux)
> >         util/annotate.c: In function 'hist_entry__get_data_type':
> >     util/annotate.c:2269:15: error: 'arch' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >       struct arch *arch;
> >                    ^~~~
> >     cc1: all warnings being treated as errors
> >
> >       43     7.30 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
> >     util/annotate.c: In function 'hist_entry__get_data_type':
> >     util/annotate.c:2351:36: error: 'arch' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >        if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
> >                                         ^~~~~~~~~~~~~~~~~~~~~
> >     cc1: all warnings being treated as errors
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This looks fine but I couldn't line up the errors with code in the
> tree. I was curious why the "maybe-uninitialized" was failing. Perhaps
> evsel__get_arch should set the out argument to NULL when an error
> occurs. This fix is also good but may potentially need repeating for
> other evsel__get_arch cases, so a fix in evsel__get_arch may be
> preferable.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Trying with this on top, i.e. what you suggests:

From 70e6fd996ce7f9c9adbb30640ed666025bf6f1e4 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 3 Apr 2024 16:49:54 -0300
Subject: [PATCH 1/1] WIP

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f316e0b65897957a..35235147b111e788 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -838,8 +838,10 @@ static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
 	struct arch *arch;
 	int err;
 
-	if (!arch_name)
+	if (!arch_name) {
+		*parch = NULL;
 		return errno;
+	}
 
 	*parch = arch = arch__find(arch_name);
 	if (arch == NULL) {
@@ -2266,7 +2268,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 {
 	struct map_symbol *ms = &he->ms;
 	struct evsel *evsel = hists_to_evsel(he->hists);
-	struct arch *arch = NULL;
+	struct arch *arch;
 	struct disasm_line *dl;
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
-- 
2.44.0


