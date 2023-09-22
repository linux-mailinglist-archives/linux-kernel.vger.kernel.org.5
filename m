Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209387AB036
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjIVLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjIVLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:07:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEEAFB;
        Fri, 22 Sep 2023 04:07:27 -0700 (PDT)
Date:   Fri, 22 Sep 2023 13:07:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695380846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WGZmhx2MBLYND2TsU/0IDHOwUPvcCtZw3IousTWzE8=;
        b=n8fL7NUJrtdejN8PB6LxG54iwG2cG6MatYRs4xgMLBq8a7cBLoeJBP/LSzTN5o30Atobev
        IJDma8K+N0zQZTNMqE5ZeDFDJ51q6bg0U4mErp/eBmtqRbxEJmPzTbXbWqTui++9lzatfY
        27AgK513Ig2WFyCXDsGSDnxIeCUExHZGBZ261uU5TFWgexwup5xOd1w6ew4QZOVJxmlGU9
        JiYBmn6Kxe+/d14VP8xxNiq/DD1ldv9d20Pxtog5OjzVPOPXlEZV9Is4+5FYOh4FufVUaH
        aDysbxhhAPsLjvjOg9+yhoXiKHNu4+C+ZYPjS0ChsP1ufT5yy87VWcJ3Mmto1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695380846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WGZmhx2MBLYND2TsU/0IDHOwUPvcCtZw3IousTWzE8=;
        b=UP4Q3E2ZxJtsWBAqk5bv+pLyhrz07U43HuxT2yh4YksNyniPOBEQ3u5UtkGS4r0mEitM4k
        3RYoRMtRh+/n54AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "John B. Wyatt IV" <jwyatt@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-rts-sst <kernel-rts-sst@redhat.com>, jlelli@redhat.com
Subject: Re: Crash with 6.6.0-rc1-rt1 and several i915 locking call traces
 with v6.5.2-rt8 and gnome-shell on Alder Lake laptop
Message-ID: <20230922110720.AZ03l3A9@linutronix.de>
References: <ZQttJ8W9UFP46E1b@thinkpad2021>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZQttJ8W9UFP46E1b@thinkpad2021>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-20 18:07:35 [-0400], John B. Wyatt IV wrote:
> Hello everyone,
Hi,

> While backporting i915 fixes to the RHEL9 kernel for a similar looking
> issue; I noticed the commits that worked for RHEL8 did not work for RHEL9.
>=20
> Testing the (almost) latest release: 6.5.2-rt8; showed a lot of call trac=
es
> on RHEL9. [1] being the most common one and it repeats itself on suspend.

A warn-once might help to reduce them so they can be worked on one by
one.

> [2] was the second one to show and seems to be the second most common
> call trace. This was tested on a Framework Alder Lake laptop with i915
> graphics. There was a total of 36 call traces before suspend and
> additional 12 after suspend (once again, [1]).
>=20
> When I tested on 6.6.0-rc1-rt1 the kernel crashed on boot. I did not
> have a way to pull the information and was transcribed manually. [3]
>=20
> [1]

Both:
> BUG: sleeping function called from invalid context at drivers/gpu/drm/i91=
5/gt/uc/intel_guc.h:330
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6590, name: gnome-=
shell
> preempt_count: 0, expected: 0
> RCU nest depth: 6, expected: 0
> 12 locks held by gnome-shell/6590:
=E2=80=A6
> BUG: sleeping function called from invalid context at drivers/gpu/drm/i91=
5/gt/uc/intel_guc.h:330
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6590, name: gnome-=
shell
> preempt_count: 0, expected: 0
> RCU nest depth: 5, expected: 0

are might-sleep splats. I don't see these on my notebook/desktop on
6.6-rc. I don't remember doing suspend on 6.5 notebook but I did that on
my desktop for testing.
It looks like due to "locks" the RCU is > 0 and then the splat triggers
because it assumes that it will schedule-out which is okay on RT. But
then it is not okay for the ww-mutex to do so I am a little confused if
this is RT only problem or also not RT. But maybe it is just a try-lock
and the warning is just wrongly triggered=E2=80=A6

> [3]
>=20
> general protection fault, probably for non-canonical address 0xdffffc0004=
: 0000(#1) PREEMPT_RT SMP KASAN NOPRI
> KASAM: null-ptr-deref in range [0x000...20-0x000...27]
> RIP: 0010:ucsi_debugfs_unregister (drivers/usb/typec/ucsi/debugfs.c:87)=
=20
> [snipped]
> PKRU: 5555554
> Call Trace:
> <TASK>
> usci_destroy+0xe/0x20=20
> ucsi_acpi_probe (drivers/usb/typec/ucsi/ucsi_acpi.c:207)=20

This is odd. That means that ucsi_register() failed and debugfs was
setup and is NULL. And check in line 87 checks ucsi which is non-NULL
and the ucsi->debugfs is NULL. So it should return but somehow it does
this. Does this also trigger without KASAN?

In the meantime let me try to enable KASAN=E2=80=A6

Sebastian
