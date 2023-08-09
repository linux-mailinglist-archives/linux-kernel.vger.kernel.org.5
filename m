Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3A7750B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjHICKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHICJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:09:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A3F3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:09:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe11652b64so9840598e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 19:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691546996; x=1692151796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVZnzliJJR6doUUi5DtgG9ZBTruUMPmdVFkPd3ysVNE=;
        b=jw232vax1jfsBUdY38N4gnDTn5uxQmNvHHzkqVbXi3bWLTANQN7k916h9Y1qQb3uM6
         xX/3tbUdXBsVKISdTSY6iUPPNtadRtrswEJB0NYSgEZM+YN+tifjB6EV1RbEsvKn8/9n
         diMlhmUmcw6Z7gpEsxrKJUkJIY0nPiFftGwrN6w9+oxfMK+9RivHj0mTuwAPWVIi94YC
         vmFixAZomhldkGmEJHQXnGJSatlCD1oC8GCkfGwLreZ3xd8UB2MmxCpmNC4swynzFHUe
         X/VPoWUCpgJsst16dnojZaW7E0qq7BPnpVVwcLZiEOMAP6eCXKsVNSyrpdiCQF/mYgjq
         QLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691546996; x=1692151796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVZnzliJJR6doUUi5DtgG9ZBTruUMPmdVFkPd3ysVNE=;
        b=FMxxGOwb+dampSdRHyncCSeLEtMOTeZkEOQhOYzlp7QobEgMSGlBHMhn7Ux3doFsaV
         cdr7aSYsekysxDA/vMHhjjeQi8OeTvaxmyRFoCvJ52Tvnwll/0XLvONlezFW8n+nNso2
         +8yZmCaonP5rOiNP+0X0vpcR7XZm/Tp9Rx/R+bdtkVmq4iVIDgVjJiR93a0EBQyTTgxG
         DmhY33nIH94EYtOijWR/a8c8FapF1Nyi8zBY4bbwNk+wOP7VNkmkhWNy2kj35tnFFVPc
         U5eyfe6tdMW/kQkUfNM5CCjVBVzomzR+t5588eLDyx+EOICuMTeSxLtUgnSlyJ5aWnO9
         KxuQ==
X-Gm-Message-State: AOJu0Ywl7s5kRviaIia+vXcwLG4SkWO32kUBqP5N3Pa3+7BuclHC77sk
        k8muRZPNnGp/rw2swdc76K0NKTkjH30OGe27hpw=
X-Google-Smtp-Source: AGHT+IGzUMJbkPcG1DlBXX0pnJulC6MAmGUARgjfIG7qHXX6oBA2gkw0vu+eTcaEp5WfZuvgCImc6cR+Ful7lWlIUY0=
X-Received: by 2002:a05:6512:110d:b0:4fd:da95:6f39 with SMTP id
 l13-20020a056512110d00b004fdda956f39mr848545lfg.68.1691546995836; Tue, 08 Aug
 2023 19:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230805095927.6907-1-yangyicong@huawei.com>
In-Reply-To: <20230805095927.6907-1-yangyicong@huawei.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 8 Aug 2023 19:09:44 -0700
Message-ID: <CAAH8bW8C5humYnfpW3y5ypwx0E-09A3QxFE1JFzR66v+mO4XfA@mail.gmail.com>
Subject: Re: [PATCH] sched/topology: Fix sched_numa_find_nth_cpu() when
 there's CPU-less node
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        tariqt@nvidia.com, kuba@kernel.org, shiju.jose@huawei.com,
        jonathan.cameron@huawei.com, prime.zeng@huawei.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 3:01=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> When booting with maxcpus=3D1 we met below panic:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
00000000000
> Mem abort info:
>   ESR =3D 0x0000000096000004
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x04: level 0 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000004
>   CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000002098202000
> [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc1 #3
> Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA BIOS 2280-A CS V2=
.B220.01 03/19/2020
> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : __bitmap_weight_and+0x40/0xb0
> lr : cpumask_weight_and+0x18/0x24
> sp : ffff80000841bab0
> x29: ffff80000841bab0 x28: 0000000000000000 x27: ffffb0d897ca6068
> x26: 0000000000000000 x25: ffff80000841bbb8 x24: 0000000000000080
> x23: ffffb0d8983c9a48 x22: 0000000000000000 x21: 0000000000000002
> x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
> x17: ffff4f5337dd9000 x16: ffff800008000000 x15: 0000000000000001
> x14: 0000000000000002 x13: 0000000000bc91ca x12: ffff202bffffe928
> x11: ffff202bffffe938 x10: ffff202bffffe908 x9 : 0000000000000001
> x8 : 0000000000000380 x7 : 0000000000000014 x6 : ffff2020040b0d00
> x5 : 0000000000332000 x4 : ffffb0d8962d9794 x3 : 0000000000000008
> x2 : 0000000000000080 x1 : 0000000000000003 x0 : ffffb0d8983c9a48
> Call trace:
>  __bitmap_weight_and+0x40/0xb0
>  cpumask_weight_and+0x18/0x24
>  hop_cmp+0x2c/0xa4
>  bsearch+0x50/0xc0
>  sched_numa_find_nth_cpu+0x80/0x130
>  cpumask_local_spread+0x38/0xa8
>  hns3_nic_init_vector_data+0x58/0x394
>  hns3_client_init+0x2c8/0x6d8
>  hclge_init_client_instance+0x128/0x39c
>  hnae3_init_client_instance.part.5+0x20/0x54
>  hnae3_register_ae_algo+0xf0/0x19c
>  hclge_init+0x58/0x84
>  do_one_initcall+0x60/0x1d0
>  kernel_init_freeable+0x1d8/0x2ac
>  kernel_init+0x24/0x12c
>  ret_from_fork+0x10/0x20
> Code: 52800014 d2800013 d503201f f8737ae1 (f8737ac0)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
> SMP: stopping secondary CPUs
> Kernel Offset: 0x30d88e200000 from 0xffff800008000000
> PHYS_OFFSET: 0x0
> CPU features: 0x000000,01100506,22006203
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x0000000b ]---
>
> The driver use cpumask_local_spread() and inner sched_numa_find_nth_cpu()
> access the node mask which is not initialized. In sched_init_numa(),
> we don't care about node without CPUs since they won't participate in sch=
eduling.
>
> This patch fix this by using a closet CPU node when the target node is
> CPU-less. Furthermore, sched_numa_hop_mask() also suffers so fix it as
> well by returning an error when information of target node is not
> initialized.
>
> Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
> Fixes: 9feae65845f7 ("sched/topology: Introduce sched_numa_hop_mask()")
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks for pointing that. Few nits inline. For the rest,
Reviewed-by: Yury Norov <yury.norov@gmail.com

> ---
>  kernel/sched/topology.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d3a3b2646ec4..78d95ebf5072 100644
> --- a/kernel/sched/topology.cYury Norov <yury.norov@gmail.com
> +++ b/kernel/sched/topology.c
> @@ -2119,6 +2119,25 @@ int sched_numa_find_nth_cpu(const struct cpumask *=
cpus, int cpu, int node)
>
>         rcu_read_lock();
>
> +       /*
> +        * When the target node is CPU-less, we cannot use it directly si=
nce
> +        * we didn't initialise sched_domains_numa_masks[level][node]. Us=
e the
> +        * closet online node instead.

Did you mean closest node?

> +        */
> +       if (!node_state(node, N_CPU)) {
> +               int tmp, closet_node, closet_distance =3D INT_MAX;
> +
> +               for_each_node_state(tmp, N_CPU) {
> +                       if (node_distance(tmp, node) < closet_distance) {
> +                               closet_node =3D tmp;
> +                               closet_distance =3D node_distance(tmp, no=
de);
> +                       }
> +               }
> +
> +               k.node =3D closet_node;
> +               node =3D closet_node;
> +       }

I think this can be generalized, but it's not a matter of this bugfix.

> +
>         k.masks =3D rcu_dereference(sched_domains_numa_masks);
>         if (!k.masks)
>                 goto unlock;
> @@ -2160,7 +2179,7 @@ const struct cpumask *sched_numa_hop_mask(unsigned =
int node, unsigned int hops)
>                 return ERR_PTR(-EINVAL);
>
>         masks =3D rcu_dereference(sched_domains_numa_masks);
> -       if (!masks)
> +       if (!masks || !masks[hops] || !masks[hops][node])
>                 return ERR_PTR(-EBUSY);

I think EBUSY relates to RCU dereference error. If the 'masks' has no
record for a specific node, it should be another error. Maybe ENOENT?

>
>         return masks[hops][node];
> --
> 2.24.0
>
