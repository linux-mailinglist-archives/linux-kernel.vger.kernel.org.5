Return-Path: <linux-kernel+bounces-107996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7D88049F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CDD1F22AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783E2E64F;
	Tue, 19 Mar 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwt93e6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA339AE7;
	Tue, 19 Mar 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872361; cv=none; b=U+8CBhikrHT+hJL1apq5r2Tel5O2oa3Nj6Fy58/26gdKQnWFUbfWuYqF17FxC94KioeDCWUsG21X/X7m2RUIMmVagZ+llHFCrssn3xJj8CCmRzuo0t5kbu6moy+6VblTv0vseQ/BMmr3tJS+XTApwcKA+m/XP180kJhHhiCZEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872361; c=relaxed/simple;
	bh=i0jJsj6QvM/T9Iar8vRpnhnFjXjdbecnQoMeRz8UCm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfQxJwrNiamyU1UGMwNrTNNQ1n7Z+CzbfR+rup0FQsl2Qa4XP4YqQlkeB84YR5FuDE6dtzvkTosnoYiQs6AYk769nhq5qQazG/Oqd/L+eWPgtlkbYULQ53SnjyIvotycWUKxU3j63amJwWhF6lCn6ccrU5oHk3apaUUM7RqRznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwt93e6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79037C433F1;
	Tue, 19 Mar 2024 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710872360;
	bh=i0jJsj6QvM/T9Iar8vRpnhnFjXjdbecnQoMeRz8UCm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zwt93e6S4MGi6Vrjb8S0YIhp2ZYSCunZV3Trr1Vboq1hluAIDUahavKnyjRcyQCry
	 PHneLxbf0VmHR3qJ6bi+kHv5U1762hmxc5zQ5VFwqbDZZhxvIb6yW6rs8vhTppnGLe
	 1EceDQEfvKn10j9FBbYK+fWlKSpb67iuVQDHQiLnS1hYcnJoP9xlFvJ4R+Ssfz+36q
	 ubaas5hxdwkL8SN439jyI3AP37QJ5A0ql6jBw8895asz00VwY/f45lok9Qpd4dcLO5
	 nhZskBupYmH1D09K0i7C7xP+in004Y/V/nbfJKoFUR8HQIg9klAEQRitgnoNhXcpn1
	 riD9iDGZZIE0A==
Date: Tue, 19 Mar 2024 15:19:14 -0300
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
Subject: Re: [PATCH 04/23] perf dwarf-aux: Add die_find_func_rettype()
Message-ID: <ZfnXIm2rRnzVcZ4n@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-5-namhyung@kernel.org>
 <ZfmZobDmVFxEQ6hU@x1>
 <CAM9d7chdEcA7qFS3k=DGfeXcdZP1xWvdory_-Q0WFPfGi0St_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chdEcA7qFS3k=DGfeXcdZP1xWvdory_-Q0WFPfGi0St_Q@mail.gmail.com>

On Tue, Mar 19, 2024 at 10:42:00AM -0700, Namhyung Kim wrote:
> On Tue, Mar 19, 2024 at 6:56 AM Arnaldo Carvalho de Melo
> > > +             return NULL;
> > > +
> > > +     if (die_get_real_type(&tmp_die, die_mem) == NULL)
> > > +             return NULL;
> >
> >
> > Here you check die_get_real_type() return, may I go and do the same for
> > the previous patch to address my review comment?
> 
> Sure thing! :)

Ack?

- Arnaldo

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index cd9364d296b6bf42..09fd6f1f0ed8eac3 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1856,7 +1856,10 @@ static int __die_find_member_offset_cb(Dwarf_Die *die_mem, void *arg)
 	if (offset == loc)
 		return DIE_FIND_CB_END;
 
-	die_get_real_type(die_mem, &type_die);
+	if (die_get_real_type(die_mem, &type_die) == NULL) {
+		// TODO: add a pr_debug_dtp() later for this unlikely failure
+		return DIE_FIND_CB_SIBLING;
+	}
 
 	if (dwarf_aggregate_size(&type_die, &size) < 0)
 		size = 0;

