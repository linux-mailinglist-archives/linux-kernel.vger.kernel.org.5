Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9077DDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbjHPJxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243645AbjHPJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BF12738
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692179524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVs8rRFJ0IEN0Qvd7JyrUgFnvlIR0R3LkNLJET1b6L0=;
        b=Um+4Q6nq2Xz1uWHdGaXVJHkHtUd4QOxFV8gfx2Y14Zlxih/t6/65GFPqEC9cOVzfxKSSnl
        7fatHZ8dliK9r3algsexVXPVgHT611LDT7DV+GXG3Ig0HXJVZq3dic0Nzom5MqBJFdafIS
        354hzWQU1ccauJ7D2Rxe87vkSEbReyk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-fLJJUVdDNzyxh-XdgtUBQw-1; Wed, 16 Aug 2023 05:52:03 -0400
X-MC-Unique: fLJJUVdDNzyxh-XdgtUBQw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe4f5ffe2aso1268283e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692179521; x=1692784321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVs8rRFJ0IEN0Qvd7JyrUgFnvlIR0R3LkNLJET1b6L0=;
        b=f892wQoFcoQEKK2WK9SpEkTLUBlzT78+VfkQ56QO92uOYf0lutpsU9q3+8eNmpYnA5
         5ho728CJ375BCSQTy/+hOu22oxb7ouXX+EIWzDcYzpnOR/eDW8B4Re3fwovd5+sikrGH
         XKqTj2es3ab8y19zQhk2FU97NlynzM6VUQFBrGBpomR2CO1zCLcyjE8UOdBYQ7mMoG8i
         s1Zhx8ZfrhZPG1AT2T5Sqmh9gvmfaYAQ/eq2ffrqqaURJ+FwtcKfIgMvHSDGOkHjqEfy
         V/RTnqj1LCVMF8LDhqlPdVa+bfIuV2LYe5NNZNRvPMiZFg+7E5TUSlysQc1kSTyhItqQ
         YgNg==
X-Gm-Message-State: AOJu0YyfyVb3CmeHdhCE+GwLoxpr8Ij5Nf7FuKQwpdKQOB2kICqGgf2w
        PBt2oBh60fQJ97RvA7MpYpwDRWDvduEGS3IGYtf0gqNKI3AkG5TtwSiaAV98hWOtC5PqqNBXjE4
        Q21dCw63Vpe4qMoXUfP/iY3gs1c5/fb0513zx5FyX
X-Received: by 2002:a2e:9043:0:b0:2b9:e10b:a511 with SMTP id n3-20020a2e9043000000b002b9e10ba511mr908811ljg.0.1692179521582;
        Wed, 16 Aug 2023 02:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGanDULkwlMo/rQxiB2QPRaIEdUVecA5fMUQidnmhkP0uI680R9tlOgxGyrfqoEs1/jh/773s08ogYfa/jn3uU=
X-Received: by 2002:a2e:9043:0:b0:2b9:e10b:a511 with SMTP id
 n3-20020a2e9043000000b002b9e10ba511mr908801ljg.0.1692179521300; Wed, 16 Aug
 2023 02:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230814144933.3956959-1-kherbst@redhat.com> <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
In-Reply-To: <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 16 Aug 2023 11:51:50 +0200
Message-ID: <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
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

On Wed, Aug 16, 2023 at 11:30=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Mon, Aug 14, 2023 at 04:49:32PM +0200, Karol Herbst wrote:
> > We can't simply free the connector after calling drm_connector_init on =
it.
> > We need to clean up the drm side first.
> >
> > It might not fix all regressions from 2b5d1c29f6c4 ("drm/nouveau/disp:
> > PIOR DP uses GPIO for HPD, not PMGR AUX interrupts"), but at least it
> > fixes a memory corruption in error handling related to that commit.
> >
> > Link: https://lore.kernel.org/lkml/20230806213107.GFZNARG6moWpFuSJ9W@fa=
t_crate.local/
> > Fixes: 95983aea8003 ("drm/nouveau/disp: add connector class")
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_connector.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
>
> This one ontop of -rc5 doesn't help, unfortunately.
>

Mind sharing your kernel logs with that patch applied? I suspect your
system boots up but you might just not have the connector available or
something? It could be that you have one of those GPUs affected by the
original change and then we'd have to figure out what to do with that.

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

