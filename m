Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D07F6C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjKXGSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKXGSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:18:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2B52D66
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 22:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i3N5b877wwqEXJcttr8x40Ktc1dX/olxiJWVssayIyw=; b=Sho5UVclWCF9mc8IXFMKVdM4wQ
        CL50tQt3DDPm88wweleeVf0oPoA7dRFLPole6BIEavVFYyp6RYgTfuG0MiMQhLL/CuVvKUHbKcL6j
        WEynwjOBpdyUi7Q7/ChZ6XV2/K6wxBLG5BVGi8liPYppJGwM/GPU0rGxVrVOq4zxXu3lA09nNLmAi
        JghIAFfNmusCy32yGgd4VE9QR6cuZ1dBuN9IwOAh/ChJRLKXNTlKjokMTE/zDx1L/OtTv+TPoI4Fx
        Wp8WVQ5wjqZHZSoiOG0VYlekf7s/bZDknI0TNdWcZ0Kc9/MIaV+eV0ts4zGko9YeDr04wfHh0pVCz
        XerJv5ng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PJX-006F9E-2z;
        Fri, 24 Nov 2023 06:05:19 +0000
Date:   Thu, 23 Nov 2023 22:05:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] riscv: fix __user annotation in traps_misaligned.c
Message-ID: <ZWA9HwUNHDFIw0wP@infradead.org>
References: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:16:17PM +0000, Ben Dooks wrote:
> @@ -319,7 +319,7 @@ static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
>  static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
>  {
>  	if (user_mode(regs)) {
> -		return __get_user(*r_val, addr);
> +		return __get_user(*r_val, (u8 __user *)addr);
>  	} else {
>  		*r_val = *addr;
>  		return 0;

This is the wrong way to approach it.  Pass the untype unsigned long
from the caller instead and do a single round of casts from that
depending on the address_space.

And please also remove this horrible else after return entipattern
while you're at it.

