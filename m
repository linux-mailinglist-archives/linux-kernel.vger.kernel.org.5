Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BEE77EBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbjHPV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbjHPV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3C1FD0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692221239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhlCltG/6J4T9mqv57bOozrctEIXFs/9BESilmBG2aE=;
        b=VQZDcXc7TefFXZJtlGW5et8r+KV6Fh0tUggpRgYard6wPQOQOQd5WniSCnI4EMPP1sZlne
        HknbzvphXSF3C+Dff6gu/vmGfSlLYcOWRFQCtAoZSrc2LtckmY+wRCghigLvUpJahmglab
        UnEITyOI3BwDUDbVKD38qkrHxtcrhEw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Bq0CUfI2Od6uWL1SAj2b5A-1; Wed, 16 Aug 2023 17:27:18 -0400
X-MC-Unique: Bq0CUfI2Od6uWL1SAj2b5A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so12788131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221236; x=1692826036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhlCltG/6J4T9mqv57bOozrctEIXFs/9BESilmBG2aE=;
        b=NO5sJFbAws5lO9lE5d326yVqYZWzhe0vrWf0FYpm/fAr4fOtPKA5dVsJJFd+Xyci/A
         hVSZTTB3zUPXCoW4VI4hG4F9zy9RIRn+RryYGJXOGFj7POiuiUudXnvRSu791XgOar3C
         qYmzHL0UM1NKGpjhhPOT9GyCy5KXLDBPnEpBHzmhwVtWQLiuPyu0allIVb+JyQY8z+yq
         gCW1/6CmHYURkjsmBLv6Ip4Ck2ybRcR712GXbPq4wIfWe4UFamla5/Gs5LBUC+vSpeGi
         WweSz6Wou8VdBG//3w3HtrhpjcMa6eszRp5i30y9ynnXhGzMV0KLAnpjnOgVaYnHW4lt
         zVgQ==
X-Gm-Message-State: AOJu0YylfMwjdpbDiT2KyfRapCEWCpxe46KaO9Ga19azVofwC2bbU72O
        IajE6Hmb4esE4Gvy8AcGFL7Jwuz0yPhXD95+nvYqrEXqBVIL6GvqLrgUiMmLDrTCuRCUkJlXjSa
        27HoB5MlLmPZGcsc7pOIa1v0G7gyAwSvjHu8nHpeexae9Y9mw9+A=
X-Received: by 2002:a2e:b53a:0:b0:2b8:3c52:113 with SMTP id z26-20020a2eb53a000000b002b83c520113mr2446675ljm.5.1692221236442;
        Wed, 16 Aug 2023 14:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqEJkEAo5Pa4rNZ4q8LahYF0AcRVhQvLqoo9MCByspT6ADS2ntaRvd1hh34mL6+q7aFi+DN5uWeOnI1es4zj0=
X-Received: by 2002:a2e:b53a:0:b0:2b8:3c52:113 with SMTP id
 z26-20020a2eb53a000000b002b83c520113mr2446668ljm.5.1692221236114; Wed, 16 Aug
 2023 14:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230814144933.3956959-1-kherbst@redhat.com> <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
 <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local> <CACO55ttasKLxBTmZjN-XBOuJFC7rng2PbLgxCT8WT6ukOZNGzQ@mail.gmail.com>
 <20230816151252.GKZNzndDNySuWC+Vwz@fat_crate.local>
In-Reply-To: <20230816151252.GKZNzndDNySuWC+Vwz@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 16 Aug 2023 23:27:05 +0200
Message-ID: <CACO55tunC5mEu3Tw64rKLqNM6MN6d=N90kYQKYwXWNMB=ahDaw@mail.gmail.com>
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

On Wed, Aug 16, 2023 at 5:13=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Aug 16, 2023 at 04:57:28PM +0200, Karol Herbst wrote:
> > Do you have any connectors listed in "/sys/class/drm"?
>
> tree /sys/class/drm/
> /sys/class/drm/
> =E2=94=9C=E2=94=80=E2=94=80 card0 -> ../../devices/pci0000:00/0000:00:02.=
0/0000:03:00.0/drm/card0
> =E2=94=9C=E2=94=80=E2=94=80 renderD128 -> ../../devices/pci0000:00/0000:0=
0:02.0/0000:03:00.0/drm/renderD128
> =E2=94=94=E2=94=80=E2=94=80 version
>
> > Also, mind sharing your vbios.rom file from
> > "/sys/kernel/debug/dri/0/vbios.rom"?
>
> Attached.

that GPU has only a `DMS-59` connector, is that right? I have such a
GPU myself, so maybe I can trigger that bug there, let's see..

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

