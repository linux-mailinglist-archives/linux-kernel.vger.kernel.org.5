Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531D807AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377311AbjLFVwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377373AbjLFVwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:52:49 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D4F10C4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:52:54 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db539f21712so301964276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701899573; x=1702504373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad4QKqllEurVWf/Pv2WnyL7sj04ktRUEA1KwimHLGBw=;
        b=A0FaZ5VPghmIMOFtE7VI5ktxGozz3Olwlubi9g38u8YjHjJ4FQqmsMbHx5O5owP402
         MCvGx1UDIadD/hB9HuYVtFRO/iIwo0dNq0lSiw4mz8KYluLoEdNgvKuQQgFIuh8Nv1eB
         kYposvN9K5OwVDmbRa3Gv9n912+wMYAeAfqA632ImawSese1WvEBzRAEmcBfENMmAHDE
         LJudlvpdo32+Q65nFFXz1GnhCjH075c+xgvoc/efJW9ZJesqy2nIpO9HcSJ8dBAPDRyQ
         yZGac/GZ9q3ZVNEXO8rmyC7iA0zgf+Vwi80FNnTTU73Q8ksqhIGRg/Y6vOxjZt64WSWi
         yKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899573; x=1702504373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad4QKqllEurVWf/Pv2WnyL7sj04ktRUEA1KwimHLGBw=;
        b=FS1eBMC7y3Ztul0Q/0QYoeWsGUwVY31Z+z/5tfAXzIfVDDKPwhQbPHwumLr0DmUlmX
         5AdtUFba5yvagZ4SkVa6GpK8BnulJnmfMP9tospoIGAlDrwMczZtxGaSeTLPRMlvOj+i
         YgRsFoytjVc1uVbrLLPvpm0rp/96uHtQsagsSJOK0z/w5aaWsHMt9JyVCf+H/uFjVZLV
         YvuinFiUxTwpckEzBxGF+RUGsU9xVu080BTNWgp5ENeEA/K/Rdn/+0Z61slwy34hF/uO
         SVSbLotEYypBD9Q6tDZeIWiS5KEZtiltRZpYmXTy7u468K6oN/7NacUhUdYFWqfbQxuD
         mM8w==
X-Gm-Message-State: AOJu0YwbtI8iF/eUvQ4c73dG1dZU4rwFZ2N6MK1og8kAE6vTxcHbBO/p
        1jLQbhUKNF7PlVPGXYNBf6mS/kFoqg6nRsNozmb/
X-Google-Smtp-Source: AGHT+IEj7nPBQx69pTJuIU/DScLOgVaCvMx3IAuTkYQQJ5vMAh2Hehp1yFZ/6ct0anbgpUrLprVHp8nDNRkJVZqoN6c=
X-Received: by 2002:a25:ab66:0:b0:db7:98ba:2468 with SMTP id
 u93-20020a25ab66000000b00db798ba2468mr1505130ybi.28.1701899573074; Wed, 06
 Dec 2023 13:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20231206060629.2827226-1-david@fromorbit.com> <20231206060629.2827226-6-david@fromorbit.com>
In-Reply-To: <20231206060629.2827226-6-david@fromorbit.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Dec 2023 16:52:42 -0500
Message-ID: <CAHC9VhTP3hRAkmp7wOKGrEzY5OXXJpnuofTG_+KdXDku18vkeA@mail.gmail.com>
Subject: Re: [PATCH 05/11] selinux: use dlist for isec inode list
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 1:07=E2=80=AFAM Dave Chinner <david@fromorbit.com> w=
rote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Because it's a horrible point of lock contention under heavily
> concurrent directory traversals...
>
>   - 12.14% d_instantiate
>      - 12.06% security_d_instantiate
>         - 12.13% selinux_d_instantiate
>            - 12.16% inode_doinit_with_dentry
>               - 15.45% _raw_spin_lock
>                  - do_raw_spin_lock
>                       14.68% __pv_queued_spin_lock_slowpath
>
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/linux/dlock-list.h        |  9 ++++
>  security/selinux/hooks.c          | 72 +++++++++++++++----------------
>  security/selinux/include/objsec.h |  6 +--
>  3 files changed, 47 insertions(+), 40 deletions(-)

In the cover letter you talk about testing, but I didn't see any
mention of testing with SELinux enabled.  Given the lock contention
stats in the description above I'm going to assume you did test this
and pass along my ACK, but if you haven't tested the changes below
please do before sending this anywhere important.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
