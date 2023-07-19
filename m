Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49173758ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGSHW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGSHWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:22:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE992210D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:21:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C4C6D1F8BF;
        Wed, 19 Jul 2023 07:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689751306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hONm7Ls/e2QRNpgmgKsoRqqEthuvFVO93IbQBRvgv9E=;
        b=vON1rA7MNMPoAvcVN8XrUGucsMdIblZ14wP5bnlBdDYDP5NlTVh0nX0NcxwJWhcEVo6Dkd
        TlP79NH4jZ8qUCTadE8zjpMR3spSVY5//fKwBX2U8t6jx+MlI4LK9SGXamfVgIGi+gD1+G
        gnHrE3dPf6qDI9hNL4ofmlwn7ZSkvT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689751306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hONm7Ls/e2QRNpgmgKsoRqqEthuvFVO93IbQBRvgv9E=;
        b=qftf+9G9cWwBYSlw4Umga0Mpci0c8TLY/8CbzPxBiFYzKjqwcAyVYHfPkYL9bfTOkLMq07
        C49uYvWWthH9ohCg==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id DCB532C142;
        Wed, 19 Jul 2023 07:21:43 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
        id BEAAF4A09FF; Wed, 19 Jul 2023 09:21:43 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Celeste Liu <coelacanthushex@gmail.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: Re: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
In-Reply-To: <20230718210037.250665-1-CoelacanthusHex@gmail.com> (Celeste
        Liu's message of "Wed, 19 Jul 2023 04:57:30 +0800")
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com>
X-Yow:  I'm receiving a coded message from EUBIE BLAKE!!
Date:   Wed, 19 Jul 2023 09:21:43 +0200
Message-ID: <mvmo7k8cqns.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 19 2023, Celeste Liu wrote:

> @@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		if (syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
> -		else
> +		else if ((long)syscall != -1L)

You can also use syscall != -1UL or even syscall != -1.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
