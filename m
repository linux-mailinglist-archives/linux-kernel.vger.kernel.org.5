Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19805776EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjHJDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJDif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689AD2100
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 20:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691638669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSXOWT6dcdztqmjZzbfXKd/Gq/opxoDLOcxehy7PRw0=;
        b=UucR7XVtWug/HHaJE6SoV1x5jRRfVrCiRGLiGv7/oBV3uRlccqgrL2T7LgJZ1HgutpgmFV
        JZLFeNcjxtcrbRuWeoWZftPsV8ROtaxj+awbqjVqBx/u4gxU4WwEyttKH3pHuS36aeBA69
        u0DY1LysGaXUCAq8GmwCj4t0G6T/IB8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Glc78wEDNv-kE6O4U5McxA-1; Wed, 09 Aug 2023 23:37:48 -0400
X-MC-Unique: Glc78wEDNv-kE6O4U5McxA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ba077dcbbcso4924231fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 20:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691638666; x=1692243466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSXOWT6dcdztqmjZzbfXKd/Gq/opxoDLOcxehy7PRw0=;
        b=iP9joVKYYoV2NE7CAiIU7DIFS40Y3IuKq2sZMxJrlrGVxVorOSXs0XDL8/O07GCj5d
         XsoTWw/q/+ESJjA59yXcRMScI3xSep8QMT08ZwEKm5e/72xKOSWvp5btAaaKrf5JW75L
         FgorpXF/gbKmZu9RICZviHS3bYvAv2qBPDeB8siNS+bwmPfFXy3E+DMvjlvCChr+TtCI
         Ffzo1EYT7KcEjGIBuqycqVNUO2aDcv1l6+nktRyfRweuJ6AMDYhDxuoA9RocCh4s4d2L
         JcfY53BkL3OX74zQvFQdThw15yWkFAU9V2rvy5alozmkU+SqviuE/jVvKx75RLxfZaZ9
         YQ0A==
X-Gm-Message-State: AOJu0YyRvoYDQKW7tEUO9zI8UH7MNzv2HOvD7EfEemQAmbgZrV5+fLFM
        Cw31XC2kFsOZoDb57c0cLaVZmRsaBBN6pbtCxjMM1etkgp1XZ0Dt3NUrkLi1nisYiqHY8smZIlS
        o0MXmdAEU0HPvcrOEr2QWzybJMAxCobcITehAjVaP
X-Received: by 2002:a2e:9447:0:b0:2b6:cd6a:17f7 with SMTP id o7-20020a2e9447000000b002b6cd6a17f7mr782542ljh.20.1691638666802;
        Wed, 09 Aug 2023 20:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEewlMoMiXrQySS2PN2O/NVdVgzNVNBbaX/UNMdkpWnE72zb71JfMWUaEcEFr8F2RrqQ+ZaZi/ZseR6/KLEkFA=
X-Received: by 2002:a2e:9447:0:b0:2b6:cd6a:17f7 with SMTP id
 o7-20020a2e9447000000b002b6cd6a17f7mr782529ljh.20.1691638666517; Wed, 09 Aug
 2023 20:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230809164753.2247594-1-trdgn@amazon.com>
In-Reply-To: <20230809164753.2247594-1-trdgn@amazon.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Aug 2023 11:37:35 +0800
Message-ID: <CACGkMEuuEngqX6eKvRLvBm7_gGipVjfbkQ+JaXsE903CEkNfvA@mail.gmail.com>
Subject: Re: [PATCH v4] tun: avoid high-order page allocation for packet header
To:     Tahsin Erdogan <trdgn@amazon.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:48=E2=80=AFAM Tahsin Erdogan <trdgn@amazon.com> =
wrote:
>
> When gso.hdr_len is zero and a packet is transmitted via write() or
> writev(), all payload is treated as header which requires a contiguous
> memory allocation. This allocation request is harder to satisfy, and may
> even fail if there is enough fragmentation.
>
> Note that sendmsg() code path limits the linear copy length, so this chan=
ge
> makes write()/writev() and sendmsg() paths more consistent.
>
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> ---
> v4: updated commit message address comments from Willem
> v3: rebase to latest net-next
> v2: replace linear =3D=3D 0 with !linear
> v1: https://lore.kernel.org/all/20230726030936.1587269-1-trdgn@amazon.com=
/

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

