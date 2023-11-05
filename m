Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116107E12DB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjKEJtC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 04:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjKEJtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:49:01 -0500
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59327EE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 01:48:57 -0800 (PST)
User-agent: mu4e 1.10.7; emacs 30.0.50
From:   Sam James <sam@gentoo.org>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <kees@kernel.org>, uecker@gcc.gnu.org
Subject: amdgpu_amdkfd_gfx* triggers new -Walloc-size warnings in GCC 14
Date:   Sun, 05 Nov 2023 09:45:24 +0000
Organization: Gentoo
Message-ID: <87wmuwo7i3.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 14 introduces a new -Walloc-size warning (https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-alloc-size)
which triggers on the following amdgpu files:
"""
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c: In function ‘kgd_hqd_dump’:
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c:241:15: error: allocation of insufficient size ‘4’ for type ‘uint32_t[2]’ {aka ‘unsigned int[2
]’} with size ‘8’ [-Werror=alloc-size[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Walloc-size]]
  241 |         *dump = kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KERNEL);
      |               ^
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c: In function ‘kgd_hqd_sdma_dump’:
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c:327:15: error: allocation of insufficient size ‘4’ for type ‘uint32_t[2]’ {aka ‘unsigned int[2
]’} with size ‘8’ [-Werror=alloc-size[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Walloc-size]]
  327 |         *dump = kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KERNEL);
      |               ^
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c: In function ‘kgd_arcturus_hqd_sdma_dump’:
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:203:15: error: allocation of insufficient size ‘4’ for type ‘uint32_t[2]’ {aka ‘unsigned int
[2]’} with size ‘8’ [-Werror=alloc-size[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Walloc-size]]
  203 |         *dump = kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KERNEL);
      |               ^
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c: In function ‘kgd_gfx_v9_4_3_hqd_sdma_dump’:
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.10/work/linux-6.5/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c:142:15: error: allocation of insufficient size ‘4’ for type ‘uint32_t[2]’ {aka ‘unsigned int
[2]’} with size ‘8’ [-Werror=alloc-size[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Walloc-size]]
  142 |         *dump = kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KERNEL);
      |               ^
"""

$ gcc-14 --version
gcc-14 (Gentoo Hardened 14.0.0 p, commit
2b02f083e67e97f8187d3ec023c3d281f49232c0) 14.0.0 20231104 (experimental)
8d22ac6a18cf542cd541c06b2a7df8fdd293946d
Copyright (C) 2023 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is
NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

thanks,
sam
