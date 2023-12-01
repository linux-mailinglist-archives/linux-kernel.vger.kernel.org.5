Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6784800314
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377413AbjLAFjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAFjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:39:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B25E11703;
        Thu, 30 Nov 2023 21:39:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF521042;
        Thu, 30 Nov 2023 21:40:08 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22F683F73F;
        Thu, 30 Nov 2023 21:39:16 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V15 0/8] arm64/perf: Enable branch stack sampling
Date:   Fri,  1 Dec 2023 11:08:58 +0530
Message-Id: <20231201053906.1261704-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables perf branch stack sampling support on arm64 platform
via a new arch feature called Branch Record Buffer Extension (BRBE). All
the relevant register definitions could be accessed here.

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers

This series applies on 6.7-rc3 after the following series from James Clark.

https://lore.kernel.org/all/20231019165510.1966367-1-james.clark@arm.com/

Also this series is being hosted below for quick access, review and test.

https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v15)

There are still some open questions regarding handling multiple perf events
with different privilege branch filters getting on the same PMU, supporting
guest branch stack tracing from the host etc. Finally also looking for some
suggestions regarding supporting BRBE inside the guest. The series has been
re-organized completely as suggested earlier.

- Anshuman

========== Perf Branch Stack Sampling Support (arm64 platforms) ===========

Currently arm64 platform does not support perf branch stack sampling. Hence
any event requesting for branch stack records i.e PERF_SAMPLE_BRANCH_STACK
marked in event->attr.sample_type, will be rejected in armpmu_event_init().

static int armpmu_event_init(struct perf_event *event)
{
	........
        /* does not support taken branch sampling */
        if (has_branch_stack(event))
                return -EOPNOTSUPP;
	........
}

$perf record -j any,u,k ls
Error:
cycles:P: PMU Hardware or event type doesn't support branch stack sampling.

-------------------- CONFIG_ARM64_BRBE and FEAT_BRBE ----------------------

After this series, perf branch stack sampling feature gets enabled on arm64
platforms where FEAT_BRBE HW feature is supported, and CONFIG_ARM64_BRBE is
also selected during build. Let's observe all all possible scenarios here.

1. Feature not built (!CONFIG_ARM64_BRBE):

Falls back to the current behaviour i.e event gets rejected.

2. Feature built but HW not supported (CONFIG_ARM64_BRBE && !FEAT_BRBE):

Falls back to the current behaviour i.e event gets rejected.

3. Feature built and HW supported (CONFIG_ARM64_BRBE && FEAT_BRBE):

Platform supports branch stack sampling requests. Let's observe through a
simple example here.

$perf record -j any_call,u,k,save_type ls

[Please refer perf-record man pages for all possible branch filter options]

$perf report
-------------------------- Snip ----------------------
# Overhead  Command  Source Shared Object  Source Symbol                                 Target Symbol                                 Basic Block Cycles
# ........  .......  ....................  ............................................  ............................................  ..................
#
     3.52%  ls       [kernel.kallsyms]     [k] sched_clock_noinstr                       [k] arch_counter_get_cntpct                   16
     3.52%  ls       [kernel.kallsyms]     [k] sched_clock                               [k] sched_clock_noinstr                       9
     1.85%  ls       [kernel.kallsyms]     [k] sched_clock_cpu                           [k] sched_clock                               5
     1.80%  ls       [kernel.kallsyms]     [k] irqtime_account_irq                       [k] sched_clock_cpu                           20
     1.58%  ls       [kernel.kallsyms]     [k] gic_handle_irq                            [k] generic_handle_domain_irq                 19
     1.58%  ls       [kernel.kallsyms]     [k] call_on_irq_stack                         [k] gic_handle_irq                            9
     1.58%  ls       [kernel.kallsyms]     [k] do_interrupt_handler                      [k] call_on_irq_stack                         23
     1.58%  ls       [kernel.kallsyms]     [k] generic_handle_domain_irq                 [k] __irq_resolve_mapping                     6
     1.58%  ls       [kernel.kallsyms]     [k] __irq_resolve_mapping                     [k] __rcu_read_lock                           10
-------------------------- Snip ----------------------

$perf report -D | grep cycles
-------------------------- Snip ----------------------
.....  1: ffff800080dd3334 -> ffff800080dd759c 39 cycles  P   0 IND_CALL
.....  2: ffff800080ffaea0 -> ffff800080ffb688 16 cycles  P   0 IND_CALL
.....  3: ffff800080139918 -> ffff800080ffae64 9  cycles  P   0 CALL
.....  4: ffff800080dd3324 -> ffff8000801398f8 7  cycles  P   0 CALL
.....  5: ffff8000800f8548 -> ffff800080dd330c 21 cycles  P   0 IND_CALL
.....  6: ffff8000800f864c -> ffff8000800f84ec 6  cycles  P   0 CALL
.....  7: ffff8000800f86dc -> ffff8000800f8638 11 cycles  P   0 CALL
.....  8: ffff8000800f86d4 -> ffff800081008630 16 cycles  P   0 CALL
-------------------------- Snip ----------------------

perf script and other tooling can also be applied on the captured perf.data
Similarly branch stack sampling records can be collected via direct system
call i.e perf_event_open() method after setting 'struct perf_event_attr' as
required.

event->attr.sample_type |= PERF_SAMPLE_BRANCH_STACK
event->attr.branch_sample_type |= PERF_SAMPLE_BRANCH_<FILTER_1> |
				  PERF_SAMPLE_BRANCH_<FILTER_2> |
				  PERF_SAMPLE_BRANCH_<FILTER_3> |
				  ...............................

But all branch filters might not be supported on the platform.

----------------------- BRBE Branch Filters Support -----------------------

- Following branch filters are supported on arm64.

	PERF_SAMPLE_BRANCH_USER		/* Branch privilege filters */
	PERF_SAMPLE_BRANCH_KERNEL
	PERF_SAMPLE_BRANCH_HV

	PERF_SAMPLE_BRANCH_ANY		/* Branch type filters */
	PERF_SAMPLE_BRANCH_ANY_CALL
	PERF_SAMPLE_BRANCH_ANY_RETURN
	PERF_SAMPLE_BRANCH_IND_CALL
	PERF_SAMPLE_BRANCH_COND
	PERF_SAMPLE_BRANCH_IND_JUMP
	PERF_SAMPLE_BRANCH_CALL

	PERF_SAMPLE_BRANCH_NO_FLAGS	/* Branch record flags */
	PERF_SAMPLE_BRANCH_NO_CYCLES
	PERF_SAMPLE_BRANCH_TYPE_SAVE
	PERF_SAMPLE_BRANCH_HW_INDEX
	PERF_SAMPLE_BRANCH_PRIV_SAVE

- Following branch filters are not supported on arm64.

	PERF_SAMPLE_BRANCH_ABORT_TX
	PERF_SAMPLE_BRANCH_IN_TX
	PERF_SAMPLE_BRANCH_NO_TX
	PERF_SAMPLE_BRANCH_CALL_STACK

Events requesting above non-supported branch filters get rejected.

------------------ Possible 'branch_sample_type' Mismatch -----------------

Branch stack sampling attributes 'event->attr.branch_sample_type' generally
remain the same for all the events during a perf record session.

$perf record -e <event_1> -e <event_2> -j <branch_filters> [workload]

event_1->attr.branch_sample_type == event_2->attr.branch_sample_type

This 'branch_sample_type' is used to configure the BRBE hardware, when both
events i.e <event_1> and <event_2> get scheduled on a given PMU. But during
PMU HW event's privilege filter inheritance, 'branch_sample_type' does not
remain the same for all events. Let's consider the following example

$perf record -e cycles:u -e instructions:k -j any,save_type ls

cycles->attr.branch_sample_type != instructions->attr.branch_sample_type

Because cycles event inherits PERF_SAMPLE_BRANCH_USER and instruction event
inherits PERF_SAMPLE_BRANCH_KERNEL. The proposed solution here configures
BRBE hardware with 'branch_sample_type' from last event to be added in the
PMU and hence captured branch records only get passed on to matching events
during a PMU interrupt.

static int
armpmu_add(struct perf_event *event, int flags)
{
	........
	if (has_branch_stack(event)) {
		/*
		 * Reset branch records buffer if a new task event gets
		 * scheduled on a PMU which might have existing records.
		 * Otherwise older branch records present in the buffer
		 * might leak into the new task event.
		 */
		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
			hw_events->brbe_context = event->ctx;
			if (armpmu->branch_reset)
				armpmu->branch_reset();
		}
		hw_events->brbe_users++;
Here ------->	hw_events->brbe_sample_type = event->attr.branch_sample_type;
	}
	........
}

Instead of overriding existing 'branch_sample_type', both could be merged.

--------------------------- Virtualisation support ------------------------

- Branch stack sampling is not currently supported inside the guest (TODO)

	- FEAT_BRBE advertised as absent via clearing ID_AA64DFR0_EL1.BRBE
	- Future support in guest requires emulating FEAT_BRBE

- Branch stack sampling the guest is not supported in the host      (TODO)

	- Tracing the guest with event->attr.exclude_guest = 0
	- There are multiple challenges involved regarding mixing events
	  with mismatched branch_sample_type and exclude_guest and passing
	  on captured BRBE records to intended events during PMU interrupt

- Guest access for BRBE registers and instructions has been blocked

- BRBE state save is not required for VHE host (EL2) guest (EL1) transition

- BRBE state is saved for NVHE host (EL1) guest (EL1) transition

-------------------------------- Testing ---------------------------------

- Cross compiled for both arm64 and arm32 platforms
- Passes all branch tests with 'perf test branch' on arm64

-------------------------------- Questions -------------------------------

- Instead of configuring the BRBE HW with branch_sample_type from the last
  event to be added on the PMU as proposed, could those be merged together
  e.g all privilege requests ORed, to form a common BRBE configuration and
  all events get branch records after a PMU interrupt ?

Changes in V15:

- Added a comment for armv8pmu_branch_probe() regarding single cpu probe
- Added a text in brbe.rst regarding single cpu probe
- Dropped runtime BRBE enable for setting DEBUG_STATE_SAVE_BRBE
- Dropped zero_branch_stack based zero branch records mechanism
- Replaced BRBFCR_EL1_DEFAULT_CONFIG with BRBFCR_EL1_CONFIG_MASK
- Added BRBFCR_EL1_CONFIG_MASK masking in branch_type_to_brbfcr()
- Moved BRBE helpers from arm_brbe.h into arm_brbe.c
- Moved armv8_pmu_xxx() declaration inside arm_brbe.h for arm64 (CONFIG_ARM64_BRBE)
- Moved armv8_pmu_xxx() stub definitions inside arm_brbe.h for arm32 (!CONFIG_ARM64_BRBE)
- Included arm_brbe.h header both in arm_pmuv3.c and arm_brbe.c
- Dropped BRBE custom pr_fmt()
- Dropped CONFIG_PERF_EVENTS wrapping from header entries
- Flush branch records when a cpu bound event follows a task bound event
- Dropped BRBFCR_EL1 from __debug_save_brbe()/__debug_restore_brbe()
- Always save the live SYS_BRBCR_EL1 in host context and then check if
  BRBE was enabled before resetting SYS_BRBCR_EL1 for the host

Changes in V14:

https://lore.kernel.org/all/20231114051329.327572-1-anshuman.khandual@arm.com/

- This series has been reorganised as suggested during V13
- There are just eight patches now i.e 5 enablement and 3 perf branch tests

- Fixed brackets problem in __SYS_BRBINFO/BRBSRC/BRBTGT() macros
- Renamed the macro i.e s/__SYS_BRBINFO/__SYS_BRBINF/
- Renamed s/BRB_IALL/BRB_IALL_INSN and s/BRBE_INJ/BRB_INJ_INSN
- Moved BRB_IALL_INSN and SYS_BRB_INSN instructions to sysreg patch
- Changed E1BRE as ExBRE in sysreg fields inside BRBCR_ELx
- Used BRBCR_ELx for defining all BRBCR_EL1, BRBCR_EL2, and BRBCR_EL12 (new)

- Folded the following three patches into a single patch i.e [PATCH 3/8]

  drivers: perf: arm_pmu: Add new sched_task() callback
  arm64/perf: Add branch stack support in struct arm_pmu
  arm64/perf: Add branch stack support in struct pmu_hw_events
  arm64/perf: Add branch stack support in ARMV8 PMU
  arm64/perf: Add PERF_ATTACH_TASK_DATA to events with has_branch_stack()

- All armv8pmu_branch_xxxx() stub definitions have been moved inside
  include/linux/perf/arm_pmuv3.h for easy access from both arm32 and arm64
- Added brbe_users, brbe_context and brbe_sample_type in struct pmu_hw_events
- Added comments for all the above new elements in struct pmu_hw_events
- Added branch_reset() and sched_task() callbacks
- Changed and optimized branch records processing during a PMU IRQ
- NO branch records get captured for event with mismatched brbe_sample_type
- Branch record context is tracked from armpmu_del() & armpmu_add()
- Branch record hardware is driven from armv8pmu_start() & armv8pmu_stop()
- Dropped NULL check for 'pmu_ctx' inside armv8pmu_sched_task()
- Moved down PERF_ATTACH_TASK_DATA assignment with a preceding comment
- In conflicting branch sample type requests, first event takes precedence

- Folded the following five patches from V13 into a single patch i.e
  [PATCH 4/8]

  arm64/perf: Enable branch stack events via FEAT_BRBE
  arm64/perf: Add struct brbe_regset helper functions
  arm64/perf: Implement branch records save on task sched out
  arm64/perf: Implement branch records save on PMU IRQ

- Fixed the year in copyright statement
- Added Documentation/arch/arm64/brbe.rst
- Updated Documentation/arch/arm64/booting.rst (BRBCR_EL2.CC for EL1 entry)
- Added __init_el2_brbe() which enables branch record cycle count support
- Disabled EL2 traps in __init_el2_fgt() while accessing BRBE registers and
  executing instructions
- Changed CONFIG_ARM64_BRBE user visible description
- Fixed a typo in CONFIG_ARM64_BRBE config option description text
- Added BUILD_BUG_ON() co-relating BRBE_BANK_MAX_ENTRIES and MAX_BRANCH_RECORDS
- Dropped arm64_create_brbe_task_ctx_kmem_cache()
- Moved down comment for PERF_SAMPLE_BRANCH_KERNEL in branch_type_to_brbcr()
- Renamed BRBCR_ELx_DEFAULT_CONFIG as BRBCR_ELx_CONFIG_MASK
- Replaced BRBCR_ELx_DEFAULT_TS with BRBCR_ELx_TS_MASK in BRBCR_ELx_CONFIG_MASK
- Replaced BRBCR_ELx_E1BRE instances with BRBCR_ELx_ExBRE

- Added BRBE specific branch stack sampling perf test patches into the series
- Added a patch to prevent guest accesses into BRBE registers and instructions
- Added a patch to save the BRBE host context in NVHE environment
- Updated most commit messages

Changes in V13:

https://lore.kernel.org/all/20230711082455.215983-1-anshuman.khandual@arm.com/
https://lore.kernel.org/all/20230622065351.1092893-1-anshuman.khandual@arm.com/

- Added branch callback stubs for aarch32 pmuv3 based platforms
- Updated the comments for capture_brbe_regset()
- Deleted the comments in __read_brbe_regset()
- Reversed the arguments order in capture_brbe_regset() and brbe_branch_save()
- Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in armv8pmu_branch_read()
- Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in capture_brbe_regset()

Changes in V12:

https://lore.kernel.org/all/20230615133239.442736-1-anshuman.khandual@arm.com/

- Replaced branch types with complete DIRECT/INDIRECT prefixes/suffixes
- Replaced branch types with complete INSN/ALIGN prefixes/suffixes
- Replaced return branch types as simple RET/ERET
- Replaced time field GST_PHYSICAL as GUEST_PHYSICAL
- Added 0 padding for BRBIDR0_EL1.NUMREC enum values
- Dropped helper arm_pmu_branch_stack_supported()
- Renamed armv8pmu_branch_valid() as armv8pmu_branch_attr_valid()
- Separated perf_task_ctx_cache setup from arm_pmu private allocation
- Collected changes to branch_records_alloc() in a single patch [5/10]
- Reworked and cleaned up branch_records_alloc()
- Reworked armv8pmu_branch_read() with new loop iterations in patch [6/10]
- Reworked capture_brbe_regset() with new loop iterations in patch [8/10]
- Updated the comment in branch_type_to_brbcr()
- Fixed the comment before stitch_stored_live_entries()
- Fixed BRBINFINJ_EL1 definition for VALID_FULL enum field
- Factored out helper __read_brbe_regset() from capture_brbe_regset()
- Dropped the helper copy_brbe_regset()
- Simplified stitch_stored_live_entries() with memcpy(), memmove()
- Reworked armv8pmu_probe_pmu() to bail out early with !probe.present
- Rework brbe_attributes_probe() without 'struct brbe_hw_attr'
- Dropped 'struct brbe_hw_attr' argument from capture_brbe_regset()
- Dropped 'struct brbe_hw_attr' argument from brbe_branch_save()
- Dropped arm_pmu->private and added arm_pmu->reg_trbidr instead

Changes in V11:

https://lore.kernel.org/all/20230531040428.501523-1-anshuman.khandual@arm.com/

- Fixed the crash for per-cpu events without event->pmu_ctx->task_ctx_data

Changes in V10:

https://lore.kernel.org/all/20230517022410.722287-1-anshuman.khandual@arm.com/

- Rebased the series on v6.4-rc2
- Moved ARMV8 PMUV3 changes inside drivers/perf/arm_pmuv3.c
- Moved BRBE driver changes inside drivers/perf/arm_brbe.[c|h]
- Moved the WARN_ON() inside the if condition in armv8pmu_handle_irq()

Changes in V9:

https://lore.kernel.org/all/20230315051444.1683170-1-anshuman.khandual@arm.com/

- Fixed build problem with has_branch_stack() in arm64 header
- BRBINF_EL1 definition has been changed from 'Sysreg' to 'SysregFields'
- Renamed all BRBINF_EL1 call sites as BRBINFx_EL1
- Dropped static const char branch_filter_error_msg[]
- Implemented a positive list check for BRBE supported perf branch filters
- Added a comment in armv8pmu_handle_irq()
- Implemented per-cpu allocation for struct branch_record records
- Skipped looping through bank 1 if an invalid record is detected in bank 0
- Added comment in armv8pmu_branch_read() explaining prohibited region etc
- Added comment warning about erroneously marking transactions as aborted
- Replaced the first argument (perf_branch_entry) in capture_brbe_flags()
- Dropped the last argument (idx) in capture_brbe_flags()
- Dropped the brbcr argument from capture_brbe_flags()
- Used perf_sample_save_brstack() to capture branch records for perf_sample_data
- Added comment explaining rationale for setting BRBCR_EL1_FZP for user only traces
- Dropped BRBE prohibited state mechanism while in armv8pmu_branch_read()
- Implemented event task context based branch records save mechanism

Changes in V8:

https://lore.kernel.org/all/20230123125956.1350336-1-anshuman.khandual@arm.com/

- Replaced arm_pmu->features as arm_pmu->has_branch_stack, updated its helper
- Added a comment and line break before arm_pmu->private element
- Added WARN_ON_ONCE() in helpers i.e armv8pmu_branch_[read|valid|enable|disable]()
- Dropped comments in armv8pmu_enable_event() and armv8pmu_disable_event()
- Replaced open bank encoding in BRBFCR_EL1 with SYS_FIELD_PREP()
- Changed brbe_hw_attr->brbe_version from 'bool' to 'int'
- Updated pr_warn() as pr_warn_once() with values in brbe_get_perf_[type|priv]()
- Replaced all pr_warn_once() as pr_debug_once() in armv8pmu_branch_valid()
- Added a comment in branch_type_to_brbcr() for the BRBCR_EL1 privilege settings
- Modified the comment related to BRBINFx_EL1.LASTFAILED in capture_brbe_flags()
- Modified brbe_get_perf_entry_type() as brbe_set_perf_entry_type()
- Renamed brbe_valid() as brbe_record_is_complete()
- Renamed brbe_source() as brbe_record_is_source_only()
- Renamed brbe_target() as brbe_record_is_target_only()
- Inverted checks for !brbe_record_is_[target|source]_only() for info capture
- Replaced 'fetch' with 'get' in all helpers that extract field value
- Dropped 'static int brbe_current_bank' optimization in select_brbe_bank()
- Dropped select_brbe_bank_index() completely, added capture_branch_entry()
- Process captured branch entries in two separate loops one for each BRBE bank
- Moved branch_records_alloc() inside armv8pmu_probe_pmu()
- Added a forward declaration for the helper has_branch_stack()
- Added new callbacks armv8pmu_private_alloc() and armv8pmu_private_free()
- Updated armv8pmu_probe_pmu() to allocate the private structure before SMP call

Changes in V7:

https://lore.kernel.org/all/20230105031039.207972-1-anshuman.khandual@arm.com/

- Folded [PATCH 7/7] into [PATCH 3/7] which enables branch stack sampling event
- Defined BRBFCR_EL1_BRANCH_FILTERS, BRBCR_EL1_DEFAULT_CONFIG in the header
- Defined BRBFCR_EL1_DEFAULT_CONFIG in the header
- Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_FZP
- Defined BRBCR_EL1_DEFAULT_TS in the header
- Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_DEFAULT_TS
- Moved BRBCR_EL1_DEFAULT_CONFIG check inside branch_type_to_brbcr()
- Moved down BRBCR_EL1_CC, BRBCR_EL1_MPRED later in branch_type_to_brbcr()
- Also set BRBE in paused state in armv8pmu_branch_disable()
- Dropped brbe_paused(), set_brbe_paused() helpers
- Extracted error string via branch_filter_error_msg[] for armv8pmu_branch_valid()
- Replaced brbe_v1p1 with brbe_version in struct brbe_hw_attr
- Added valid_brbe_[cc, format, version]() helpers
- Split a separate brbe_attributes_probe() from armv8pmu_branch_probe()
- Capture event->attr.branch_sample_type earlier in armv8pmu_branch_valid()
- Defined enum brbe_bank_idx with possible values for BRBE bank indices
- Changed armpmu->hw_attr into armpmu->private
- Added missing space in stub definition for armv8pmu_branch_valid()
- Replaced both kmalloc() with kzalloc()
- Added BRBE_BANK_MAX_ENTRIES
- Updated comment for capture_brbe_flags()
- Updated comment for struct brbe_hw_attr
- Dropped space after type cast in couple of places
- Replaced inverse with negation for testing BRBCR_EL1_FZP in armv8pmu_branch_read()
- Captured cpuc->branches->branch_entries[idx] in a local variable
- Dropped saved_priv from armv8pmu_branch_read()
- Reorganize PERF_SAMPLE_BRANCH_NO_[CYCLES|NO_FLAGS] related configuration
- Replaced with FIELD_GET() and FIELD_PREP() wherever applicable
- Replaced BRBCR_EL1_TS_PHYSICAL with BRBCR_EL1_TS_VIRTUAL
- Moved valid_brbe_nr(), valid_brbe_cc(), valid_brbe_format(), valid_brbe_version()
  select_brbe_bank(), select_brbe_bank_index() helpers inside the C implementation
- Reorganized brbe_valid_nr() and dropped the pr_warn() message
- Changed probe sequence in brbe_attributes_probe()
- Added 'brbcr' argument into capture_brbe_flags() to ascertain correct state
- Disable BRBE before disabling the PMU event counter
- Enable PERF_SAMPLE_BRANCH_HV filters when is_kernel_in_hyp_mode()
- Guard armv8pmu_reset() & armv8pmu_sched_task() with arm_pmu_branch_stack_supported()

Changes in V6:

https://lore.kernel.org/linux-arm-kernel/20221208084402.863310-1-anshuman.khandual@arm.com/

- Restore the exception level privilege after reading the branch records
- Unpause the buffer after reading the branch records
- Decouple BRBCR_EL1_EXCEPTION/ERTN from perf event privilege level
- Reworked BRBE implementation and branch stack sampling support on arm pmu
- BRBE implementation is now part of overall ARMV8 PMU implementation
- BRBE implementation moved from drivers/perf/ to inside arch/arm64/kernel/
- CONFIG_ARM_BRBE_PMU renamed as CONFIG_ARM64_BRBE in arch/arm64/Kconfig
- File moved - drivers/perf/arm_pmu_brbe.c -> arch/arm64/kernel/brbe.c
- File moved - drivers/perf/arm_pmu_brbe.h -> arch/arm64/kernel/brbe.h
- BRBE name has been dropped from struct arm_pmu and struct hw_pmu_events
- BRBE name has been abstracted out as 'branches' in arm_pmu and hw_pmu_events
- BRBE name has been abstracted out as 'branches' in ARMV8 PMU implementation
- Added sched_task() callback into struct arm_pmu
- Added 'hw_attr' into struct arm_pmu encapsulating possible PMU HW attributes
- Dropped explicit attributes brbe_(v1p1, nr, cc, format) from struct arm_pmu
- Dropped brbfcr, brbcr, registers scratch area from struct hw_pmu_events
- Dropped brbe_users, brbe_context tracking in struct hw_pmu_events
- Added 'features' tracking into struct arm_pmu with ARM_PMU_BRANCH_STACK flag
- armpmu->hw_attr maps into 'struct brbe_hw_attr' inside BRBE implementation
- Set ARM_PMU_BRANCH_STACK in 'arm_pmu->features' after successful BRBE probe
- Added armv8pmu_branch_reset() inside armv8pmu_branch_enable()
- Dropped brbe_supported() as events will be rejected via ARM_PMU_BRANCH_STACK
- Dropped set_brbe_disabled() as well
- Reformated armv8pmu_branch_valid() warnings while rejecting unsupported events

Changes in V5:

https://lore.kernel.org/linux-arm-kernel/20221107062514.2851047-1-anshuman.khandual@arm.com/

- Changed BRBCR_EL1.VIRTUAL from 0b1 to 0b01
- Changed BRBFCR_EL1.EnL into BRBFCR_EL1.EnI
- Changed config ARM_BRBE_PMU from 'tristate' to 'bool'

Changes in V4:

https://lore.kernel.org/all/20221017055713.451092-1-anshuman.khandual@arm.com/

- Changed ../tools/sysreg declarations as suggested
- Set PERF_SAMPLE_BRANCH_STACK in data.sample_flags
- Dropped perfmon_capable() check in armpmu_event_init()
- s/pr_warn_once/pr_info in armpmu_event_init()
- Added brbe_format element into struct pmu_hw_events
- Changed v1p1 as brbe_v1p1 in struct pmu_hw_events
- Dropped pr_info() from arm64_pmu_brbe_probe(), solved LOCKDEP warning

Changes in V3:

https://lore.kernel.org/all/20220929075857.158358-1-anshuman.khandual@arm.com/

- Moved brbe_stack from the stack and now dynamically allocated
- Return PERF_BR_PRIV_UNKNOWN instead of -1 in brbe_fetch_perf_priv()
- Moved BRBIDR0, BRBCR, BRBFCR registers and fields into tools/sysreg
- Created dummy BRBINF_EL1 field definitions in tools/sysreg
- Dropped ARMPMU_EVT_PRIV framework which cached perfmon_capable()
- Both exception and exception return branche records are now captured
  only if the event has PERF_SAMPLE_BRANCH_KERNEL which would already
  been checked in generic perf via perf_allow_kernel()

Changes in V2:

https://lore.kernel.org/all/20220908051046.465307-1-anshuman.khandual@arm.com/

- Dropped branch sample filter helpers consolidation patch from this series
- Added new hw_perf_event.flags element ARMPMU_EVT_PRIV to cache perfmon_capable()
- Use cached perfmon_capable() while configuring BRBE branch record filters

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/20220613100119.684673-1-anshuman.khandual@arm.com/

- Added CONFIG_PERF_EVENTS wrapper for all branch sample filter helpers
- Process new perf branch types via PERF_BR_EXTEND_ABI

Changes in RFC V2:

https://lore.kernel.org/linux-arm-kernel/20220412115455.293119-1-anshuman.khandual@arm.com/

- Added branch_sample_priv() while consolidating other branch sample filter helpers
- Changed all SYS_BRBXXXN_EL1 register definition encodings per Marc
- Changed the BRBE driver as per proposed BRBE related perf ABI changes (V5)
- Added documentation for struct arm_pmu changes, updated commit message
- Updated commit message for BRBE detection infrastructure patch
- PERF_SAMPLE_BRANCH_KERNEL gets checked during arm event init (outside the driver)
- Branch privilege state capture mechanism has now moved inside the driver

Changes in RFC V1:

https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: James Clark <james.clark@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (5):
  arm64/sysreg: Add BRBE registers and fields
  KVM: arm64: Prevent guest accesses into BRBE system registers/instructions
  drivers: perf: arm_pmuv3: Enable branch stack sampling framework
  drivers: perf: arm_pmuv3: Enable branch stack sampling via FEAT_BRBE
  KVM: arm64: nvhe: Disable branch generation in nVHE guests

James Clark (3):
  perf: test: Speed up running brstack test on an Arm model
  perf: test: Remove empty lines from branch filter test output
  perf: test: Extend branch stack sampling test for Arm64 BRBE

 Documentation/arch/arm64/booting.rst   |   6 +
 Documentation/arch/arm64/brbe.rst      | 156 ++++
 arch/arm64/include/asm/el2_setup.h     | 113 ++-
 arch/arm64/include/asm/kvm_host.h      |   4 +
 arch/arm64/include/asm/sysreg.h        | 109 +++
 arch/arm64/kvm/debug.c                 |   5 +
 arch/arm64/kvm/hyp/nvhe/debug-sr.c     |  33 +
 arch/arm64/kvm/sys_regs.c              | 130 ++++
 arch/arm64/tools/sysreg                | 170 +++++
 drivers/perf/Kconfig                   |  11 +
 drivers/perf/Makefile                  |   1 +
 drivers/perf/arm_brbe.c                | 985 +++++++++++++++++++++++++
 drivers/perf/arm_brbe.h                |  63 ++
 drivers/perf/arm_pmu.c                 |  57 +-
 drivers/perf/arm_pmuv3.c               | 141 +++-
 include/linux/perf/arm_pmu.h           |  34 +-
 include/linux/perf/arm_pmuv3.h         |   1 -
 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/shell/test_brstack.sh |  57 +-
 tools/perf/tests/tests.h               |   1 +
 tools/perf/tests/workloads/Build       |   2 +
 tools/perf/tests/workloads/traploop.c  |  39 +
 22 files changed, 2105 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/arch/arm64/brbe.rst
 create mode 100644 drivers/perf/arm_brbe.c
 create mode 100644 drivers/perf/arm_brbe.h
 create mode 100644 tools/perf/tests/workloads/traploop.c

-- 
2.25.1

