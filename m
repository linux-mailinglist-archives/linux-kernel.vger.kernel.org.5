Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB47A9DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjIUTo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIUTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:44:27 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3798755AE4;
        Thu, 21 Sep 2023 10:50:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 81A2760173;
        Thu, 21 Sep 2023 16:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1695307510; bh=7MNMf/5wLuDOzd81hlGE2fuMxkyLMCjXuf9gtw7vPdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KlrPDSGHxwZ6q4CDdxwD92SLGGoeSuWx57+ZAruG+fw/xcjyslgwastDsVDfFNJbK
         emaHy7ahp7ah9Nl6K0SAdPP581IVuD1blfYiBAud1jkSl8IIuxi6e8FLGUDUQIvFRO
         /hPlKP5mKVXCDVkyX3CIOr6k/noKf1WXnKVBxAm2Nr52rWmVP4q+I5yJF6jN9fU+Iy
         Od98pvAmowvfGjl9fCjxnYBjYT++6Jxv+wun//QjfMZaUTfCe2ey4r+QAK2ntZrDQ5
         Xkp5NZKO6yqD5+NVWIcODDD+KYRH01C9iZAIvns+8YsyU2j3w6AOQj2DoosFZ8HKbE
         jb6EKjM363uwA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RFnCqO-4w49M; Thu, 21 Sep 2023 16:45:07 +0200 (CEST)
Received: from [IPV6:2001:b68:2:2600:a00d:4e77:39e3:b52f] (unknown [IPv6:2001:b68:2:2600:a00d:4e77:39e3:b52f])
        by domac.alu.hr (Postfix) with ESMTPSA id 0DDCD60157;
        Thu, 21 Sep 2023 16:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695307507; bh=7MNMf/5wLuDOzd81hlGE2fuMxkyLMCjXuf9gtw7vPdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2Mlwc/Gcd/WzVSDQBWWK9/Xt+IF+57O3N8UqPnTYvoAI6wc9JWpe31LD9i7cjq7tq
         FgmFVT97G/yPTqMipOWKjlcOJyECxM7/tg+STMWZpeIWsjO3tGhUTMp53L0uDIdBCj
         p554o0TzWg8tMG/SagK3LbUIpf1U4TRoPIAim3QAthk2HSkLIZuT2L49OcHv9InUWi
         iDgR3ibBleP4xKmZum3HxxB5FaYZG4HDUyXNqHy5gFlYNwJg5Ls/yIzQvddyncCPSV
         xq3R0MiHGdWKAs63rR14Y6a0HLn9B54MLoLCuKGdJmkkQxnt+zG95mIbxNhoI6s+p5
         I55N/t2HMPx3w==
Message-ID: <ac5143f3-9e7e-4216-920c-88d18f3eb495@alu.unizg.hr>
Date:   Thu, 21 Sep 2023 16:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] acpica: use spinlocks to fix the data-races
 reported by the KCSAN
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Jung-uk Kim <jkim@freebsd.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20230920074158.3605-1-mirsad.todorovac@alu.unizg.hr>
 <CAJZ5v0j5d-jc8LRODvcjcu63URZV+EVgekQXDzN9xsWnabTaLQ@mail.gmail.com>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <CAJZ5v0j5d-jc8LRODvcjcu63URZV+EVgekQXDzN9xsWnabTaLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2023 11:53 AM, Rafael J. Wysocki wrote:
> On Wed, Sep 20, 2023 at 9:44 AM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> KCSAN reported hundreds of instances of data-races in ACPICA like this one:
> 
> If you want to make changes in the ACPICA code, the way to do that is
> to submit a pull request for the upstream ACPICA project on GitHub.
> 
> Then you can resend the Linux patch with a Link: tag pointing to the
> upstream pull request.

I got the reply that I have to put the code into the ACPICA uniplatform 
language and I just did not manage that at first attempt.

Best regards,
Mirsad Todorovac

>> [    6.994149] ==================================================================
>> [    6.994443] BUG: KCSAN: data-race in acpi_ut_status_exit / acpi_ut_trace
>>
>> [    6.994795] write to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 2:
>> [    6.994944] acpi_ut_status_exit (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/utdebug.c:467)
>> [    6.994957] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:563)
>> [    6.994968] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwxface.c:171)
>> [    6.994980] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:511)
>> [    6.994990] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:644 (discriminator 1))
>> [    6.995000] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:695)
>> [    6.995010] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:267)
>> [    6.995019] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
>> [    6.995027] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
>> [    6.995038] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
>> [    6.995046] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
>> [    6.995055] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
>> [    6.995066] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)
>>
>> [    6.995121] read to 0xffffffffbae5a884 of 4 bytes by task 0 on cpu 9:
>> [    6.995267] acpi_ut_trace (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/utdebug.c:263)
>> [    6.995279] acpi_hw_validate_io_request (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwvalid.c:101)
>> [    6.995291] acpi_hw_read_port (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwvalid.c:202)
>> [    6.995303] acpi_hw_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:251)
>> [    6.995313] acpi_hw_register_read (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:725 /home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwregs.c:499)
>> [    6.995325] acpi_read_bit_register (/home/marvin/linux/kernel/torvalds2/drivers/acpi/acpica/hwxface.c:171)
>> [    6.995336] acpi_idle_bm_check (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:511)
>> [    6.995346] acpi_idle_enter_bm (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:644 (discriminator 1))
>> [    6.995356] acpi_idle_enter (/home/marvin/linux/kernel/torvalds2/drivers/acpi/processor_idle.c:695)
>> [    6.995366] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:267)
>> [    6.995375] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
>> [    6.995383] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
>> [    6.995394] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
>> [    6.995402] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
>> [    6.995411] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
>> [    6.995422] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)
>>
>> [    6.995476] value changed: 0x00000004 -> 0x00000002
>>
>> [    6.995629] Reported by Kernel Concurrency Sanitizer on:
>> [    6.995748] CPU: 9 PID: 0 Comm: swapper/9 Not tainted 6.6.0-rc2-kcsan-00003-g16819584c239-dirty #21
>> [    6.995758] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [    6.995765] ==================================================================
>>
>> Please find the complete list at: https://domac.alu.unizg.hr/~mtodorov/linux/patches/acpica_utdebug/acpi_ut_status_exit.log.xz
>>
>> A number of unprotected increments:
>>
>>          acpi_gbl_nesting_level++;
>>
>> and conditional statements:
>>
>>          if (acpi_gbl_nesting_level) {
>>                  acpi_gbl_nesting_level--;
>>          }
>>
>> no longer work in SMP environment.
>>
>> Proper locking like
>>
>>          spin_lock(&acpi_utdebug_lock);
>>          acpi_gbl_nesting_level++;
>>          spin_unlock(&acpi_utdebug_lock);
>>
>> and
>>
>>          spin_lock(&acpi_utdebug_lock);
>>          if (acpi_gbl_nesting_level) {
>>                  acpi_gbl_nesting_level--;
>>          }
>>          spin_unlock(&acpi_utdebug_lock);
>>
>> makes these data-races go away.
>>
>> Additionally, READ_ONCE() or WRITE_ONCE() is required with the global variable
>> acpi_gbl_nesting_level to prevent unwanted read or write reordering or other funny
>> stuff the optmisers do.
>>
>> The patch eliminates KCSAN BUG warnings.
>>
>> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Fixes: 6be2d72b18649 ("ACPICA: Update for a few debug output statements")
>> Fixes: bf9b448ef8430 ("ACPICA: Debug output: Do not emit function nesting level for kernel build.")
>> Fixes: 6e875fa0480c1 ("ACPICA: Debugger: fix slight indentation issue")
>> Fixes: ^1da177e4c3f4 ("Initial git repository build.")
>> Cc: Jung-uk Kim <jkim@FreeBSD.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Erik Kaneda <erik.kaneda@intel.com>
>> Cc: Bob Moore <robert.moore@intel.com>
>> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: acpica-devel@lists.linuxfoundation.org
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202309201331.S2c1JL2h-lkp@intel.com/
>> ---
>> v1 -> v2:
>>   Moved the declaration of 'u32 nesting_level' inside #ifdef ACPI_APPLICATION ... #endif
>>   according to the unused variable warning of the kernel test robot.
>>
>> v1:
>>   Preliminary RFC version of the patch.
>>
>>   drivers/acpi/acpica/utdebug.c | 40 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 35 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
>> index c5f6c85a3a09..1faf7dc144f0 100644
>> --- a/drivers/acpi/acpica/utdebug.c
>> +++ b/drivers/acpi/acpica/utdebug.c
>> @@ -16,6 +16,8 @@
>>   #define _COMPONENT          ACPI_UTILITIES
>>   ACPI_MODULE_NAME("utdebug")
>>
>> +static DEFINE_SPINLOCK(acpi_utdebug_lock);
>> +
>>   #ifdef ACPI_DEBUG_OUTPUT
>>   static acpi_thread_id acpi_gbl_previous_thread_id = (acpi_thread_id) 0xFFFFFFFF;
>>   static const char *acpi_gbl_function_entry_prefix = "----Entry";
>> @@ -60,13 +62,16 @@ void acpi_ut_init_stack_ptr_trace(void)
>>   void acpi_ut_track_stack_ptr(void)
>>   {
>>          acpi_size current_sp;
>> +       u32 nesting_level;
>>
>>          if (&current_sp < acpi_gbl_lowest_stack_pointer) {
>>                  acpi_gbl_lowest_stack_pointer = &current_sp;
>>          }
>>
>> -       if (acpi_gbl_nesting_level > acpi_gbl_deepest_nesting) {
>> -               acpi_gbl_deepest_nesting = acpi_gbl_nesting_level;
>> +       nesting_level = READ_ONCE(acpi_gbl_nesting_level);
>> +
>> +       if (nesting_level > acpi_gbl_deepest_nesting) {
>> +               acpi_gbl_deepest_nesting = nesting_level;
>>          }
>>   }
>>
>> @@ -136,6 +141,7 @@ acpi_debug_print(u32 requested_debug_level,
>>          va_list args;
>>   #ifdef ACPI_APPLICATION
>>          int fill_count;
>> +       u32 nesting_level;
>>   #endif
>>
>>          /* Check if debug output enabled */
>> @@ -156,7 +162,7 @@ acpi_debug_print(u32 requested_debug_level,
>>                  }
>>
>>                  acpi_gbl_previous_thread_id = thread_id;
>> -               acpi_gbl_nesting_level = 0;
>> +               WRITE_ONCE(acpi_gbl_nesting_level, 0);
>>          }
>>
>>          /*
>> @@ -176,14 +182,16 @@ acpi_debug_print(u32 requested_debug_level,
>>                  acpi_os_printf("[%u] ", (u32)thread_id);
>>          }
>>
>> -       fill_count = 48 - acpi_gbl_nesting_level -
>> +       fill_count = 48 - READ_ONCE(acpi_gbl_nesting_level) -
>>              strlen(acpi_ut_trim_function_name(function_name));
>>          if (fill_count < 0) {
>>                  fill_count = 0;
>>          }
>>
>> +       nesting_level = READ_ONCE(acpi_gbl_nesting_level);
>> +
>>          acpi_os_printf("[%02d] %*s",
>> -                      acpi_gbl_nesting_level, acpi_gbl_nesting_level + 1, " ");
>> +                      nesting_level, nesting_level + 1, " ");
>>          acpi_os_printf("%s%*s: ",
>>                         acpi_ut_trim_function_name(function_name), fill_count,
>>                         " ");
>> @@ -260,7 +268,10 @@ acpi_ut_trace(u32 line_number,
>>                const char *module_name, u32 component_id)
>>   {
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          acpi_gbl_nesting_level++;
>> +       spin_unlock(&acpi_utdebug_lock);
>> +
>>          acpi_ut_track_stack_ptr();
>>
>>          /* Check if enabled up-front for performance */
>> @@ -298,7 +309,10 @@ acpi_ut_trace_ptr(u32 line_number,
>>                    u32 component_id, const void *pointer)
>>   {
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          acpi_gbl_nesting_level++;
>> +       spin_unlock(&acpi_utdebug_lock);
>> +
>>          acpi_ut_track_stack_ptr();
>>
>>          /* Check if enabled up-front for performance */
>> @@ -334,7 +348,10 @@ acpi_ut_trace_str(u32 line_number,
>>                    const char *module_name, u32 component_id, const char *string)
>>   {
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          acpi_gbl_nesting_level++;
>> +       spin_unlock(&acpi_utdebug_lock);
>> +
>>          acpi_ut_track_stack_ptr();
>>
>>          /* Check if enabled up-front for performance */
>> @@ -370,7 +387,10 @@ acpi_ut_trace_u32(u32 line_number,
>>                    const char *module_name, u32 component_id, u32 integer)
>>   {
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          acpi_gbl_nesting_level++;
>> +       spin_unlock(&acpi_utdebug_lock);
>> +
>>          acpi_ut_track_stack_ptr();
>>
>>          /* Check if enabled up-front for performance */
>> @@ -414,9 +434,11 @@ acpi_ut_exit(u32 line_number,
>>                                   acpi_gbl_function_exit_prefix);
>>          }
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          if (acpi_gbl_nesting_level) {
>>                  acpi_gbl_nesting_level--;
>>          }
>> +       spin_unlock(&acpi_utdebug_lock);
>>   }
>>
>>   ACPI_EXPORT_SYMBOL(acpi_ut_exit)
>> @@ -463,9 +485,11 @@ acpi_ut_status_exit(u32 line_number,
>>                  }
>>          }
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          if (acpi_gbl_nesting_level) {
>>                  acpi_gbl_nesting_level--;
>>          }
>> +       spin_unlock(&acpi_utdebug_lock);
>>   }
>>
>>   ACPI_EXPORT_SYMBOL(acpi_ut_status_exit)
>> @@ -502,9 +526,11 @@ acpi_ut_value_exit(u32 line_number,
>>                                   ACPI_FORMAT_UINT64(value));
>>          }
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          if (acpi_gbl_nesting_level) {
>>                  acpi_gbl_nesting_level--;
>>          }
>> +       spin_unlock(&acpi_utdebug_lock);
>>   }
>>
>>   ACPI_EXPORT_SYMBOL(acpi_ut_value_exit)
>> @@ -540,9 +566,11 @@ acpi_ut_ptr_exit(u32 line_number,
>>                                   acpi_gbl_function_exit_prefix, ptr);
>>          }
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          if (acpi_gbl_nesting_level) {
>>                  acpi_gbl_nesting_level--;
>>          }
>> +       spin_unlock(&acpi_utdebug_lock);
>>   }
>>
>>   /*******************************************************************************
>> @@ -577,9 +605,11 @@ acpi_ut_str_exit(u32 line_number,
>>                                   acpi_gbl_function_exit_prefix, string);
>>          }
>>
>> +       spin_lock(&acpi_utdebug_lock);
>>          if (acpi_gbl_nesting_level) {
>>                  acpi_gbl_nesting_level--;
>>          }
>> +       spin_unlock(&acpi_utdebug_lock);
>>   }
>>
>>   /*******************************************************************************
>> --
>> 2.34.1
>>
