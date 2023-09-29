Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA717B3595
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjI2Od7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjI2OdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:33:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89076171F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:32:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4195fe5cf73so301371cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695997960; x=1696602760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJFVcdWCqcDV6qycuab+i81ZPsWdTYGA5ipCa8aCpMg=;
        b=CXraKciQQimxJy+UHkFRD4YD4ez/m6GoXPMka7oAOG5OQR+bQK6uOib1lbM44HZxCt
         4YYnqtRIWU/ov7ZXAjBP0dxolTwls1iP97J6zIbIHL4prKxX+PhWeASqmFj3fdzvjCuS
         S3zi+cdmmvIWuhTjhkiIWDBcskNo/rE5EOS9+GG19RLaChK6NCp1qnIsWaWawmFnooqj
         OttyhwHGPLjSsePgyHu1VyNdDuWNd2eWuaO7mb1UElwmHP4ciQtUcK9JMJcYkiCBBCRK
         1LMHlxFhLz0Lp7gNAilOnpE0eKnh8lz1vX/q3j5kM8kbYHPbKVfReUB19JTJZr4nOurb
         nuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997960; x=1696602760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJFVcdWCqcDV6qycuab+i81ZPsWdTYGA5ipCa8aCpMg=;
        b=fqUI0nysWPwSqi/x1v/BmggW5awy3n+3m/fGrUcoE5SsxVrsXIMENLchneEJO7ry23
         oWOpeVkq8lnXs/EorZ8aNKDRAVH9hBHFx4BejQtSGsuKkVYdv+mokMPBKl6JmGpFK9Fw
         3gU6egvVCVJvfqcEgfqbhUJf6kbbQwA50/H72GFBHgp+BGMxqzMeCbVM8S2uonUqIP/z
         VcuFxjyrdOpEThnuIK/dKgNyHgmWSsu+2KKaOZjZnWdFkmq4ehu1hdrgHi9r2lqlifU2
         oPXnfpReWdXb9+88KihCoYn3Jo/G8Xc9w1Qz6IGAkHY/DLyCpquapeggiijL9uxRsKLc
         W7kQ==
X-Gm-Message-State: AOJu0Yyrr/DZ1P+5xjEEIld/CUeSjLIVidsVRc7ojVhG1ogPbjMtjqqt
        UKIJPn/QAQDuaRYfDnZdFZLX+BreTdDRVFr3WhXtSA==
X-Google-Smtp-Source: AGHT+IFAwQTjk3G75M/yQUuug/Yw85V4PBTHHuarGfbIzYyACFPixSdSwaUBRfdVtxsTVRDlGbcksaa4RTXqRz4Mdrs=
X-Received: by 2002:ac8:5885:0:b0:404:8218:83da with SMTP id
 t5-20020ac85885000000b00404821883damr1154536qta.1.1695997960490; Fri, 29 Sep
 2023 07:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230829234426.64421-1-tony.luck@intel.com> <20230928191350.205703-1-tony.luck@intel.com>
 <20230928191350.205703-8-tony.luck@intel.com>
In-Reply-To: <20230928191350.205703-8-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 29 Sep 2023 16:32:29 +0200
Message-ID: <CALPaoCjegjOYvOK7a5mVONpm5G6Q-BK-n7-U3EP5mzyhTRL=yQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] x86/resctrl: Sub NUMA Cluster detection and enable
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thu, Sep 28, 2023 at 9:14=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
> +static __init int snc_get_config(void)
> +{
> +       unsigned long *node_caches;
> +       int mem_only_nodes =3D 0;
> +       int cpu, node, ret;
> +       int num_l3_caches;
> +
> +       if (!x86_match_cpu(snc_cpu_ids))
> +               return 1;
> +
> +       node_caches =3D bitmap_zalloc(nr_node_ids, GFP_KERNEL);
> +       if (!node_caches)
> +               return 1;
> +
> +       cpus_read_lock();
> +       for_each_node(node) {
> +               cpu =3D cpumask_first(cpumask_of_node(node));
> +               if (cpu < nr_cpu_ids)
> +                       set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches=
);
> +               else
> +                       mem_only_nodes++;
> +       }
> +       cpus_read_unlock();
> +
> +       num_l3_caches =3D bitmap_weight(node_caches, nr_node_ids);
> +       if (!num_l3_caches)
> +               return 1;
> +
> +       ret =3D (nr_node_ids - mem_only_nodes) / num_l3_caches;
> +       kfree(node_caches);

It seems a little peculiar to free node_caches a couple of lines after
you're actually done with it.

> +
> +       if (ret > 1)
> +               rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope =
=3D RESCTRL_NODE;
> +
> +       return ret;
> +}
> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>         struct rdt_hw_resource *hw_res;
>         struct rdt_resource *r;
>
> +       snc_nodes_per_l3_cache =3D snc_get_config();
> +
>         for_each_rdt_resource(r) {
>                 hw_res =3D resctrl_to_arch_res(r);
>
> --
> 2.41.0
>

Reviewed-by: Peter Newman <peternewman@google.com>
