Return-Path: <linux-kernel+bounces-1525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA4814FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A58281E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9963588B;
	Fri, 15 Dec 2023 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyKhJrsi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3730130;
	Fri, 15 Dec 2023 18:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1178DC433C8;
	Fri, 15 Dec 2023 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702664809;
	bh=Uxm+Ld+49+IKhlPh3+Lb8jzwdKp8zlKxeU1rGQh+uUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyKhJrsiRdLEraV527cDOWhQbObcRjmIiegnkMgjULdaB9RzGb1HQkGRM+Lm7TaU3
	 Vd2dNC1zrVz/PzMIrXykUKke7H9RrYz9YFA1DNmU+m4fMQsq9jDV8li1Zq/wY8LeqC
	 pvzYyEOUF+BF14YGXPZOhrG2XnTjzVq0Jl34g6rC9jHAvCep/zilYrFVY7VPybFNWI
	 RONJmn9L9AtfqemjvL87HZiR8bGD4h7Wdsv3hQBgkUNU59nVuaDwDSr7lyfnueujQN
	 gWhDD1rmFg8806u2BzFSf4ldI1i1/judHa1Kr6Ql5wAoFbF6mhK3IHPN4Zpxcyz5T+
	 VwduapuXXn36w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5A65F403EF; Fri, 15 Dec 2023 15:26:46 -0300 (-03)
Date: Fri, 15 Dec 2023 15:26:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>, maz@kernel.org,
	marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXyaZjwrpy6toGf6@kernel.org>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <ZXxyanyZgWBTOnoK@kernel.org>
 <4658ca16-9749-434e-9296-3893aa2a34da@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4658ca16-9749-434e-9296-3893aa2a34da@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Fri, Dec 15, 2023 at 12:59:22PM -0500, Liang, Kan escreveu:
> On 2023-12-15 10:36 a.m., Arnaldo Carvalho de Melo wrote:
> 
> #perf report --header-only | grep event
> # event : name = cpu_atom/cycles:P/, , id = { 7360, 7361, 7362, 7363,
> 7364, 7365, 7366, 7367, 7368, 7369 }, type = 0 (PERF_TYPE_HARDWARE),
> size = 136, config = 0xa00000000, { sample_period, sample_freq } = 3000,
> sample_type = IP|TID|TIME|PERIOD|IDENTIFIER, read_format = ID|LOST,
> disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3,
> sample_id_all = 1
> # event : name = cpu_core/cycles:P/, , id = { 7370, 7371, 7372, 7373,
> 7374, 7375, 7376, 7377, 7378, 7379, 7380, 7381 }, type = 0
> (PERF_TYPE_HARDWARE), size = 136, config = 0x400000000, { sample_period,
> sample_freq } = 3000, sample_type = IP|TID|TIME|PERIOD|IDENTIFIER,
> read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1,
> enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
> 
> I think we should move all the modifiers after the "/". The below patch
> can fix it.
> 
> https://lore.kernel.org/lkml/20231215175455.1300261-1-kan.liang@linux.intel.com/

Right, I implemented it in a slightly different way, but end result
should be the same:

From 5dd1b7ab1ba69ebb8e070923dcc214b7b489ffc2 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 15 Dec 2023 15:23:30 -0300
Subject: [PATCH 1/1] perf evlist: Move event attributes to after the / when
 uniquefying using the PMU name

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6f0892803c2249af..3a9505c99490b372 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2522,7 +2522,7 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 void evlist__uniquify_name(struct evlist *evlist)
 {
 	struct evsel *pos;
-	char *new_name;
+	char *new_name, *attributes;
 	int ret;
 
 	if (perf_pmus__num_core_pmus() == 1)
@@ -2535,8 +2535,16 @@ void evlist__uniquify_name(struct evlist *evlist)
 		if (strchr(pos->name, '/'))
 			continue;
 
-		ret = asprintf(&new_name, "%s/%s/",
-			       pos->pmu_name, pos->name);
+		attributes = strchr(pos->name, ':');
+		if (attributes)
+			*attributes = '\0';
+
+		ret = asprintf(&new_name, "%s/%s/%s",
+			       pos->pmu_name, pos->name, attributes ? attributes + 1 : "");
+
+		if (attributes)
+			*attributes = ':';
+
 		if (ret) {
 			free(pos->name);
 			pos->name = new_name;
-- 
2.43.0


