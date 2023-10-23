Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAAC7D291D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjJWDco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjJWDcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:32:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41189188;
        Sun, 22 Oct 2023 20:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y5xX1ErYcsMd6Y6gVo+lbykAvr/Jdr2/F+4FDP026CQ=; b=lxK+3fvOqD3CtQ1DgE3+eF0hkh
        UqX1WgsdQZN/Ixg0ThkuMf0sFkSKMFT4lfksGNP1H6i9YsdaMp/4Xm/YGimwU8pPHQwO0l4u/fsYu
        G4RQct1hFu31rbHKO2vhlMoYe/pTELjk/4kPAChdEoDZuzHwabKpC0dXTChJmo2f22gO3QI9IREmV
        OdcVsCxzYOaNTxGfzc/5N38hR6fqcy+RtC9fu4IpWfFztBvVpa0TG+66s2OctNQhaoOKB4k8GcWrM
        H/7Q+2kpUbD45oGEVhXJqvKsElVpCcVzLlqhkjfs6A+6Ir94n+Ty0RazW6XRueHlvxvO1xXmD2LSk
        etMHA3QQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qulg0-00BRDp-9t; Mon, 23 Oct 2023 03:32:24 +0000
Date:   Mon, 23 Oct 2023 04:32:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <ZTXpSMF8Y1ePP9ba@casper.infradead.org>
References: <20231023133033.5d54f393@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023133033.5d54f393@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 01:30:33PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ftrace tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> arch/powerpc/kernel/setup-common.c:604:10: error: 'struct seq_buf' has no member named 'readpos'
>   604 |         .readpos = 0,

This would fix it.

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2f1026fba00d..34975532e44c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -601,7 +601,6 @@ struct seq_buf ppc_hw_desc __initdata = {
 	.buffer = ppc_hw_desc_buf,
 	.size = sizeof(ppc_hw_desc_buf),
 	.len = 0,
-	.readpos = 0,
 };
 
 static __init void probe_machine(void)


Steven, do you prefer fixup patches like this, or do you want a v3 that
includes this?
