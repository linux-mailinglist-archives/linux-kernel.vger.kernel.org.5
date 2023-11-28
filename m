Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3548C7FC17F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346117AbjK1Ppi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbjK1Ppf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:45:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732910E4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701186340; x=1732722340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BTtNI/kP7Oj/cphm9g8LdfrDMhDpH3L8ToC6A/UuepU=;
  b=d9GcvftM4kJW+xOjBBeac5hINpXkRUR37nSIpozE5of+pB/s1fbze3WE
   d49YykjiIGzlKP3glJpUkJ2WngnzDfjmpY9lfNm5uIso2CiDqFJNc8htz
   IERYpnh0flfm7H3aHAbGIsUxk8/iouYTyEvC3401ciwCy+Lr8oCYgteyU
   F+FsrSYvKDbjd0gx8Gwi5CLb+o5d49R1/Z+vBCY7KlBjVZvGpMUINzPJ+
   DanZ+e0GQ8jZGLKKbEiGJ8BSAaifPVZiktezRZu/YmVEML8dvAuaMMY/s
   mgZOvkVeJMVNNWfJBD3D7HxeHUKC5OQJ7ss3XxfMMNLPWYkLf4Um4sDMJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457274710"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457274710"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 07:45:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="744946511"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="744946511"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 07:45:39 -0800
Date:   Tue, 28 Nov 2023 07:45:39 -0800
From:   Isaku Yamahata <isaku.yamahata@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, ltao@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        isaku.yamahata@linux.intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <20231128154539.GC1102144@ls.amr.corp.intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:41:08PM +0800,
Baoquan He <bhe@redhat.com> wrote:

> On 11/17/23 at 06:46pm, Kirill A. Shutemov wrote:
> > On Fri, Nov 17, 2023 at 11:03:00PM +0800, Baoquan He wrote:
> > > On 11/17/23 at 03:47pm, Kirill A. Shutemov wrote:
> > > > On Thu, Nov 16, 2023 at 10:45:23PM +0800, Baoquan He wrote:
> > > > > On 11/16/23 at 10:17pm, Baoquan He wrote:
> > > > > > On 11/16/23 at 03:56pm, Kirill A. Shutemov wrote:
> > > > > > > On Thu, Nov 16, 2023 at 08:10:47PM +0800, Baoquan He wrote:
> > > > > > > > On 11/15/23 at 03:00pm, Kirill A. Shutemov wrote:
> > > > > > > > > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > > > > > > > > TDX guest.
> > > > > > > > 
> > > > > > > > I finally got a machine of intel-eaglestream-spr as host and built a
> > > > > > > > tdx guest to give it a shot, the kexec reboot is working very well,
> > > > > > > > while kdump kernel always failed to boot up. I only built kernel and
> > > > > > > > installed it on tdx guest.
> > > > > > > > ------------------------------------------
> > > > > > > > [    1.422500] Run /init as init process
> > > > > > > > [    1.423073] Failed to execute /init (error -2)
> > > > > > > > [    1.423759] Run /sbin/init as init process
> > > > > > > > [    1.424370] Run /etc/init as init process
> > > > > > > > [    1.424969] Run /bin/init as init process
> > > > > > > > [    1.425588] Run /bin/sh as init process
> > > > > > > > [    1.426150] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
> > > > > > > > [    1.428122] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00014-gbdba31ba3cec #3
> > > > > > > > [    1.429232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> > > > > > > > [    1.430328] Call Trace:
> > > > > > > > [    1.430717]  <TASK>
> > > > > > > > [    1.431041]  dump_stack_lvl+0x33/0x50
> > > > > > > > [    1.431581]  panic+0x324/0x340
> > > > > > > > [    1.432037]  ? __pfx_kernel_init+0x10/0x10
> > > > > > > > [    1.432629]  kernel_init+0x174/0x1c0
> > > > > > > > [    1.433149]  ret_from_fork+0x2d/0x50
> > > > > > > > [    1.433690]  ? __pfx_kernel_init+0x10/0x10
> > > > > > > > [    1.434277]  ret_from_fork_asm+0x1b/0x30
> > > > > > > > [    1.434850]  </TASK>
> > > > > > > > [    1.435345] Kernel Offset: disabled
> > > > > > > > [    1.439216] Rebooting in 10 seconds..
> > > > > > > > qemu-kvm: cpus are not resettable, terminating
> > > > > > > 
> > > > > > > Could you shared your kernel config and details about your setup (qemu
> > > > > > > command, kernel command line, ...)?
> > > > > > 
> > > > > > We followed tdx-tools README to setup the environment and built host and
> > > > > > guest kernel, qemu command is as below. I copied the
> > > > > > tdx-tools/build/rhel-9/intel-mvp-tdx-kernel/tdx-base.config to the
> > > > > > latest upstream linxu kernel then execute 'make olddefconfig'. Because
> > > > > > your patchset can't be applied to the stable kernel with the 731
> > > > > > patches.
> > > > > > 
> > > > > > cd /home/root/tdx-tools
> > > > > > ./start-qemu.sh -i /home/root/guest_tdx.qcow2 -b grub
> > > > > 
> > > > > This is the qemu command when execute above line of command, just for
> > > > > your reference if you happen to not take this way.
> > > > 
> > > > Still failed to reproduce :/
> > > > 
> > > > Blind shot: could you check if the patch below makes any difference.
> > > 
> > > Still failed. And I found the normal reboot does't work either. I will
> > > do more testing tomorrow, e.g use the tdx-tools's own rhel9 kernel
> > > config and rebuild, and update host kernel too.
> 
> I did more tests, resuls are summarized as below: 
> 
> 1) kexec reboot works, but always fallback to 1 cpu even though multiple
> cpus are specified;
> 2) kdump kernel need more crashkernel memory to boot up,
>    crashkernel=512M works well in our case. But it failed in vmcore
>    saving process, either makedumpfile or cp can't access the 1st
>    kernel's old memory;
> 3) Normal reboot always failed;
...
> 3) not sure if this is particular case on the system we tested on.

qemu handles guest reset request as shutdown.  This is expected. 
It is common for confidential guest support.

In theory it's possible for qemu to re-create TDX guest and start a new guest.
Because the qemu implementation is too convoluted, it's not worthwhile to
implement it.  Instead we can modify libvirt to restart qemu for reset request.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
