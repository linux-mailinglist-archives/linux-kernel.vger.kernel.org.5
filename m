Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2C7A42D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbjIRHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbjIRHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:32:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE8186;
        Mon, 18 Sep 2023 00:32:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC40C433B9;
        Mon, 18 Sep 2023 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695022341;
        bh=07Jp3LphXzl4EkHja0JdIUA/xjHpNGiZuguIXloPztM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vnbzf3QhQuVmwYQAf2Mt0WSZBefd5lhLSFtkXhwMC+n+X7N4ki+6T0boDwsgMr0XN
         AAdXg1yYsIa/lFW8JGjF+xmiLYY63eHqaMwytJIlEVwOkPrMrojuYJZhQpE797YZju
         GZcg8J0n+fEArc0GhUtiTV4LpXaeVrImgv2qDiS2pZ01DSA9wJwPYqPfL7KPbaX6bE
         QYQH9HSRdQuGBz3raOjQKyLrYnfzs7cZoMWOYQ1LzctZYuLHDNxMU/K31vWL6RTmKL
         zi7xoAjilllhk4DMDBlwvUkOVzwZl6SwuVwOf6rk+tbCRJ2s6/D0PIr6IMDdrgSqtE
         mxvGlqxn371yQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 13/13] bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of
Date:   Mon, 18 Sep 2023 10:29:55 +0300
Message-Id: <20230918072955.2507221-14-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918072955.2507221-1-rppt@kernel.org>
References: <20230918072955.2507221-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

BPF just-in-time compiler depended on CONFIG_MODULES because it used
module_alloc() to allocate memory for the generated code.

Since code allocations are now implemented with execmem, drop dependency of
CONFIG_BPF_JIT on CONFIG_MODULES and make it select CONFIG_EXECMEM.

Suggested-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 kernel/bpf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 6a906ff93006..5be11c906f93 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -42,7 +42,7 @@ config BPF_JIT
 	bool "Enable BPF Just In Time compiler"
 	depends on BPF
 	depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
-	depends on MODULES
+	select EXECMEM
 	help
 	  BPF programs are normally handled by a BPF interpreter. This option
 	  allows the kernel to generate native code when a program is loaded
-- 
2.39.2

