Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163F976FB76
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjHDHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHDHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:55:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339E13E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:55:12 -0700 (PDT)
Date:   Fri, 4 Aug 2023 09:55:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691135709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GurkoAqMu0khTxYpNbsDiGnKymUQOgS8F9/kpVIV2Q=;
        b=Lww8boMOzZpNlkw0kIwztNAItD0+8lTnlhsDGtB1FSI15BNPaFkPAkR4VgAk3rOv5UwNJA
        Nv+m8HBVOAzWWOXoIq903WuVIE0qD6IAzmJ37KDf16w2hVU23oWkDjA7yOG/s3oaZkioBO
        SsMQTBu4NhBDkdHEVg3n1NnubfI0W+Mk8MVRGnEnG6JeatkzuCGG7y5O8zk0Ut8g6gWIjc
        lmUZa5LXFZ0ElimoICEx6FvYnErZGB79WBW8fZKTigM8k9pUjZjfELG1MaAJeuyWCFFjrL
        82IEKzM1cN2oQKVP8dMaUlTFc7zDEIgaamisVCv7YkLUDY+IBUP2ePkPdBEszw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691135709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GurkoAqMu0khTxYpNbsDiGnKymUQOgS8F9/kpVIV2Q=;
        b=7DT77UHEXDK/Asb7dM6Um/ucVqwuFO91/+5upKajymGqnxqo7D4a4MBg6xK2iGEgnlMQlg
        nUUSietmlxllH9CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/microcode: Remove microcode_mutex.
Message-ID: <20230804075504.MxYvbNle@linutronix.de>
References: <20230803083253.VGMnC9Gd@linutronix.de>
 <7f31f938-cd4f-bb1b-d44d-57adabf62c51@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7f31f938-cd4f-bb1b-d44d-57adabf62c51@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-03 14:15:13 [-0700], Sohil Mehta wrote:
> Nit: The full stop at the end is not needed.
>=20
> On 8/3/2023 1:32 AM, Sebastian Andrzej Siewior wrote:
> > microcode_mutex is only used by reload_store().  It has a comment saying
> > "to synchronize with each other". This probably means the sysfs
> > interface vs the legacy interface which was removed in commit
> > 181b6f40e9ea8 ("x86/microcode: Rip out the OLD_INTERFACE").
> >=20
>=20
> There is also commit b6f86689d5b7 ("x86/microcode: Rip out the subsys
> interface gunk") which last year removed another usage of microcode_mutex.

Okay.

> > The sysfs interface does not need additional synchronisation vs itself
> > because it is provided as kernfs_ops::mutex which is acquired in
> > kernfs_fop_write_iter().
> >=20
> > Remove superfluous microcode_mutex.
>=20
> I agree, the current usage does look unnecessary.
>=20
> Maybe reword the commit message to say that after these two Rip outs
> there are no of *other* usages of microcode_mutex to synchronize with?

Okay.

> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > This poped up as "defined but not used" on RT builds without
> > CONFIG_MICROCODE_LATE_LOADING enabled.
>=20
> This issue has been raised a couple of times recently but the
> justification has been deemed insufficient since it can't be reproduced
> with a .config file.

The PREEMPT_RT's implementation of struct mutex is different which makes
it easier for the compiler to spot an used mutex. The !RT's
implementation has list_head pointing to the mutex as part of
MUTEX_INIT which marks the variable as used.

> See:
> https://lore.kernel.org/lkml/20230324114720.1756466-1-john.ogness@linutro=
nix.de/
>=20
> and
>=20
> https://lore.kernel.org/lkml/20230522062713.427998-1-christian.gmeiner@gm=
ail.com/
>=20
> However, your current justification of not needing the mutex itself
> seems reasonable to me.

So everyone tried to move it but me=E2=80=A6

=E2=80=A6
> The code changes look fine to me.
>=20
> You can also add below to the patch.

Will do.

Sebastian
