Return-Path: <linux-kernel+bounces-70420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6CD859785
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414371C20BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9E6D1A4;
	Sun, 18 Feb 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nok6Eciu"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136816BFA5
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708268783; cv=none; b=rCKhmB6oMc5ZE0FNyt0/fBGFIKOnWCi2HJsghLT8WR3nJLyaCk8UA5YGYiqQx283a2C0Uz6vt605PTlkxGKlshLVfEbHw9U6xQeg+5MWtMVZ3pbcCArx7icSclbiIbfIW+WzomWHl5CHOyyxz0ct4yCdjaX4XbDUVbfJF5XxC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708268783; c=relaxed/simple;
	bh=tGxXT1XhuS6erETM7SEYMuB1n/Ny+q6o/Kd1LNyFGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB/Wh4GIQjoBzYYMk2TAB0zdcpsIXpdJa/8xU1iAZWN241v8AddgEEf/asr326pN52HdDtG1opNc1LcNLxB9rdv7EhwbOQMhi4icGtZTdwxf0w/uuQ1C8AqySz2uI2qrKLcrxu+9YDnmH/+noN4TzHy0em/3/XlNE16cF8i977w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nok6Eciu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2551141a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708268780; x=1708873580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weWvwdjLFnP8JZ5vKjO/UijVTnJpQLLncBhysMzZFhc=;
        b=Nok6EciuTdMz1z1pS6cwicCCDdDOCTlLLo8ABabxLV63CY9iqUxn64wyit7TOT0kaJ
         QX2hm83AMDkBl2NkOt5cVe4oG7h2l8B+qZVKbsRS73MoqmO7I6RX4K8TrcKX5jtJzLUk
         tI3z8QSxh8c2UaT8LapZMXo5PsTJA9g3cZCDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708268780; x=1708873580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weWvwdjLFnP8JZ5vKjO/UijVTnJpQLLncBhysMzZFhc=;
        b=W/4SlwLjTRVuEb87Sa7vE5eosCHtIRfcbiW5AshMdjKxmWsxXqAWl4ctLAnpcscQzJ
         7zlOPy+k9431BLaZXStd7o4UuNPOB1TmKQMucn6VHC7qK5GHHb3kPg4gmPQ3KTyVYTug
         9YeMP2ovRZFWtO8hTNr8/Guuw733E43AtC9jkaKebAhJ+cBtwermOjdV0TD9m6FUiOHI
         r+mpVr52TvL68e78sLTxKUJ6MJZ3dmWWEV+wMdUhGKFErqy+VRjyMKfNCFm5+waXZc+L
         qIXbaLjcmGV9GLFA2gS5UeIS/7bTfH9CeVSBB6yVD8vZy4RNlv8XNActrt0cOopERyeF
         SGWw==
X-Forwarded-Encrypted: i=1; AJvYcCWHEHLdtnim/bkyreFiPWdB411AKmAQ4kglifnkSK6R2fmwe0xRvx1orAImIkqt+RZTW0BTrfpmdZ6uY1ODeiPrJpep76y9qzMb/DZY
X-Gm-Message-State: AOJu0YxwtuBKcECubDcn5K/CrhkwHUat4HAEuos4x6+r9P2a2y/z0zUd
	5rzygC+302BxAbm1yQSTQ9SFXSLxXzZaQaKegYcCzJ6cusVbBopepN8eK1ozRQ==
X-Google-Smtp-Source: AGHT+IG/mO2zX6w/nhGHQ9iPPz8f+kIiHx6ka4l6BoesYRu+P37Fs580FgkZTJG8iwIS84D9OwUWXw==
X-Received: by 2002:a05:6a00:450e:b0:6e2:9bca:fdc4 with SMTP id cw14-20020a056a00450e00b006e29bcafdc4mr4640585pfb.21.1708268780315;
        Sun, 18 Feb 2024 07:06:20 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a30-20020aa78e9e000000b006e45fc20539sm598295pfr.123.2024.02.18.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:06:19 -0800 (PST)
Date: Sun, 18 Feb 2024 07:06:19 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
Message-ID: <202402180701.FA42F70BE2@keescook>
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>

On Sun, Feb 18, 2024 at 11:55:01AM +0100, Christophe Leroy wrote:
> set_memory_ro() can fail, leaving memory unprotected.
> 
> Check its return and take it into account as an error.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/filter.h | 5 +++--
>  kernel/bpf/core.c      | 4 +++-
>  kernel/bpf/verifier.c  | 4 +++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fee070b9826e..fc0994dc5c72 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -881,14 +881,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
>  
>  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
>  
> -static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> +static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
>  {
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  	if (!fp->jited) {
>  		set_vm_flush_reset_perms(fp);
> -		set_memory_ro((unsigned long)fp, fp->pages);
> +		return set_memory_ro((unsigned long)fp, fp->pages);
>  	}
>  #endif
> +	return 0;
>  }
>  
>  static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 71c459a51d9e..c49619ef55d0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2392,7 +2392,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  	}
>  
>  finalize:
> -	bpf_prog_lock_ro(fp);
> +	*err = bpf_prog_lock_ro(fp);
> +	if (*err)
> +		return fp;

Weird error path, but yes.

>  
>  	/* The tail call compatibility check can only be done at
>  	 * this late stage as we need to determine, if we deal
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c5d68a9d8acc..1f831a6b4bbc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19020,7 +19020,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	 * bpf_prog_load will add the kallsyms for the main program.
>  	 */
>  	for (i = 1; i < env->subprog_cnt; i++) {
> -		bpf_prog_lock_ro(func[i]);
> +		err = bpf_prog_lock_ro(func[i]);
> +		if (err)
> +			goto out_free;
>  		bpf_prog_kallsyms_add(func[i]);
>  	}

Just to double-check if memory permissions being correctly restored on
this error path, I walked back through it and see that it ultimately
lands on vfree(), which appears to just throw the entire mapping away,
so I think that's safe. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

