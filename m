Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCA76DEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjHCDV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHCDVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061CD26BA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691032835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QovWFaxHnWeqR0vsWVD+az55lOwaqV+kKvtZL++WfzY=;
        b=T8sryNJAQ0kZ1BE8gimpDl5+Dgwx8JnyyZFcmFIlvDlQYlZPgoMI209R85NvM+OTo/Y8Sh
        VZb7tw4gSoFlvGb2ZZgfuiD5PIoHpXWwM2bApUztslvZw4rzrOTiQb+TcerdPSqCmqmWEg
        UYY8dpwJi6ael6VkZLuARcKtR1UAoUE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-4x-g5wAqMra25Sbz86Mx6Q-1; Wed, 02 Aug 2023 23:20:33 -0400
X-MC-Unique: 4x-g5wAqMra25Sbz86Mx6Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9e8abe539so4062161fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691032832; x=1691637632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QovWFaxHnWeqR0vsWVD+az55lOwaqV+kKvtZL++WfzY=;
        b=Lbe+csZ0CKO2D7V40SFtrb8WWwqVT8haDvBxIPtWxDcDaVojDVFj8U3wocUq0o1f28
         2pZ5K9DkXiTHtZTrK5Tm/Z/qjCQmVXo9yEd4Wm0GZgIABIb54wSuuhvMxmYrqfddTURe
         5zC0jf9dqxFvV+cUcVelB09w7TGa/62HVjo4Fz/c8JeVAVp++bJwVURZiVxp0CaAhX5Z
         fCkh7UiI8ra4suGLekog9egczxghedoJXLqT6yfQVFyVgsRJLIAJEXb2kWLBkBW4QA6/
         /BSWqLzoS6lhL7DU3VOMZSiwwEN1/A4kFLYA4RuOpfD9g9SOH1muQ3L9IWZfyf7gqL4V
         9kXA==
X-Gm-Message-State: ABy/qLbERvib3nDYkJNfIlF34B/uf+Cp5tdQWJoY8QFclfFFtX49jOJB
        PcgAHao7hgwBKGFVHz/DVdJn+XajbpDouiAmfDsEWAkI2jN5QhmFqTK4Dj+EVr1M4gnLusWpBzu
        RO7DeI/69yKA3ee2I06BwfAaTbRFMzvRSDisKbmDL
X-Received: by 2002:a2e:964e:0:b0:2b9:e701:ac48 with SMTP id z14-20020a2e964e000000b002b9e701ac48mr6600474ljh.32.1691032832463;
        Wed, 02 Aug 2023 20:20:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlETOgSsHd7bMfj2t0yr6N9rcMcAX7TnYSzl+FA8xdXceqfOu5sepJNkq4Hwq08yfISEjwj2LTwuXlc9sOWBhWQ=
X-Received: by 2002:a2e:964e:0:b0:2b9:e701:ac48 with SMTP id
 z14-20020a2e964e000000b002b9e701ac48mr6600470ljh.32.1691032832279; Wed, 02
 Aug 2023 20:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220710.464-1-andrew.kanner@gmail.com> <20230801220710.464-2-andrew.kanner@gmail.com>
In-Reply-To: <20230801220710.464-2-andrew.kanner@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 3 Aug 2023 11:20:20 +0800
Message-ID: <CACGkMEtRyEkpRetANvU1L97gLtVVT+vaBV1Hmh2QqZu9c9tvYw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com,
        dsahern@gmail.com, jbrouer@redhat.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 6:09=E2=80=AFAM Andrew Kanner <andrew.kanner@gmail.c=
om> wrote:
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
> ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But Jesper
> Dangaard Brouer <jbrouer@redhat.com> noted that after introducing the
> xdp_init_buff() which all XDP driver use - it's safe to remove this
> check. The original intend was to catch cases where XDP drivers have
> not been updated to use xdp.frame_sz, but that is not longer a concern
> (since xdp_init_buff).
>
> Running the initial syzkaller repro it was discovered that the
> contiguous physical memory allocation is used for both xdp paths in
> tun_get_user(), e.g. tun_build_skb() and tun_alloc_skb(). It was also
> stated by Jesper Dangaard Brouer <jbrouer@redhat.com> that XDP can
> work on higher order pages, as long as this is contiguous physical
> memory (e.g. a page).
>
> Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail=
.com
> Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.c=
om/T/
> Link: https://syzkaller.appspot.com/bug?extid=3Df817490f5bd20541b90a
> Link: https://lore.kernel.org/all/20230725155403.796-1-andrew.kanner@gmai=
l.com/T/
> Fixes: 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility routine")
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/core/filter.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 06ba0e56e369..28a59596987a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4116,12 +4116,6 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *,=
 xdp, int, offset)
>         if (unlikely(data_end > data_hard_end))
>                 return -EINVAL;
>
> -       /* ALL drivers MUST init xdp->frame_sz, chicken check below */
> -       if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
> -               WARN_ONCE(1, "Too BIG xdp->frame_sz =3D %d\n", xdp->frame=
_sz);
> -               return -EINVAL;
> -       }
> -
>         if (unlikely(data_end < xdp->data + ETH_HLEN))
>                 return -EINVAL;
>
> --
> 2.39.3
>

