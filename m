Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531987ACBB1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjIXTsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIXTsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:48:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E5DD3;
        Sun, 24 Sep 2023 12:48:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20080C433C7;
        Sun, 24 Sep 2023 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695584898;
        bh=aWZU5UswlWXquKo6TvzlVJ0C2F5RZIJgKxqaiKhJe0w=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=P7MuQXYExhov1tOcpJNBJi+Dptm2BawzZz407EtRwDNs0+z52FABR1ecbYXtEX6jb
         b4ZLH4pkOC77kz3n4wSTvRGzGqaPj/4lkcqXXyIYfp6ljxnRDcb1qKBB8X/AXCgVI6
         82vNGIkMjWEWvi/Gq9H7WnzU0f6sbqfObsxvH2HkACKrZhy99munQ/ygsamKl8SH/6
         J2EKMTuIjq4FuGxeZXA7F9mwbCx1YmBIcCjMRjEmfREWMAApupMouHnJYZKmXXK1XZ
         SH4mGe4Wp69zQ6mbayHCa3CSbaA/XJwrtnOLRbnCy0zxICkpoaykhoh0+cHInynUDO
         g/vNs/JQX26Qw==
Date:   Sun, 24 Sep 2023 12:48:15 -0700
From:   Kees Cook <kees@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kees Cook <keescook@chromium.org>
CC:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v15 01/11] LSM: Identify modules by more than name
User-Agent: K-9 Mail for Android
In-Reply-To: <dfdb82a8-85b2-4704-35b9-3ad901a179f1@I-love.SAKURA.ne.jp>
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-2-casey@schaufler-ca.com> <1f5e725d-58b6-eca2-97dc-d7c1209ff167@I-love.SAKURA.ne.jp> <568c0730-b458-04b4-dbfa-77da1758aa05@schaufler-ca.com> <94743c22-bc76-e741-e577-3e0845423f69@I-love.SAKURA.ne.jp> <6df9f8b8-5653-09a5-ae0a-6526016abaff@schaufler-ca.com> <ec37cd2f-24ee-3273-c253-58d480569117@I-love.SAKURA.ne.jp> <202309200803.1911A584@keescook> <af696700-ae4b-346e-4c52-3a7a21b0f46c@I-love.SAKURA.ne.jp> <202309231838.CB16E6B5@keescook> <dfdb82a8-85b2-4704-35b9-3ad901a179f1@I-love.SAKURA.ne.jp>
Message-ID: <407A11DD-932D-441E-B4EC-673F4423CEDD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 24, 2023 4:06:07 AM PDT, Tetsuo Handa <penguin-kernel@I-love=
=2ESAKURA=2Ene=2Ejp> wrote:
>Patch description says
>
>  The LSM ID values are sequential, with the oldest module
>  LSM_ID_CAPABILITY being the lowest value and the existing modules
>  numbered in the order they were included in the main line kernel=2E
>  This is an arbitrary convention for assigning the values, but
>  none better presents itself=2E The value 0 is defined as being invalid=
=2E

"in the order they were included in the main line kernel" Out of trees are=
n't in main line=2E

And "This is an arbitrary convention" specifically says it's arbitrary=2E

There is literally nothing here stopping out of tree modules=2E I have pro=
ven this, and so have you with these quotes=2E What is left to object to?

>You withdraw your "Reviewed-by" response unless "The LSM ID values are se=
quential"
>and "must be approved by the LSM maintainers" are removed and "the LSM ma=
intainers/community
>shall never complain about what names and/or values are assigned" is adde=
d, don't you?

*For main line kernels*

Please, understand both the *intent* and *reality*: this does not block ou=
t of tree LSMs, full stop=2E

>Keeping how the HUGE space is used under control of the LSM community wil=
l be
>better for both in-tree and out-of-tree LSM modules=2E I really can't und=
erstand
>why you don't want to utilize this opportunity=2E

I cannot understand what else you need to hear=2E

-Kees


--=20
Kees Cook
