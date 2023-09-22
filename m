Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D87ABA5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjIVUEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjIVUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1DB1A6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695412995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zU1ePHAefeFxTXZM8u/psnUpZJDPZqr4P4dFF5GIDXg=;
        b=hlOZRxuF4gKifKexpynMWviFxjl9Sip1+EFerrYFbUVpXsR0na0D7GW63HjiL7xM7hiTmq
        yNCUS0KOVWskuTvQwSFrNN1QXo7KrVwW2OXOnZZ5uq/ieg4uI6SThdczLFhM1OZjwMgXUB
        jI/I7DmOCW8CdcdIDYY8qZBYLKmEU6Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-ZADIF8QiOXOKxLxLiT0Cpg-1; Fri, 22 Sep 2023 16:03:13 -0400
X-MC-Unique: ZADIF8QiOXOKxLxLiT0Cpg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-321596eef3cso1692393f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412992; x=1696017792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zU1ePHAefeFxTXZM8u/psnUpZJDPZqr4P4dFF5GIDXg=;
        b=XxpFrGJXBsM1cisiLl03PeTPRTdmOSMX/tsXxdPb1gD/g4y3B3dQWEOYW4Iz0GcmsN
         B7dY1rjVcZ4dcPNgg+tKZxl+wkFX58sAy4LUWCI35CzSaaxvXrucM8oiV3AgsrH0wMEq
         h90ER9YUSfOy/NW1g3y7swIP7qW75L9ddxzvxCwDAqJV+wGQMivgf5UqZLc1LeK4rbfX
         RWV//lUc0qi5nHcK07UD6KWOEpivNgWOgWkvlWDbPcU6bhEexDvnxepYOJHNvHtHjL2z
         gQ/0d6xypENrel5yFqVsBpSPEGyysbC+58svrwYjhvTFhLqGAVuYNy+RmynTXS9M7Yzt
         qhaA==
X-Gm-Message-State: AOJu0Yy9yEXLoVKU2giaP2PHw74S/3gGHOjTegdW0k2R4BPlBXTvjpGe
        bJgjiDR6I8eaT0+h0zbdVY9EqYxEdGUN7TKqCprmtv7bz7b7H1j/ZYUMFMfBziC45wsoNzGpDJm
        9wmLhItscTTkhFIxUv55TF3OGrWcBToHzbhqtwWqY
X-Received: by 2002:a5d:634f:0:b0:314:15b7:20a5 with SMTP id b15-20020a5d634f000000b0031415b720a5mr527253wrw.54.1695412992192;
        Fri, 22 Sep 2023 13:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTZl6rkhr/PiUOUiLr+kSFy/3mY+COZ4tNEWDsl/U+LxS1XkQWhOSTYt8+bj43ud44/d0uOrILQ7qwJNK57cg=
X-Received: by 2002:a5d:634f:0:b0:314:15b7:20a5 with SMTP id
 b15-20020a5d634f000000b0031415b720a5mr527243wrw.54.1695412991901; Fri, 22 Sep
 2023 13:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695403360.git.christophe.jaillet@wanadoo.fr> <6083c5d6e7e4eb567bf6f5cbb5bdf6b0286cee45.1695403360.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <6083c5d6e7e4eb567bf6f5cbb5bdf6b0286cee45.1695403360.git.christophe.jaillet@wanadoo.fr>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 22 Sep 2023 16:03:00 -0400
Message-ID: <CAK-6q+ifLNmM_nT5MGy9SPAmx61=AogkyNsGw=yPdYPsUsFcyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        gfs2@lists.linux.dev
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

Hi,

On Fri, Sep 22, 2023 at 1:38=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 8 is not the maximum size of the suffix used when creating debugfs files.
>
> Let the compiler compute the correct size, and only give a hint about the
> longest possible string that is used.
>
> When building with W=3D1, this fixes the following warnings:
>
>   fs/dlm/debug_fs.c: In function =E2=80=98dlm_create_debug_file=E2=80=99:
>   fs/dlm/debug_fs.c:1020:58: error: =E2=80=98snprintf=E2=80=99 output may=
 be truncated before the last format character [-Werror=3Dformat-truncation=
=3D]
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls-=
>ls_name);
>         |                                                          ^
>   fs/dlm/debug_fs.c:1020:9: note: =E2=80=98snprintf=E2=80=99 output betwe=
en 9 and 73 bytes into a destination of size 72
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls-=
>ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:50: error: =E2=80=98_queued_asts=E2=80=99 direct=
ive output may be truncated writing 12 bytes into a region of size between =
8 and 72 [-Werror=3Dformat-truncation=3D]
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts",=
 ls->ls_name);
>         |                                                  ^~~~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:9: note: =E2=80=98snprintf=E2=80=99 output betwe=
en 13 and 77 bytes into a destination of size 72
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts",=
 ls->ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
>
> Fixes: 541adb0d4d10b ("fs: dlm: debugfs for queued callbacks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

there is a similar patch [0] already in the queue for dlm.

- Alex

[0] https://lore.kernel.org/gfs2/20230906143153.1353077-5-aahringo@redhat.c=
om/T/#u

