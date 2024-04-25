Return-Path: <linux-kernel+bounces-158668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA48B23A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8F41C209A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B814A0B9;
	Thu, 25 Apr 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rea49bX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982A14A08A;
	Thu, 25 Apr 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054360; cv=none; b=NzoZ6BpixfD+ZRR8v1CeLpp5+NWEXijE8Qm+qOJkEcOdBmjzSpU5qplSJIxNGgtBi6QTzWsS+t/V63z5XhwtWDh12/6FJfU9QGKy+4CL0w8/cXMA9suXOQz7JJfejELQVAb0PvJ2GLq1ZiX9N7LIBpZO9Eze4J5kVVKCTQTBCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054360; c=relaxed/simple;
	bh=9cICcM8ZQlXyY6PN93HTqQikUXtMY8paiV5smzFHaps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL/CRbcjdXw//K6gt/kDv7a2T4ftgViheLOqdmpmuMovl2UEqS8dvYev4S/98rTdAlc/Uo692ZIg+c1DpCSVUmk075urHJeUhg/7Td3tiIYcS/URvHMXGrrrsTlzzYWrGxcLQATEqwIdcYTAAvt3RiFmTlebJHcsLx3p8gLepZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rea49bX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFE9C113CE;
	Thu, 25 Apr 2024 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714054359;
	bh=9cICcM8ZQlXyY6PN93HTqQikUXtMY8paiV5smzFHaps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rea49bX5nph7NYR/01w0KxxTo8BJ8bTnw+Pdr3YLJRP3J8ZMr642uTwRKv/A1ITuK
	 +irwwpQjSuC6pVao+lAFp1f3dib0FCzhZ6k8Rb2sC12D8ujlnxvjgA0iV4TmXvMnOD
	 2yC0YAB9yVjewnyEWkYDVPSseVR3vxBnhGCZV5T+5UiW9MbzBDYMCxeGCymdyyPJck
	 NICeSVqhbCC+GEXFqkQQlYQNHPgsckwCrAtwm+m+0bqwB6C3WuIsDHvb9Auy76qTBe
	 GDx8QNT7ZnJPConRIOoZUxqJWSuQ1IqTjfgIeO/GEJH7DS8F5LE6C6zBv2Ui1vadqM
	 LAroS/7iTRtog==
Date: Thu, 25 Apr 2024 11:12:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf annotate: Update dso binary type when try
 build-id
Message-ID: <Zipk0p08bxO7werD@x1>
References: <20240425005157.1104789-1-namhyung@kernel.org>
 <20240425005157.1104789-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425005157.1104789-2-namhyung@kernel.org>

On Wed, Apr 24, 2024 at 05:51:57PM -0700, Namhyung Kim wrote:
> dso__disassemble_filename() tries to get the filename for objdump (or
> capstone) using build-id.  But I found sometimes it didn't disassemble
> some functions.  It turned out that those functions belong to a dso
> which has no binary type set.  It seems it sets the binary type for some
> special files only - like kernel (kallsyms or kcore) or BPF images.  And
> there's a logic to skip dso with DSO_BINARY_TYPE__NOT_FOUND.
> 
> As it's checked the build-id cache linke, it should set the binary type
> as DSO_BINARY_TYPE__BUILD_ID_CACHE.
> 
> Fixes: 873a83731f1c ("perf annotate: Skip DSOs not found")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/disasm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 412101f2cf2a..6d1125e687b7 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  			}
>  		}
>  		mutex_unlock(&dso->lock);
> +	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
> +		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
>  	}
>  
>  	free(build_id_path);

Fixed up to take into account a recent patch by Ian that turned that
&dso->lock into dso__lock(dso):

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 70650808e2e7bf88..2921b32357705a02 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 			}
 		}
 		mutex_unlock(dso__lock(dso));
+	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
+		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
 	}
 
 	free(build_id_path);

