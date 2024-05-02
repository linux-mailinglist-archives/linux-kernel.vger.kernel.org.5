Return-Path: <linux-kernel+bounces-166825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB18BA011
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496341F22AED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115F5172767;
	Thu,  2 May 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+1iyiT8"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A016FF2B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673440; cv=none; b=oWxUT5odr2k1CGSKBnPhxT5gnj6czCKG+iPJpPle44+92C7hkfEf2/WIrcyt9bR//E6tEDDs20aZQda+F8AeE3fEsZLIr/MgdhHryF18Xl0FkQaKzuY2uBalxIhtpP6PpYCGt6mdD3aQtwxSaEcmXEBqZJp8gbfAFEn+gUuJ0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673440; c=relaxed/simple;
	bh=AcnmsWUVf9xLPrnw47a0KF7R6rwSZZwi3yfcAeEYBoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG41NuYQafRcbDRKHnomU1M3KMSarT7TaUzcgrHICGzqS7i4J4ezervadyq5CkCan8KbU8BXRFEzLHhxpHCfWvgME2aoRVn93H7oQmxoEe5urkkRFGpCns/LxahI38zVCTSZuIKZo6+R7rdPtGW0vlGLsYAEndEbedJKgYwVXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+1iyiT8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so64111cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714673437; x=1715278237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op4gNRXry59h7+j/49DFpIw3hUOH2bKFP8OCK+0oJVg=;
        b=b+1iyiT8D2C1byUzQVaPpbUtGFt873eNI1SpIHglxfbXcSY/FRXTJJ6aKZKQ932WOO
         A03jK6zM787itHBjZ1QZQRGc1K7+OIP8qKpbf/Jrzuyst4a3y5fWLQhSUhxqV8zeNff7
         TA+L9BjVt2mLxGsmbL6K9wDQ/1kzf9BVVihHizEULoLqgRyDg3kyVDPJcHgc5MhOlsfl
         raLASO9BwtHXCm5OfrqRlIHPYVsgg8teW4h0cn2H+alLoFb3F884djglGBfRqaSlV9lU
         2Ffd4z1WvWiCHo9u5rVgqWZNZF3B5c2dtZ8iFZ5QLwk/AjE2QLa3MxIyeCE6pZCsAWcz
         Am/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673437; x=1715278237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op4gNRXry59h7+j/49DFpIw3hUOH2bKFP8OCK+0oJVg=;
        b=W4iwWUSxS3Z464FuFUp6801GgCgxbxWZLbwEfAPZUCx8uknG0dcz7RFUEZ3sLjnCFE
         ZP/LRhZP8g4UXSuleTpLBeINkK+KYn8yBrYajquFUCK+xQLA/izjQsM2wHENI8VFcOOq
         8gf0KyvhWkBJCp9gr/YFg2UR1gDznUI0qgXbUH75GNfhf1/Md0YaWMGrUx1r82lRA99n
         L17LMYBC+v+GoXO5aJPnz2eCLuQqj98JF/vTURtnCgHkjC3mgXp5P3KXYDVdaaT0WRnC
         NADSbGUFsfSbYlxH/pHldjIj8wjmYhlrBk/qV1Il3jevS9Db2WCdIk4HUeKQ9kWVDdyT
         Kl5Q==
X-Gm-Message-State: AOJu0YydnlpmtdUHRkiuqV+HSMGwEU0R4reqSUl+dErZXLXT9vYt4c5M
	yPyO4YaTwBxqPePhjNNm09FPHcfpUNSncFCFyoUazN1FXbCCmuIR2zJGf1GQrVKYwkjxYF4vUlX
	Glg3veE+pFufQZYnWySCqHoOLakqdeOsJXW0q
X-Google-Smtp-Source: AGHT+IEOmEYefU1KrK/38Dg4v//I6kIhkNaNjJ5s7D/q1f0E3fn55QC6u3qit4RAHuumrO5p+JDaANRIeHLszPs4ZYI=
X-Received: by 2002:ac8:594b:0:b0:43a:bcee:eaa2 with SMTP id
 d75a77b69052e-43cd71b0f37mr178961cf.20.1714673437396; Thu, 02 May 2024
 11:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502105853.5338-1-adrian.hunter@intel.com> <20240502105853.5338-6-adrian.hunter@intel.com>
In-Reply-To: <20240502105853.5338-6-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 May 2024 11:10:25 -0700
Message-ID: <CAP-5=fX4UxekyxkaX8EH8UcAXe-JAdXRTCguWmTJ8mARg64h-Q@mail.gmail.com>
Subject: Re: [PATCH 05/10] x86/insn: Add support for REX2 prefix to the
 instruction decoder logic
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 3:59=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Intel Advanced Performance Extensions (APX) uses a new 2-byte prefix name=
d
> REX2 to select extended general purpose registers (EGPRs) i.e. r16 to r31=
.
>
> The REX2 prefix is effectively an extended version of the REX prefix.
>
> REX2 and EVEX are also used with PUSH/POP instructions to provide a
> Push-Pop Acceleration (PPX) hint. With PPX hints, a CPU will attempt to
> fast-forward register data between matching PUSH and POP instructions.
>
> REX2 is valid only with opcodes in maps 0 and 1. Similar extension for
> other maps is provided by the EVEX prefix, covered in a separate patch.
>
> Some opcodes in maps 0 and 1 are reserved under REX2. One of these is use=
d
> for a new 64-bit absolute direct jump instruction JMPABS.
>
> Refer to the Intel Advanced Performance Extensions (Intel APX) Architectu=
re
> Specification for details.
>
> Define a code value for the REX2 prefix (INAT_PFX_REX2), and add attribut=
e
> flags for opcodes reserved under REX2 (INAT_NO_REX2) and to identify
> opcodes (only JMPABS) that require a mandatory REX2 prefix
> (INAT_REX2_VARIANT).
>
> Amend logic to read the REX2 prefix and get the opcode attribute for the
> map number (0 or 1) encoded in the REX2 prefix.
>
> Amend the awk script that generates the attribute tables from the opcode
> map, to recognise "REX2" as attribute INAT_PFX_REX2, and "(!REX2)"
> as attribute INAT_NO_REX2, and "(REX2)" as attribute INAT_REX2_VARIANT.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/include/asm/inat.h                | 11 +++++++++-
>  arch/x86/include/asm/insn.h                | 25 ++++++++++++++++++----
>  arch/x86/lib/insn.c                        | 25 ++++++++++++++++++++++
>  arch/x86/tools/gen-insn-attr-x86.awk       | 11 +++++++++-
>  tools/arch/x86/include/asm/inat.h          | 11 +++++++++-
>  tools/arch/x86/include/asm/insn.h          | 25 ++++++++++++++++++----
>  tools/arch/x86/lib/insn.c                  | 25 ++++++++++++++++++++++
>  tools/arch/x86/tools/gen-insn-attr-x86.awk | 11 +++++++++-
>  8 files changed, 132 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
> index b56c5741581a..1331bdd39a23 100644
> --- a/arch/x86/include/asm/inat.h
> +++ b/arch/x86/include/asm/inat.h
> @@ -35,6 +35,8 @@
>  #define INAT_PFX_VEX2  13      /* 2-bytes VEX prefix */
>  #define INAT_PFX_VEX3  14      /* 3-bytes VEX prefix */
>  #define INAT_PFX_EVEX  15      /* EVEX prefix */
> +/* x86-64 REX2 prefix */
> +#define INAT_PFX_REX2  16      /* 0xD5 */
>
>  #define INAT_LSTPFX_MAX        3
>  #define INAT_LGCPFX_MAX        11
> @@ -50,7 +52,7 @@
>
>  /* Legacy prefix */
>  #define INAT_PFX_OFFS  0
> -#define INAT_PFX_BITS  4
> +#define INAT_PFX_BITS  5
>  #define INAT_PFX_MAX    ((1 << INAT_PFX_BITS) - 1)
>  #define INAT_PFX_MASK  (INAT_PFX_MAX << INAT_PFX_OFFS)
>  /* Escape opcodes */
> @@ -77,6 +79,8 @@
>  #define INAT_VEXOK     (1 << (INAT_FLAG_OFFS + 5))
>  #define INAT_VEXONLY   (1 << (INAT_FLAG_OFFS + 6))
>  #define INAT_EVEXONLY  (1 << (INAT_FLAG_OFFS + 7))
> +#define INAT_NO_REX2   (1 << (INAT_FLAG_OFFS + 8))
> +#define INAT_REX2_VARIANT      (1 << (INAT_FLAG_OFFS + 9))
>  /* Attribute making macros for attribute tables */
>  #define INAT_MAKE_PREFIX(pfx)  (pfx << INAT_PFX_OFFS)
>  #define INAT_MAKE_ESCAPE(esc)  (esc << INAT_ESC_OFFS)
> @@ -128,6 +132,11 @@ static inline int inat_is_rex_prefix(insn_attr_t att=
r)
>         return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_REX;
>  }
>
> +static inline int inat_is_rex2_prefix(insn_attr_t attr)
> +{
> +       return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_REX2;
> +}
> +
>  static inline int inat_last_prefix_id(insn_attr_t attr)
>  {
>         if ((attr & INAT_PFX_MASK) > INAT_LSTPFX_MAX)
> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> index 1b29f58f730f..95249ec1f24e 100644
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -112,10 +112,15 @@ struct insn {
>  #define X86_SIB_INDEX(sib) (((sib) & 0x38) >> 3)
>  #define X86_SIB_BASE(sib) ((sib) & 0x07)
>
> -#define X86_REX_W(rex) ((rex) & 8)
> -#define X86_REX_R(rex) ((rex) & 4)
> -#define X86_REX_X(rex) ((rex) & 2)
> -#define X86_REX_B(rex) ((rex) & 1)
> +#define X86_REX2_M(rex) ((rex) & 0x80) /* REX2 M0 */
> +#define X86_REX2_R(rex) ((rex) & 0x40) /* REX2 R4 */
> +#define X86_REX2_X(rex) ((rex) & 0x20) /* REX2 X4 */
> +#define X86_REX2_B(rex) ((rex) & 0x10) /* REX2 B4 */
> +
> +#define X86_REX_W(rex) ((rex) & 8)     /* REX or REX2 W */
> +#define X86_REX_R(rex) ((rex) & 4)     /* REX or REX2 R3 */
> +#define X86_REX_X(rex) ((rex) & 2)     /* REX or REX2 X3 */
> +#define X86_REX_B(rex) ((rex) & 1)     /* REX or REX2 B3 */
>
>  /* VEX bit flags  */
>  #define X86_VEX_W(vex) ((vex) & 0x80)  /* VEX3 Byte2 */
> @@ -161,6 +166,18 @@ static inline void insn_get_attribute(struct insn *i=
nsn)
>  /* Instruction uses RIP-relative addressing */
>  extern int insn_rip_relative(struct insn *insn);
>
> +static inline int insn_is_rex2(struct insn *insn)
> +{
> +       if (!insn->prefixes.got)
> +               insn_get_prefixes(insn);
> +       return insn->rex_prefix.nbytes =3D=3D 2;

It'd be nice to capture that a rex2 prefix is by definition 2 bytes.
Playing devil's advocate, if there were a REX and a REX2 prefix,
couldn't rex_prefix.nbytes be 3? I'm wondering about other prefix
combinations that may confuse this logic, maybe someone dreams up
doing this for say alignment reasons like "rep ret".

Thanks,
Ian

> +}
> +
> +static inline insn_byte_t insn_rex2_m_bit(struct insn *insn)
> +{
> +       return X86_REX2_M(insn->rex_prefix.bytes[1]);
> +}
> +
>  static inline int insn_is_avx(struct insn *insn)
>  {
>         if (!insn->prefixes.got)
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 1bb155a0955b..6126ddc6e5f5 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -185,6 +185,17 @@ int insn_get_prefixes(struct insn *insn)
>                         if (X86_REX_W(b))
>                                 /* REX.W overrides opnd_size */
>                                 insn->opnd_bytes =3D 8;
> +               } else if (inat_is_rex2_prefix(attr)) {
> +                       insn_set_byte(&insn->rex_prefix, 0, b);
> +                       b =3D peek_nbyte_next(insn_byte_t, insn, 1);
> +                       insn_set_byte(&insn->rex_prefix, 1, b);
> +                       insn->rex_prefix.nbytes =3D 2;
> +                       insn->next_byte +=3D 2;
> +                       if (X86_REX_W(b))
> +                               /* REX.W overrides opnd_size */
> +                               insn->opnd_bytes =3D 8;
> +                       insn->rex_prefix.got =3D 1;
> +                       goto vex_end;
>                 }
>         }
>         insn->rex_prefix.got =3D 1;
> @@ -294,6 +305,20 @@ int insn_get_opcode(struct insn *insn)
>                 goto end;
>         }
>
> +       /* Check if there is REX2 prefix or not */
> +       if (insn_is_rex2(insn)) {
> +               if (insn_rex2_m_bit(insn)) {
> +                       /* map 1 is escape 0x0f */
> +                       insn_attr_t esc_attr =3D inat_get_opcode_attribut=
e(0x0f);
> +
> +                       pfx_id =3D insn_last_prefix_id(insn);
> +                       insn->attr =3D inat_get_escape_attribute(op, pfx_=
id, esc_attr);
> +               } else {
> +                       insn->attr =3D inat_get_opcode_attribute(op);
> +               }
> +               goto end;
> +       }
> +
>         insn->attr =3D inat_get_opcode_attribute(op);
>         while (inat_is_escape(insn->attr)) {
>                 /* Get escaped opcode */
> diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-in=
sn-attr-x86.awk
> index af38469afd14..3f43aa7d8fef 100644
> --- a/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -64,7 +64,9 @@ BEGIN {
>
>         modrm_expr =3D "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
>         force64_expr =3D "\\([df]64\\)"
> -       rex_expr =3D "^REX(\\.[XRWB]+)*"
> +       rex_expr =3D "^((REX(\\.[XRWB]+)+)|(REX$))"
> +       rex2_expr =3D "\\(REX2\\)"
> +       no_rex2_expr =3D "\\(!REX2\\)"
>         fpu_expr =3D "^ESC" # TODO
>
>         lprefix1_expr =3D "\\((66|!F3)\\)"
> @@ -99,6 +101,7 @@ BEGIN {
>         prefix_num["VEX+1byte"] =3D "INAT_PFX_VEX2"
>         prefix_num["VEX+2byte"] =3D "INAT_PFX_VEX3"
>         prefix_num["EVEX"] =3D "INAT_PFX_EVEX"
> +       prefix_num["REX2"] =3D "INAT_PFX_REX2"
>
>         clear_vars()
>  }
> @@ -314,6 +317,10 @@ function convert_operands(count,opnd,       i,j,imm,=
mod)
>                 if (match(ext, force64_expr))
>                         flags =3D add_flags(flags, "INAT_FORCE64")
>
> +               # check REX2 not allowed
> +               if (match(ext, no_rex2_expr))
> +                       flags =3D add_flags(flags, "INAT_NO_REX2")
> +
>                 # check REX prefix
>                 if (match(opcode, rex_expr))
>                         flags =3D add_flags(flags, "INAT_MAKE_PREFIX(INAT=
_PFX_REX)")
> @@ -351,6 +358,8 @@ function convert_operands(count,opnd,       i,j,imm,m=
od)
>                         lptable3[idx] =3D add_flags(lptable3[idx],flags)
>                         variant =3D "INAT_VARIANT"
>                 }
> +               if (match(ext, rex2_expr))
> +                       table[idx] =3D add_flags(table[idx], "INAT_REX2_V=
ARIANT")
>                 if (!match(ext, lprefix_expr)){
>                         table[idx] =3D add_flags(table[idx],flags)
>                 }
> diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/a=
sm/inat.h
> index a61051400311..2e65312cae52 100644
> --- a/tools/arch/x86/include/asm/inat.h
> +++ b/tools/arch/x86/include/asm/inat.h
> @@ -35,6 +35,8 @@
>  #define INAT_PFX_VEX2  13      /* 2-bytes VEX prefix */
>  #define INAT_PFX_VEX3  14      /* 3-bytes VEX prefix */
>  #define INAT_PFX_EVEX  15      /* EVEX prefix */
> +/* x86-64 REX2 prefix */
> +#define INAT_PFX_REX2  16      /* 0xD5 */
>
>  #define INAT_LSTPFX_MAX        3
>  #define INAT_LGCPFX_MAX        11
> @@ -50,7 +52,7 @@
>
>  /* Legacy prefix */
>  #define INAT_PFX_OFFS  0
> -#define INAT_PFX_BITS  4
> +#define INAT_PFX_BITS  5
>  #define INAT_PFX_MAX    ((1 << INAT_PFX_BITS) - 1)
>  #define INAT_PFX_MASK  (INAT_PFX_MAX << INAT_PFX_OFFS)
>  /* Escape opcodes */
> @@ -77,6 +79,8 @@
>  #define INAT_VEXOK     (1 << (INAT_FLAG_OFFS + 5))
>  #define INAT_VEXONLY   (1 << (INAT_FLAG_OFFS + 6))
>  #define INAT_EVEXONLY  (1 << (INAT_FLAG_OFFS + 7))
> +#define INAT_NO_REX2   (1 << (INAT_FLAG_OFFS + 8))
> +#define INAT_REX2_VARIANT      (1 << (INAT_FLAG_OFFS + 9))
>  /* Attribute making macros for attribute tables */
>  #define INAT_MAKE_PREFIX(pfx)  (pfx << INAT_PFX_OFFS)
>  #define INAT_MAKE_ESCAPE(esc)  (esc << INAT_ESC_OFFS)
> @@ -128,6 +132,11 @@ static inline int inat_is_rex_prefix(insn_attr_t att=
r)
>         return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_REX;
>  }
>
> +static inline int inat_is_rex2_prefix(insn_attr_t attr)
> +{
> +       return (attr & INAT_PFX_MASK) =3D=3D INAT_PFX_REX2;
> +}
> +
>  static inline int inat_last_prefix_id(insn_attr_t attr)
>  {
>         if ((attr & INAT_PFX_MASK) > INAT_LSTPFX_MAX)
> diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/a=
sm/insn.h
> index 65c0d9ce1e29..1a7e8fc4d75a 100644
> --- a/tools/arch/x86/include/asm/insn.h
> +++ b/tools/arch/x86/include/asm/insn.h
> @@ -112,10 +112,15 @@ struct insn {
>  #define X86_SIB_INDEX(sib) (((sib) & 0x38) >> 3)
>  #define X86_SIB_BASE(sib) ((sib) & 0x07)
>
> -#define X86_REX_W(rex) ((rex) & 8)
> -#define X86_REX_R(rex) ((rex) & 4)
> -#define X86_REX_X(rex) ((rex) & 2)
> -#define X86_REX_B(rex) ((rex) & 1)
> +#define X86_REX2_M(rex) ((rex) & 0x80) /* REX2 M0 */
> +#define X86_REX2_R(rex) ((rex) & 0x40) /* REX2 R4 */
> +#define X86_REX2_X(rex) ((rex) & 0x20) /* REX2 X4 */
> +#define X86_REX2_B(rex) ((rex) & 0x10) /* REX2 B4 */
> +
> +#define X86_REX_W(rex) ((rex) & 8)     /* REX or REX2 W */
> +#define X86_REX_R(rex) ((rex) & 4)     /* REX or REX2 R3 */
> +#define X86_REX_X(rex) ((rex) & 2)     /* REX or REX2 X3 */
> +#define X86_REX_B(rex) ((rex) & 1)     /* REX or REX2 B3 */
>
>  /* VEX bit flags  */
>  #define X86_VEX_W(vex) ((vex) & 0x80)  /* VEX3 Byte2 */
> @@ -161,6 +166,18 @@ static inline void insn_get_attribute(struct insn *i=
nsn)
>  /* Instruction uses RIP-relative addressing */
>  extern int insn_rip_relative(struct insn *insn);
>
> +static inline int insn_is_rex2(struct insn *insn)
> +{
> +       if (!insn->prefixes.got)
> +               insn_get_prefixes(insn);
> +       return insn->rex_prefix.nbytes =3D=3D 2;
> +}
> +
> +static inline insn_byte_t insn_rex2_m_bit(struct insn *insn)
> +{
> +       return X86_REX2_M(insn->rex_prefix.bytes[1]);
> +}
> +
>  static inline int insn_is_avx(struct insn *insn)
>  {
>         if (!insn->prefixes.got)
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index ada4b4a79dd4..f761adeb8e8c 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -185,6 +185,17 @@ int insn_get_prefixes(struct insn *insn)
>                         if (X86_REX_W(b))
>                                 /* REX.W overrides opnd_size */
>                                 insn->opnd_bytes =3D 8;
> +               } else if (inat_is_rex2_prefix(attr)) {
> +                       insn_set_byte(&insn->rex_prefix, 0, b);
> +                       b =3D peek_nbyte_next(insn_byte_t, insn, 1);
> +                       insn_set_byte(&insn->rex_prefix, 1, b);
> +                       insn->rex_prefix.nbytes =3D 2;
> +                       insn->next_byte +=3D 2;
> +                       if (X86_REX_W(b))
> +                               /* REX.W overrides opnd_size */
> +                               insn->opnd_bytes =3D 8;
> +                       insn->rex_prefix.got =3D 1;
> +                       goto vex_end;
>                 }
>         }
>         insn->rex_prefix.got =3D 1;
> @@ -294,6 +305,20 @@ int insn_get_opcode(struct insn *insn)
>                 goto end;
>         }
>
> +       /* Check if there is REX2 prefix or not */
> +       if (insn_is_rex2(insn)) {
> +               if (insn_rex2_m_bit(insn)) {
> +                       /* map 1 is escape 0x0f */
> +                       insn_attr_t esc_attr =3D inat_get_opcode_attribut=
e(0x0f);
> +
> +                       pfx_id =3D insn_last_prefix_id(insn);
> +                       insn->attr =3D inat_get_escape_attribute(op, pfx_=
id, esc_attr);
> +               } else {
> +                       insn->attr =3D inat_get_opcode_attribute(op);
> +               }
> +               goto end;
> +       }
> +
>         insn->attr =3D inat_get_opcode_attribute(op);
>         while (inat_is_escape(insn->attr)) {
>                 /* Get escaped opcode */
> diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/=
tools/gen-insn-attr-x86.awk
> index af38469afd14..3f43aa7d8fef 100644
> --- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -64,7 +64,9 @@ BEGIN {
>
>         modrm_expr =3D "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
>         force64_expr =3D "\\([df]64\\)"
> -       rex_expr =3D "^REX(\\.[XRWB]+)*"
> +       rex_expr =3D "^((REX(\\.[XRWB]+)+)|(REX$))"
> +       rex2_expr =3D "\\(REX2\\)"
> +       no_rex2_expr =3D "\\(!REX2\\)"
>         fpu_expr =3D "^ESC" # TODO
>
>         lprefix1_expr =3D "\\((66|!F3)\\)"
> @@ -99,6 +101,7 @@ BEGIN {
>         prefix_num["VEX+1byte"] =3D "INAT_PFX_VEX2"
>         prefix_num["VEX+2byte"] =3D "INAT_PFX_VEX3"
>         prefix_num["EVEX"] =3D "INAT_PFX_EVEX"
> +       prefix_num["REX2"] =3D "INAT_PFX_REX2"
>
>         clear_vars()
>  }
> @@ -314,6 +317,10 @@ function convert_operands(count,opnd,       i,j,imm,=
mod)
>                 if (match(ext, force64_expr))
>                         flags =3D add_flags(flags, "INAT_FORCE64")
>
> +               # check REX2 not allowed
> +               if (match(ext, no_rex2_expr))
> +                       flags =3D add_flags(flags, "INAT_NO_REX2")
> +
>                 # check REX prefix
>                 if (match(opcode, rex_expr))
>                         flags =3D add_flags(flags, "INAT_MAKE_PREFIX(INAT=
_PFX_REX)")
> @@ -351,6 +358,8 @@ function convert_operands(count,opnd,       i,j,imm,m=
od)
>                         lptable3[idx] =3D add_flags(lptable3[idx],flags)
>                         variant =3D "INAT_VARIANT"
>                 }
> +               if (match(ext, rex2_expr))
> +                       table[idx] =3D add_flags(table[idx], "INAT_REX2_V=
ARIANT")
>                 if (!match(ext, lprefix_expr)){
>                         table[idx] =3D add_flags(table[idx],flags)
>                 }
> --
> 2.34.1
>

