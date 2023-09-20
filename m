Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F367B7A8A01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjITRDr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjITRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:03:42 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B5DE;
        Wed, 20 Sep 2023 10:03:31 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6bc57401cb9so13696a34.0;
        Wed, 20 Sep 2023 10:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229411; x=1695834211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frwJafWpVtftBg3p1eNKNriXzlETV5ppzjf7DC98WZM=;
        b=dlVPAkOEFs8K2mg9tP7WtV19RtoYmLuN+xgLNJW7oVpYfSC2lwDmNDTYELa8gOUjce
         WNxRvvkpAaer5x/FN5wMhNuGnSnHoJnK/Tp4XeakYxFv/DrjlXs7m4IfBn2NzH1Szna9
         LeZ+huoM9rbVtVbQmgCP7f3T4JWpq53+2lGF1+MuNcAMhobuHxifi20QnDWtw2pMTFis
         RYQxZg/k9y0ho78r2ydEOKu9C2sFF7AEuYiQpOHz8N5kPBgiZgM1ny4INRX7TwsQuded
         zmQsvPJrC4FB5M9Tq3j+UPoNVBklRH/VZ8+4u6zmK/UJ4jWUnmc0E3TEyMT9GOt8/DPt
         2gDg==
X-Gm-Message-State: AOJu0YwzC9k1oW2LCRgm/a3AbtwG+A7dXIuFdda650bXUWQ/vCBvI4Z4
        2a4sXzxrUacG1nSENBq74yH40ha28MfhOCLw2+BGW+TT
X-Google-Smtp-Source: AGHT+IFjjdGu8FBizMigrdWOdPJsngiIUgzdyjwxbhCkv6zx7OZxeWbBSCgfvJ4bB+HD6B+pmt8j/ywBR8MNX4OYgwM=
X-Received: by 2002:a05:6808:1512:b0:3ad:f535:7e9a with SMTP id
 u18-20020a056808151200b003adf5357e9amr1995902oiw.5.1695229410891; Wed, 20 Sep
 2023 10:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230920162222.3614-1-mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230920162222.3614-1-mirsad.todorovac@alu.unizg.hr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Sep 2023 19:03:19 +0200
Message-ID: <CAJZ5v0iLjOYBGcANrziRghZTPqHrPhJksB=oV9tRJYctWJ=CvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ACPICA: utdebug: use spinlocks to fix the
 data-races reported by the KCSAN
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Jung-uk Kim <jkim@freebsd.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 6:30 PM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> KCSAN reported hundreds of instances of data-races in ACPICA like this one:
>
> [    6.994149] ==================================================================
> [    6.994443] BUG: KCSAN: data-race in acpi_ut_status_exit / acpi_ut_trace
>
> [    6.994795] write to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 2:
> [    6.994944] acpi_ut_status_exit (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/utdebug.c:467)
> [    6.994957] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:563)
> [    6.994968] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwxface.c:171)
> [    6.994980] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:511)
> [    6.994990] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:644 (discriminator 1))
> [    6.995000] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:695)
> [    6.995010] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:267)
> [    6.995019] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
> [    6.995027] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
> [    6.995038] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
> [    6.995046] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
> [    6.995055] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
> [    6.995066] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)
>
> [    6.995121] read to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 9:
> [    6.995267] acpi_ut_trace (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/utdebug.c:263)
> [    6.995279] acpi_hw_validate_io_request (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwvalid.c:101)
> [    6.995291] acpi_hw_read_port (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwvalid.c:202)
> [    6.995303] acpi_hw_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:251)
> [    6.995313] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:725 /home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:499)
> [    6.995325] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwxface.c:171)
> [    6.995336] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:511)
> [    6.995346] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:644 (discriminator 1))
> [    6.995356] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:695)
> [    6.995366] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:267)
> [    6.995375] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
> [    6.995383] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
> [    6.995394] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
> [    6.995402] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
> [    6.995411] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
> [    6.995422] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)
>
> [    6.995476] value changed: 0x00000004 -> 0x00000002
>
> [    6.995629] Reported by Kernel Concurrency Sanitizer on:
> [    6.995748] CPU: 9 PID: 0 Comm: swapper/9 Not tainted 6.6.0-rc2-kcsan-00003-g16819584c239-dirty #21
> [    6.995758] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [    6.995765] ==================================================================
>
> Please find the complete list at: https://domac.alu.unizg.hr/~mtodorov/linux/patches/acpica_utdebug/acpi_ut_status_exit.log.xz
>
> A number of unprotected increments:
>
>         acpi_gbl_nesting_level++;
>
> and conditional statements:
>
>         if (acpi_gbl_nesting_level) {
>                 acpi_gbl_nesting_level--;
>         }
>
> no longer work in SMP environment.
>
> Proper locking like
>
>         spin_lock(&acpi_utdebug_lock);
>         acpi_gbl_nesting_level++;
>         spin_unlock(&acpi_utdebug_lock);
>
> and
>
>         spin_lock(&acpi_utdebug_lock);
>         if (acpi_gbl_nesting_level) {
>                 acpi_gbl_nesting_level--;
>         }
>         spin_unlock(&acpi_utdebug_lock);
>
> makes these data-races go away.
>
> Additionally, READ_ONCE() or WRITE_ONCE() is required with the global variable
> acpi_gbl_nesting_level to prevent unwanted read or write reordering or other funny
> stuff the optmisers do.
>
> The patch eliminates KCSAN BUG warnings.
>
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Fixes: 6be2d72b18649 ("ACPICA: Update for a few debug output statements")
> Fixes: bf9b448ef8430 ("ACPICA: Debug output: Do not emit function nesting level for kernel build.")
> Fixes: 6e875fa0480c1 ("ACPICA: Debugger: fix slight indentation issue")
> Fixes: ^1da177e4c3f4 ("Initial git repository build.")
> Cc: Jung-uk Kim <jkim@FreeBSD.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Erik Kaneda <erik.kaneda@intel.com>
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: acpica-devel@lists.linuxfoundation.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309201331.S2c1JL2h-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202309201308.5ZBJFbjh-lkp@intel.com/
> Link: https://github.com/acpica/acpica/pull/893
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v2 -> v3:
>  Made the pull request at the ACPICA github.
>  Fixed DEFINE_SPINLOCK() undefined warning by putting it inside #ifdef ACPI_DEBUG_OUTPUT
>  ... #endif
>  Capitalised ACPICA according to the convention.
>
> v1 -> v2:
>  Moved the declaration of 'u32 nesting_level' inside #ifdef ACPI_APPLICATION ... #endif
>  according to the unused variable warning of the kernel test robot.
>
> v1:
>  Preliminary RFC version of the patch.
>
>  drivers/acpi/acpica/utdebug.c | 49 +++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
> index c5f6c85a3a09..594eee294f0f 100644
> --- a/drivers/acpi/acpica/utdebug.c
> +++ b/drivers/acpi/acpica/utdebug.c
> @@ -15,8 +15,9 @@
>
>  #define _COMPONENT          ACPI_UTILITIES
>  ACPI_MODULE_NAME("utdebug")
> -
>  #ifdef ACPI_DEBUG_OUTPUT
> +static DEFINE_SPINLOCK(acpi_utdebug_lock);

No, you can't do that in the ACPICA code.  Likewise for other
Linux-specific pieces of code in the patch below.

I'd very much prefer you to send a proper problem report instead of
sending patches like this.

As it stands, I'm not even sure what problem exactly this is
attempting to address.

Thanks!
