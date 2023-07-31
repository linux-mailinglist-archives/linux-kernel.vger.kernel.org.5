Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C286B769352
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGaKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGaKnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC710C8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 316B06100F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B26CC433C8;
        Mon, 31 Jul 2023 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690800225;
        bh=Vk9ISal5My128QiuUiytKnF7RzMfVDL0jYip7BWRwNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+VEoAA7yEXhXuEos33whxmN9wBux3J1KZOvn96rZaLnHZA60pUkYb+foZ0m4bSiY
         w/2CdQFZnsEjW9gmO2nwLm8F1mqkZpTp5SNB/E1CuAtZ0QapyPzkc5+/7oVUP3+Y9f
         bZSdXLCamlvvWIFuKtCgMzUbD7fYtP+7Vcrq2s0RSvU33I+thxvrVOys9zpea5c+4l
         /wtFDo6MuKa1/d4aIrjDu7550OOFoZh73QarTpuROWWQmFuzA/IIkc5HT9RgLq830s
         zSb+nMu9fMLusrtAkJT9delZO37nmdUaO5z42byCf4WwpLJUWk58mt2GecSnaPvAew
         Dla5N7tHb30IA==
Date:   Mon, 31 Jul 2023 11:43:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, lstoakes@gmail.com,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Subject: Re: arm64: perf test 26 rpi4 oops
Message-ID: <20230731104340.GA24767@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
 <20230728141852.GA21718@willie-the-truck>
 <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Lorenzo, Kefeng and others]

On Sun, Jul 30, 2023 at 06:09:15PM +0200, Mike Galbraith wrote:
> On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
> >
> > Looking at this quickly with Mark, the most likely explanation is that
> > a bogus kernel address is being passed as the source pointer to
> > copy_to_user().
> 
> 'start' in read_kcore_iter() is bogus a LOT when running perf test 26,
> and that back to at least 5.15.  Seems removal of bogon-proofing gave a
> toothless old bug teeth, but seemingly only to perf test 26.  Rummaging
> around with crash vmlinux /proc/kcore seems to be bogon free anyway.
> 
> Someone should perhaps take a peek at perf.  Bogons aside, it also
> doesn't seem to care deeply about kernel response.  Whether the kernel
> oops or I bat 945 bogons aside, it says 'OK'.  That seems a tad odd.

Aha, so I think I triggered the issue you're seeing under QEMU (log
below). perf (unhelpfully) doesn't have stable test numbers, so it's
test 21 in my case. However, it only explodes if I run it as root, since
/proc/kcore is 0400 on my system.

The easiest way to trigger the problem is simply:

# objdump -d /proc/kcore

Looking at the history, I wonder whether this is because of a combination
of:

e025ab842ec3 ("mm: remove kern_addr_valid() completely")

which removed the kern_addr_valid() check on the basis that kcore used
copy_from_kernel_nofault() anyway, and:

2e1c0170771e ("fs/proc/kcore: avoid bounce buffer for ktext data")

which replaced the copy_from_kernel_nofault() with _copy_to_user().

So with both of those applied, we're missing the address check on arm64.

Will

--->8

[   40.136085] Unable to handle kernel paging request at virtual address ffffffdcaabf0000
[   40.136453] Mem abort info:
[   40.136570]   ESR = 0x0000000096000006
[   40.136737]   EC = 0x25: DABT (current EL), IL = 32 bits
[   40.136946]   SET = 0, FnV = 0
[   40.137085]   EA = 0, S1PTW = 0
[   40.137232]   FSC = 0x06: level 2 translation fault
[   40.137441] Data abort info:
[   40.137573]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[   40.137801]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   40.138005]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   40.138257] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000e51c5000
[   40.138516] [ffffffdcaabf0000] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023ffff003, pmd=0000000000000000
[   40.139218] Internal error: Oops: 0000000096000006 [#1] SMP
[   40.139515] Modules linked in:
[   40.139780] CPU: 1 PID: 225 Comm: objdump Not tainted 6.5.0-rc3-v8 #5
[   40.140038] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   40.140439] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   40.140710] pc : __arch_copy_to_user+0x180/0x240
[   40.140944] lr : _copy_to_iter+0xe8/0x4b0
[   40.141115] sp : ffffffc0805b3950
[   40.141256] x29: ffffffc0805b3950 x28: ffffffdcaabf0000 x27: ffffffdcabfff228
[   40.141568] x26: ffffffdcaabf0000 x25: ffffffc0805b3d68 x24: 0000000000000001
[   40.141841] x23: ffffff80c0e2d880 x22: ffffffc0805b3d40 x21: 0000000000000400
[   40.142119] x20: ffffffdcabe9cd40 x19: 0000000000000400 x18: 0000000000000000
[   40.142385] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffdcaabf0000
[   40.142665] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   40.142933] x11: 0000008000000000 x10: ffffffdcabe9cd40 x9 : 0000000000000230
[   40.143206] x8 : 0000000000101000 x7 : 0000007e08000000 x6 : 00000055c51a9840
[   40.143479] x5 : 00000055c51a9c40 x4 : 0000000000000000 x3 : 0000000000000400
[   40.143761] x2 : 0000000000000380 x1 : ffffffdcaabf0000 x0 : 00000055c51a9840
[   40.144124] Call trace:
[   40.144258]  __arch_copy_to_user+0x180/0x240
[   40.144433]  read_kcore_iter+0x718/0x810
[   40.144564]  proc_reg_read_iter+0x8c/0xe8
[   40.144720]  vfs_read+0x204/0x2a8
[   40.144846]  ksys_read+0x74/0x108
[   40.144975]  __arm64_sys_read+0x24/0x38
[   40.145113]  invoke_syscall+0x4c/0x118
[   40.145267]  el0_svc_common.constprop.0+0x68/0x120
[   40.145437]  do_el0_svc+0x40/0xa8
[   40.145568]  el0_svc+0x30/0x98
[   40.145702]  el0t_64_sync_handler+0xc0/0xc8
[   40.145866]  el0t_64_sync+0x190/0x198
[   40.146103] Code: d503201f d503201f d503201f d503201f (a8c12027) 
[   40.146518] ---[ end trace 0000000000000000 ]---
