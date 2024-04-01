Return-Path: <linux-kernel+bounces-126880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49F8942D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FB828374D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410748781;
	Mon,  1 Apr 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJ7WKCBv"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C247A6B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990586; cv=none; b=qZzPw5/zmM70i+XbiRVRbhe5gDUdrzrD25M51tclkigDxjUS03wU3VZsupK+IKsSQ4HNMkn2Na2U1DBLV6MSTyax6v7XohAHWzm4kqgkfKL/xuOZFM4N5BQ1Z5Rbg04r2JPBKUaMH6h3rq8HmEzZ1PRUZJFhXxqCtCn1PBnH/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990586; c=relaxed/simple;
	bh=1q/v0qVcNPm0O5XhriyDb/Ehqbm3FXH4riUM+31nGzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxPIBJwIiZZ3UNc3uIArllNLoMiHILU9DDfB7EwkoPK/EnfzIVj/4NYcVVkhqmFds9qOw9Pq3wZOuLGFHjviBlzbOzuEFebnwbZlAX5nR9A0WXdVoSLGbCHpwXqtHA06BED0HCKP9rRu/MSqDbINaOZGnTaO1/r2hqI3/3lLyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJ7WKCBv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e25da9c4c4so94065ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711990584; x=1712595384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDxV6bNSrvc/Iw623a9WbvLZVM6IOcYb5oZ/QmrWmKs=;
        b=qJ7WKCBvO989YZqwSbJL7HT4TwJUTUPp082k7NhexXyR1mmJZtgF2sPiAzKiIPpGhi
         +ExSCrZWchbHpUW+5Eka8B1XlIlHWkyrNeSuFy4lI1Nj4FzFHskGi44t5C36+gPLhefx
         E4Oy5aTumgeyc45diIYh7KvDHoEQ01wDDn71Cru/1Aq5+Gp50zf2bfGUDwdITeNDFDwG
         YMOrf0IGJDUMVppEqe4cTVEEQNI4p+g/H9Kadkct4NKDWzKgKNaNZw7yLDqaD5CaCU1v
         K0lvj2tj39SCpwgtRVfSkLGbMZacQK36sEKpfCQlUCR5QLtiNTUx2SRlB3IaBJ6E0GRX
         P0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990584; x=1712595384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDxV6bNSrvc/Iw623a9WbvLZVM6IOcYb5oZ/QmrWmKs=;
        b=ErwTt4Xb+JZ4OqD4LqSs3QLirJc59Bpdg2HyUx8ldqgZGIthw8WRD+FmBJ4gWb2qAu
         /3lbBKCNFXrt8/AiCsR/O3Ln+uzDaHGxJe6/U+jOQOrJmkZX2H1/fL87YhrMsHF4cdMu
         mU+sqcoRiGs186U/9N0g2PJiX0eDMsHx7+VFz64SbcitgzENTXIIsPTTMFtZswyi/KAz
         FBlLrtmnajr975czLEvKO772DIsBPHUn0a5DMt/HVusrHyEtMg2ZvSoaX5IA7I2pBhev
         g2BFWvHxxUnFjlJps5JfjOECWFJOEBlnTG+hSMAsn7vX6HrAcSUwEixIYNeVd42Rc7YU
         E3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXySDdmRitW90hfcsB4ZSMgqfKx0zuq8m0d0cwY4uhk3EkLqiGxS2vbSxDomrB2ust9psQK6eeliMYWk1ehtOy1Rcd04EWqiLTn2pa4
X-Gm-Message-State: AOJu0YyMTu01vePcKqzHqGvqcPTA384BYgeOUzHcx+/cMLQbtD22Mlsu
	J1YG/0UEt1TwtjKfpdgqPrcF1fkQ87nmFBWfAPer71BCsjdfRM3CwGEeFqq0/nDZVXo6I9+JQ9j
	1FOjTbYVLlRO62aOhgHYZsgy6ffHemuXRVRee
X-Google-Smtp-Source: AGHT+IFTdd1JwfLtiYc8oNdWZHXHgjeYwbsJIIaPkvPT2I5M0iROTz3xR1JtzgCIXD+iGiObImXXhsCN6Tpj2/jZ5Jo=
X-Received: by 2002:a17:903:32cc:b0:1e0:a7b0:eabd with SMTP id
 i12-20020a17090332cc00b001e0a7b0eabdmr589138plr.22.1711990583625; Mon, 01 Apr
 2024 09:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401160805.51277-1-yakoyoku@gmail.com>
In-Reply-To: <20240401160805.51277-1-yakoyoku@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 1 Apr 2024 09:56:10 -0700
Message-ID: <CAP-5=fXu4uM=cU8Q=1JP19sELfarNE9BtBmbFW0Uyq2e_HJ6QA@mail.gmail.com>
Subject: Re: [PATCH] perf srcline: Implement addr2line using libdw
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 9:08=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> `perf script` can be quite slow when inlines are enabled, by default it
> spawns an `addr2line` process and communicates with it via pipes, that
> comes with a certain overhead. The other option is to build perf with
> libbfd enabled so that its methods are called directly instead, but due
> to its licensing the resulting binary cannot be redistribuited.
>
> This commit adds the ability for perf to use libdw to query the source
> lines of binaries from the passed addresses. This avoids the process
> spawn overhead and because libdw is licensed dually under
> GPL-2.0-or-later and LGPL-3.0-or-later it can be distributed by
> downstream packagers. Another thing to consider is that if libdebuginfod
> was enabled for libdw then it's used to download debug info, it can be
> switched off by unsetting the `DEBUGINFOD_URLS` envvar.
>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Awesome sauce! Namhyung was just mentioning the idea to do this to me.
I wonder when this lands we can just work to remove all of the
BUILD_NONDISTRO options, namely libbfd, libiberty, etc. I suspect we
have dead/broken code hiding there.

> ---
>  tools/perf/Makefile.config |   7 +-
>  tools/perf/util/srcline.c  | 277 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 281 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 1fe8df97fe88..ab6d41e7a6b6 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -947,13 +947,16 @@ ifdef BUILD_NONDISTRO
>      $(call feature_check,disassembler-init-styled)
>    endif
>
> -  CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
> -  CXXFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
> +  CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT -DHAVE_SYMBOLIZER_SUPPORT
> +  CXXFLAGS +=3D -DHAVE_LIBBFD_SUPPORT -DHAVE_SYMBOLIZER_SUPPORT

What does SYMBOLIZER mean in this context? Shouldn't the code be gated
on say a HAVE_LIBDW?

>    ifeq ($(feature-libbfd-buildid), 1)
>      CFLAGS +=3D -DHAVE_LIBBFD_BUILDID_SUPPORT
>    else
>      $(warning Old version of libbfd/binutils things like PE executable p=
rofiling will not be available)
>    endif
> +else ifndef NO_LIBDW_DWARF_UNWIND
> +  CFLAGS +=3D -DHAVE_SYMBOLIZER_SUPPORT
> +  CXXFLAGS +=3D -DHAVE_SYMBOLIZER_SUPPORT
>  endif
>
>  ifndef NO_DEMANGLE
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 7addc34afcf5..8117424137cc 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -130,6 +130,8 @@ static struct symbol *new_inline_sym(struct dso *dso,
>
>  #define MAX_INLINE_NEST 1024
>
> +#ifdef HAVE_SYMBOLIZER_SUPPORT
> +
>  #ifdef HAVE_LIBBFD_SUPPORT
>
>  /*
> @@ -372,6 +374,279 @@ void dso__free_a2l(struct dso *dso)
>
>  #else /* HAVE_LIBBFD_SUPPORT */
>
> +#include <elfutils/libdwfl.h>
> +#include <dwarf.h>
> +
> +static char *debuginfo_path =3D NULL;
> +
> +static const Dwfl_Callbacks offline_callbacks =3D {
> +       /* We use this table for core files too.  */
> +       .find_elf =3D dwfl_build_id_find_elf,
> +       .find_debuginfo =3D dwfl_standard_find_debuginfo,
> +       .section_address =3D dwfl_offline_section_address,
> +       .debuginfo_path =3D &debuginfo_path,
> +
> +};
> +
> +struct a2l_data {

Perhaps libdw_a2l_data to avoid confusion with data used for forked
addr2line. Could you comment the variables? Names like "input" are
fairly generic so you could provide an example of what their values
are. It is also useful to comment when something like a string is
owned by the struct, so that cleaning it up can be checked.

> +       const char *input;
> +       Dwarf_Addr addr;
> +       Dwarf_Addr bias;
> +
> +       bool found;
> +       const char *filename;
> +       const char *funcname;
> +       int line;

Moving "found" and "line" later will avoid padding. As this data is
attached to a DSO, does there need to be some kind of locking protocol
for >1 symbolizing the same DSO? Perhaps these should be filled in as
out arguments to avoid this kind of complexity.

Also, there is some DSO clean up happening in:
https://lore.kernel.org/lkml/CAM9d7chqnsDBCVFoK2hSs=3D22QrXBS=3D13Px5hGA4hM=
=3Dho7CZd2g@mail.gmail.com/
where accessor functions are used for the sake of reference count checking:
https://perf.wiki.kernel.org/index.php/Reference_Count_Checking
which may cause some minor conflicts with this patch.

> +
> +       Dwfl *dwfl;
> +       Dwfl_Module *mod;
> +       GElf_Sym **syms;
> +};
> +
> +static const char *get_diename(Dwarf_Die *die)
> +{
> +       Dwarf_Attribute attr;
> +       const char *name;
> +
> +       name =3D dwarf_formstring(
> +               dwarf_attr_integrate(die, DW_AT_MIPS_linkage_name, &attr)=
 ?:
> +                       dwarf_attr_integrate(die, DW_AT_linkage_name, &at=
tr));
> +
> +       if (name =3D=3D NULL)
> +               name =3D dwarf_diename(die) ?: "??";
> +
> +       return name;
> +}
> +
> +static void find_address_in_section(struct a2l_data *a2l)
> +{
> +       Dwarf_Addr addr;
> +       Dwfl_Line *line;
> +
> +       if (a2l->found)
> +               return;
> +
> +       a2l->mod =3D dwfl_addrmodule(a2l->dwfl, a2l->addr);
> +       if (!a2l->mod)
> +               return;
> +
> +       dwfl_module_getdwarf(a2l->mod, &a2l->bias);
> +       addr =3D a2l->addr + a2l->bias;
> +
> +       line =3D dwfl_module_getsrc(a2l->mod, addr);
> +       if (!line)
> +               line =3D dwfl_getsrc(a2l->dwfl, addr);
> +       if (!line)
> +               return;
> +
> +       a2l->filename =3D dwfl_lineinfo(line, NULL, &a2l->line, NULL, NUL=
L, NULL);
> +       a2l->funcname =3D dwfl_module_addrname(a2l->mod, addr);
> +
> +       if (a2l->filename && !strlen(a2l->filename))
> +               a2l->filename =3D NULL;
> +       else
> +               a2l->found =3D true;
> +}
> +
> +static struct a2l_data *addr2line_init(const char *path)
> +{
> +       Dwfl *dwfl;
> +       struct a2l_data *a2l =3D NULL;
> +
> +       dwfl =3D dwfl_begin(&offline_callbacks);
> +       if (!dwfl)
> +               goto out;
> +
> +       if (dwfl_report_offline(dwfl, "", path, -1) =3D=3D NULL)
> +               return NULL;
> +
> +       a2l =3D zalloc(sizeof(*a2l));
> +       if (a2l =3D=3D NULL)
> +               goto out;
> +
> +       a2l->dwfl =3D dwfl;
> +       a2l->input =3D strdup(path);
> +       if (a2l->input =3D=3D NULL)
> +               goto out;
> +
> +       if (dwfl_report_end(dwfl, NULL, NULL))
> +               goto out;
> +
> +       return a2l;
> +
> +out:
> +       if (a2l) {
> +               zfree((char **)&a2l->input);
> +               free(a2l);
> +       }
> +       dwfl_end(dwfl);
> +       return NULL;
> +}
> +
> +static void addr2line_cleanup(struct a2l_data *a2l)
> +{
> +       if (a2l->dwfl)
> +               dwfl_end(a2l->dwfl);
> +       zfree((char **)&a2l->input);
> +       zfree(&a2l->syms);
> +       free(a2l);
> +}
> +
> +static int inline_list__append_dso_a2l(struct dso *dso,
> +                                      struct inline_node *node,
> +                                      struct symbol *sym)
> +{
> +       struct a2l_data *a2l =3D dso->a2l;
> +       struct symbol *inline_sym =3D new_inline_sym(dso, sym, a2l->funcn=
ame);
> +       char *srcline =3D NULL;
> +
> +       if (a2l->filename)
> +               srcline =3D srcline_from_fileline(a2l->filename, a2l->lin=
e);
> +
> +       return inline_list__append(inline_sym, srcline, node);
> +}
> +
> +static int get_inline_function(struct dso *dso, struct inline_node *node=
,
> +                              struct symbol *sym)
> +{
> +       struct a2l_data *a2l =3D dso->a2l;
> +       Dwarf_Addr addr =3D a2l->addr + a2l->bias;
> +       Dwarf_Addr bias =3D 0;
> +       Dwarf_Die *cudie =3D dwfl_module_addrdie(a2l->mod, addr, &bias);
> +
> +       Dwarf_Die *scopes =3D NULL;
> +       int nscopes =3D dwarf_getscopes(cudie, addr - bias, &scopes);
> +       if (nscopes < 0)
> +               return 0;
> +
> +       if (nscopes > 0) {

Try to prefer early return to avoid indenting the code. So I think the
above can just be:

if (nscopes <=3D 0)
    return 0;

and then you don't need this "if (nscopes > 0) {"

> +               Dwarf_Die subroutine;
> +               Dwarf_Off dieoff =3D dwarf_dieoffset(&scopes[0]);
> +               dwarf_offdie(dwfl_module_getdwarf(a2l->mod, &bias), dieof=
f,
> +                            &subroutine);
> +               free(scopes);
> +               scopes =3D NULL;

Is this dead code?

> +
> +               nscopes =3D dwarf_getscopes_die(&subroutine, &scopes);
> +               if (nscopes > 1) {

Similar early return comment to above to avoid indentation.

Thanks,
Ian

> +                       Dwarf_Die cu;
> +                       Dwarf_Files *files;
> +                       if (dwarf_diecu(&scopes[0], &cu, NULL, NULL) !=3D=
 NULL &&
> +                           dwarf_getsrcfiles(cudie, &files, NULL) =3D=3D=
 0) {
> +                               for (int i =3D 0; i < nscopes - 1; i++) {
> +                                       Dwarf_Word val;
> +                                       Dwarf_Attribute attr;
> +                                       Dwarf_Die *die =3D &scopes[i];
> +                                       if (dwarf_tag(die) !=3D
> +                                           DW_TAG_inlined_subroutine)
> +                                               continue;
> +
> +                                       for (int j =3D i + 1; j < nscopes=
; j++) {
> +                                               Dwarf_Die *parent =3D &sc=
opes[j];
> +                                               int tag =3D dwarf_tag(par=
ent);
> +                                               if (tag =3D=3D DW_TAG_inl=
ined_subroutine ||
> +                                                   tag =3D=3D DW_TAG_ent=
ry_point ||
> +                                                   tag =3D=3D DW_TAG_sub=
program) {
> +                                                       a2l->funcname =3D
> +                                                               get_diena=
me(
> +                                                                       p=
arent);
> +                                                       break;
> +                                               }
> +                                       }
> +
> +                                       a2l->filename =3D NULL;
> +                                       a2l->line =3D 0;
> +                                       if (dwarf_formudata(
> +                                                   dwarf_attr(die,
> +                                                              DW_AT_call=
_file,
> +                                                              &attr),
> +                                                   &val) =3D=3D 0)
> +                                               a2l->filename =3D dwarf_f=
ilesrc(
> +                                                       files, val, NULL,=
 NULL);
> +
> +                                       if (dwarf_formudata(
> +                                                   dwarf_attr(die,
> +                                                              DW_AT_call=
_line,
> +                                                              &attr),
> +                                                   &val) =3D=3D 0)
> +                                               a2l->line =3D val;
> +
> +                                       if (a2l->filename !=3D NULL)
> +                                               if (inline_list__append_d=
so_a2l(
> +                                                       dso, node, sym))
> +                                                       return 0;
> +                               }
> +                       }
> +               }
> +       }
> +       free(scopes);
> +
> +       return 1;
> +}
> +
> +static int addr2line(const char *dso_name, u64 addr, char **file,
> +                    unsigned int *line, struct dso *dso, bool unwind_inl=
ines,
> +                    struct inline_node *node, struct symbol *sym)
> +{
> +       int ret =3D 0;
> +       struct a2l_data *a2l =3D dso->a2l;
> +
> +       if (!a2l) {
> +               dso->a2l =3D addr2line_init(dso_name);
> +               a2l =3D dso->a2l;
> +       }
> +
> +       if (a2l =3D=3D NULL) {
> +               if (!symbol_conf.disable_add2line_warn)
> +                       pr_warning("addr2line_init failed for %s\n", dso_=
name);
> +               return 0;
> +       }
> +
> +       a2l->addr =3D addr;
> +       a2l->found =3D false;
> +
> +       find_address_in_section(a2l);
> +
> +       if (!a2l->found)
> +               return 0;
> +
> +       if (unwind_inlines) {
> +               if (node && inline_list__append_dso_a2l(dso, node, sym))
> +                       return 0;
> +
> +               if (node && !get_inline_function(dso, node, sym))
> +                       return 0;
> +
> +               ret =3D 1;
> +       }
> +
> +       if (file) {
> +               *file =3D a2l->filename ? strdup(a2l->filename) : NULL;
> +               ret =3D *file ? 1 : 0;
> +       }
> +
> +       if (line)
> +               *line =3D (unsigned int)a2l->line;
> +
> +       return ret;
> +}
> +
> +void dso__free_a2l(struct dso *dso)
> +{
> +       struct a2l_data *a2l =3D dso->a2l;
> +
> +       if (!a2l)
> +               return;
> +
> +       addr2line_cleanup(a2l);
> +
> +       dso->a2l =3D NULL;
> +}
> +
> +#endif /* HAVE_LIBBFD_SUPPORT */
> +
> +#else /* HAVE_SYMBOLIZER_SUPPORT */
> +
>  static int filename_split(char *filename, unsigned int *line_nr)
>  {
>         char *sep;
> @@ -788,7 +1063,7 @@ void dso__free_a2l(struct dso *dso)
>         dso->a2l =3D NULL;
>  }
>
> -#endif /* HAVE_LIBBFD_SUPPORT */
> +#endif /* HAVE_SYMBOLIZER_SUPPORT */
>
>  static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>                                         struct dso *dso, struct symbol *s=
ym)
> --
> 2.44.0
>

