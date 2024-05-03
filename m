Return-Path: <linux-kernel+bounces-167187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A66C8BA566
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC9F1C21FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D65118B14;
	Fri,  3 May 2024 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djC15hPn"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865C14F62
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703860; cv=none; b=pteEgUnTWDy/30gkym4dLQtt/t0cJdbsuJ8i/12MfVmjaY2HbISj1Svfd2nIaT/NcOKkubXUYsYEO3jbZUd52i6hSHDiUUKtkvnlhYBCT9qTl04QoeZSHnToFTwf0Qs0s/bbQkqztnz2STKuB1yq8oXIvHMYXmta06qyzuZPLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703860; c=relaxed/simple;
	bh=P1tNdnHMeUh1ztf5OxFm/efjzaOJ88pVUMTvLiyAec8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiWOnqBKeO7aRBSmAujlY9BGnZK0HXmhbEJFUCwOdJNEv0hsnoLN7IVInok/NS8DXyl3qmhZ+nCX0CS4apODJAnvpde9Xa8KGwc0opYh2NGWGoYF4j8+L2o3wjg0nyxUg1uHbQsjrcyksFc6hUW9oHaJrde7pke4UCfmoZZ82jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djC15hPn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f72a29f13so660842e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714703857; x=1715308657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOl2gl0CKeCoR9KkGO2oMhcoDMcEE+ph32ZmwgyY4w4=;
        b=djC15hPnAaAk7P1kIi0R9TeufLJ4Tj50BONMb/gtpD6khZu5sABXWSipOGQjyrSMlP
         OEs3s6Q6+PpzFZeL4zHh636lvKGDy/4SinJEmracsMsj4v0KYADf2C/zsjKVWSC8ItM3
         yTB4/Va6xkPqEM4MYTOTj1nFoMYZOSPMvP1Uo3mrcGgFEp2rMC3LBXLctiKxiqMMGYLl
         5ZmT5F+EcKv466cSF12HnrzswJVROtWRJLJktZaEzfT7WXZtoLFiN8QrfPGdNqjdPL3I
         OcygXz5hUqoG7z5S/r72tdVMU90EohaY1gRFSLnxNeNvSKBa9Smq7pCt7sf8C9KIH4tS
         cQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714703857; x=1715308657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOl2gl0CKeCoR9KkGO2oMhcoDMcEE+ph32ZmwgyY4w4=;
        b=rXfGoIryzd39n4fwLzVtZmGsZgz6oLyKgiM+LKH43yJaiJ0x94mouCNdEPm0+5MHb8
         VztqKLWlfcbpdyN7ojQQG/18VQAcZYVtZKiyCq03KhVNtuNdiK0/UR5li4vLsKHsF5rD
         0U7vXZvdH6VE4kI/u1KgGy7BrqWQ7k8SbzETXebyJ6s7A0oEsqZxCXnBMuGMVtsaxJ1Y
         3b9DGXvhbqpQdZ+ZaVZghvcnwcnrmAtt3qptPp+GUVYo4gC/g8Pf+bCTIa113E8kM1/z
         76Cv2BZVjaQu6XlZhqi2VYOrmI0cIrRRnmDXRuMk7x4Ewtn1Ac8ZMGD0g1U5CmRTZtm1
         pQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI2H2G1AZZuImm1hKvZtg0ABEBu1oLXDnGwyx4GzBEgBOOTlM3i67yMwW9MHNPo+QbnDfMNA8WnEmmJkaOqGNLA/D6DxpgD0VKud3+
X-Gm-Message-State: AOJu0YwgQZEIkYYLkjyzwl7L4YRQIuvYZCRhhH5yDMFrA+Eq+AY7n/p4
	sOerktMFKrzay999zf6lyHcjoqtn1evzGBKziRfFLVIuSjB3y+9RfufE6kyOb2B8e9z+MtdLOZu
	758Rew5SXWfE8CytS2yMM5GneKZwRKFbIst92bFkmT31AhBQNI4I6gyQ=
X-Google-Smtp-Source: AGHT+IGD370JRl9Z5QPqGfGyUZ/21OmfZM6h80E/KeOm6QxBNwhg85RkQYXZlxPIcfX6n8xtGAU09uxxERboVwm1xrw=
X-Received: by 2002:ac2:44af:0:b0:51f:53e0:1bc4 with SMTP id
 c15-20020ac244af000000b0051f53e01bc4mr985926lfm.29.1714703856559; Thu, 02 May
 2024 19:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502190223.3975970-1-usamaarif642@gmail.com> <20240502190223.3975970-2-usamaarif642@gmail.com>
In-Reply-To: <20240502190223.3975970-2-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 2 May 2024 19:36:58 -0700
Message-ID: <CAJD7tkbevtBCcWUQYZwyqM7WMjLfN+BNE3LwQjFzNkOEgRO1cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 12:02=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Initate writeback with the below steps and check using
> memory.stat.zswpwb if zswap writeback occurred:
> 1. Allocate memory.
> 2. Reclaim memory equal to the amount that was allocated in step 1.
>    This will move it into zswap.
> 3. Save current zswap usage.
> 4. Move the memory allocated in step 1 back in from zswap.
> 5. Set zswap.max to half the amount that was recorded in step 3.
> 6. Attempt to reclaim memory equal to the amount that was allocated,
>    this will either trigger writeback if its enabled, or reclamation
>    will fail if writeback is disabled as there isn't enough zswap
>    space.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 125 +++++++++++++++++++-
>  1 file changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index f0e488ed90d8..cd864ab825d0 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -50,7 +50,7 @@ static int get_zswap_stored_pages(size_t *value)
>         return read_int("/sys/kernel/debug/zswap/stored_pages", value);
>  }
>
> -static int get_cg_wb_count(const char *cg)
> +static long get_cg_wb_count(const char *cg)
>  {
>         return cg_read_key_long(cg, "memory.stat", "zswpwb");
>  }
> @@ -248,6 +248,127 @@ static int test_zswapin(const char *root)
>         return ret;
>  }
>
> +/*
> + * Initate writeback with the following steps:
> + * 1. Allocate memory.
> + * 2. Reclaim memory equal to the amount that was allocated in step 1.
> +      This will move it into zswap.
> + * 3. Save current zswap usage.
> + * 4. Move the memory allocated in step 1 back in from zswap.
> + * 5. Set zswap.max to half the amount that was recorded in step 3.
> + * 6. Attempt to reclaim memory equal to the amount that was allocated,
> +      this will either trigger writeback if its enabled, or reclamation
> +      will fail if writeback is disabled as there isn't enough zswap spa=
ce.
> + */
> +static int initiate_writeback(const char *cgroup, void *arg)
> +{
> +       char *test_group =3D arg;
> +       size_t memsize =3D MB(4);
> +       int ret =3D -1;
> +       bool wb_enabled =3D cg_read_long(test_group, "memory.zswap.writeb=
ack");
> +       long zswap_usage;

Nit: Reverse christmas tree (i.e. is usually more aesthetically
pleasing, but it isn't consistently followed but up to you. You can
separate the declaration and initialization of wb_enabled to do that
if you choose to.

> +
> +       if (cg_write(test_group, "memory.max", "8M"))
> +               return ret;

Why do we need to set this?

> +
> +       /* Allocate random memory to enusre high zswap memory usage */

typo: ensure

> +       char *mem =3D (char *)malloc(memsize);
> +
> +       if (!mem)
> +               return ret;
> +       for (int i =3D 0; i < memsize; i++)
> +               mem[i] =3D rand() % 128;

I am curious, what compression ratio do you observe in practice with
this? Is there a risk of pages becoming totally incompressible and
skipping zswap? One way to guarantee the page compressibility is to
add a bunch of zeros. I usually fill half of it with zeros and half of
it with random data. Not sure if this is actually required though.

> +
> +       /* Try and reclaim allocated memory */
> +       if (cg_write(test_group, "memory.reclaim", "4M")) {
> +               ksft_print_msg("Failed to reclaim all of the requested me=
mory\n");
> +               goto out;
> +       }
> +
> +       zswap_usage =3D cg_read_long(test_group, "memory.zswap.current");
> +
> +       /* zswpin */
> +       for (int i =3D 0; i < memsize; i++) {
> +               if (mem[i] < 0 || mem[i] > 127) {
> +                       ksft_print_msg("invalid memory\n");
> +                       ret =3D -1;
> +               }
> +       }

I understand this correctness check is not strictly needed, but it is
very weak right now. There is a 50% chance that corruption will be
missed because the range we are checking is half the possible values.

If we want a reliable correctness check, perhaps we should fill the
page with increasing known values instead. Then after zswpin, we can
check that the data is exactly what we filled in the first place.

Is there any value in using random data here? If there is, we can
store a second copy of the array to compare against instead.

> +
> +       if (cg_write_numeric(test_group, "memory.zswap.max", zswap_usage/=
2))
> +               goto out;
> +
> +       /*
> +        * If writeback is enabled, trying to reclaim memory now will tri=
gger a
> +        * writeback as zswap.max is half of what was needed when reclaim=
 ran the first time.
> +        * If writeback is disabled, memory reclaim will fail as zswap is=
 limited and
> +        * it can't writeback to swap.
> +        */
> +       ret =3D cg_write(test_group, "memory.reclaim", "4M");
> +       if (!wb_enabled && ret)

Should we assert that ret is -EBUSY if !wb_enabled instead? Right now
any error code will pass. The test will also pass if reclaim succeeds
while writeback is disabled, which is not correct behavior.

> +               ret =3D 0;
> +out:
> +       free(mem);
> +       return ret;
> +}
> +
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

Why do we need different cgroup names? The tests do not run in
parallel, do they?

> +       if (!test_group)
> +               goto out;
> +       if (cg_create(test_group))
> +               goto out;
> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"=
))
> +               return ret;
> +
> +       zswpwb_before =3D get_cg_wb_count(test_group);
> +       if (zswpwb_before < 0) {

Should we assert zswpwb_before =3D=3D 0 instead?

> +               ksft_print_msg("failed to get zswpwb_before\n");
> +               goto out;
> +       }
> +
> +       if (cg_run(test_group, initiate_writeback, (void *) test_group))

Nit: initiate_writeback() is not a very descriptive name because it
may or may not trigger writeback.

> +               goto out;
> +
> +       /* Verify that zswap writeback occurred only if writeback was ena=
bled */
> +       zswpwb_after =3D get_cg_wb_count(test_group);
> +       if (wb) {
> +               if (zswpwb_after <=3D zswpwb_before) {

If we assert zswpwb_before =3D=3D 0 above, this can be simplified. Also, I
think a single condition is enough, the message contents can be
inferred by which test failed.

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
> @@ -425,6 +546,8 @@ struct zswap_test {
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

