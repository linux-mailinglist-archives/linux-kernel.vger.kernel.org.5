Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1E7D0B04
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376578AbjJTJAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376557AbjJTJAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B13A1A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697792352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvz9/SuKlOMM8eAgBNPqNzyC4gsPxikcYikuf/XYhDE=;
        b=W/ad8hcr32ZUvgbUuKVT74tF8JnKkYUaFaMzThEGgtk5esj2TRr2YlvDlyIAbq8iPqbxBM
        ytNpTqx9KSTWkIsvzgMw58aEYuuTEktZWJpEixT7M/8hzmyHKFSg/IEcjQp8TWHq5plFpl
        9GJcr4Zh+KvMNe+wTMVuZAinKC1c7oE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-4w44VoWyNUGA_V2L9r8lXg-1; Fri, 20 Oct 2023 04:59:08 -0400
X-MC-Unique: 4w44VoWyNUGA_V2L9r8lXg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32d9751ca2cso274176f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697792347; x=1698397147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvz9/SuKlOMM8eAgBNPqNzyC4gsPxikcYikuf/XYhDE=;
        b=pKMhbtFAQk/fTNKdQlmEqtn6p4UtYVPjPC4MXm/SAADlmrx+ZFim8tizDN6RTkEAtz
         8rSz3AQ6dlJ/aDbO0xeOT5J2ZLDWy3f9hKowG/5DUOzJN793Y6LXORJ/mf8qpG/UaPhb
         O9mJtPQvehDVOS0TWYiP70bwVxop218zTi0L3vApgycLxdZ2+4+wqkI0c3+ASBV6nC22
         2sD15kGocJkfeyZB/eE6s9u7OFzRVXkb8dhngGYRrErVcdo+krmF5sADido68kMOdNih
         /CPP4qyIgMGdck3BBGu4YVM9cEN6ueKK7JUG/fjyDkmmM5P8VcuzAGIEZRpQ35ngmSyZ
         QTxg==
X-Gm-Message-State: AOJu0YxVtOFp1A/jgt9k6St5oYva/dcufj3myD6LpAlwfDJjI5DVC2DU
        ivFfdUEU/zVLJUn6oTap/295YFpGgmQFvBcC9vkgb6rsu78TJjIMKGmZwmqQe/zpFEKtbQ39god
        jvLjGuSOMVeBIeiUQr0ekmY7N
X-Received: by 2002:a5d:5709:0:b0:319:71be:9248 with SMTP id a9-20020a5d5709000000b0031971be9248mr874305wrv.19.1697792347514;
        Fri, 20 Oct 2023 01:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwAlnz5LFaGpViOPQBVbbYYBiYpleDv/HpXbeUWdlmaJa7e7XRaJ3iQ9+0DjOBQ8udLXNkOQ==
X-Received: by 2002:a5d:5709:0:b0:319:71be:9248 with SMTP id a9-20020a5d5709000000b0031971be9248mr874294wrv.19.1697792347172;
        Fri, 20 Oct 2023 01:59:07 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d4d43000000b003196b1bb528sm1226535wru.64.2023.10.20.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:59:06 -0700 (PDT)
Date:   Fri, 20 Oct 2023 04:59:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arei.gonglei@huawei.com,
        linux-crypto@vger.kernel.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio-crypto: handle config changed by work queue
Message-ID: <20231020045844-mutt-send-email-mst@kernel.org>
References: <20231007064309.844889-1-pizhenwei@bytedance.com>
 <ZTIVDQZeHb2BlbH7@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTIVDQZeHb2BlbH7@gondor.apana.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 01:50:05PM +0800, Herbert Xu wrote:
> On Sat, Oct 07, 2023 at 02:43:09PM +0800, zhenwei pi wrote:
> > MST pointed out: config change callback is also handled incorrectly
> > in this driver, it takes a mutex from interrupt context.
> > 
> > Handle config changed by work queue instead.
> > 
> > Cc: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > ---
> >  drivers/crypto/virtio/virtio_crypto_common.h |  3 +++
> >  drivers/crypto/virtio/virtio_crypto_core.c   | 14 +++++++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> Patch applied.  Thanks.


It's in my tree too, but git should be able to figure it out.

> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

