Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B377150C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHFMcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHFMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A8114;
        Sun,  6 Aug 2023 05:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4AC6108D;
        Sun,  6 Aug 2023 12:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC15C433C7;
        Sun,  6 Aug 2023 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691325114;
        bh=VLwj9EaXv+Fvvx85CZU4JjWoolXLJ0yM8fecfAPaf5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=INAA8BSr90XipNSGW0JRg0PjktcyyUvVFfH6S0Ek6xBC99L22thuVIfxHTQO+t2aH
         oIheQcMAgoYaxRJvlLBRYQ/Z7niaLtSSP4c+VnTFZPxRHbsMcO8r/fcgyHFVePxp3l
         zJP8cFTpXUCmPNXc9S2vv+rl/J3IgtUie5u0viOR45/zLLoS8QtmLS3Mh9281JDNlX
         x5kVIf2SWoqkrA1mZ4NuKC/v0BlNUc2fdd6Ip++dRTzSPePQ5uXTTM9mOer87EW2V2
         Rvd/VpSSkBid0R9FUtvJEI9ffc45PZvtWZgpRpoM5EBNi+8i8/gVaw9VWuaY+Ffpl7
         Kf3zlDkXrGJww==
Date:   Sun, 6 Aug 2023 21:31:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: confused about kprobes
Message-Id: <20230806213150.5571b4a7f4a0531fcb00f689@kernel.org>
In-Reply-To: <ZM+BhEz9u7hrWe6e@nam-dell>
References: <ZM+BhEz9u7hrWe6e@nam-dell>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nam,

On Sun, 6 Aug 2023 13:18:28 +0200
Nam Cao <namcaov@gmail.com> wrote:

> Hello,
> 
> I am struggling to understand how kprobes works. It would be very nice if someone
> can spare the time to explain to me. I'm confused about this function in particular:
> 
> /*
>  * Return an optimized kprobe whose optimizing code replaces
>  * instructions including 'addr' (exclude breakpoint).
>  */
> static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
> {
> 	int i;
> 	struct kprobe *p = NULL;
> 	struct optimized_kprobe *op;
> 
> 	/* Don't check i == 0, since that is a breakpoint case. */
> 	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> 		p = get_kprobe(addr - i);
> 
> 	if (p && kprobe_optready(p)) {
> 		op = container_of(p, struct optimized_kprobe, kp);
> 		if (arch_within_optimized_kprobe(op, addr))
> 			return p;
> 	}
> 
> 	return NULL;
> }
> 
> The document mentions something about optimizing by replacing trap instructions
> with jump instructions, so I am assuming this function is part of that.

Yes, you're right. 

> But I
> fail to see what this function is trying to do exactly. The for loop seems to
> call get_kprobe at addresses immediately before "addr". But what for? What are
> at addresses before "addr"?

This is for finding a jump optimized kprobe which will modify the instruction
pointed by 'addr'. As you may know, on x86, the software-breakpoint
instruction is 1 byte, but the jump will be 5 bytes. In that case, if we put
something at instruction including 'addr', it will be ignored or it will break
the jump instruction. So it is used for finding such optimized kprobe.

For the kprobe, the jump optimization is optional and hidden from the user. We
should prioritize adding kprobes at specified locations over optimization.
Thus if we find such optimized kprobe, it must be unoptimized.

> 
> Can someone be so kind to give me a line-by-line explanation of this function?

> 	/* Don't check i == 0, since that is a breakpoint case. */
> 	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> 		p = get_kprobe(addr - i);

This tries to find any kprobe before the given addr whcih is possible to be
optimized.

> 
> 	if (p && kprobe_optready(p)) {

If there is a kprobe and that is ready for optimizing (including optimized)

> 		op = container_of(p, struct optimized_kprobe, kp);

convert the kprobe to optimized-kprobe and,

> 		if (arch_within_optimized_kprobe(op, addr))

check whether the optimized kprobe jump modification area is including 'addr'.

> 			return p;

If so, return the found kprobe.

> 	}

Thank you,


> 
> Thanks!
> 
> Nam


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
