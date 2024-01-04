Return-Path: <linux-kernel+bounces-17233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0097824A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A51F232B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79E2C6AD;
	Thu,  4 Jan 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7spoNeU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671302C68F;
	Thu,  4 Jan 2024 21:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF1C433C7;
	Thu,  4 Jan 2024 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704403422;
	bh=VIyfw1phAScaI5WARkugbBS2lpSOHPiAcwls60APFyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7spoNeUr1nz8XL4sUh4IHmD2fbM4mKlo8ftu+ClxUISgXAJeOHY7guKDbwskXTAm
	 i9xl2Y74i0AZablyNMllAmfK9pvfjFLPL0NvQ6tu/E5RMrX3gCeBWxZIyUAwFnSfT6
	 FWBKW4Bx8uAyRVv3A/NNVfaPUPv3iDGRr8IqN9L4Fc1uneP1AMm5c6t5sYW0MQa0ov
	 VYD8BbCLzEAPgo2bMMoO4pd5Lu0E70CDqhdanmO4iBXrift4XSmJAfck6b14szlJnv
	 WbSk08cnvdp1uq9EOykKT126BfddGDLXqJuAA6j0c+M95lUKX5058W9ccgjSV3XQP1
	 a48iqovgmzjJQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id ED74F403EF; Thu,  4 Jan 2024 18:23:39 -0300 (-03)
Date: Thu, 4 Jan 2024 18:23:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, yaowenbin <yaowenbin1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf tui: don't ignore job control
Message-ID: <ZZch2_ceYO-UI71B@kernel.org>
References: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
 <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 27, 2022 at 09:57:40PM +0100, Ahelenia Ziemiańska escreveu:
> In its infinite wisdom, by default, SLang sets susp undef,
> and this can only be un-done by calling SLtty_set_suspend_state(true).
> After every SLang_init_tty().
> 
> Additionally, no provisions are made for maintaining the teletype
> attributes across suspend/continue (outside of curses emulation mode(?!),
> which provides full support, naturally), so we need to save and restore
> the flags ourselves, as well as reset the text colours when going under.
> We need to also re-draw the screen, and raising SIGWINCH, shockingly,
> Just Works.
> 
> The correct solution would be to Not Use SLang, but as a stop-gap,
> this makes TUI perf report usable.

This was in the compost pile for a long time, but I got to it, indeed
'perf report' works, the refresh after returning to it, etc.

'perf top' needs some care, but we can do it later.

About not using slang, perf started with newt, I moved to slang, there
are people suggesting we move to some more modern thing, maybe
notcurses?

- Arnaldo
 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> Yeah, somehow I didn't hit that in my tests, but it was relatively easy
> to trigger when I tried. A full partial write retry loop is an overkill
> here, I think, and few other places in perf actually try to resubmit
> partial writes, so.
> 
>  tools/perf/ui/browsers/annotate.c |  1 +
>  tools/perf/ui/browsers/hists.c    |  2 ++
>  tools/perf/ui/browsers/scripts.c  |  1 +
>  tools/perf/ui/tui/setup.c         | 22 ++++++++++++++++++++++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index c03fa76c02ff..6a4ffbf66c7f 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -942,6 +942,7 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>  	/* reset abort key so that it can get Ctrl-C as a key */
>  	SLang_reset_tty();
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  
>  	return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
>  }
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index b72ee6822222..2479e6d42e7c 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3010,6 +3010,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
>  	/* reset abort key so that it can get Ctrl-C as a key */
>  	SLang_reset_tty();
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  
>  	if (min_pcnt)
>  		browser->min_pcnt = min_pcnt;
> @@ -3682,6 +3683,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>  	/* reset abort key so that it can get Ctrl-C as a key */
>  	SLang_reset_tty();
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  
>  	memset(&action, 0, sizeof(action));
>  
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 47d2c7a8cbe1..50d45054ed6c 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -166,6 +166,7 @@ void run_script(char *cmd)
>  	printf("\033[c\033[H\033[J");
>  	fflush(stdout);
>  	SLang_init_tty(0, 0, 0);
> +	SLtty_set_suspend_state(true);
>  	SLsmg_refresh();
>  }
>  
> diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
> index a3b8c397c24d..09524ba04975 100644
> --- a/tools/perf/ui/tui/setup.c
> +++ b/tools/perf/ui/tui/setup.c
> @@ -2,12 +2,14 @@
>  #include <signal.h>
>  #include <stdbool.h>
>  #include <stdlib.h>
> +#include <termios.h>
>  #include <unistd.h>
>  #include <linux/kernel.h>
>  #ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
>  #endif
>  
> +#include "../../util/color.h"
>  #include "../../util/debug.h"
>  #include "../../perf.h"
>  #include "../browser.h"
> @@ -122,6 +124,23 @@ static void ui__signal(int sig)
>  	exit(0);
>  }
>  
> +static void ui__sigcont(int sig)
> +{
> +	static struct termios tty;
> +
> +	if (sig == SIGTSTP) {
> +		while (tcgetattr(SLang_TT_Read_FD, &tty) == -1 && errno == EINTR)
> +			;
> +		while (write(SLang_TT_Read_FD, PERF_COLOR_RESET, sizeof(PERF_COLOR_RESET) - 1) == -1 && errno == EINTR)
> +			;
> +		raise(SIGSTOP);
> +	} else {
> +		while (tcsetattr(SLang_TT_Read_FD, TCSADRAIN, &tty) == -1 && errno == EINTR)
> +			;
> +		raise(SIGWINCH);
> +	}
> +}
> +
>  int ui__init(void)
>  {
>  	int err;
> @@ -136,6 +155,7 @@ int ui__init(void)
>  	err = SLang_init_tty(-1, 0, 0);
>  	if (err < 0)
>  		goto out;
> +	SLtty_set_suspend_state(true);
>  
>  	err = SLkp_init();
>  	if (err < 0) {
> @@ -150,6 +170,8 @@ int ui__init(void)
>  	signal(SIGINT, ui__signal);
>  	signal(SIGQUIT, ui__signal);
>  	signal(SIGTERM, ui__signal);
> +	signal(SIGTSTP, ui__sigcont);
> +	signal(SIGCONT, ui__sigcont);
>  
>  	perf_error__register(&perf_tui_eops);
>  
> -- 
> 2.30.2
> 



-- 

- Arnaldo

