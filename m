Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574817D9885
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345861AbjJ0MkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345872AbjJ0MkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:40:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB7AD44
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:40:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so13359a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698410407; x=1699015207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3S9UlYquDwd0tGwn3PIHTQ987AlsMHRgUMPksjI4zo=;
        b=KRgrNYQHlS012yFCzR404jfeV/uUU2fErmJ25d2BjBEfG/AvqoAEny3pc0ZDc5T/bE
         Xef+8x5ImchATx4jB7k4yPHDbX420tcdyc8o6J+X7ygbP3LpwuXAsbVjOTwUHMtsfyFv
         6+I+xKXKkmG9ywfuxkajGAahAYQBAuresus2bXffCHiXaSUVFncqY15ROY1NY0l4duAp
         gyCwKsuKOmdVymdqlJBc/l7oPDVX31xMSTnGuDg7EQeZvgVoEil6Zy6bFo4owyIh1bEg
         7U1cNV1nhEpt32VBu/p+4ojtS+1yo39DBW4xLekzBAIiuGKY2UU/4dcvh6J64Kd08sdP
         2tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698410407; x=1699015207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3S9UlYquDwd0tGwn3PIHTQ987AlsMHRgUMPksjI4zo=;
        b=etRw9EihHxHBh5qzDAr1zFT1BA4qYSUDlNhI215OVIIxaJdSluCluIHksdBosw/ce4
         fEcrAdaFd13XuR11ofuCcr4M8kUo+eJ91r7j2pRIccDsjGa7HSr8AnV1MQ9QPiFsR/Lx
         G2FlsXDuGauv5oNANSgg0iAAlCz/qM16uPVdDKlMPBIctFoH9JVFq3G+wQdEd+eO5Nvy
         Gdo80y829+cp+9DRb/IKHGpXX1UgL4kDmEaOJ94IYD67uIh3gBuU4VkhVOtQWhjZo7nm
         BEh8O47XV+x9SQ1osc4iwj9o5eXXRhTTPW4IVan/e3GM3sl2n0cGuIQaof7G2AnmOORV
         PBng==
X-Gm-Message-State: AOJu0YwhT/2OWkenhtmngpuvv+0CcI4Snngy9evD99qwCZ6N0F1oLZ9/
        1h4PHJ2EHNP8wdWOIrKVhnfGEM73dQfP7Qfv3/E2Lw==
X-Google-Smtp-Source: AGHT+IGuoikFAKbKzz4NMIziLDwoCgtAdGlrp7XAt6tYWmzpwiKatGjY4KOqjEHOGpCjig678CK/OTrrJ9/y18R99Vk=
X-Received: by 2002:a50:9b5d:0:b0:540:e46d:1ee8 with SMTP id
 a29-20020a509b5d000000b00540e46d1ee8mr121633edj.4.1698410406518; Fri, 27 Oct
 2023 05:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <a6f256694783a0692f2f079e7ac76ace621308c3.camel@mediatek.com>
In-Reply-To: <a6f256694783a0692f2f079e7ac76ace621308c3.camel@mediatek.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 27 Oct 2023 14:39:52 +0200
Message-ID: <CANn89iK4M-=v0k_Aw_noWb_duDUZ54_3WKZV57BFRSQ1fhxcZA@mail.gmail.com>
Subject: Re: [PATCH net-next] net:prevent shared skb corruption on rx-gro-list segmentation
To:     =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "maze@google.com" <maze@google.com>,
        "cmllamas@google.com" <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 1:28=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) <Len=
a.Wang@mediatek.com> wrote:
>
> From 1d4aea846dd08d824e1097a933ed8618a6da03da Mon Sep 17 00:00:00 2001
> From: lena wang <lena.wang@mediatek.com>
> Date: Fri, 27 Oct 2023 17:52:50 +0800
> Subject: [PATCH net-next] net:prevent shared skb corruption on rx-gro-
> list segmentation
>
> shared skb triggers corruptions on rx-gro-list segmentation.
>
> [42438.749474] [ T1425] Unable to handle kernel NULL pointer
> dereference at virtual address 00000000000000d8
> [42438.749530] [ T1425] Mem abort info:
> [42438.749547] [ T1425]   ESR =3D 0x0000000096000006
> [42438.749566] [ T1425]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [42438.749588] [ T1425]   SET =3D 0, FnV =3D 0
> [42438.749606] [ T1425]   EA =3D 0, S1PTW =3D 0
> [42438.749623] [ T1425]   FSC =3D 0x06: level 2 translation fault
> [42438.749642] [ T1425] Data abort info:
> [42438.749656] [ T1425]   ISV =3D 0, ISS =3D 0x00000006
> [42438.749674] [ T1425]   CM =3D 0, WnR =3D 0
> [42438.749691] [ T1425] user pgtable: 4k pages, 39-bit VAs,
> pgdp=3D00000001f96b9000
> [42438.749714] [ T1425] [00000000000000d8] pgd=3D08000001f96ba003,
> p4d=3D08000001f96ba003, pud=3D08000001f96ba003, pmd=3D0000000000000000
> [42438.749769] [ T1425] Internal error: Oops: 0000000096000006 [#1]
> PREEMPT SMP
> [42438.749796] [ T1425] cpufreq stop DVFS log done
> [42438.797144] [ T1425] Kernel Offset: 0x29eb000000 from
> 0xffffffc008000000
> [42438.797185] [ T1425] PHYS_OFFSET: 0x40000000
> [42438.797203] [ T1425] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [42438.797219] [ T1425] pc : [0xffffffe9f3e38c34]
> __udp_gso_segment+0x24c/0x48c
> [42438.797248] [ T1425] lr : [0xffffffe9f3e38bf4]
> __udp_gso_segment+0x20c/0x48c
> [42438.797269] [ T1425] sp : ffffffc017acb5c0
> [42438.797280] [ T1425] x29: ffffffc017acb5d0 x28: 000000000000c85f
> ......
> [42438.799172] [ T1425] Call trace:
> [42438.799184] [ T1425]  dump_backtrace+0xf4/0x118
> [42438.799210] [ T1425]  show_stack+0x18/0x24
> [42438.799227] [ T1425]  dump_stack_lvl+0x60/0x7c
> [42438.799250] [ T1425]  dump_stack+0x18/0x3c
> [42438.799270] [ T1425]  mrdump_common_die+0x24c/0x398 [mrdump]
> [42438.799354] [ T1425]  ipanic_die+0x20/0x34 [mrdump]
> [42438.799425] [ T1425]  notify_die+0x80/0xd8
> [42438.799447] [ T1425]  die+0x94/0x2b8
> [42438.799463] [ T1425]  __do_kernel_fault+0x264/0x298
> [42438.799485] [ T1425]  do_page_fault+0x98/0x4a0
> [42438.799503] [ T1425]  do_translation_fault+0x38/0x54
> [42438.799521] [ T1425]  do_mem_abort+0x58/0x118
> [42438.799540] [ T1425]  el1_abort+0x3c/0x5c
> [42438.799555] [ T1425]  el1h_64_sync_handler+0x54/0x90
> [42438.799575] [ T1425]  el1h_64_sync+0x68/0x6c
> [42438.799591] [ T1425]  __udp_gso_segment+0x24c/0x48c
> [42438.799611] [ T1425]  udp4_ufo_fragment+0x118/0x15c
> [42438.799628] [ T1425]  inet_gso_segment+0x164/0x338
> [42438.799644] [ T1425]  skb_mac_gso_segment+0xc4/0x13c
> [42438.799666] [ T1425]  __skb_gso_segment+0xc4/0x124
> [42438.799686] [ T1425]  validate_xmit_skb+0x9c/0x2e0
> [42438.799703] [ T1425]  validate_xmit_skb_list+0x4c/0x80
> [42438.799722] [ T1425]  sch_direct_xmit+0x70/0x3d0
> [42438.799739] [ T1425]  __dev_queue_xmit+0x5f0/0xd40
> [42438.799757] [ T1425]  ip_finish_output2+0x3f8/0x460
> [42438.799774] [ T1425]  __ip_finish_output+0x194/0x240
> [42438.799790] [ T1425]  ip_finish_output+0x20/0xf4
> [42438.799810] [ T1425]  ip_output+0x100/0x1a0
> [42438.799830] [ T1425]  NF_HOOK+0xac/0x154
> [42438.799848] [ T1425]  ip_forward+0x308/0x320
> [42438.799868] [ T1425]  ip_sublist_rcv+0x1f0/0x25c
> [42438.799887] [ T1425]  ip_list_rcv+0x138/0x174
> [42438.799905] [ T1425]  __netif_receive_skb_list_core+0x1e8/0x28c
> [42438.799923] [ T1425]  netif_receive_skb_list_internal+0x1ec/0x2b4
> [42438.799942] [ T1425]  netif_receive_skb_list+0x2c/0x144
> [42438.799960] [ T1425]  ccmni_queue_state_callback+0x98/0x304 [ccmni]
> [42438.800009] [ T1425]  port_net_queue_state_notify+0x178/0x1c0
> [ccci_md_all]
> [42438.800257] [ T1425]  ccci_port_queue_status_notify+0xf0/0x2a8
> [ccci_md_all]
> [42438.800496] [ T1425]  dpmaif_rxq_push_thread+0xb0/0x1d4
> [ccci_dpmaif]
> [42438.800602] [ T1425]  kthread+0x104/0x1d4
> [42438.800621] [ T1425]  ret_from_fork+0x10/0x20
>
> In some scenarios the GRO-ed skb shared with multi users. This
> segmentation touches the shared heads which sets frag_list to null.
> After linearization the skb->next is null which results the corruption.

What scenarios would do that ?

Packets sent to ndo_start_xmit() are not supposed to be shared. (with
pktgen exception, which is well understood)

A driver wants to be able to overwrite parts of skb (skb->next and
many other fields), this is not specific to GSO

A real fix (if needed) would probably be elsewhere.

>
> So for shared skb, it needs to clone first than unclone with header and
> data separated for different devices.
>
> Signed-off-by: lena wang <lena.wang@mediatek.com>

Why targeting net-next ?


> ---
>  net/core/skbuff.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b157efea5dea..adeb3ad9697b 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4351,6 +4351,12 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>
>         skb_push(skb, -skb_network_offset(skb) + offset);
>
> +       if (skb_shared(skb)) {
> +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> +               if (!skb)
> +                       goto err_linearize;
> +       }
> +
>         /* Ensure the head is writeable before touching the shared info
> */
>         err =3D skb_unclone(skb, GFP_ATOMIC);
>         if (err)
> --
> 2.18.0
