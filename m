Return-Path: <linux-kernel+bounces-4342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E551817BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93E91F24155
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12977207C;
	Mon, 18 Dec 2023 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+z7paLf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0372050;
	Mon, 18 Dec 2023 20:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B81C433C8;
	Mon, 18 Dec 2023 20:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702930998;
	bh=1BbFmHk7YWm21tYfkE1YB3VNtMpu0O976sXjLOROCI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+z7paLfbgZAjpmOTmHVwoxJ6YSx551WdDhzrYfskPGJRhY7uveqGjw9UCH3DT7co
	 LS1GpbLOmclwEHt/hYug9+hLkw9KGvrqwDqpnE9S8LuiDMo6vv0KtqRiTCn74Ll9fY
	 8uxJdMfBDMJO52quiokBGxQUBOgNItz/iN3aIpG80rMSqbH6rCRtYbdEHNuAIG/71a
	 M70KyrYEGbDFKLyrAGJL4lkd3qXkn5+/pe/8R5jgtfH0UHTgFUZzz3PilpLwAMEu5F
	 1R94UaPdvvg/vuxU4ZqVAbThn2bGZ6WmeOkRkhoj4fKlYKpWYnYJu7ZBcS5B7xlzWr
	 BZk1LqjBQZzBQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id E33F6403EF; Mon, 18 Dec 2023 17:23:15 -0300 (-03)
Date: Mon, 18 Dec 2023 17:23:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>, maz@kernel.org,
	marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZYCqM2WQjUHWNUfw@kernel.org>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <ZXxyanyZgWBTOnoK@kernel.org>
 <4658ca16-9749-434e-9296-3893aa2a34da@linux.intel.com>
 <ZXyaZjwrpy6toGf6@kernel.org>
 <14957171-6abd-4fd6-9e05-669b4945c0df@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14957171-6abd-4fd6-9e05-669b4945c0df@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Fri, Dec 15, 2023 at 01:53:12PM -0500, Liang, Kan escreveu:
> On 2023-12-15 1:26 p.m., Arnaldo Carvalho de Melo wrote:
> > Right, I implemented it in a slightly different way, but end result
> > should be the same:

> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Fri, 15 Dec 2023 15:23:30 -0300
> > Subject: [PATCH 1/1] perf evlist: Move event attributes to after the / when uniquefying using the PMU name
 
> Looks good to me and verified.

> Tested-by: Kan Liang <kan.liang@linux.intel.com>

I ended up with a bit more simplified version:

From 22ecc4601e28a12661f14ca877e39348dab6be8e Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 15 Dec 2023 15:23:30 -0300
Subject: [PATCH 1/1] perf evlist: Move event attributes to after the / when
 uniquefying using the PMU name

When turning an event with attributes to the format including the PMU we
need to move the "event:attributes" format to "event/attributes/" so
that we can copy the event displayed and use it in the command line,
i.e. in 'perf top' we had:

 1K cpu_atom/cycles:P/
 11K cpu_core/cycles:P/

If I try to use that on the command line:

  # perf top -e cpu_atom/cycles:P/
  event syntax error: 'cpu_atom/cycles:P/'
                                \___ Bad event or PMU

  Unable to find PMU or event on a PMU of 'cpu_atom'

  Initial error:
  event syntax error: 'cpu_atom/cycles:P/'
                                \___ unknown term 'cycles:P' for pmu
  'cpu_atom'

  valid terms:

    event,pc,edge,offcore_rsp,ldlat,inv,umask,cmask,config,config1,config2,config3,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite ,driver-config,percore,aux-output,aux-sample-size,metric-id,raw,legacy-cache,hardware
  Run
    'perf list' for a list of valid events

  Usage: perf top [<options>]

     -e, --event <event>   event selector. use 'perf list' to list available events
  #

Cc: Hector Martin <marcan@marcan.st>
Cc: Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZXxyanyZgWBTOnoK@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6f0892803c2249af..95f25e9fb994ab2a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2521,9 +2521,8 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 
 void evlist__uniquify_name(struct evlist *evlist)
 {
+	char *new_name, empty_attributes[2] = ":", *attributes;
 	struct evsel *pos;
-	char *new_name;
-	int ret;
 
 	if (perf_pmus__num_core_pmus() == 1)
 		return;
@@ -2535,11 +2534,17 @@ void evlist__uniquify_name(struct evlist *evlist)
 		if (strchr(pos->name, '/'))
 			continue;
 
-		ret = asprintf(&new_name, "%s/%s/",
-			       pos->pmu_name, pos->name);
-		if (ret) {
+		attributes = strchr(pos->name, ':');
+		if (attributes)
+			*attributes = '\0';
+		else
+			attributes = empty_attributes;
+
+		if (asprintf(&new_name, "%s/%s/%s", pos->pmu_name, pos->name, attributes + 1)) {
 			free(pos->name);
 			pos->name = new_name;
+		} else {
+			*attributes = ':';
 		}
 	}
 }
-- 
2.43.0


