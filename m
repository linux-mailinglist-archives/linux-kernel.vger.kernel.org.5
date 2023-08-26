Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA678972F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjHZOGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjHZOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9B19A0;
        Sat, 26 Aug 2023 07:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF3860C48;
        Sat, 26 Aug 2023 14:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECE8C433C7;
        Sat, 26 Aug 2023 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693058759;
        bh=Ze6naM6U59K5ICms6WQezoP77wFgRyyjcL6t5lX9uuw=;
        h=From:To:Cc:Subject:Date:From;
        b=V/pQIM4gR/qKdBijAkROfswGIGjWgUDg9tDwcdB5oQjuwDut1f/T7iSPFvVD3VDt6
         xeJDITzFMjSHarCyQGWq0dPkEgqtbQsq6X6TSpR/ux7M1f770IGKNExZSIR8bPdYhz
         gbLSKalsrfNVZy/3LQbLQC20BYj6EueahLcU3Wo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.48
Date:   Sat, 26 Aug 2023 16:05:46 +0200
Message-ID: <2023082646-underwire-unending-71b5@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.48 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/srso.rst |    4 
 Makefile                                   |    2 
 arch/x86/include/asm/entry-common.h        |    1 
 arch/x86/include/asm/nospec-branch.h       |   28 +++---
 arch/x86/kernel/cpu/amd.c                  |    1 
 arch/x86/kernel/cpu/bugs.c                 |   28 ++++--
 arch/x86/kernel/static_call.c              |   13 ++
 arch/x86/kernel/traps.c                    |    2 
 arch/x86/kernel/vmlinux.lds.S              |   20 ++--
 arch/x86/kvm/svm/svm.c                     |    2 
 arch/x86/lib/retpoline.S                   |  135 ++++++++++++++++++++---------
 tools/objtool/arch/x86/decode.c            |    2 
 tools/objtool/check.c                      |   21 ++--
 13 files changed, 178 insertions(+), 81 deletions(-)

Borislav Petkov (AMD) (4):
      x86/srso: Explain the untraining sequences a bit more
      x86/CPU/AMD: Fix the DIV(0) initial fix attempt
      x86/srso: Disable the mitigation on unaffected configurations
      x86/srso: Correct the mitigation status when SMT is disabled

Greg Kroah-Hartman (1):
      Linux 6.1.48

Peter Zijlstra (9):
      x86/cpu: Fix __x86_return_thunk symbol type
      x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
      x86/alternative: Make custom return thunk unconditional
      x86/cpu: Clean up SRSO return thunk mess
      x86/cpu: Rename original retbleed methods
      x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
      x86/cpu: Cleanup the untrain mess
      x86/static_call: Fix __static_call_fixup()
      objtool/x86: Fixup frame-pointer vs rethunk

Petr Pavlu (1):
      x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

