Return-Path: <linux-kernel+bounces-136268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1E89D222
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5DA282689
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8A76EB72;
	Tue,  9 Apr 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XQdrfIcv"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DA6A033
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643083; cv=none; b=RciCFyvUnQ8NKLu9AVJ8z7X3MeS8QWLSiy5lW/htX6vXzuZxDc6CeDWcitknwTdEDTEwYF+gD3VtDMBLk1h8cYjeSdGoA6/xCs0Gm5DnIiSL2g49aBBlCui2xj3DVimmMAiDEzZYNP1ObsvwP8RPK8m13I7oTE/8SrHbr2SoqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643083; c=relaxed/simple;
	bh=FeGJhwdCRoYiR7gWBRDEHf6ksBD8EYGCjDCGZB1cG1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pyJ3nasdll7XmcnVheSkUmsmii/Gq/GzmsvLZTSSu6VtwRA7iPF7WARDDWI+wjXjS9sPkZOffu9IlBkPBdS3tAmcjN34phGPyeqlP6w/jAYEYsZDpgE5XKkYEOwixdJ9KBOqKvlgEq3GAlpzhHxzK6hqYSYz/iR3A9q9eG8wIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XQdrfIcv; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22f078f1aecso1445070fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712643079; x=1713247879; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBHuIUhNOhdsdT4E1VbYuT6s0TqYlSkEpMfCY4cxP8I=;
        b=XQdrfIcvgoi1Dg2XP37+n/69SkHbOIy5Wy7USaOoJBxt/TAZCGDfAKmQTVTK1sMwFp
         ceIzBs41ST5tKLhTZFHVD3E9eX62ynm5bGXvP59HD9xOsrBjp9Pk/iZ1FmLXGpao2LxI
         RcKULfVcL+XPsNWgeSBUxa58maGN86N3wEQvgrFcjG8qYwYC4JPdkGgCd07ruh0G/5+B
         fMTQLkyd4OzjOF0N2S2WQGTAjojnESyOjaKoiFQzd8zpDzk2z50dt4OHb2E0HFGIGRpI
         G7oNFEdbX9U/Op+cbaS7+gVAqYPO99NHwVK9fwvZEqc5WxfjkFuR5FBBU7cbjw5NrEFr
         1r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643079; x=1713247879;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBHuIUhNOhdsdT4E1VbYuT6s0TqYlSkEpMfCY4cxP8I=;
        b=uZfvUfZ8MSgi6p0FWisuuvI/4/2vzBQDuzbid2zsRaT8GPRES7sHkVW/P9b10wC+KU
         XqlEe4g9+1+w4lNLa0+yeoZBh2sU3AxETcRxqPdAtI1XdPAH7ILKduis+f/C6AiMqin1
         qEi2HyPCqdY3Em6G+0UjXYm8ZaxfHz/vxQYcGcN/ei/rU+tTa/91GU5jmMxsaAQxb7QT
         ZmuHrmYSoQusbrXkj1NxTO+XwxNO0e5iU0ffmtu8P51oXg24M6kzAlhkuKymnQk7ehI7
         RLBlBS9+vUS+w5ehO7dri2ACgWlsULPidRVkRLfGbkjd1oKGrCvRpkb5simt1ePdQeow
         IUbA==
X-Forwarded-Encrypted: i=1; AJvYcCUweEqR7XoM1o9d9P8/Wy4jmrt6NX/X36bqxrCDSiU9dozYw9qOeaFr5QLfDCU/pojSoJej9vEDYsQZKjzzO+5bFXo6/ATkifIIZoDd
X-Gm-Message-State: AOJu0Yz24O4uRXQc0ifl6FtPsBf/7IG6JOX4yArkDM+FR9gPqFVQgPzq
	MKha67FKYntTLit36luVTnUVuiSMSSRZqb7K+U5UjzNZXrJPCnRG6vvmgs7ers3R+/ezvjKgS8/
	2g5ecyAKibP0E5UxXZm4ulEiqqihzPjaLhwUJlA==
X-Google-Smtp-Source: AGHT+IFvudyBofLrHAmCHcvrirjTPeOh/LfBkROqNxC8jYZnxveaUfivrBknhs9HXAiY/b7ilrHkQVPl/uePqbz67jU=
X-Received: by 2002:a05:6870:d286:b0:22a:7c81:1e2e with SMTP id
 d6-20020a056870d28600b0022a7c811e2emr12163359oae.16.1712643078963; Mon, 08
 Apr 2024 23:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240407123829.36474-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 9 Apr 2024 14:11:07 +0800
Message-ID: <CAEEQ3wnsOJXEMspM=A1jLkuLC-Ny5DA0_W-8ngE6n-jiJcDEnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo entirely with PPTT
To: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added committers of pptt.c. Could you give some comments? thanks.

On Sun, Apr 7, 2024 at 8:39=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> When the type and level information of this_leaf cannot be obtained
> from arch, cacheinfo is completely filled in with the content of PPTT.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/acpi/pptt.c | 135 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 124 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index a35dd0e41c27..6c54fc8e3039 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -21,6 +21,9 @@
>  #include <linux/cacheinfo.h>
>  #include <acpi/processor.h>
>
> +void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache, struct acpi_tabl=
e_header *table,
> +                        int cpu, int level, int *index);
> +
>  static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_tabl=
e_header *table_hdr,
>                                                         u32 pptt_ref)
>  {
> @@ -77,6 +80,18 @@ static inline bool acpi_pptt_match_type(int table_type=
, int type)
>                 table_type & ACPI_PPTT_CACHE_TYPE_UNIFIED & type);
>  }
>
> +static inline u32 get_cache_id(struct acpi_pptt_cache *cache)
> +{
> +       struct acpi_pptt_cache_v1 *cache_v1;
> +
> +       if (cache->flags & ACPI_PPTT_CACHE_ID_VALID) {
> +               cache_v1 =3D ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +                                       cache, sizeof(struct acpi_pptt_ca=
che));
> +               return cache_v1->cache_id;
> +       }
> +       return 0;
> +}
> +
>  /**
>   * acpi_pptt_walk_cache() - Attempt to find the requested acpi_pptt_cach=
e
>   * @table_hdr: Pointer to the head of the PPTT table
> @@ -104,7 +119,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_=
table_header *table_hdr,
>                                          unsigned int *split_levels,
>                                          struct acpi_subtable_header *res=
,
>                                          struct acpi_pptt_cache **found,
> -                                        unsigned int level, int type)
> +                                        unsigned int level, int type, in=
t cpu, int *index)
>  {
>         struct acpi_pptt_cache *cache;
>
> @@ -125,7 +140,7 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_=
table_header *table_hdr,
>                      acpi_pptt_match_type(cache->attributes, ACPI_PPTT_CA=
CHE_TYPE_INSTR)))
>                         *split_levels =3D local_level;
>
> -               if (local_level =3D=3D level &&
> +               if (level && local_level =3D=3D level &&
>                     acpi_pptt_match_type(cache->attributes, type)) {
>                         if (*found !=3D NULL && cache !=3D *found)
>                                 pr_warn("Found duplicate cache level/type=
 unable to determine uniqueness\n");
> @@ -137,7 +152,9 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_=
table_header *table_hdr,
>                          * to verify that we don't find a duplicate
>                          * cache node.
>                          */
> -               }
> +               } else
> +                       acpi_fill_cacheinfo(cache, table_hdr, cpu, local_=
level, index);
> +
>                 cache =3D fetch_pptt_cache(table_hdr, cache->next_level_o=
f_cache);
>         }
>         return local_level;
> @@ -147,7 +164,7 @@ static struct acpi_pptt_cache *
>  acpi_find_cache_level(struct acpi_table_header *table_hdr,
>                       struct acpi_pptt_processor *cpu_node,
>                       unsigned int *starting_level, unsigned int *split_l=
evels,
> -                     unsigned int level, int type)
> +                     unsigned int level, int type, int cpu, int *index)
>  {
>         struct acpi_subtable_header *res;
>         unsigned int number_of_levels =3D *starting_level;
> @@ -161,7 +178,8 @@ acpi_find_cache_level(struct acpi_table_header *table=
_hdr,
>
>                 local_level =3D acpi_pptt_walk_cache(table_hdr, *starting=
_level,
>                                                    split_levels, res, &re=
t,
> -                                                  level, type);
> +                                                  level, type, cpu, inde=
x);
> +
>                 /*
>                  * we are looking for the max depth. Since its potentiall=
y
>                  * possible for a given node to have resources with diffe=
ring
> @@ -197,7 +215,7 @@ static void acpi_count_levels(struct acpi_table_heade=
r *table_hdr,
>                               unsigned int *levels, unsigned int *split_l=
evels)
>  {
>         do {
> -               acpi_find_cache_level(table_hdr, cpu_node, levels, split_=
levels, 0, 0);
> +               acpi_find_cache_level(table_hdr, cpu_node, levels, split_=
levels, 0, 0, 0, NULL);
>                 cpu_node =3D fetch_pptt_node(table_hdr, cpu_node->parent)=
;
>         } while (cpu_node);
>  }
> @@ -316,6 +334,7 @@ static u8 acpi_cache_type(enum cache_type type)
>  }
>
>  static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_he=
ader *table_hdr,
> +                                                   int cpu,
>                                                     u32 acpi_cpu_id,
>                                                     enum cache_type type,
>                                                     unsigned int level,
> @@ -325,6 +344,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(s=
truct acpi_table_header *ta
>         struct acpi_pptt_cache *found =3D NULL;
>         struct acpi_pptt_processor *cpu_node;
>         u8 acpi_type =3D acpi_cache_type(type);
> +       int index =3D 0;
>
>         pr_debug("Looking for CPU %d's level %u cache type %d\n",
>                  acpi_cpu_id, level, acpi_type);
> @@ -333,7 +353,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(s=
truct acpi_table_header *ta
>
>         while (cpu_node && !found) {
>                 found =3D acpi_find_cache_level(table_hdr, cpu_node,
> -                                             &total_levels, NULL, level,=
 acpi_type);
> +                                             &total_levels, NULL, level,=
 acpi_type, cpu, &index);
>                 *node =3D cpu_node;
>                 cpu_node =3D fetch_pptt_node(table_hdr, cpu_node->parent)=
;
>         }
> @@ -406,8 +426,14 @@ static void update_cache_properties(struct cacheinfo=
 *this_leaf,
>          * specified in PPTT.
>          */
>         if (this_leaf->type =3D=3D CACHE_TYPE_NOCACHE &&
> -           found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
> -               this_leaf->type =3D CACHE_TYPE_UNIFIED;
> +           found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) {
> +               if (acpi_pptt_match_type(found_cache->attributes, ACPI_PP=
TT_CACHE_TYPE_DATA))
> +                       this_leaf->type =3D CACHE_TYPE_DATA;
> +               if (acpi_pptt_match_type(found_cache->attributes, ACPI_PP=
TT_CACHE_TYPE_INSTR))
> +                       this_leaf->type =3D CACHE_TYPE_INST;
> +               if (acpi_pptt_match_type(found_cache->attributes, ACPI_PP=
TT_CACHE_TYPE_UNIFIED))
> +                       this_leaf->type =3D CACHE_TYPE_UNIFIED;
> +       }
>
>         if (revision >=3D 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_V=
ALID)) {
>                 found_cache_v1 =3D ACPI_ADD_PTR(struct acpi_pptt_cache_v1=
,
> @@ -417,19 +443,106 @@ static void update_cache_properties(struct cachein=
fo *this_leaf,
>         }
>  }
>
> +static bool cache_is_filled_id(struct acpi_pptt_cache *cache, int cpu)
> +{
> +       u32 id =3D get_cache_id(cache);
> +       struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> +       struct cacheinfo *this_leaf;
> +       int index =3D 0;
> +
> +       while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> +               this_leaf =3D this_cpu_ci->info_list + index;
> +               if (this_leaf->id =3D=3D id)
> +                       return true;
> +               index++;
> +       }
> +       return false;
> +}
> +
> +static bool cache_is_filled_content(struct acpi_pptt_cache *cache,
> +                                   struct acpi_table_header *table,
> +                                   int cpu, int level, u8 revision)
> +{
> +       struct acpi_pptt_processor *cpu_node;
> +       struct cacheinfo *this_leaf, *tleaf;
> +       struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> +       struct cacheinfo tmp_leaf =3D {0};
> +       int index =3D 0;
> +
> +       cpu_node =3D acpi_find_processor_node(table, get_acpi_id_for_cpu(=
cpu));
> +       tleaf =3D &tmp_leaf;
> +       tleaf->level =3D level;
> +
> +       while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
> +               this_leaf =3D this_cpu_ci->info_list + index;
> +               update_cache_properties(tleaf, cache,
> +                                       ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu=
_node, table)),
> +                                       revision);
> +               if (!memcmp(this_leaf, tleaf, sizeof(struct cacheinfo)))
> +                       return true;
> +               index++;
> +       }
> +       return false;
> +}
> +
> +static bool cache_is_filled(struct acpi_pptt_cache *cache, struct acpi_t=
able_header *table,
> +                                  int cpu, int level)
> +{
> +       u8 revision =3D table->revision;
> +
> +       /*
> +        * If revision >=3D 3, compare the cacheid directly,
> +        * otherwise compare the entire contents of the cache.
> +        */
> +       if (revision >=3D 3)
> +               return cache_is_filled_id(cache, cpu);
> +       else
> +               return cache_is_filled_content(cache, table, cpu, level, =
revision);
> +}
> +
> +void acpi_fill_cacheinfo(struct acpi_pptt_cache *cache,
> +                               struct acpi_table_header *table,
> +                               int cpu, int level, int *index)
> +{
> +       struct cacheinfo *this_leaf;
> +       struct acpi_pptt_processor *cpu_node;
> +       struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> +
> +       if (!index)
> +               return;
> +
> +       cpu_node =3D acpi_find_processor_node(table, get_acpi_id_for_cpu(=
cpu));
> +       this_leaf =3D this_cpu_ci->info_list + *index;
> +       if (this_leaf) {
> +               this_leaf->level =3D level;
> +               if (cache_is_filled(cache, table, cpu, level))
> +                       return;
> +               update_cache_properties(this_leaf, cache,
> +                                       ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu=
_node,
> +                                                       table)),
> +                                       table->revision);
> +               *index +=3D 1;
> +       }
> +}
> +
>  static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>                                  unsigned int cpu)
>  {
>         struct acpi_pptt_cache *found_cache;
>         struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>         u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> -       struct cacheinfo *this_leaf;
> +       struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
>         unsigned int index =3D 0;
>         struct acpi_pptt_processor *cpu_node =3D NULL;
>
> +       if (!this_leaf->type && !this_leaf->level) {
> +               acpi_find_cache_node(table, acpi_cpu_id, cpu, 0, 0, &cpu_=
node);
> +               return;
> +       }
> +
>         while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
>                 this_leaf =3D this_cpu_ci->info_list + index;
> -               found_cache =3D acpi_find_cache_node(table, acpi_cpu_id,
> +               found_cache =3D acpi_find_cache_node(table, acpi_cpu_id, =
cpu,
>                                                    this_leaf->type,
>                                                    this_leaf->level,
>                                                    &cpu_node);
> --
> 2.20.1
>

Thanks,
Yunhui

