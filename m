Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8F76289E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGZCKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGZCKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B92116
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690337407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7bDIq1bzY465BO1ikbOzMcgPMOtP/SRoAEj7PnPWEQ=;
        b=fZOgCJbpImPyXEpNKAn5OlLEpeaOdYdfho6V05n9UVM5S+6DJZWvktjtnOt+5LmSXVRowQ
        FvdpQNdhL33PC5A04SPjVoLH5UVQ5quVoajVp9dm82d1rYltqgndY3wTbFnCQie8DS2YpO
        WVySq3qEUGSX6IEXrqyZ6cypOl5dK9k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-MJ7YTbN8PqiGaj7xcMuzDA-1; Tue, 25 Jul 2023 22:10:06 -0400
X-MC-Unique: MJ7YTbN8PqiGaj7xcMuzDA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b988ba1137so25877301fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690337405; x=1690942205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7bDIq1bzY465BO1ikbOzMcgPMOtP/SRoAEj7PnPWEQ=;
        b=LMTrCHruIXaYwChddtLCNOsyU65uZA3lddiCV+Ec2d+jxfLL5SUddGIUyoNeT8Zu9p
         k9QDKyFIASvwT3lkz8qtPp1/JfxRQbP62QedLpYBu6kzagPnf+TA+9sD9AfwugH5tH/N
         czQdAtkjYuqps1Ukqo9LssObF9LxOpsBh1aEpGLiLevo+IZSnuIHC+87Nh81MpW4C0Pp
         Z+I+IMUwFfyqVPROVLEJZr5CfnnEA/S+eBXaNFNvIBjlvbS4Wz6k1TW+8uTSBEMCi/TC
         Jam8HBGHU5AAU9vQumlUtFnMIhR2P3afh7b3FfsN/bLMlDEXKufv21mqDPLZazpWPPoY
         DcYg==
X-Gm-Message-State: ABy/qLYIGuH4WvjR0y5ERIorQoZm/2BIRdqDm9v1EfYtmKZtDDEyEvOx
        GYYrkVGqXqFe5kREDt6djDiYJXzi14k+5TTJ9HeQjNNgEiP++wDwudgKbDRN4CVV26+1HaTT9Is
        P1R4Vp+BWND7uiS0Gn1jOKace1SHCj4fWXp4Fmx+W
X-Received: by 2002:a2e:740c:0:b0:2b6:df15:f6c3 with SMTP id p12-20020a2e740c000000b002b6df15f6c3mr421211ljc.39.1690337404997;
        Tue, 25 Jul 2023 19:10:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH5n0NZmMcxmIedZTS/miupPMCrGyzDqyGwVRWakUfxzh5EJlfkOl2hIJP2qoGZ5X8BPBLEKYFInjxlohQV8V4=
X-Received: by 2002:a2e:740c:0:b0:2b6:df15:f6c3 with SMTP id
 p12-20020a2e740c000000b002b6df15f6c3mr421200ljc.39.1690337404691; Tue, 25 Jul
 2023 19:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230725155403.796-1-andrew.kanner@gmail.com>
In-Reply-To: <20230725155403.796-1-andrew.kanner@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 26 Jul 2023 10:09:53 +0800
Message-ID: <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:54=E2=80=AFPM Andrew Kanner <andrew.kanner@gmail=
.com> wrote:
>
> Syzkaller reported the following issue:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Too BIG xdp->frame_sz =3D 131072
> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>   ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>   bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
> ...
> Call Trace:
>  <TASK>
>  bpf_prog_4add87e5301a4105+0x1a/0x1c
>  __bpf_prog_run include/linux/filter.h:600 [inline]
>  bpf_prog_run_xdp include/linux/filter.h:775 [inline]
>  bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
>  netif_receive_generic_xdp net/core/dev.c:4807 [inline]
>  do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
>  tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
>  tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
>  call_write_iter include/linux/fs.h:1871 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x650/0xe40 fs/read_write.c:584
>  ksys_write+0x12f/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
> ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But
> tun_get_user() still provides an execution path with do_xdp_generic()
> and exceed XDP limits for packet size.
>
> Using the syzkaller repro with reduced packet size it was also
> discovered that XDP_PACKET_HEADROOM is not checked in
> tun_can_build_skb(), although pad may be incremented in
> tun_build_skb().
>
> If we move the limit check from tun_can_build_skb() to tun_build_skb()
> we will make xdp to be used only in tun_build_skb(), without falling
> in tun_alloc_skb(), etc. And moreover we will drop the packet which
> can't be processed in tun_build_skb().
>
> Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.c=
om/T/
> Link: https://syzkaller.appspot.com/bug?id=3D5335c7c62bfff89bbb1c8f14cdab=
ebe91909060f
> Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>
> Notes:
>     V2 -> V3:
>     * attach the forgotten changelog
>     V1 -> V2:
>     * merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
>       syzkaller repro and missing XDP_PACKET_HEADROOM in pad
>     * changed the title and description of the execution path, suggested
>       by Jason Wang <jasowang@redhat.com>
>     * move the limit check from tun_can_build_skb() to tun_build_skb() to
>       remove duplication and locking issue, and also drop the packet in
>       case of a failed check - noted by Jason Wang <jasowang@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
>  drivers/net/tun.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d75456adc62a..7c2b05ce0421 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1594,10 +1594,6 @@ static bool tun_can_build_skb(struct tun_struct *t=
un, struct tun_file *tfile,
>         if (zerocopy)
>                 return false;
>
> -       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> -           SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
> -               return false;
> -
>         return true;
>  }
>
> @@ -1673,6 +1669,9 @@ static struct sk_buff *tun_build_skb(struct tun_str=
uct *tun,
>         buflen +=3D SKB_DATA_ALIGN(len + pad);
>         rcu_read_unlock();
>
> +       if (buflen > PAGE_SIZE)
> +               return ERR_PTR(-EFAULT);
> +
>         alloc_frag->offset =3D ALIGN((u64)alloc_frag->offset, SMP_CACHE_B=
YTES);
>         if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL=
)))
>                 return ERR_PTR(-ENOMEM);
> --
> 2.39.3
>

