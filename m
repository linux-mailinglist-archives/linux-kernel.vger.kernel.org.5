Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97A805685
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442251AbjLENvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjLENvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9852BB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701784308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqwroJrGTHefUhDWiBCdA2J4vAuymH0bz+Axm1qiXbE=;
        b=Ks2ogx33pVMFv1Mq8ARU5VZDCrPgMulgEejFQYZ3cUj1O10xuc8UsumHYbWIrANiG+uaiv
        XFEKHpHvzQXKlhAuf0rx//JUj/gsWlnvq0GbcQ/a7Or87bCSDmIOnp9dW+M18HOlR5qhdB
        pr9qpXxbWytrGcF5CmxCTvps/5yXQCo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-E63hAdDVMCKPL0bEHUlvjQ-1; Tue, 05 Dec 2023 08:51:47 -0500
X-MC-Unique: E63hAdDVMCKPL0bEHUlvjQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d0544c07c3so25642785ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784306; x=1702389106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqwroJrGTHefUhDWiBCdA2J4vAuymH0bz+Axm1qiXbE=;
        b=w+O4uqnQu5VF0j+EULjwxuBRg0BPYDRMvxf/Pd64xk5/wS6/otAP5UGWwlCPRjJ8TH
         trlx37ANynh/PFLJFu3iPMvV66f6TvHNFRIMExhw2edQy3wbyPnfS+V8Ovn1LO0K+70P
         0eRLLk35bTRenOkqP5ILmPcXYlUbKZeHkUXTBskRQLk8wULLizNsRJz/snAVQGYGtdbb
         8IRcx35Hc9gEZjxyrA8iz3lzdwsLHHDMcWDjQdMRMVtdwOKjrY5H9PMUVHaFQK3D1L7R
         9cCMwuPvl5ficiNfKb+q9r+XDf4oZ04EsP1JYUj2DdY+lpTmr29Ms9MgTPqBik0CbdYF
         7Log==
X-Gm-Message-State: AOJu0YwIrc/Gch/8k0PWXaTyHIExOSpoIZW5RshMdEj0rqamW3NBo2g1
        XzFB/va7FVzmO1y7I1Nr/7YSGwUp0sGjp6Uqy7FB6gswnGxIzE6s2jCYSUoXE4yn3d7fg3PgJqB
        CXboHxCprOA1y9ArFfbpbWWqRnR1nvXcVXYDrfKPi
X-Received: by 2002:a17:902:e741:b0:1d0:8555:a1bc with SMTP id p1-20020a170902e74100b001d08555a1bcmr3325800plf.13.1701784306640;
        Tue, 05 Dec 2023 05:51:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz6qoVMl9eTDZiTRuQ7GXnKYIuL8zYPdZOJYvdGQGzFFqt7PvtFFUulBhuNSWU8a3LTp27fh5Kz0Th3mHZFuQ=
X-Received: by 2002:a17:902:e741:b0:1d0:8555:a1bc with SMTP id
 p1-20020a170902e74100b001d08555a1bcmr3325793plf.13.1701784306367; Tue, 05 Dec
 2023 05:51:46 -0800 (PST)
MIME-Version: 1.0
References: <000000000000737829060b7b8775@google.com> <tencent_FCCCB879B66D7C2C2D6E4C97F4E972EE3A0A@qq.com>
In-Reply-To: <tencent_FCCCB879B66D7C2C2D6E4C97F4E972EE3A0A@qq.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 5 Dec 2023 14:51:34 +0100
Message-ID: <CAHc6FU4XREidNxwtW8m2YnsBGfANdH4W8b56KOeMNLjEEU_WGQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix kernel BUG in gfs2_quota_cleanup
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 2, 2023 at 10:34=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
> [Analysis]
> When the task exits, it will execute cleanup_mnt() to recycle the mounted=
 gfs2
> file system, but it performs a system call fsconfig(4, FSCONFIG_CMD_RECON=
FIGURE,
> NULL, NULL, 0) before executing the task exit operation.
>
> This will execute the following kernel path to complete the setting of
> SDF_JOURNAL_LIVE for sd_flags:
>
> SYSCALL_DEFINE5(fsconfig, ..)->
>         vfs_fsconfig_locked()->
>                 vfs_cmd_reconfigure()->
>                         gfs2_reconfigure()->
>                                 gfs2_make_fs_rw()->
>                                         set_bit(SDF_JOURNAL_LIVE, &sdp->s=
d_flags);
>
> [Fix]
> Add SDF_NORECOVERY check in gfs2_quota_cleanup() to avoid checking
> SDF_JOURNAL_LIVE on the path where gfs2 is being unmounted.

Thanks for this fix, I've applied it and added the following tag:

Fixes: f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")

>
> Reported-and-tested-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/gfs2/quota.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 95dae7838b4e..af32dd8a72fa 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1505,7 +1505,8 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
>         LIST_HEAD(dispose);
>         int count;
>
> -       BUG_ON(test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
> +       BUG_ON(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) &&
> +               test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
>
>         spin_lock(&qd_lock);
>         list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
> --
> 2.43.0

Thanks,
Andreas

