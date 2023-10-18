Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC957CD2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjJRDZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRDZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32664F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697599466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vP8Akdnj19M5FdbKS3dxPmuDyWARzrhP3HlPL65UPsI=;
        b=YVp+AA3MfPR3UPCD6GKfjjUY1Nqc+cfhPcQbIfzQVBKiP+A9DDDqEOtpE9kwS3k4eANb+2
        5o8g6LG6e01C9DSrYydTfy+3dOwaRfzo24hchiRls+tkFDeYS0Oot+Lfp/SOLOXcDfggn+
        mBUEKE9rFg4s2hKoNJdemsvuc59p30g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-gEUOxsnoN3WuASCRv_VpQw-1; Tue, 17 Oct 2023 23:24:24 -0400
X-MC-Unique: gEUOxsnoN3WuASCRv_VpQw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c53c85e482so11106171fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697599463; x=1698204263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP8Akdnj19M5FdbKS3dxPmuDyWARzrhP3HlPL65UPsI=;
        b=ZM4ZWnYtJfU/U+CxIuyTds+8rw2CgsguW3qaA/JuUeEa3XVYa1gtHEHKaOoQGBY+7t
         g2HGKbV3ukJekxHw0yZSzieAUQGMotK8aUqcWBzFT571XImyetsMozQ42WcU3IYGEcUi
         PzbgBWBVbmclW8JWXHeaLNmy9ScyDxnUqy7gJUiZAqoWC/kO82V52X5lRihvERoxXu3j
         BEAnmKn2CetfHpjjbQlYniOlvELSAh+qP7aYoMFmrs9N2HZUr2CGlqRZhNtDVz2if4jb
         o7IGOFyZFCXilLRBpntT7we4JYX9/kkXx9h6u17EESn2+zy1ibtc6+h44g/lrs1GtJMv
         okfw==
X-Gm-Message-State: AOJu0YzgcysByJJ1j0Ql3mDO2KjWngHCEIRXLnIDQiWFtB5LKdScay/f
        lEjcE8aHeelYLS4u1YmDvYHpoVYWtXrH8nhy6GedaBQNWcdWoRe/7Ax0DuWZzjxm9arn3NkFfY6
        9TgNm72wUV2JKDOGEyDTsZOxTjhNuXynnljzJXwQCBaj5sD7vrPk=
X-Received: by 2002:a05:651c:1a0c:b0:2c5:3490:9bbc with SMTP id by12-20020a05651c1a0c00b002c534909bbcmr3660493ljb.26.1697599463124;
        Tue, 17 Oct 2023 20:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8B9ZK7fbk2rH4EnZYGhL/MxTSmtexty2Z722xVv1mLZr7/rsSQfqXL7RbU2lXxCtomg2SHsLD7EapNU7bimo=
X-Received: by 2002:a05:651c:1a0c:b0:2c5:3490:9bbc with SMTP id
 by12-20020a05651c1a0c00b002c534909bbcmr3660486ljb.26.1697599462824; Tue, 17
 Oct 2023 20:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231011064208.2143245-1-lulu@redhat.com> <20231011064208.2143245-4-lulu@redhat.com>
 <CACGkMEtuavpV=D0CPad2EhaQ_Xkr6TNa2jgFer-JO2SwSvyoeg@mail.gmail.com>
In-Reply-To: <CACGkMEtuavpV=D0CPad2EhaQ_Xkr6TNa2jgFer-JO2SwSvyoeg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 Oct 2023 11:24:11 +0800
Message-ID: <CACGkMEuP=nF=Ez=17e4Db_XH+2KX31BdjHo7hYytB_Q3reE8xg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, xieyongji@bytedance.com,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Oct 11, 2023 at 2:42=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > In VDUSE_GET_RECONNECT_INFO, the Userspace App can get the map size
>
> I'm not sure why this is needed, the structure that mmaped to
> userspace should belong to uAPI then userspace can do versions there?

Ok, so I think this makes sense, it can help to avoid duplicating
versions in each mmaped pages.

Thanks

