Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3780D418
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjLKRhl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 12:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344802AbjLKRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:37:33 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC6123;
        Mon, 11 Dec 2023 09:37:38 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso1824971e87.2;
        Mon, 11 Dec 2023 09:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316257; x=1702921057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq+VT1yoNILYRnVYlXhIlgVV3TQoNuR0AWtL0JI09is=;
        b=QiI/UkQv7mV95XzCPICO7aO2jhtYILNOdk2PcvVPAnTsCahBAuQeFl9GZr7GYbAKfQ
         8zGTEmqmbo3+znWKbuxr+PDKPp0XVO4Ts94o0PzqQhWcuMG9/uj2Ga5EkaZQ4dU2rlko
         WYz2TArp9dgf5yiOr5lFJUDFELmqj+my6IAJYV/0CheGb1zyxRCq4aYVxLFsZxn/yF9Y
         95tQ7RZz/ixzlpky6YBhwNL6GuXIb2bMaDIU7Mekua97Ji3O23ZQSXwDLDVxjB/9FLzy
         KalpmprGs861mpIHtngE9Vgjcj5d1Ei1QlsoI+TOwtuBjSKQlhUVsRbW/gr0OCPsHm+N
         wjEQ==
X-Gm-Message-State: AOJu0YxRNved6N6Wu0N/13MRWHFZqVQTxuXaYJfswpOSlEuu64ceSfsz
        CylDshP/Q+ZgpcmSKqFzohZXJYLS47Txs3sxqhw=
X-Google-Smtp-Source: AGHT+IEpL3HwYdodNmXK64xmycgt8LjdEl6qA7Mj1X3e8066G/U6GTY9ZLc39vLD67XcJ17bcvHzAg==
X-Received: by 2002:a05:6512:6c7:b0:50c:d72:2010 with SMTP id u7-20020a05651206c700b0050c0d722010mr2686236lff.121.1702316256502;
        Mon, 11 Dec 2023 09:37:36 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512104100b0050ab696bfaasm1142468lfb.3.2023.12.11.09.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:37:36 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so6063439e87.0;
        Mon, 11 Dec 2023 09:37:36 -0800 (PST)
X-Received: by 2002:ac2:4892:0:b0:50c:20f3:2a3 with SMTP id
 x18-20020ac24892000000b0050c20f302a3mr2287048lfc.6.1702316256037; Mon, 11 Dec
 2023 09:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20231211163412.2766147-1-dhowells@redhat.com> <20231211163412.2766147-3-dhowells@redhat.com>
In-Reply-To: <20231211163412.2766147-3-dhowells@redhat.com>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Mon, 11 Dec 2023 13:37:24 -0400
X-Gmail-Original-Message-ID: <CAB9dFdsCnAeitHcNJRY+f8eG=exrgpBZpczfMhHHXLvCR32MaA@mail.gmail.com>
Message-ID: <CAB9dFdsCnAeitHcNJRY+f8eG=exrgpBZpczfMhHHXLvCR32MaA@mail.gmail.com>
Subject: Re: [PATCH 2/3] afs: Fix dynamic root lookup DNS check
To:     David Howells <dhowells@redhat.com>
Cc:     Markus Suvanto <markus.suvanto@gmail.com>,
        linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 12:34 PM David Howells <dhowells@redhat.com> wrote:
>
> In the afs dynamic root directory, the ->lookup() function does a DNS check
> on the cell being asked for and if the DNS upcall reports an error it will
> report an error back to userspace (typically ENOENT).
>
> However, if a failed DNS upcall returns a new-style result, it will return
> a valid result, with the status field set appropriately to indicate the
> type of failure - and in that case, dns_query() doesn't return an error and
> we let stat() complete with no error - which can cause confusion in
> userspace as subsequent calls that trigger d_automount then fail with
> ENOENT.
>
> Fix this by checking the status result from a valid dns_query() and
> returning an error if it indicates a failure.
>
> Fixes: bbb4c4323a4d ("dns: Allow the dns resolver to retrieve a server set")
> Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216637
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/dynroot.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index 34474a061654..4089d77a7a4d 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -114,6 +114,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
>         struct afs_net *net = afs_d2net(dentry);
>         const char *name = dentry->d_name.name;
>         size_t len = dentry->d_name.len;
> +       char *result = NULL;
>         int ret;
>
>         /* Names prefixed with a dot are R/W mounts. */
> @@ -131,9 +132,22 @@ static int afs_probe_cell_name(struct dentry *dentry)
>         }
>
>         ret = dns_query(net->net, "afsdb", name, len, "srv=1",
> -                       NULL, NULL, false);
> -       if (ret == -ENODATA || ret == -ENOKEY)
> +                       &result, NULL, false);
> +       if (ret == -ENODATA || ret == -ENOKEY || ret == 0)
>                 ret = -ENOENT;
> +       if (ret >= sizeof(struct dns_server_list_v1_header)) {

This needs an additional ret > 0 check, as the comparison may return
true with a negative ret if it gets promoted to an unsigned.

> +               struct dns_server_list_v1_header *v1 = (void *)result;
> +
> +               if (v1->hdr.zero == 0 &&
> +                   v1->hdr.content == DNS_PAYLOAD_IS_SERVER_LIST &&
> +                   v1->hdr.version == 1 &&
> +                   (v1->status != DNS_LOOKUP_GOOD &&
> +                    v1->status != DNS_LOOKUP_GOOD_WITH_BAD))
> +                       return -ENOENT;
> +
> +       }
> +
> +       kfree(result);
>         return ret;
>  }

Marc
