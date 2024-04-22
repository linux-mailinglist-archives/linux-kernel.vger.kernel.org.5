Return-Path: <linux-kernel+bounces-153368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862818ACD34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC821F20CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8781514D2;
	Mon, 22 Apr 2024 12:45:40 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2D14F9E6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789939; cv=none; b=e3HM0/13XMFX5nvclGxyYKMXqit39eVcQ/DDMlkiAvWzeJewF1bx4lEjgonlLGTAL/qNCz2PjrtB6hN2CjE2lw9meGbdZgdwlY1wuOtcD48i976aNENe4ro76IXa94XDMfWsiRqUPrh1YFGQTylrBgegXMgW/BKfcZlOzyyAusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789939; c=relaxed/simple;
	bh=yYH2vuZoVpYszLzr7WSPOJbEUql1N3RWmEXWyg6uOw8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktzYpKzPnY8XLRhNoIrjO9sWgSW1UCX5XveA44stkVD38Ed4np3V3VYVNQ5FHhUXtG+SDtzHNCCT+n5kYSvN5hkw7wtVA5qO1dUlW142mv/vP1GKGIRYj0Xi1QmwQ3ZbQvVfRi5KGLeNrUQfBCEfUX1PJnRVyrSHmN3afsLLYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by xavier.telenet-ops.be with bizsmtp
	id ECla2C0040SSLxL01Cla1Y; Mon, 22 Apr 2024 14:45:34 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryt2V-001tuv-VA
	for linux-kernel@vger.kernel.org;
	Mon, 22 Apr 2024 14:45:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryt37-005ihq-Vk
	for linux-kernel@vger.kernel.org;
	Mon, 22 Apr 2024 14:45:34 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.9-rc5
Date: Mon, 22 Apr 2024 14:45:33 +0200
Message-Id: <20240422124533.1363483-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wgfck-6-2YcD3Bzhjo0E0L0g2HGSZksB9pzRCah=Y4HBw@mail.gmail.com>
References: <CAHk-=wgfck-6-2YcD3Bzhjo0E0L0g2HGSZksB9pzRCah=Y4HBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.9-rc5[1] compared to v6.8[2].

Summarized:
  - build errors: +11/-8
  - build warnings: +1/-40

JFYI, when comparing v6.9-rc5[1] to v6.9-rc4[3], the summaries are:
  - build errors: +6/-5
  - build warnings: +1/-1476

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ed30a4a51bb196781c8058073ea720133a65596f/ (all 138 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e8f897f4afef0031fe618a8e94127a0934896aba/ (all 138 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0bbac3facb5d6cc0171c45c9873a2dc96bea9680/ (all 138 configs)


*** ERRORS ***

11 error regressions:
  + /kisskb/src/arch/sparc/kernel/setup_64.c: error: no previous prototype for 'alloc_irqstack_bootmem' [-Werror=missing-prototypes]:  => 602:13
  + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]:  => 254:1
  + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]:  => 282:1
  + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]:  => 307:1
  + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]:  => 343:1
  + /kisskb/src/crypto/scompress.c: error: unused variable 'dst_page' [-Werror=unused-variable]:  => 174:38
  + /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h: error: 'gen7_0_0_external_core_regs' defined but not used [-Werror=unused-variable]:  => 924:19
  + /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h: error: 'gen7_2_0_external_core_regs' defined but not used [-Werror=unused-variable]:  => 748:19
  + /kisskb/src/fs/bcachefs/btree_io.c: error: format '%lu' expects argument of type 'long unsigned int', but argument 12 has type 'unsigned int' [-Werror=format=]:  => 891:34, 891:6
  + {standard input}: Error: invalid operands for opcode: 606 => 1099, 610
  + {standard input}: Error: pcrel too far:  => 570, 579, 543, 563, 581, 588, 561, 572, 590, 545, 552, 554

8 error improvements:
  - /kisskb/src/arch/sparc/lib/cmpdi2.c: error: no previous prototype for '__cmpdi2' [-Werror=missing-prototypes]: 6:11 => 
  - /kisskb/src/drivers/mtd/maps/sun_uflash.c: error: no previous prototype for 'uflash_devinit' [-Werror=missing-prototypes]: 50:5 => 
  - /kisskb/src/include/linux/fortify-string.h: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]: 537:4 => 
  - /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror]: 528:4 => 
  - /kisskb/src/kernel/dma.c: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]: 88:6 => 
  - /kisskb/src/kernel/dma.c: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]: 70:5 => 
  - {standard input}: Error: branch to a symbol in another ISA mode: 5016, 5011 => 
  - {standard input}: Error: expected symbol name: 1095 => 


*** WARNINGS ***

1 warning regressions:
  + /kisskb/src/fs/bcachefs/btree_io.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 12 has type 'unsigned int' [-Wformat=]:  => 891:34, 891:6

40 warning improvements:
  - /kisskb/src/arch/sparc/lib/cmpdi2.c: warning: no previous prototype for '__cmpdi2' [-Wmissing-prototypes]: 6:11 => 
  - /kisskb/src/arch/sparc/lib/ucmpdi2.c: warning: no previous prototype for '__ucmpdi2' [-Wmissing-prototypes]: 5:11 => 
  - /kisskb/src/drivers/net/ethernet/i825xx/sun3_82586.c: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]: 990:108 => 
  - /kisskb/src/drivers/tty/serial/mcf.c: warning: no previous prototype for 'early_mcf_setup' [-Wmissing-prototypes]: 473:12 => 
  - /kisskb/src/kernel/dma.c: warning: no previous prototype for 'free_dma' [-Wmissing-prototypes]: 88:6 => 
  - /kisskb/src/kernel/dma.c: warning: no previous prototype for 'request_dma' [-Wmissing-prototypes]: 70:5 => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x110 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x30 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x4c (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x68 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x84 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xa0 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xbc (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xd8 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xf4 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_ext_maps+0xd8 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x14 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x30 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x4c (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x68 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0x84 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xa0 (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed: section mismatch in reference: qed_mfw_legacy_maps+0xbc (section: .data) -> qed_mfw_legacy_bb_100g (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x14 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x30 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x4c (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x68 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0x84 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xa0 (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede: section mismatch in reference: qede_forced_speed_maps+0xbc (section: .data) -> qede_forced_speed_100000 (section: .init.rodata): N/A => 
  - modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0x184 (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 
  - {standard input}: Warning: end of file not at end of a line; newline inserted: 1094 => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

