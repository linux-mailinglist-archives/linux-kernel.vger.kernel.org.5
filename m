Return-Path: <linux-kernel+bounces-145873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45398A5C34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCED1F22A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B595156898;
	Mon, 15 Apr 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gibnX/Zv"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1BB156895
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212868; cv=none; b=msQuVpg0NTRMWx84C6AkD+qOLSzyjV4pHy8gp5WG02Pion2qloxq1+opqNNkRAxcc0VCAt4a8iCcSctMyRuw29Vw/26V82whtDtB/q0BdVahA3CWs+557UoltCVrTngG5224lAcusELZ9qwrnB7th8Xhcc2mKB+g6mD4qLBDZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212868; c=relaxed/simple;
	bh=YWWNLAuTWhqTxUfsMHMi21ZtDWl4VTUnXLF6UYpG08I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUHZS8n8ZIBJZHu+l1Ysj/le8MHgoxvsb9hNMk8T5ElMiFcNZaAV/tFB6TGbzSItPGCDSaGOQ/KXuhFxiOuCI3CXbc+1QKYD8d+FxE0/hS9OmnakMuKJxDewXo9Shl6rkvCWcjnjcUGuksP7J/vfy/5rAoCYZCYV1IkyFinKDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gibnX/Zv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2220a389390so1622574fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713212864; x=1713817664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RJIY+n1THl4Og3bwdrrfCfeqvoZNA/rwl+yUf6pHzc=;
        b=gibnX/ZvgkQlZs179K/3oJ2ywkWUo9Wys5cmJj/lEJoKeZWezki4ID4MJ70G9sPhyI
         HIFl3kqOj6eKK/GAwjpUheT0lm96meXnEZXPdar8K1A5ftqGzobLeTVs5ST9fAucBVhO
         2/1MtrOTCal+FL5mJwUbGu2UAWsAdnNqjUWw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212864; x=1713817664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RJIY+n1THl4Og3bwdrrfCfeqvoZNA/rwl+yUf6pHzc=;
        b=T2oggBGqIaY6MWMz1Jyf8Ih0JYY6pbgUTQ7GWlSaYF1ITpir+tQ34Z2g6QrqNiKQZV
         8qyocqo4EiJql7RJ0sf6hubANQoxVEAJ3axv9AM8o/6BbiJy/4EzNF0I855Ws3kM/dgh
         JNsDPIdRpIvVrNdJNYrq9jtA44qwAkuA9uMY3dOfVL2D7Zq1Od5hppeBfmn4ZpWoHPab
         v/FDajMEnO+/Vr56lLkBQ5UE6xmQeM7VlM3TjDN6MxShTTX+kAURR/ncb8xS1eRWp3cb
         1M3Jgbs1f6Ipjrm+OGs3wDW1MMiGvtaZZyuAfuLu4820fICjOYKQ1H2ZF4+elM3bRq9J
         jwbw==
X-Forwarded-Encrypted: i=1; AJvYcCVmIB3fyr05beob0ZpoMoqQh9e+dHn4ekAa8fNN8qz/muR+VCFXyKoOSKYGD4ClfGNhyCR+8uVf1s7sczFx/MzwlX6+S2aseq9BvKXU
X-Gm-Message-State: AOJu0YxHmrqPEkLmyBEd/Rqk764SGNHfh2Q5X/aQYFWoHOSCyAsp1XK0
	sM9VHdUIhEuotbyk2Ji/7HNmJPL4KJMg2+AWo5MBB0TRnPI1p5Z5CIsT8M0w/PMeh86qkLBI5TF
	O66yhNBgRM7/LM8bVUKETjSscBEQqfnrdbnYi
X-Google-Smtp-Source: AGHT+IGpgVPCV92d+R3UlsqTSLZBjek2VtqCidg00gg6yncTI8Fxx9kop3PSbTvCmdLmkjI54JVDIbqEx9QANbp9+sQ=
X-Received: by 2002:a05:6870:249c:b0:235:b0b:87a6 with SMTP id
 s28-20020a056870249c00b002350b0b87a6mr134718oaq.13.1713212863040; Mon, 15 Apr
 2024 13:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-4-jeffxu@chromium.org>
 <e1744539-a843-468a-9101-ce7a08669394@collabora.com>
In-Reply-To: <e1744539-a843-468a-9101-ce7a08669394@collabora.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 15 Apr 2024 13:27:32 -0700
Message-ID: <CABi2SkVnhcOpeA63XoKq97Uc_VyWdLUqYdOtUXxJ1fos5-Tq2g@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] selftest mm/mseal memory sealing
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, corbet@lwn.net, Liam.Howlett@oracle.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:32=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Please fix following for this and fifth patch as well:
>
> --> checkpatch.pl --codespell tools/testing/selftests/mm/mseal_test.c
>
> WARNING: Macros with flow control statements should be avoided
> #42: FILE: tools/testing/selftests/mm/mseal_test.c:42:
> +#define FAIL_TEST_IF_FALSE(c) do {\
> +               if (!(c)) {\
> +                       ksft_test_result_fail("%s, line:%d\n", __func__,
> __LINE__);\
> +                       goto test_end;\
> +               } \
> +       } \
> +       while (0)
>
> WARNING: Macros with flow control statements should be avoided
> #50: FILE: tools/testing/selftests/mm/mseal_test.c:50:
> +#define SKIP_TEST_IF_FALSE(c) do {\
> +               if (!(c)) {\
> +                       ksft_test_result_skip("%s, line:%d\n", __func__,
> __LINE__);\
> +                       goto test_end;\
> +               } \
> +       } \
> +       while (0)
>
> WARNING: Macros with flow control statements should be avoided
> #59: FILE: tools/testing/selftests/mm/mseal_test.c:59:
> +#define TEST_END_CHECK() {\
> +               ksft_test_result_pass("%s\n", __func__);\
> +               return;\
> +test_end:\
> +               return;\
> +}
>
I tried to fix those warnings of checkpatch in the past, but no good
solution. If I put the condition check in the test, the code will have
too many "if" and decrease readability.  If there is a better
solution, I'm happy to do that, suggestions are welcome.

>
> On 4/15/24 9:35 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > selftest for memory sealing change in mmap() and mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/.gitignore   |    1 +
> >  tools/testing/selftests/mm/Makefile     |    1 +
> >  tools/testing/selftests/mm/mseal_test.c | 1836 +++++++++++++++++++++++
> >  3 files changed, 1838 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index d26e962f2ac4..98eaa4590f11 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -47,3 +47,4 @@ mkdirty
> >  va_high_addr_switch
> >  hugetlb_fault_after_madv
> >  hugetlb_madv_vs_map
> > +mseal_test
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index eb5f39a2668b..95d10fe1b3c1 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -59,6 +59,7 @@ TEST_GEN_FILES +=3D mlock2-tests
> >  TEST_GEN_FILES +=3D mrelease_test
> >  TEST_GEN_FILES +=3D mremap_dontunmap
> >  TEST_GEN_FILES +=3D mremap_test
> > +TEST_GEN_FILES +=3D mseal_test
> >  TEST_GEN_FILES +=3D on-fault-limit
> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >  TEST_GEN_FILES +=3D thuge-gen
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > new file mode 100644
> > index 000000000000..06c780d1d8e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/mseal_test.
> > +static void __write_pkey_reg(u64 pkey_reg)
> > +{
> > +#if defined(__i386__) || defined(__x86_64__) /* arch */
> > +     unsigned int eax =3D pkey_reg;
> > +     unsigned int ecx =3D 0;
> > +     unsigned int edx =3D 0;
> > +
> > +     asm volatile(".byte 0x0f,0x01,0xef\n\t"
> > +                     : : "a" (eax), "c" (ecx), "d" (edx));
> > +     assert(pkey_reg =3D=3D __read_pkey_reg());
> Use ksft_exit_fail_msg instead of assert to stay inside TAP format if
> condition is false and error is generated.
>
I can remove the usage of assert() from the test.

> > +int main(int argc, char **argv)
> > +{
> > +     bool test_seal =3D seal_support();
> > +
> > +     ksft_print_header();
> > +
> > +     if (!test_seal)
> > +             ksft_exit_skip("sealing not supported, check CONFIG_64BIT=
\n");
> > +
> > +     if (!pkey_supported())
> > +             ksft_print_msg("PKEY not supported\n");
> > +
> > +     ksft_set_plan(80);
> > +
> > +     test_seal_addseal();
> > +     test_seal_unmapped_start();
> > +     test_seal_unmapped_middle();
> > +     test_seal_unmapped_end();
> > +     test_seal_multiple_vmas();
> > +     test_seal_split_start();
> > +     test_seal_split_end();
> > +     test_seal_invalid_input();
> > +     test_seal_zero_length();
> > +     test_seal_twice();
> > +
> > +     test_seal_mprotect(false);
> > +     test_seal_mprotect(true);
> > +
> > +     test_seal_start_mprotect(false);
> > +     test_seal_start_mprotect(true);
> > +
> > +     test_seal_end_mprotect(false);
> > +     test_seal_end_mprotect(true);
> > +
> > +     test_seal_mprotect_unalign_len(false);
> > +     test_seal_mprotect_unalign_len(true);
> > +
> > +     test_seal_mprotect_unalign_len_variant_2(false);
> > +     test_seal_mprotect_unalign_len_variant_2(true);
> > +
> > +     test_seal_mprotect_two_vma(false);
> > +     test_seal_mprotect_two_vma(true);
> > +
> > +     test_seal_mprotect_two_vma_with_split(false);
> > +     test_seal_mprotect_two_vma_with_split(true);
> > +
> > +     test_seal_mprotect_partial_mprotect(false);
> > +     test_seal_mprotect_partial_mprotect(true);
> > +
> > +     test_seal_mprotect_two_vma_with_gap(false);
> > +     test_seal_mprotect_two_vma_with_gap(true);
> > +
> > +     test_seal_mprotect_merge(false);
> > +     test_seal_mprotect_merge(true);
> > +
> > +     test_seal_mprotect_split(false);
> > +     test_seal_mprotect_split(true);
> > +
> > +     test_seal_munmap(false);
> > +     test_seal_munmap(true);
> > +     test_seal_munmap_two_vma(false);
> > +     test_seal_munmap_two_vma(true);
> > +     test_seal_munmap_vma_with_gap(false);
> > +     test_seal_munmap_vma_with_gap(true);
> > +
> > +     test_munmap_start_freed(false);
> > +     test_munmap_start_freed(true);
> > +     test_munmap_middle_freed(false);
> > +     test_munmap_middle_freed(true);
> > +     test_munmap_end_freed(false);
> > +     test_munmap_end_freed(true);
> > +
> > +     test_seal_mremap_shrink(false);
> > +     test_seal_mremap_shrink(true);
> > +     test_seal_mremap_expand(false);
> > +     test_seal_mremap_expand(true);
> > +     test_seal_mremap_move(false);
> > +     test_seal_mremap_move(true);
> > +
> > +     test_seal_mremap_shrink_fixed(false);
> > +     test_seal_mremap_shrink_fixed(true);
> > +     test_seal_mremap_expand_fixed(false);
> > +     test_seal_mremap_expand_fixed(true);
> > +     test_seal_mremap_move_fixed(false);
> > +     test_seal_mremap_move_fixed(true);
> > +     test_seal_mremap_move_dontunmap(false);
> > +     test_seal_mremap_move_dontunmap(true);
> > +     test_seal_mremap_move_fixed_zero(false);
> > +     test_seal_mremap_move_fixed_zero(true);
> > +     test_seal_mremap_move_dontunmap_anyaddr(false);
> > +     test_seal_mremap_move_dontunmap_anyaddr(true);
> > +     test_seal_discard_ro_anon(false);
> > +     test_seal_discard_ro_anon(true);
> > +     test_seal_discard_ro_anon_on_rw(false);
> > +     test_seal_discard_ro_anon_on_rw(true);
> > +     test_seal_discard_ro_anon_on_shared(false);
> > +     test_seal_discard_ro_anon_on_shared(true);
> > +     test_seal_discard_ro_anon_on_filebacked(false);
> > +     test_seal_discard_ro_anon_on_filebacked(true);
> > +     test_seal_mmap_overwrite_prot(false);
> > +     test_seal_mmap_overwrite_prot(true);
> > +     test_seal_mmap_expand(false);
> > +     test_seal_mmap_expand(true);
> > +     test_seal_mmap_shrink(false);
> > +     test_seal_mmap_shrink(true);
> > +
> > +     test_seal_merge_and_split();
> > +     test_seal_zero_address();
> > +
> > +     test_seal_discard_ro_anon_on_pkey(false);
> > +     test_seal_discard_ro_anon_on_pkey(true);
> > +
> > +     ksft_finished();
> > +     return 0;
> The return isn't needed as ksft_finished() calls exit() with right exit c=
ode.
>
Sure. I can remove "return 0"

Thanks
-Jeff

- Jeff

> > +}
>
> --
> BR,
> Muhammad Usama Anjum

