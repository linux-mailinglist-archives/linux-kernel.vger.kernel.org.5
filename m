Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6B477EDC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbjHPXTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347122AbjHPXTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E610C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692227907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e27Prao+8w59knGJmOWj+3FndpKc2qgsbyaKBRsKylU=;
        b=Q9/aQrA5X1+ygBNF3HAUmTXZc8+5fQNm8ul1cwsU4JAu+w101B/NZOFJNuRuC3qVY49RYU
        b6VZGpS55+W/XWUkDGkMBJNQuImWAOGtJSdA3hcikqc1IR+qaiC28pjxaC2RZ1d0B7pxBT
        dWpTouVbmHkqYpAdf6/bGaUxVBpg7C8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-4dLJJUB1OtakkQbz6wKCTQ-1; Wed, 16 Aug 2023 19:18:25 -0400
X-MC-Unique: 4dLJJUB1OtakkQbz6wKCTQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe6b399119so1420295e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227904; x=1692832704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e27Prao+8w59knGJmOWj+3FndpKc2qgsbyaKBRsKylU=;
        b=BQUzonUL0q9aOgiwAECO/5O5i+N9PVsHFJ19oEmbvBEMAJ3OyhGq+XF8BopZyFZ/Sm
         ikiK56nKJnS37qCM1oDTwWJ3Q+1g6yb+Jjy/w7lmnmaGHcwZkS58QOv/BD8KzSwX35SK
         Y/7Ns0mZbay5yZtrKO7tKUkOe+m3Hqat6dqY/w8g86eC/+immGlv/5zwB4hnIHMMBBGB
         1KUgqvuXIMYY59rK+Q6R8exwtQa3vkWt79BZD8/BfWdtt5j79AkoofYHoGyaj9ObyeX6
         Ly1fmL6Cn31CIwB97cK+OvLGVDajZDSToET98hppVgyYbLFpnT6tTGzVfeXd19BN26P6
         Ez/w==
X-Gm-Message-State: AOJu0YwlLdw6ynw2qRIWY6UiM4lnlcYaRUutt01Xo+lBbXxX6mRxEpgK
        lnXUprBeYghaYCGM6I8VpkODRlzsT87LnaiYngOAJqpNtsJqo5RqPc1fxrCRL6Ye1O4h+D3Bc68
        6r3Q3Y+OA1ARvYxgH4uhUS2ITP2aMv2ilkwzHkVsEz7CmJ/VA2a0=
X-Received: by 2002:a2e:535d:0:b0:2b6:af68:6803 with SMTP id t29-20020a2e535d000000b002b6af686803mr2442423ljd.4.1692227904017;
        Wed, 16 Aug 2023 16:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1K6kBGziG4deNuHLAraS88W59a/Ay7fpQlOgwaRtMAQHHcJu47CsepbxS6R+gOkE0cHNdxbWZY06UjdNnDbI=
X-Received: by 2002:a2e:535d:0:b0:2b6:af68:6803 with SMTP id
 t29-20020a2e535d000000b002b6af686803mr2442415ljd.4.1692227903720; Wed, 16 Aug
 2023 16:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230814144933.3956959-1-kherbst@redhat.com> <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
 <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local> <CACO55ttasKLxBTmZjN-XBOuJFC7rng2PbLgxCT8WT6ukOZNGzQ@mail.gmail.com>
 <20230816151252.GKZNzndDNySuWC+Vwz@fat_crate.local> <CACO55tunC5mEu3Tw64rKLqNM6MN6d=N90kYQKYwXWNMB=ahDaw@mail.gmail.com>
 <20230816221353.GXZN1KIXloRn8cGt5E@fat_crate.local>
In-Reply-To: <20230816221353.GXZN1KIXloRn8cGt5E@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 17 Aug 2023 01:18:12 +0200
Message-ID: <CACO55ts7430tAUDC+0qY0EZ5ReO=2Rjwj1SzHaBLodmyBgrUrw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:14=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Wed, Aug 16, 2023 at 11:27:05PM +0200, Karol Herbst wrote:
> > that GPU has only a `DMS-59` connector, is that right?
>
> No clue. How do I figure that out?
>

do you have one of these? https://en.wikipedia.org/wiki/DMS-59

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

