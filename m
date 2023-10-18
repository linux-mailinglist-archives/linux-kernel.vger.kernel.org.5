Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDC7CDB25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjJRL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:59:37 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DF95;
        Wed, 18 Oct 2023 04:59:35 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b652e785dbso1885994241.0;
        Wed, 18 Oct 2023 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697630375; x=1698235175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSLEtac6YWNcjyN2XaZ66UNWEZESE1pu5pgWAJH4WN4=;
        b=ftkQq86pcBVLjXusbzii00nck7Rw7PHhEwd72gh8GgvTBdz38Otw91IgAIuqUWrRuH
         pajPNjD4U+SJcdVmQASoU9UrPouqt4KpLPrGkq+6AQ1TmyZpDHL2n+R9EWoINSgTPXvO
         kzeBo5GeC+mbnI2nmMJ5lLMyoDbmsYFOkbXFk/0PbEY6vrHiS172tTE45FbI3CQUzdEp
         5yAn6LPjrLtUcz8Ry5CKXlecw7DbdZRPcSCz8xZ94KIXEOQmic+JuHg9ulGh4ArBXn8T
         ykq/rnryjihazqUtzNAMqWFQeJw8WTLnhAGfv9/YGVjK4MvQP8P3lCG9IdEEKmbqMxqg
         QveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697630375; x=1698235175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSLEtac6YWNcjyN2XaZ66UNWEZESE1pu5pgWAJH4WN4=;
        b=Ni1EB2nWBLs/MrSSA+CL1DRh7o93WevnJAdn+Bb6rjoyBlRAHwSxVoCHBn2k5qPFul
         OiT2pMjCXt5/PUl5diNyRxY2RM/dLYhIoBtyvDpkrbScX254lLwXy3Sce4KSrvqSKpG2
         d6iYPVFCTcKFiJfuuB2kOfg5PRhZGhld5LUjdFMzPHMnrVzyr233jjdarSChEanToQlI
         YJAZGn3TAhKvDc1TUJxmgds7cQEXAeUkJ+vVapNIAujbuvkXMtsNHPv+DnN5RtUH71eo
         DdAYGx50whjHTZFi39xhkOuZlOgBP8qh9fUjFgQOiCzbJ4PhcABz7tybBC2NsWJlIVYo
         NAhA==
X-Gm-Message-State: AOJu0YxxTStE7CpMLZ8l3kpAQi3JWJ5WaoD5dYm9Chjaiaubn1d7iuDv
        OXarOxFuScajIOFbL3yoHyHX1iErTUiEuSXTwStggMyQ+uQ=
X-Google-Smtp-Source: AGHT+IEJtIxLf67NLwnxcrQ0j7f8znVdg0J2tifl4gHxSS6DJKuOsdAtZlaIO2hBJDlAta/KFOt0/MOduUZ1Fv1ktVE=
X-Received: by 2002:a67:c113:0:b0:457:c49c:bc63 with SMTP id
 d19-20020a67c113000000b00457c49cbc63mr5655335vsj.6.1697630374867; Wed, 18 Oct
 2023 04:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231018074553.41333-1-hu1.chen@intel.com>
In-Reply-To: <20231018074553.41333-1-hu1.chen@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Oct 2023 14:59:23 +0300
Message-ID: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
Subject: Re: ovl: ovl_fs::creator_cred::usage scalability issues
To:     Chen Hu <hu1.chen@intel.com>
Cc:     miklos@szeredi.hu, malini.bhandaru@intel.com, tim.c.chen@intel.com,
        mikko.ylinen@intel.com, lizhen.you@intel.com,
        vinicius.gomes@intel.com, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FUZZY_CREDIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:47=E2=80=AFAM Chen Hu <hu1.chen@intel.com> wrote=
:
>
> *Problem*
> ovl_permission() checks the underlying inode with the credential of mount=
er.
> The cred, struct ovl_fs::creator_cred, is somewhat global per overlayfs
> superblock. Performance degrades when concurrency increases on the cred, =
to be
> specific, on ovl_fs::creator_cred::usage.
>
> This happens when there are massive file access inside container, especia=
lly
> on SoC with many cores. With Linux 6.6.0-rc2, we run a web workload conta=
iner
> on Intel 4th Xeon Sapphire Rapids which has 56 cores. Perf reports that 5=
.7%
> (2.50% + 1.87% + 1.33%) CPU stall in overlayfs:
> Self    Command       Shared Object            Symbol
> 2.50%   foo           [kernel.vmlinux]         [k] override_creds
> 1.87%   foo           [kernel.vmlinux]         [k] revert_creds
> 1.33%   foo           [kernel.vmlinux]         [k] generic_permission
>
> On Soc with more than 100 cores, we can even observe ~30% CPU stalled!
>
> This scalability issue is caused by two factors:
> 1) Contention on creator_cred::usage
>    creator_cred::usage is atomic_t and is inc/dec atomically during every=
 file
>    access. So HW acquires the corresponding cache line exclusively. This
>    operataiton is expensive and gets worse when contention is heavy.
>    Call chain:
>       ovl_permission()
>       -> ovl_override_creds()
>       -> override_creds()
>       -> get_new_cred()
>       -> atomic_inc(&cred->usage);
>
>       ovl_permission()
>       -> revert_creds()
>       -> put_cred()
>       -> atomic_dec_and_test(&(cred)->usage))
>
> 2) False sharing
>    `perf c2c` shows false sharing issue between cred::usage and cred::fsu=
id.
>    This is why generic_permission() stalls 1.33% CPU in above perf report=
.
>    ovl_permission() updates cred::usage and it also reads cred::fsuid.
>    Unfortunately, they locate in the same cache line and thus false shari=
ng
>    occurs. cred::fsuid is read at:
>       ovl_permission()
>       -> inode_permission()
>       -> generic_permission()
>       -> acl_permission_check()
>       -> current_fsuid()
>
> *Mitigations we tried*
> We tried several mitigations but are not sure if it can be a fix or just
> workaround / hack. So we report this and want to have some discussions.
>
> Our mitigations aims to eliminate the contention on creator_cred->usage.
> Without contention, the false sharing will be tiny and no need to handle.=
 The
> mitigations we tested are:
>    1) Check underlying inode once in its lifetime.

But the check is against a specific permission mask.
Your patch caches the result of the permission check of a specific mask
and uses it as the result to return for any mask.

>    OR
>    2) In ovl_permission(), copy global creator_cred to a local variable t=
o
>       avoid concurrency.
>

This sounds a bit risky, but maybe it can work.
If you want to create a local copy of creds, I think that the fact that thi=
s
is a local copy should be expressed in flags like cred->non_rcu.

put_cred() should be aware of this flag and avoid calling __put_cred().
The local copy should be initialized with usage 1 by copying creator_cred
and we need to have an assertion if cred->usage drops to 0.

Also, ofs->creator_cred itself should be marked as a "read-only copy"
of credentials and we should add assertions to make sure that no code
calls get_cred() on a read-only copy.

The ovl_override_cred() function should take a local cred variable to use
the copy method for any access to ofs->creator_cred, not only in
ovl_permissions().

ovl_override_creds() should be coupled with ovl_revert_creds() which
also takes the local var as argument and also asserts that the local copy
usage is 1.

We can maybe take the opportunity to DEFINE_GUARD() for an
ovl_cred struct and use it in many of the overlayfs methods.

And maybe I am missing something and this cannot be done
or there is a much easier way to solve the problem.

Thanks,
Amir.
