Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10C577274E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjHGOQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjHGOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:16:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE37F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:16:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so73207411fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691417769; x=1692022569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVE/GJTe1IuiufpABjiYZn1olHI1ifx/I1TivYEBHQg=;
        b=KDeUHSfDD3L4EI9ZDbXXnOCIgf36k4kTiyHRIIffaGRG3HCFl39GcfvKDi2APyBxt9
         uIkOV41JjBWzvcfkl4hWbMoMF6B7yW2N6o4toZetNa+16q9cwIbk8dhp8WLMlbMnqtzs
         lrCcsJN2ho/fqPCpmMmUqd/p18Lc2P1XhR9Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417769; x=1692022569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVE/GJTe1IuiufpABjiYZn1olHI1ifx/I1TivYEBHQg=;
        b=DpF2Hc+Ctmrk/OqOUrvvmTkh/A5DJvU/94m6jimyt5JOBReTikMhy6pDrIw6XhXmqk
         7IoYjgCfR7mVrxsx45psvSO/m1bZf6rzVY5iv1QW7xjmbUfov/XICrl19jCX1MUV1buW
         AYpImDkh3SgzmEJpxdgBGPaUOl3UkZHq3QKvV8bSOoPxMOr4etq6oJfaz2iXItKhThxP
         QrPTxhgAlwcgwpzQ5iUFr/y1/qDuFTqy7oz+yDpw40k2fWbyLkaPO+aVVh1bpTeGu0gd
         HgZWf+hJohqotFoF5RdPmDFhuwzPvsPqVQL0jek8zq5MPmtQG3nf4yyWgbMDcCEekWWG
         QeBw==
X-Gm-Message-State: AOJu0YyuVp9aerv63evKfm8gdeuQhzmBhSo4jj9t80wE7jya+abFPSNX
        /Jfysdekp8XyRvV0laQN8YGKnM8/DuRHcol1pEBCqg==
X-Google-Smtp-Source: AGHT+IGOrJUhdG+ahMA8bObfIwJouhmkY47ZzUfvTwinDgzhZuBpH+4Q7OaueJuZRAHK8xn8XVlTzjWWvAUYbt+ovvQ=
X-Received: by 2002:a2e:b166:0:b0:2b9:dd3b:cf43 with SMTP id
 a6-20020a2eb166000000b002b9dd3bcf43mr6572529ljm.13.1691417768626; Mon, 07 Aug
 2023 07:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com> <20230807110936.21819-19-zhengqi.arch@bytedance.com>
In-Reply-To: <20230807110936.21819-19-zhengqi.arch@bytedance.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Aug 2023 10:16:03 -0400
Message-ID: <CAEXW_YTKHUeZHWtzeSG5Tt7MscNKjVTScBWkVDkC4Orisa7w=Q@mail.gmail.com>
Subject: Re: [PATCH v4 18/48] rcu: dynamically allocate the rcu-lazy shrinker
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 7:36=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
>
> Use new APIs to dynamically allocate the rcu-lazy shrinker.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

For RCU:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel


> ---
>  kernel/rcu/tree_nocb.h | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 5598212d1f27..e1c59c33738a 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1396,13 +1396,6 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, stru=
ct shrink_control *sc)
>
>         return count ? count : SHRINK_STOP;
>  }
> -
> -static struct shrinker lazy_rcu_shrinker =3D {
> -       .count_objects =3D lazy_rcu_shrink_count,
> -       .scan_objects =3D lazy_rcu_shrink_scan,
> -       .batch =3D 0,
> -       .seeks =3D DEFAULT_SEEKS,
> -};
>  #endif // #ifdef CONFIG_RCU_LAZY
>
>  void __init rcu_init_nohz(void)
> @@ -1410,6 +1403,7 @@ void __init rcu_init_nohz(void)
>         int cpu;
>         struct rcu_data *rdp;
>         const struct cpumask *cpumask =3D NULL;
> +       struct shrinker * __maybe_unused lazy_rcu_shrinker;
>
>  #if defined(CONFIG_NO_HZ_FULL)
>         if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)=
)
> @@ -1436,8 +1430,16 @@ void __init rcu_init_nohz(void)
>                 return;
>
>  #ifdef CONFIG_RCU_LAZY
> -       if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
> -               pr_err("Failed to register lazy_rcu shrinker!\n");
> +       lazy_rcu_shrinker =3D shrinker_alloc(0, "rcu-lazy");
> +       if (!lazy_rcu_shrinker) {
> +               pr_err("Failed to allocate lazy_rcu shrinker!\n");
> +       } else {
> +               lazy_rcu_shrinker->count_objects =3D lazy_rcu_shrink_coun=
t;
> +               lazy_rcu_shrinker->scan_objects =3D lazy_rcu_shrink_scan;
> +               lazy_rcu_shrinker->seeks =3D DEFAULT_SEEKS;
> +
> +               shrinker_register(lazy_rcu_shrinker);
> +       }
>  #endif // #ifdef CONFIG_RCU_LAZY
>
>         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
> --
> 2.30.2
>
