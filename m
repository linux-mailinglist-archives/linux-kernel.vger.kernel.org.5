Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1BD7565FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGQOMy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjGQOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:12:50 -0400
X-Greylist: delayed 2156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 07:12:44 PDT
Received: from 11.mo584.mail-out.ovh.net (11.mo584.mail-out.ovh.net [46.105.34.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA0198
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:12:44 -0700 (PDT)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.4.54])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 46BA72349E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:35:59 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-nt57t (unknown [10.110.208.139])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5908E1FE0D;
        Mon, 17 Jul 2023 13:35:58 +0000 (UTC)
Received: from courmont.net ([37.59.142.99])
        by ghost-submission-6684bf9d7b-nt57t with ESMTPSA
        id 0WBlO71DtWRI+QAABt2Raw
        (envelope-from <remi@remlab.net>); Mon, 17 Jul 2023 13:35:57 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-99G003bbea4a9f-defe-487c-86c7-12b72316aa3d,
                    B0373659C9CBE7527DE2AA887F006526039BD3B2) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 37.33.153.76
Date:   Mon, 17 Jul 2023 16:35:52 +0300
From:   =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_00/10=5D_riscv=3A_Allow_user?= =?US-ASCII?Q?space_to_directly_access_perf_counters?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230703124647.215952-1-alexghiti@rivosinc.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
Message-ID: <DDB4EEB8-12A0-4E66-8E96-808E84A82078@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 4881620523424160219
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeevjeejleefheetveehffekiedtveegteevteffueffffefkeegieeikefghfegfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdefjedrfeefrdduheefrdejiedpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgvmhhisehrvghmlhgrsgdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 3 juillet 2023 15:46:37 GMT+03:00, Alexandre Ghiti <alexghiti@rivosinc.com> a écrit :
>riscv used to allow direct access to cycle/time/instret counters,
>bypassing the perf framework, this patchset intends to allow the user to
>mmap any counter when accessed through perf. But we can't break the
>existing behaviour so we introduce a sysctl perf_user_access like arm64
>does, which defaults to the legacy mode described above.

AFAIK, if the default settings breaks user space, the patchset is considered to break user space. That being the case, either this case is deemed special enough that breaking user space is OK, or it is not.

If it is not OK, then the only way out that I can think of, consists of trapping and emulating the counters, returning the same sanitised values that Linux perf would return. Then you can add a kernel config option to disable that trap-and-emulation code in the future.

Either way, I don't suppose that there should be an option to be insecurely backward compatible.

>
>This version needs openSBI v1.3 *and* a kernel fix that went upstream lately
>(https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/).
>
>**Important**: In this version, the default mode is now user access, not
>the legacy so some applications will break.
>
>base-commit-tag: v6.4-rc6
>
>Changes in v4:
>- Fixed some nits in riscv_pmu_sbi.c thanks to Andrew
>- Fixed the documentation thanks to Andrew
>- Added RB from Andrew \o/
>
>Changes in v3:
>- patch 1 now contains the ref to the faulty commit (no Fixes tag as it is only a comment), as Andrew suggested
>- Removed RISCV_PMU_LEGACY_TIME from patch 3, as Andrew suggested
>- Rename RISCV_PMU_PDEV_NAME to "riscv-pmu-sbi", patch4 is just cosmetic now, as Andrew suggested
>- Removed a few useless (and wrong) comments, as Andrew suggested
>- Simplify arch_perf_update_userpage code, as Andrew suggested
>- Documentation now mentions that time CSR is *always* accessible, whatever the mode, as suggested by Andrew
>- Removed CYCLEH reference and add TODO for rv32 support, as suggested by Atish
>- Do not rename the pmu instance as Atish suggested
>- Set pmc_width only if rdpmc is enabled and CONFIG_RISCV_PMU is set and the event is a hw event
>- Move arch_perf_update_userpage https://lore.kernel.org/lkml/20230616114831.3186980-1-maz@kernel.org/T/
>- **Switch to user mode access by default**
>
>Changes in v2:
>- Split into smaller patches, way better!
>- Add RB from Conor
>- Simplify the way we checked riscv architecture
>- Fix race mmap and other thread running on other cpus
>- Use hwc when available
>- Set all userspace access flags in event_init, too cumbersome to handle sysctl changes
>- Fix arch_perf_update_userpage for pmu other than riscv-pmu by renaming pmu driver
>- Fixed kernel test robot build error
>- Fixed documentation (Andrew and Bagas)
>- perf testsuite passes mmap tests in all 3 modes
>
>Alexandre Ghiti (10):
>  perf: Fix wrong comment about default event_idx
>  include: riscv: Fix wrong include guard in riscv_pmu.h
>  riscv: Make legacy counter enum match the HW numbering
>  drivers: perf: Rename riscv pmu sbi driver
>  riscv: Prepare for user-space perf event mmap support
>  drivers: perf: Implement perf event mmap support in the legacy backend
>  drivers: perf: Implement perf event mmap support in the SBI backend
>  Documentation: admin-guide: Add riscv sysctl_perf_user_access
>  tools: lib: perf: Implement riscv mmap support
>  perf: tests: Adapt mmap-basic.c for riscv
>
> Documentation/admin-guide/sysctl/kernel.rst |  27 ++-
> drivers/perf/riscv_pmu.c                    | 113 +++++++++++
> drivers/perf/riscv_pmu_legacy.c             |  28 ++-
> drivers/perf/riscv_pmu_sbi.c                | 196 +++++++++++++++++++-
> include/linux/perf/riscv_pmu.h              |  12 +-
> include/linux/perf_event.h                  |   3 +-
> tools/lib/perf/mmap.c                       |  65 +++++++
> tools/perf/tests/mmap-basic.c               |   4 +-
> 8 files changed, 428 insertions(+), 20 deletions(-)
>
