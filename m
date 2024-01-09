Return-Path: <linux-kernel+bounces-21311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB13828D68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDDB250DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA1A3D397;
	Tue,  9 Jan 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ+y5J++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A93D386
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FEDC433C7;
	Tue,  9 Jan 2024 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704828713;
	bh=DuKYBO+7w/uc0uTUCzs21KjanFoIiR9zDfYC6/3epKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQ+y5J++5lIKysrognLtCk1y9SKnX06Cu3DwizEQODrE63G8NAe2tSS/YyM3wKEEB
	 VApxUUSgVrzygzq2WPp8MltbGWee+lViP1Y+s0M2ImFoxVRSEsYIqfx87kjm2F7qLO
	 l8MmMpTLs/Mn2PbAkCqmEFYWkKOTvugukWXQAI5GGEKvpOa/f9DloA8AqHRXXpsBAe
	 Fd0MpmHfmFbhCz4xtAYXQ65TwLOZj6+2C9riQPOWOrV8MC68WawfUrdAs15ytjOQ8j
	 kEKdEbijsgITbzHaBmNtyCpAPE9w7vDjhk1YRLUoSkMDNdfq+WIZ2CcAUh/BD099Js
	 gZy9Eb4wT+UeQ==
Date: Tue, 9 Jan 2024 11:31:51 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] objtool: make objtool SLS validation fatal when
 building with CONFIG_SLS=y
Message-ID: <20240109193151.nkmn5yfv24tfmodd@treble>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
 <20231213134303.2302285-3-dimitri.ledkov@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213134303.2302285-3-dimitri.ledkov@canonical.com>

On Wed, Dec 13, 2023 at 01:43:01PM +0000, Dimitri John Ledkov wrote:
> Make objtool SLS validation fatal when building with CONFIG_SLS=y,
> currently it is a build.log warning only.
> 
> This is a standalone patch, such that if regressions are identified
> (with any config or toolchain configuration) it can be reverted until
> relevant identified code is fixed up or otherwise
> ignored/silecned/marked as safe.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  tools/objtool/check.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 15df4afae2..9709f037f1 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4500,7 +4500,9 @@ static int validate_sls(struct objtool_file *file)
>  		}
>  	}
>  
> -	return warnings;
> +	/* SLS is an optional security safety feature, make it fatal
> +	 * to ensure no new code is introduced that fails SLS */
> +	return -warnings;
>  }

I'm thinking this patch (and the next one) go too far, yet not far
enough :-)

Too far, because there are still some outstanding randconfig warnings
which need to be fixed.

Not far enough, because there are other warnings which might also have
disastrous effects.  For example, even the "unreachable warning" could
mean missing SLS or retpoline mitigations.

So I'm thinking we should try to get as many of the outstanding warnings
fixed as we can, and then flip the CONFIG_WERROR switch for all
non-fatal warnings.

-- 
Josh

