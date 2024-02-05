Return-Path: <linux-kernel+bounces-53801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED484A6B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51091F23570
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B3C50273;
	Mon,  5 Feb 2024 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSe+YHdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8A481B1;
	Mon,  5 Feb 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160178; cv=none; b=ZRQx4qx958FrfxRPEkoIk4aiN90KahNxMY0CVoaTPvg+fkwtsPM2p4VgdHHVaaazRu7qwDM3+x6DwbJL3jZPfz6VOflInl0itOZWlozNgBy3FHPZz98osNYs5ePmHZKNntD7qZ6zfAY550eZ48OMb33pBBq9AGlgZ6MrIYgmmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160178; c=relaxed/simple;
	bh=gIJqV3GMvqU06kq7guQE1A5kqVd2/defoIhiF42CLmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiyyaiKyfrDH07AOPk1TS90HVKdV1r/XQ5qDqtBoMSSxgA8DqmPio2G+58VpK8dplJSgy9SAm9X3fiAjegwDYMuKYZqIRnF1Fc+DNy1iIJQNC0MoiZLuBLW/r2+xBADONmgJfbWyfsaLln9ZVptMAu9ng2SeT0nPFjl0qOp9MM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSe+YHdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB2FC433F1;
	Mon,  5 Feb 2024 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160178;
	bh=gIJqV3GMvqU06kq7guQE1A5kqVd2/defoIhiF42CLmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSe+YHddlccusr7ABupcCp9O5z2Agk20uLwXqeYelTWA+p8m4oijoUwBYjkcQ99e+
	 LRKrCFcvW7e/yrIa7E/3kJD6xQaGb4wzGY1yWhj70QvXVLuM5zlRutfK0rVLYwS/EC
	 RxCqGmMgoz/mOMhXWVkkh5fr0Ez6gXOssicvTxZTXDG7oR9gXL8tRxwI2P1B8kBUNT
	 7YXTEhos2zRjgtI5Y46BA7RV0Fp2/dKLeE3bpvU6iBwXCWsf6BJ4YyfBjdnhlesIZx
	 t5x60q4iJjl5fkVXLLbJJgoOV5qrd0imDwZJRFQXg5n29EEoEt7urLUbxS12v/2xD2
	 gvrHW49p4PJbA==
Date: Mon, 5 Feb 2024 16:09:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] perf thread_map: Free strlist on normal path in
 thread_map__new_by_tid_str()
Message-ID: <ZcEybM9bV6vP9n7K@x1>
References: <20240205104616.132417-1-yangjihong1@huawei.com>
 <20240205104616.132417-6-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205104616.132417-6-yangjihong1@huawei.com>

On Mon, Feb 05, 2024 at 10:46:16AM +0000, Yang Jihong wrote:
> slist needs to be freed in both error path and normal path in
> thread_map__new_by_tid_str().

Please add:

Fixes: b52956c961be3a04 ("perf tools: Allow multiple threads or processes in record, stat, top")

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/thread_map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
> index e848579e61a8..ea3b431b9783 100644
> --- a/tools/perf/util/thread_map.c
> +++ b/tools/perf/util/thread_map.c
> @@ -280,13 +280,13 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
>  		threads->nr = ntasks;
>  	}
>  out:
> +	strlist__delete(slist);
>  	if (threads)
>  		refcount_set(&threads->refcnt, 1);
>  	return threads;
>  
>  out_free_threads:
>  	zfree(&threads);
> -	strlist__delete(slist);
>  	goto out;
>  }
>  
> -- 
> 2.34.1

