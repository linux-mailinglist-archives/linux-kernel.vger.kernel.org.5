Return-Path: <linux-kernel+bounces-158740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF408B2459
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A2B24804
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F214A4EC;
	Thu, 25 Apr 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM7BzCKf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EF13328D;
	Thu, 25 Apr 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056590; cv=none; b=usIfTDapLq9j4014L09GOBg61yY43B3r6uckZyKqU7tBuSqbfnDZL7G7ZZ38cHYONJ78T3Ukh404OdXJXNQOYl8JZWB0tA/DT69VAP9pZP8S2THHSv+geqwtJ8rSCzDsY5WeChZ3lzNLYCFXMnFKWp4vGbEzEDU36/Bf/5A1g5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056590; c=relaxed/simple;
	bh=S4j43sOmzi/yE2O9yobieBlpo8nx80XmbizZ0kSyVEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ21ZygnP8Bs1yhQ4XqhmWPNrf1/mK4mZEo1GJMDt0grl4yFK5h5m6DY3xahuqZroV6BHAyT1LP1mnYOSQtxZ/Lo/BjnjkV2ykGqFV6TS26olH4J44A6x8ak7Z0QlbsDXJEM2iIlh9TlBDcoag8cTbGdniQDO6hshq8RO/ZWU40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM7BzCKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8239C113CC;
	Thu, 25 Apr 2024 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714056588;
	bh=S4j43sOmzi/yE2O9yobieBlpo8nx80XmbizZ0kSyVEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aM7BzCKfjR0vLKsgJSg0svPXtMy3Pfdi7JVPuSeESlO7X1u8UvC85RMAv7isI2AVA
	 kf8uJfqQqj9/SxbOiQQiMMv+kzrYz6OTSUlrQl3+UDrxYVu/gFnfKgV9dEEvV3fywK
	 N94r9EaGHGz4P0e+kUQl8hu/CCeGOuuThK5NAOPjlG7W1jfnBUtWF3gpPc+36CuPhN
	 mVFnSjDC3h22DAKsfv/Ao2u2GJDex4z2sPO+8qYJ3mnrYDFZQw23wKUn5gVuijPrhe
	 ENEay6Pu3D6WiYLECqRGmb4Eqv/UddLFxBp534VWCxl/lOEU7A+RntxqwBd42haSHl
	 V93Ses6xb9VCQ==
Date: Thu, 25 Apr 2024 11:49:44 -0300
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
Message-ID: <ZiptiObJxYPeXqK_@x1>
References: <20240425005157.1104789-1-namhyung@kernel.org>
 <20240425005157.1104789-2-namhyung@kernel.org>
 <Zipk0p08bxO7werD@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zipk0p08bxO7werD@x1>

On Thu, Apr 25, 2024 at 11:12:40AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 24, 2024 at 05:51:57PM -0700, Namhyung Kim wrote:
> > +++ b/tools/perf/util/disasm.c
> > @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> >  		mutex_unlock(&dso->lock);
> > +	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
> > +		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
> >  	}
 
> Fixed up to take into account a recent patch by Ian that turned that
> &dso->lock into dso__lock(dso):
 
> +++ b/tools/perf/util/disasm.c
> @@ -1156,6 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  			}
>  		}
>  		mutex_unlock(dso__lock(dso));
> +	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
> +		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
>  	}

Nah, I forgot some more stuff, this is what I have now:

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 2921b32357705a02..72aec8f61b944a7a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1156,8 +1156,8 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 			}
 		}
 		mutex_unlock(dso__lock(dso));
-	} else if (dso->binary_type == DSO_BINARY_TYPE__NOT_FOUND) {
-		dso->binary_type = DSO_BINARY_TYPE__BUILD_ID_CACHE;
+	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
+		dso__set_binary_type(dso, DSO_BINARY_TYPE__BUILD_ID_CACHE);
 	}
 
 	free(build_id_path);

