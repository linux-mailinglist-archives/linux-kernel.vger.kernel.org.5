Return-Path: <linux-kernel+bounces-141535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6D8A1F81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF721C223AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6914F65;
	Thu, 11 Apr 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbiADfm/"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D4134D1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863724; cv=none; b=HO4AQqAqgHNZoyb3LjmfalcHVhJJ2Cbs9elEUzMb84f3Q0D1HOzntHspKyoLgDEJxVF6VQ7GNs2ukT+HWLHOdZ9Ji3mXLYqltDprO1N12NCJQSpjHNrPWz4go7KRHMhex0VPyvB6LXk5YiY86L+pFWR8m4fKbUtxAR0O+uqPL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863724; c=relaxed/simple;
	bh=2wqO/VI9wR+rKR4772S2Xx4bJZOinojvgpSdE2lM2F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bT4nwJAXj21TX2L+gyDCb1JzdEEftNdyO3F2uXYroUBESvCdR0Hd7QSlmkjIvuY2Ig4qqsu4maCWmb6Nbab9r7c4vh8r5Tj36kc1fDgimqnIKjKDjJOgy3JGZgxJYFp/0Y0XOO4kLplfr6QjZ+k1WLdkAnJV55hdN/HjPyFEiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbiADfm/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346406a5fb9so79164f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712863721; x=1713468521; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1A7ZU9tA23qg01DfqJpEf36vCcYeGeVpUyv+TFXWWw=;
        b=BbiADfm/c35oRV3R/hHPsfHJjcXmDr2+BCRwon4Sp6BiOjs07ku12R8tnGdxH4BGtc
         8omqox/6rXV31SfIk8TYJnSK4P6CJIZ2/iR3+V8CW8hPaitoWtMftbmScR5rDTn/txd9
         7SbVAxHuGuNLko4/v4WFWN7JdPrWJrg9gjqGzSVkIle/rw5SyGYykovX9NDkgimSJa/d
         2W4H5uFSPcdtBtwUuSwDYIOai/mHncWnr3fJ3LfqV5mLC2UY0Q3HxY2duRXQJgX4x6i/
         1XMosVOYAzlGpNjzvdF4pM+g/HEU+I6J8MCqPialDdLdfUH0YibBJ/nFKLDgJhRSeriM
         CAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863721; x=1713468521;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1A7ZU9tA23qg01DfqJpEf36vCcYeGeVpUyv+TFXWWw=;
        b=XIpE2MTAvzjJ42cJyDjFZr1tlqF79m/uSWNXmIbq0bO0cR2YzEwfognPUJihKRTzcE
         zio50A6tqXZO9TP1j2V94zGhKPYHzDdK3OotG1nioyNjaYKql7HIzUAH+N7zu/ULG/91
         FppiPm9V+zNCnBbwM+t4X9cZS+HlZfDits8OPej9AiI/OLlTxP+eZZHuLiCbWB1Ohulg
         fXKtrsF2bLF0SRm9s168u0w8+6+8DGWEedfIs1HfnjOdvDninE4HpQvqYSEQk5SN05AU
         PVzphHkssWJ0z25OD3IY4+QmQ5IMA3+7771XMJo0yAATEbX7kyErtnQKt+lM6Mk8gScb
         hpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUua3z0TCxS5TtFey/YSrTiSf4+LdXl8jUJA3dB8+/o7Vlk68ZwpDvGpLkxZasWO/hNr1wNJslkned3dEZwccTiJKiwhBNzmBBD6OPE
X-Gm-Message-State: AOJu0YyFEjc/52e4lm8vJcMtPRWfpdBiaIGTXydLaWE37lzZtznkbVZf
	eoVwsOyyO/U6JASN6cAwK+DRoacp/V3fL9oZHO4lzIAMPeZyCNjPcbhahSBIM/7wliQ4J1NR0c6
	C+vhqpyqa09aB9Flccthi3dVXWJA=
X-Google-Smtp-Source: AGHT+IF6SwtxhEqBajCZV1lyN/TSkqnQU9MJQsLYQn40kzU8czMJFbQN5Rh5VJNgsDHLZdJruzC6MpZIQjy6+LKD1Jo=
X-Received: by 2002:a5d:4e0a:0:b0:33d:fb3:9021 with SMTP id
 p10-20020a5d4e0a000000b0033d0fb39021mr309171wrt.54.1712863720669; Thu, 11 Apr
 2024 12:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com> <20240311204019.1183634-8-bjohannesmeyer@gmail.com>
In-Reply-To: <20240311204019.1183634-8-bjohannesmeyer@gmail.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Thu, 11 Apr 2024 12:28:29 -0700
Message-ID: <CAOZ5it1NaWyUM4GTJ+XrMet7aQXT27q1VZ4FeD8osbTccVpj9w@mail.gmail.com>
Subject: Re: [PATCH 7/7] scripts/faddr2line: Check only two symbols when
 calculating symbol size
To: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org, 
	Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 1:40=E2=80=AFPM Brian Johannesmeyer
<bjohannesmeyer@gmail.com> wrote:
>
> Rather than looping through each symbol in a particular section to
> calculate a symbol's size, grep for the symbol and its immediate
> successor, and only use those two symbols.
>
> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> ---
>  scripts/faddr2line | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 1fa6beef9f97..70d5a4602a92 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -252,7 +252,7 @@ __faddr2line() {
>                                 found=3D2
>                                 break
>                         fi
> -               done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -=
v sec=3D$sym_sec '$7 =3D=3D sec' | sort --key=3D2)
> +               done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -=
v sec=3D$sym_sec '$7 =3D=3D sec' | sort --key=3D2 | ${GREP} -A1 " ${sym_nam=
e}$")
>
>                 if [[ $found =3D 0 ]]; then
>                         warn "can't find symbol: sym_name: $sym_name sym_=
sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
> --
> 2.34.1
>

Hey Josh,

I just noticed that this patch does not correctly handle duplicate
sym_names. To fix, the "--no-group-separator" option should be added
as follows:

> -               done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -=
v sec=3D$sym_sec '$7 =3D=3D sec' | sort --key=3D2)
> +               done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -=
v sec=3D$sym_sec '$7 =3D=3D sec' | sort --key=3D2 | ${GREP} -A1 --no-group-=
separator " ${sym_name}$")

Would you like me to re-submit the patch series with this fix?

Thanks,

Brian

