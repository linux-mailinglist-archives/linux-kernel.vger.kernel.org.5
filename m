Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF87B7EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjJDMQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242335AbjJDMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:16:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E306A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:16:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87602C433C8;
        Wed,  4 Oct 2023 12:16:24 +0000 (UTC)
Date:   Wed, 4 Oct 2023 08:17:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] tracing/timerlat: Hotplug support for the user-space
 interface
Message-ID: <20231004081731.141dfb99@gandalf.local.home>
In-Reply-To: <3fbe67a4-225c-14c1-cb5a-3f667ad80b0e@kernel.org>
References: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
        <20231003210309.4335307d@gandalf.local.home>
        <3fbe67a4-225c-14c1-cb5a-3f667ad80b0e@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/nqQqZZJ_PrnKA=0=TSK/aS5"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/nqQqZZJ_PrnKA=0=TSK/aS5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 4 Oct 2023 12:02:52 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 10/4/23 03:03, Steven Rostedt wrote:
> > On Fri, 29 Sep 2023 17:02:46 +0200
> > Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> >   
> >> The osnoise/per_cpu/CPU$/timerlat_fd is create for each possible
> >> CPU, but it might create confusion if the CPU is not online.
> >>
> >> Create the file only for online CPUs, also follow hotplug by
> >> creating and deleting as CPUs come and go.
> >>
> >> Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")  
> > 
> > Is this a fix that needs to go in now and Cc'd to stable? Or is this
> > something that can wait till the next merge window?  
> 
> We can wait for the next merge window... it is a non-trivial fix.
> 

A requirement is if it's a fix, not really how "trivial" it is.

That said, I'm able to consistently triggered this:

BUG: kernel NULL pointer dereference, address: 00000000000000a0
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0 
 Oops: 0002 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 20 Comm: cpuhp/1 Not tainted 6.6.0-rc4-test-00008-g2df8f295b0e2 #103
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 RIP: 0010:down_write+0x23/0x70
 Code: 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb e8 2e bc ff ff bf 01 00 00 00 e8 24 14 31 ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 75 33 65 48 8b 04 25 00 36 03 00 48 89 43 08 bf 01
 RSP: 0018:ffffb17f800e3d98 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 00000000000000a0 RCX: ffffff8100000000
 RDX: 0000000000000001 RSI: 0000000000000064 RDI: ffffffffb6edd5cc
 RBP: ffffb17f800e3df8 R08: ffff8c6237c61188 R09: 000000008020001b
 R10: ffff8c6237c61160 R11: 0000000000000001 R12: 000000000002da30
 R13: 0000000000000000 R14: ffffffffb6314080 R15: ffff8c6237c61188
 FS:  0000000000000000(0000) GS:ffff8c6237c40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000000000a0 CR3: 0000000102412001 CR4: 0000000000170ee0
 Call Trace:
  <TASK>
  ? __die+0x23/0x70
  ? page_fault_oops+0x17d/0x4c0
  ? exc_page_fault+0x7f/0x180
  ? asm_exc_page_fault+0x26/0x30
  ? __pfx_osnoise_cpu_die+0x10/0x10
  ? down_write+0x1c/0x70
  ? down_write+0x23/0x70
  ? down_write+0x1c/0x70
  simple_recursive_removal+0xef/0x280
  ? __pfx_remove_one+0x10/0x10
  ? __pfx_osnoise_cpu_die+0x10/0x10
  tracefs_remove+0x44/0x70
  timerlat_rm_per_cpu_interface+0x28/0x70
  osnoise_cpu_die+0xf/0x20
  cpuhp_invoke_callback+0xf8/0x460
  ? __pfx_smpboot_thread_fn+0x10/0x10
  cpuhp_thread_fun+0xf3/0x190
  smpboot_thread_fn+0x18c/0x230
  kthread+0xf7/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>
 Modules linked in:
 CR2: 00000000000000a0
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:down_write+0x23/0x70
 Code: 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb e8 2e bc ff ff bf 01 00 00 00 e8 24 14 31 ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 75 33 65 48 8b 04 25 00 36 03 00 48 89 43 08 bf 01
 RSP: 0018:ffffb17f800e3d98 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 00000000000000a0 RCX: ffffff8100000000
 RDX: 0000000000000001 RSI: 0000000000000064 RDI: ffffffffb6edd5cc
 RBP: ffffb17f800e3df8 R08: ffff8c6237c61188 R09: 000000008020001b
 R10: ffff8c6237c61160 R11: 0000000000000001 R12: 000000000002da30
 R13: 0000000000000000 R14: ffffffffb6314080 R15: ffff8c6237c61188
 FS:  0000000000000000(0000) GS:ffff8c6237c40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000000000a0 CR3: 0000000102412001 CR4: 0000000000170ee0
 note: cpuhp/1[20] exited with irqs disabled
 note: cpuhp/1[20] exited with preempt_count 1


With running the attached script as:

 # ./ftrace-test-tracers sleep 1

-- Steve

--MP_/nqQqZZJ_PrnKA=0=TSK/aS5
Content-Type: application/octet-stream; name=ftrace-test-tracers
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=ftrace-test-tracers

IyEvYmluL2Jhc2gKCmZpbmRfZGVidWdmcygpIHsKICAgIGRlYnVnZnM9YGNhdCAvcHJvYy9tb3Vu
dHMgfCB3aGlsZSByZWFkIG1vdW50IGRpciB0eXBlIG9wdHMgYSBiOyBkbwoJaWYgWyAkbW91bnQg
PT0gImRlYnVnZnMiIF07IHRoZW4KCSAgICBlY2hvICRkaXI7CgkgICAgYnJlYWsKCWZpCiAgICBk
b25lYAogICAgaWYgWyAteiAiJGRlYnVnZnMiIF07IHRoZW4KCWlmICEgbW91bnQgLXQgZGVidWdm
cyBub2RldiAvc3lzL2tlcm5lbC9kZWJ1ZzsgdGhlbgoJICAgIGVjaG8gIkZBSUxFRCB0byBtb3Vu
dCBkZWJ1Z2ZzIgoJICAgIGV4aXQgLTEKCWZpCgllY2hvICIvc3lzL2tlcm5lbC9kZWJ1ZyIKICAg
IGVsc2UKCWVjaG8gJGRlYnVnZnMKICAgIGZpCn0KCmRlYnVnZnM9YGZpbmRfZGVidWdmc2AKdHJh
Y2VkaXI9IiRkZWJ1Z2ZzL3RyYWNpbmciCgphcmc9InNsZWVwIDEwIgppZiBbICQjIC1ndCAwIF07
IHRoZW4KCWFyZz0iJEAiCmZpCgpmb3IgdHJhY2VyIGluIGBjYXQgJHRyYWNlZGlyL2F2YWlsYWJs
ZV90cmFjZXJzYDsgZG8KCWlmIFsgJHRyYWNlciA9PSAibm9wIiBdOyB0aGVuCgkJY29udGludWU7
CglmaQoJZWNobyAiVGVzdGluZyB0cmFjZXIgJHRyYWNlciIKCWVjaG8gJHRyYWNlciA+ICR0cmFj
ZWRpci9jdXJyZW50X3RyYWNlcgoJZWNobyAicnVubmluZyAkYXJnIgoJJGFyZwoJZWNobyAwID4g
JHRyYWNlZGlyL3RyYWNpbmdfb24KCWNhdCAkdHJhY2VkaXIvdHJhY2UKCWVjaG8gbm9wID4gJHRy
YWNlZGlyL2N1cnJlbnRfdHJhY2VyCgllY2hvIDEgPiAkdHJhY2VkaXIvdHJhY2luZ19vbgpkb25l
Cg==

--MP_/nqQqZZJ_PrnKA=0=TSK/aS5--
