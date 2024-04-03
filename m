Return-Path: <linux-kernel+bounces-130078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4928973EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A4B31E72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641E14D45F;
	Wed,  3 Apr 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV7hJIgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7826292
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157380; cv=none; b=EexPlykUWrzUxde6zncQJxNdWbzk9OJY0PuZJp+wbM8ayjXVNZIi6rN3nG+nhVz0a12i/3ma2XR62hy0BCz3PZOZuTKBrEJQgCpupAnvau8iZsJDNZBSkOGVfOnrORGI5gb8fJkr7N9TpqkzFX9GIymeJ3mA8RT67cNOT20UvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157380; c=relaxed/simple;
	bh=riKi8wnczMz8UTMFc9nPxQ0MsS2H5IgGazls9fbwT4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bwrYjyXCBZP3yfpQ9rznWBSwRNtvuCWIYn6wkfY8eKZhygJGo8do5hMYyO4KGuWxcCV/g/CHwOlLJWnb/swd1B3zSsVgHBHDv34/pWOguhn7pantwuJyG3VfDBjB6yGkyTgco2jJ3z7FEh0LXe0TJ/mYcCIULgaOJ/mqRBF87UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV7hJIgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B534EC433C7;
	Wed,  3 Apr 2024 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712157380;
	bh=riKi8wnczMz8UTMFc9nPxQ0MsS2H5IgGazls9fbwT4c=;
	h=Date:From:To:Cc:Subject:From;
	b=EV7hJIgPnUPfC1PqLnYiJNImMHGwrLVqxEmvCO4iL+TKaQc1EpHlvXdEBpNY6EAgD
	 JrI89htlDHWXATzVVXSd3PWcnt7Z6V9uFQoUU+BOnPnipbYZAlgUJ4iTIkenfxYXxp
	 jNOQb0aQsz4OB+7EtY33o2S2bom2VKEzyxJhnWK6Fx/ZEAHMOHo28aixPTuYbs+itR
	 YRRy9W1sa7bWB3fDIyMoEKPYcJSabc67NAgh0n39pQUJNXHTNbf7LmWBlw5zIetod5
	 RtsPAwHCixvoWgmceTl/98nvwxLA/8h9SwEB1nAATC40QSKlCSiFlVEPrTgKLGVPHB
	 lopy4vxdM69YA==
Date: Wed, 3 Apr 2024 12:16:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf annotate: Initialize 'arch' variable not to trip
 some -Werror=maybe-uninitialized
Message-ID: <Zg1ywF7uRsfXYfYS@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In some older distros the build is failing due to
-Werror=maybe-uninitialized, in this case we know that this isn't the
case because 'arch' gets initialized by evsel__get_arch(), so just init
it to NULL to silence those cases.

E.g.:

    32    17.12 opensuse:15.5                 : FAIL gcc version 7.5.0 (SUSE Linux)
        util/annotate.c: In function 'hist_entry__get_data_type':
    util/annotate.c:2269:15: error: 'arch' may be used uninitialized in this function [-Werror=maybe-uninitialized]
      struct arch *arch;
                   ^~~~
    cc1: all warnings being treated as errors

      43     7.30 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    util/annotate.c: In function 'hist_entry__get_data_type':
    util/annotate.c:2351:36: error: 'arch' may be used uninitialized in this function [-Werror=maybe-uninitialized]
       if (map__dso(ms->map)->kernel && arch__is(arch, "x86") &&
                                        ^~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b795f27f26024f35..f316e0b65897957a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2266,7 +2266,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 {
 	struct map_symbol *ms = &he->ms;
 	struct evsel *evsel = hists_to_evsel(he->hists);
-	struct arch *arch;
+	struct arch *arch = NULL;
 	struct disasm_line *dl;
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *op_loc;
-- 
2.44.0


