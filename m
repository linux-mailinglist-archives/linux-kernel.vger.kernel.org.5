Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4327FED58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbjK3Kyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjK3Kyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:54:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B4810D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:54:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b450bd014so766400a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701341691; x=1701946491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XR+8gmLSge88d7ltQNeWVsM7hJthxDwuclCE1+JMykY=;
        b=aVNu1BwFr5byo3AtgdAC0b9vqLdwFrf7remEgGA29tzUf4H4WQuljv79cK7Mwwz7L+
         CxNTCv9aNu3puo536sPNwqp1QP+Av2Zk9MQoPmOY6S8fQxfIYqeZwCfR5apH8Afv+smv
         Y/kNkt3g5GriW1jzt/VakJFOHJoCNPLc305Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701341691; x=1701946491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR+8gmLSge88d7ltQNeWVsM7hJthxDwuclCE1+JMykY=;
        b=vQIEa+DA9fQm2rC+XGtnjUKlGv3jsKiE66zK/9aI7QealLj0prCMsBv+Hsc2OYJppc
         1zIi6jrshJfdikhxSAwjYH8+eZdNYPATiYep5IW1RreVPQT2AYv5xNLMefnu5yBes77U
         WROBNWM0kdoKHOE33YZ9P7LD41USz77FpRQ9RNXNXuLxs4B9EUvSWFRLk4F2S9hP+RRi
         P7iWuGklwRjGBtRTFyTF1VEu7Fgw4/TtQpGB3jFrp3nP0knM7r+XESz9MB9bLg3CU0bn
         jAaGfbwHInWx/X0ZgePZqBbpLz2QoSlrmxzCTagwrynB2ej+ogLNdaYt3cMmlax4r/fq
         7hTw==
X-Gm-Message-State: AOJu0YwRFB/wRS72KbxC/ucsiGAnlUUBJPmIbOKYUwy2trWdn4GCSqdv
        6PjfsmCOyJqBodiVMNOx+2z8swvYWhSPEKgF5Cunvw==
X-Google-Smtp-Source: AGHT+IFAvEDD+XKsyvhQVBhDBApbFr7Fee0HYIPNqifh12zYTGl2jNJ0IpOVKoIozrPs4OrqAUaKTcws8RGb7cmEtQE=
X-Received: by 2002:a17:906:cec7:b0:a10:8db4:bcf3 with SMTP id
 si7-20020a170906cec700b00a108db4bcf3mr8968339ejb.9.1701341691027; Thu, 30 Nov
 2023 02:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20231116075726.28634-1-hbh25y@gmail.com>
In-Reply-To: <20231116075726.28634-1-hbh25y@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 30 Nov 2023 11:54:39 +0100
Message-ID: <CAJfpegvN5Rzy1_2v3oaf1Rp_LP_t3w6W_-Ozn1ADoCLGSKBk+Q@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     vgoyal@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 08:57, Hangyu Hua <hbh25y@gmail.com> wrote:
>
> fuse_dax_conn_free() will be called when fuse_fill_super_common() fails
> after fuse_dax_conn_alloc(). Then deactivate_locked_super() in
> virtio_fs_get_tree() will call virtio_kill_sb() to release the discarded
> superblock. This will call fuse_dax_conn_free() again in fuse_conn_put(),
> resulting in a possible double free.
>
> Fixes: 1dd539577c42 ("virtiofs: add a mount option to enable dax")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  fs/fuse/dax.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 23904a6a9a96..12ef91d170bb 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1222,6 +1222,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
>         if (fc->dax) {
>                 fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
>                 kfree(fc->dax);
> +               fc->dax = NULL;

Is there a reason not to simply remove the fuse_dax_conn_free() call
from the cleanup path in fuse_fill_super_common()?

Thanks,
Miklos


>         }
>  }
>
> --
> 2.34.1
>
