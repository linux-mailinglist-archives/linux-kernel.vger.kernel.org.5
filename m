Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9977F448
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349356AbjHQK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349978AbjHQKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5F198C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692267900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IRxWEvpry+CMCB1V4M7R9Ft7ALq/o4jMyxueGSdGQE=;
        b=R0OAnQOuu8/8bXUAwnNa+z8O2/l3UA8qrfGkVnugDNdx3uupdzSyWa16h/zU+lLoAT/nRb
        6cYrdcF20Oq0/wybszRTa73raR6JIG6zmhrGxH4Gv0OFypwKZuiKn24bwvC1cdOtShtBq6
        jbqMTtOipWBwbAekUjbPurHeWC5es8M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-05VdWRIoN5WYZFepzLVdcQ-1; Thu, 17 Aug 2023 06:24:58 -0400
X-MC-Unique: 05VdWRIoN5WYZFepzLVdcQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b7375e49so17543921fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692267897; x=1692872697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IRxWEvpry+CMCB1V4M7R9Ft7ALq/o4jMyxueGSdGQE=;
        b=D81JLGk5o/sKqEKPT+jZnzVEjwR9kwiHS6rGg+uDfXzHQJQC7pJlK3fDSZW/IUIKbV
         MYVkwVycPnCkTUEx3dEKGnycOFy/SrHUuxAklcXFFLQcqGGs3kIvpoNTI/e6GSGDI9B1
         1yDY8bDhXg1m8B22/U1UQfF1RNRv4A3KNQztE3g6FmiRi2AqjG1k+IZUk8CVFTa+0ZRF
         sYHnGPXMi4GUwM/BFGI+T/PODwuJiWW54aNUcZycvsOio7nuJan6wQFSE//oiY2GUtCq
         mzodJs1xWDJclzpuqO6mwXtTzOVPr9AukLjgSXMB3O3Llh/Zu7WB7Lf2hTD4hZjwKmmO
         MX4g==
X-Gm-Message-State: AOJu0YzpnzreoGAoTDzLFLj/nSaFp6Gah+aTmUiu3r7Co5cq4fl7gOvg
        q+imJq3ejiRphHFpJ8i2bWkRPOxjbClA/d3jYZcz8Qa985wVgI8s0WOaPMn4fvjuQ4HCF6BXm6g
        AsG7HwBD4JUKJKpfJrnUt9QVB6mGGiTfZWUIj3uQ3jGhHzB/Z/NE=
X-Received: by 2002:a2e:511a:0:b0:2b9:7034:9bbe with SMTP id f26-20020a2e511a000000b002b970349bbemr2980380ljb.4.1692267896884;
        Thu, 17 Aug 2023 03:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBgIDULJ6Inl1Pke61/jYkvIRMPsZ4hSRwZSoxXgucJresEcAyxdEKMlWsoFg6hvKo7nHipu3sd9ZNJWFoGNg=
X-Received: by 2002:a2e:511a:0:b0:2b9:7034:9bbe with SMTP id
 f26-20020a2e511a000000b002b970349bbemr2980368ljb.4.1692267896541; Thu, 17 Aug
 2023 03:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
 <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local> <CACO55ttasKLxBTmZjN-XBOuJFC7rng2PbLgxCT8WT6ukOZNGzQ@mail.gmail.com>
 <20230816151252.GKZNzndDNySuWC+Vwz@fat_crate.local> <CACO55tunC5mEu3Tw64rKLqNM6MN6d=N90kYQKYwXWNMB=ahDaw@mail.gmail.com>
 <20230816221353.GXZN1KIXloRn8cGt5E@fat_crate.local> <CACO55ts7430tAUDC+0qY0EZ5ReO=2Rjwj1SzHaBLodmyBgrUrw@mail.gmail.com>
 <20230817081032.GAZN3V+NQ1blzQC2sU@fat_crate.local> <CACO55tv-dKnDzUYYFW+d2pNoAhEoEniUT=QAmD4-c_xKQw0cfw@mail.gmail.com>
 <CACO55tuWTYngfw+MZnan+U4eYyE+SvOWgxzffaCMNGQgriq3ig@mail.gmail.com> <20230817101129.GCZN3yUTWHkt22Jgec@fat_crate.local>
In-Reply-To: <20230817101129.GCZN3yUTWHkt22Jgec@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 17 Aug 2023 12:24:45 +0200
Message-ID: <CACO55tt9ZLKjaTyARXQ4VePgd41nYCQBn+wAGGDJRw1QV3hPBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>
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

On Thu, Aug 17, 2023 at 12:11=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Aug 17, 2023 at 12:00:47PM +0200, Karol Herbst wrote:
> > btw, what would help is to know where `nvkm_uconn_uevent` actually
> > fails, or rather, are you running into this "/* TODO: support DP IRQ
> > on ANX9805 and remove this hack. */" condition?
>
> Send me a diff, I'll run it here and catch output over serial.
>

simply throw a

printk(KERN_WARNING "nvkm_uconn_uevent %u\n", outp->info.location);

inside drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c:104 after that
mentioned comment.

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

