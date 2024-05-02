Return-Path: <linux-kernel+bounces-166532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045388B9BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7291F22F29
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E4913C67D;
	Thu,  2 May 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcMM+n2H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF1219F6;
	Thu,  2 May 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657818; cv=none; b=DddzT/4aXbD9AGTCjFg0B3H3SypnHAZ6st13X8DSVSfHYsVx9J97rfo/lVztxq7fBDb63lD2nsi5NXbKFlSym32+KXi4OBn0RimoHvqbZ+HyOXju/QDwV+Ha5fai52Bkvy3beYoexSsNoB+aAkuVLPtSdmGENP8FIzC1Gv/Mpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657818; c=relaxed/simple;
	bh=CnVtUj//jjfGpdXeVZA+hatKTZhYD0wcuPbPNXJPn/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp+mqCn4WOXWKcgy9CH3eplBMYb0GK5Ha+x+dAKhQ4jH+AOyh7y6vTtzY6IpGBSLC0pme2wg2ylItl9PV8KCxQ8cMNyo2qZOP8ZSkDrB7edndCIBAxBl+HoMYWk7vbl4Uc3sVA8+w9eewp1fh71DyJXG8avJ/BLxzHJnt0XsH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcMM+n2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791EFC113CC;
	Thu,  2 May 2024 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714657818;
	bh=CnVtUj//jjfGpdXeVZA+hatKTZhYD0wcuPbPNXJPn/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcMM+n2HtzRjjLn1JuoPxqNa4/bX+u/BXmbrECRET3J81DWgR/+mJlBRZAx5lp1jJ
	 ta32APyATg1FnCqBV+Cd8S8AoCKeN9EtaMiYVMsrKCkYV5kd0a42XYeDJCbkqGpG2v
	 dU9nTBUN1vGlONpfIxVId3PH6g0HJbMkI8PS913/Ol2c0MywNtYTz8/RAyxN6w+ypQ
	 i0KtGXhdJqxjx0FM3NGQf+oGrHYedqfZr0xxgeL5Cgxf3iiuXLTrGoDUElZNlGl6pB
	 y7j4oF3mJfpAou0PPmpkwAuFnMWZ4mCGzSQ9G07XxdLZYFEvdae0bZQbObXU0GyrND
	 CKvWYtmdLhHKQ==
Date: Thu, 2 May 2024 10:50:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/6] perf annotate-data: Collect global variables in
 advance
Message-ID: <ZjOaFS7_vEojFnUZ@x1>
References: <20240502060011.1838090-1-namhyung@kernel.org>
 <20240502060011.1838090-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502060011.1838090-3-namhyung@kernel.org>

On Wed, May 01, 2024 at 11:00:07PM -0700, Namhyung Kim wrote:
> Currently it looks up global variables from the current CU using address
> and name.  But it sometimes fails to find a variable as the variable can
> come from a different CU - but it's still strange it failed to find a
> declaration for some reason.
> 
> Anyway, it can collect all global variables from all CU once and then
> lookup them later on.  This slightly improves the success rate of my
> test data set.

It would be interesting you could provide examples from your test data
set, i.e. after this patch these extra global variables were considered
in the test results, with some tool output, etc.

This would help intersested parties to reproduce your results,
validate the end result, etc.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.c | 57 +++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 12d5faff3b7a..4dd0911904f2 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -28,6 +28,8 @@
>  /* register number of the stack pointer */
>  #define X86_REG_SP 7
>  
> +static void delete_var_types(struct die_var_type *var_types);
> +
>  enum type_state_kind {
>  	TSR_KIND_INVALID = 0,
>  	TSR_KIND_TYPE,
> @@ -557,8 +559,8 @@ static bool global_var__add(struct data_loc_info *dloc, u64 addr,
>  	if (gvar == NULL)
>  		return false;
>  
> -	gvar->name = strdup(name);
> -	if (gvar->name == NULL) {
> +	gvar->name = name ? strdup(name) : NULL;
> +	if (name && gvar->name == NULL) {
>  		free(gvar);
>  		return false;
>  	}
> @@ -612,6 +614,53 @@ static bool get_global_var_info(struct data_loc_info *dloc, u64 addr,
>  	return true;
>  }
>  
> +static void global_var__collect(struct data_loc_info *dloc)
> +{
> +	Dwarf *dwarf = dloc->di->dbg;
> +	Dwarf_Off off, next_off;
> +	Dwarf_Die cu_die, type_die;
> +	size_t header_size;
> +
> +	/* Iterate all CU and collect global variables that have no location in a register. */
> +	off = 0;
> +	while (dwarf_nextcu(dwarf, off, &next_off, &header_size,
> +			    NULL, NULL, NULL) == 0) {
> +		struct die_var_type *var_types = NULL;
> +		struct die_var_type *pos;
> +
> +		if (dwarf_offdie(dwarf, off + header_size, &cu_die) == NULL) {
> +			off = next_off;
> +			continue;
> +		}
> +
> +		die_collect_global_vars(&cu_die, &var_types);
> +
> +		for (pos = var_types; pos; pos = pos->next) {
> +			const char *var_name = NULL;
> +			int var_offset = 0;
> +
> +			if (pos->reg != -1)
> +				continue;
> +
> +			if (!dwarf_offdie(dwarf, pos->die_off, &type_die))
> +				continue;
> +
> +			if (!get_global_var_info(dloc, pos->addr, &var_name,
> +						 &var_offset))
> +				continue;
> +
> +			if (var_offset != 0)
> +				continue;
> +
> +			global_var__add(dloc, pos->addr, var_name, &type_die);
> +		}
> +
> +		delete_var_types(var_types);
> +
> +		off = next_off;
> +	}
> +}
> +
>  static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
>  				u64 ip, u64 var_addr, int *var_offset,
>  				Dwarf_Die *type_die)
> @@ -620,8 +669,12 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
>  	int offset;
>  	const char *var_name = NULL;
>  	struct global_var_entry *gvar;
> +	struct dso *dso = map__dso(dloc->ms->map);
>  	Dwarf_Die var_die;
>  
> +	if (RB_EMPTY_ROOT(&dso->global_vars))
> +		global_var__collect(dloc);
> +
>  	gvar = global_var__find(dloc, var_addr);
>  	if (gvar) {
>  		if (!dwarf_offdie(dloc->di->dbg, gvar->die_offset, type_die))
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

