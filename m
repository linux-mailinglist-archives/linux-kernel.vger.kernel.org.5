Return-Path: <linux-kernel+bounces-165634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF68B8EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5DAB20FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3018040;
	Wed,  1 May 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHoppEpb"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E4DDAB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583796; cv=none; b=i/qYhweKrFsN4Y1i7YegQgh4DA3S4Wp8o/yOgquxC7ZVJbnid862yD9DNcRq0QGwD2qJGOaTa85Bsoise1MVr2YYRVctCOJsUpJgkCd0kZu4ZUtw1PTHV0KrU+FJdpgVS3L2BVpVnl4TkT2r1v04Ww7cz1uA5qzOYrwxH5Zi2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583796; c=relaxed/simple;
	bh=0BmLq37R522FU/HxHiaxBEjlQlb5UJR6+0WcNtEbFCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZW8/SGxlrdb/kk0qDfT0FBL/PwqIU4j6Y0Y8s1HEhFl69xfw0Be+NRE+FGjhBk+uyFmPakcJqcEKEYSkHjBr/5xFWjmwZrZCWrNBqjCYYeLcnYgZXPRMfUk2EchH5wN8ZACwsgPP2hqwOgXuIFoT7APwAXWm0xVVH/cn1k6O4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHoppEpb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51a7d4466bso761232966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714583793; x=1715188593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONQyBcD8VRLw4uQD2Qcjp9+m2MW2Gbhx15MpCK/CXQs=;
        b=BHoppEpbCUtnHzspEiXWLtgu9n6wjtvsillrEj5uqw41Bho0bmrrM74BWxL0EB2IKO
         36vYzf/vzu2p4TGD7yymXyyExRrjzRTvs2KeEVFVKWRyACsEG+tSNv4bokyxFZCcnPkx
         i6Q0jWeduVXM1Wap9CrbKnA+jeaaroxqeuuGK4dvMG5oXWX4tEOgh7jDUyjEXvzWG9YT
         h2sVcMW2FPDvcWZ2uABsqvnReMJS926AckPHABH19uxEE/itO3dO+gn24goRa66EJ+ka
         BtSnsWE1RIStmrVj/irLEZ9yFYTvrgco2Pefl+6eUgDIGGr+2uQzX24LTspmUhE/l60Z
         hA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583793; x=1715188593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONQyBcD8VRLw4uQD2Qcjp9+m2MW2Gbhx15MpCK/CXQs=;
        b=CxBmR8/WP/u3NFIjPgInkLLANz1i/bG6i/B+c7frlTJg28h6fdsEifd983/4s4hyVC
         +G1I9WbsKLsQ0VFZerVqvr3wlPlasTRW2MZBzoIv+EPz5LcaKvZmmPmyUwQJaZJSTUod
         yWkeLUEamEiS8KI4IcknOF1+Il0S9sDXaGgs4/0xUz4n1LUgvrVI5eMIQSpotSZECasy
         FnfS7EZxJTR+pILhzvoJngEZNzOaArrciMicxOepgz14ef3dI74U4ysgHCGug5IpSz3A
         cN1pbBOF+1savbbl1UTzU45y4IICAANM3o4M6L5V451P0Qm6lCkjb3/LObb15Y5Ma39e
         edhw==
X-Forwarded-Encrypted: i=1; AJvYcCUxZxg4jxiLEqrGmPxnrGb8CoUsCNFw+RdPMgIUwoh+uhlaE00UKG5WeWhesKvuSppN7FDf66zM3ljR21NI/KS/9DeX2lV1FjH4CW/U
X-Gm-Message-State: AOJu0YwBB1kbYI7sCkm5bnK4rpkEM/kUcKrHqNU75zEijdCWe2o6ruCR
	0dAgnkHXzocHp+qpCZB2DYSPyGtKW1/ddCEHaRlO1VzHT3lXcUkTHGpdxpJ579wA2WPPWNwNYwN
	1cwN1eYfK1pZVa/7TMtv3z0l8hEBy1XwHzHTl
X-Google-Smtp-Source: AGHT+IHowXyWVWUMsYZG3v7H2VTVJc9cyGycjNtSuZrYRRdK9YOB+oIJBeQ/0JwCKLpK+peFqmNZF1398qplDqqYd6E=
X-Received: by 2002:a17:906:f8d4:b0:a52:5baf:23d with SMTP id
 lh20-20020a170906f8d400b00a525baf023dmr2258407ejb.15.1714583792458; Wed, 01
 May 2024 10:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501100446.1454264-1-usamaarif642@gmail.com>
In-Reply-To: <20240501100446.1454264-1-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 1 May 2024 10:15:54 -0700
Message-ID: <CAJD7tkZ_fmzo8RGGpiH+0uUZCC7Nbnny6iHHfBruk2oa21Pi9Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usama,

On Wed, May 1, 2024 at 3:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
> The condition for writeback can be triggered by allocating random
> memory more than memory.high to push memory into zswap, more than
> zswap.max to trigger writeback if enabled, but less than memory.max
> so that OOM is not triggered. Both values of memory.zswap.writeback
> are tested.

Thanks for working on this :)

>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index f0e488ed90d8..fe0e7221525c 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void *ar=
g)
>         return 0;
>  }
>
> +static int allocate_random_bytes(const char *cgroup, void *arg)
> +{
> +       size_t size =3D (size_t)arg;
> +       char *mem =3D (char *)malloc(size);
> +
> +       if (!mem)
> +               return -1;
> +       for (int i =3D 0; i < size; i++)
> +               mem[i] =3D rand() % 128;
> +       free(mem);
> +       return 0;
> +}
> +
>  static char *setup_test_group_1M(const char *root, const char *name)
>  {
>         char *group_name =3D cg_name(root, name);
> @@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
>         return ret;
>  }
>
> +/* Test to verify the zswap writeback path */
> +static int test_zswap_writeback(const char *root, bool wb)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *test_group;
> +       long zswpwb_before, zswpwb_after;
> +
> +       test_group =3D cg_name(root,
> +               wb ? "zswap_writeback_enabled_test" : "zswap_writeback_di=
sabled_test");
> +       if (!test_group)
> +               goto out;
> +       if (cg_create(test_group))
> +               goto out;
> +       if (cg_write(test_group, "memory.max", "8M"))
> +               goto out;
> +       if (cg_write(test_group, "memory.high", "2M"))
> +               goto out;
> +       if (cg_write(test_group, "memory.zswap.max", "2M"))
> +               goto out;
> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"=
))
> +               goto out;
> +
> +       zswpwb_before =3D cg_read_key_long(test_group, "memory.stat", "zs=
wpwb ");
> +       if (zswpwb_before < 0) {
> +               ksft_print_msg("failed to get zswpwb_before\n");
> +               goto out;
> +       }
> +
> +       /*
> +        * Allocate more than memory.high to push memory into zswap,
> +        * more than zswap.max to trigger writeback if enabled,
> +        * but less than memory.max so that OOM is not triggered
> +        */
> +       if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
> +               goto out;

We set the zswap limit to 2M. So for this to work properly we need to
guarantee that the 3M of random data will compress into more than 2M.
Is this true for all possible zpool implementations and compression
algorithms? How likely for this to break and start producing false
negatives if zswap magically becomes more efficient?

One alternative approach that I used before, although more complex, is
to start by compressing the memory (i.e. through reclaim) without a
zswap limit, and check the zswap usage. Then, fault the memory back
in, set the zswap limit lower than the observed usage, and repeat.
This should guarantee writeback AFAICT.

Also, using memory.reclaim may be easier than memory.high if you
follow this approach, as you would need to raise memory.high again to
be able to decompress the memory.

> +
> +       /* Verify that zswap writeback occurred only if writeback was ena=
bled */
> +       zswpwb_after =3D cg_read_key_long(test_group, "memory.stat", "zsw=
pwb ");
> +       if (wb) {
> +               if (zswpwb_after <=3D zswpwb_before) {
> +                       ksft_print_msg("writeback enabled and zswpwb_afte=
r <=3D zswpwb_before\n");
> +                       goto out;
> +               }
> +       } else {
> +               if (zswpwb_after !=3D zswpwb_before) {
> +                       ksft_print_msg("writeback disabled and zswpwb_aft=
er !=3D zswpwb_before\n");
> +                       goto out;
> +               }
> +       }
> +
> +       ret =3D KSFT_PASS;
> +
> +out:
> +       cg_destroy(test_group);
> +       free(test_group);
> +       return ret;
> +}
> +
> +static int test_zswap_writeback_enabled(const char *root)
> +{
> +       return test_zswap_writeback(root, true);
> +}
> +
> +static int test_zswap_writeback_disabled(const char *root)
> +{
> +       return test_zswap_writeback(root, false);
> +}
> +
>  /*
>   * When trying to store a memcg page in zswap, if the memcg hits its mem=
ory
>   * limit in zswap, writeback should affect only the zswapped pages of th=
at
> @@ -425,6 +506,8 @@ struct zswap_test {
>         T(test_zswap_usage),
>         T(test_swapin_nozswap),
>         T(test_zswapin),
> +       T(test_zswap_writeback_enabled),
> +       T(test_zswap_writeback_disabled),
>         T(test_no_kmem_bypass),
>         T(test_no_invasive_cgroup_shrink),
>  };
> --
> 2.43.0
>

