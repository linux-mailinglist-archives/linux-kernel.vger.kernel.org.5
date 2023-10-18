Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF17CE00A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345826AbjJROf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345835AbjJROf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E657B46B3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697639570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+hIIyolcoAhu3WZDYJvpkd8XrLzwi17lqom2zgmM7I=;
        b=SRvloYAiTcfUdlzfLK9rqEENcDPEauSo8ibTpY5wWeIB+hJm31op4UNX84Ru9dZO9G4iSr
        2TmkRlRsNc+Ke0O+A+nHJl9L3j047gGyprFG6O0ETw75WEZvKRkcg9Sdqv2njsYES5Uugk
        wXmFpxjZVnizUZHuoewwAhjL+AP2Czw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-fCId0Z_5Oau5U2ch7qphAw-1; Wed, 18 Oct 2023 10:32:38 -0400
X-MC-Unique: fCId0Z_5Oau5U2ch7qphAw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2b1ac753fso8079756b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639557; x=1698244357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+hIIyolcoAhu3WZDYJvpkd8XrLzwi17lqom2zgmM7I=;
        b=QOXnPU71aJY4FLIdkkL0d2rOxs4+8VBDiiWyAdI/e30RZgSGT+vexWzv2ewp9dbNcr
         5KPpfGJz77eWUsaHBURHJpPq8fWVlXdcsKaDAVWJqopU8oBJpyc7Qja+xdIJQs3QHDWF
         HHMkb/0Ii6GZ6PjrxCVX6+F2+5IiUKDZeE06KsUpFlAik0C2BkZmYfh2lKGKg+1g9cdj
         bBQ9pMyYo54ADZDeLeMXvXHXRUR+j5jyxo3D7GB0HAPVFPgvW+G2M0X4zAH7kstO9+/h
         Trc/aHPZJHJr2gyTIUTV61wNEbugUnkG18qcmAu4KCyP8nHq653inmKurKI+zXR34GK8
         RGmQ==
X-Gm-Message-State: AOJu0Yw1vbLmAVlQ3uz6oMdbr01SS1rmTxwnCLm0q3zHPv8BluaxfOqW
        c0vq76pJGlGLgzqJD6wIGCMmgMRp4UpVx6+RwApSCwPiBiR+fLKVvz1x7LI+mXxaKk3dzw4OFcH
        EHCdGx2ebXKc1x6XI895bxRHm7WS0jAkf/6IZJ64a
X-Received: by 2002:a05:6808:df3:b0:3a4:8251:5f43 with SMTP id g51-20020a0568080df300b003a482515f43mr5134035oic.40.1697639557741;
        Wed, 18 Oct 2023 07:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJZ0HVTUp+cKIoQPyPSp/EXlm6/WaNKSXxkPslSA2R5r3Bbt7OFS5yZTlg6c13Zt/RYoAUWjid9rbi0mzRUuU=
X-Received: by 2002:a05:6808:df3:b0:3a4:8251:5f43 with SMTP id
 g51-20020a0568080df300b003a482515f43mr5134021oic.40.1697639557500; Wed, 18
 Oct 2023 07:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
 <20231018122220.GB10751@lst.de>
In-Reply-To: <20231018122220.GB10751@lst.de>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Wed, 18 Oct 2023 16:32:19 +0200
Message-ID: <CAASaF6xHTv6iZd5ttHOJ_M=hpjaGZOnUCGSHkbGy_yLbe2G8nw@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix short copy in iomap_write_iter()
To:     Christoph Hellwig <hch@lst.de>
Cc:     djwong@kernel.org, willy@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 2:22=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 18, 2023 at 10:24:20AM +0200, Jan Stancek wrote:
> > Make next iteration retry with amount of bytes we managed to copy.
>
> The observation and logic fix look good.  But I wonder if simply
> using a goto instead of the extra variable would be a tad cleaner?
> Something like this?

Looks good to me. Would you be OK if I re-posted it as v2 with your
Signed-off-by added?


>
> ---
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 061f3d14c12001..2d491590795aa4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -881,8 +881,10 @@ static loff_t iomap_write_iter(struct iomap_iter *it=
er, struct iov_iter *i)
>                 size_t bytes;           /* Bytes to write to folio */
>                 size_t copied;          /* Bytes copied from user */
>
> +               bytes =3D iov_iter_count(i);
> +retry:
>                 offset =3D pos & (chunk - 1);
> -               bytes =3D min(chunk - offset, iov_iter_count(i));
> +               bytes =3D min(chunk - offset, bytes);
>                 status =3D balance_dirty_pages_ratelimited_flags(mapping,
>                                                                bdp_flags)=
;
>                 if (unlikely(status))
> @@ -933,10 +935,12 @@ static loff_t iomap_write_iter(struct iomap_iter *i=
ter, struct iov_iter *i)
>                          * halfway through, might be a race with munmap,
>                          * might be severe memory pressure.
>                          */
> -                       if (copied)
> -                               bytes =3D copied;
>                         if (chunk > PAGE_SIZE)
>                                 chunk /=3D 2;
> +                       if (copied) {
> +                               bytes =3D copied;
> +                               goto retry;
> +                       }
>                 } else {
>                         pos +=3D status;
>                         written +=3D status;
>

