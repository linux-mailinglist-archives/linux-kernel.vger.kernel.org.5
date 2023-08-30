Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17A78DF61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbjH3TVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbjH3HYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:24:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4F1BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:24:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5135121860;
        Wed, 30 Aug 2023 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693380274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axaL9ZP5OcS0CsYrai2CnzHIn/ti9r5RP/T3400Brzo=;
        b=segRofjBOjlgR5b4WEGTYP/15oWV7e3e52dWOMo2ydQiaDlf4xEgW9IkBH/srEr66OKYoT
        n1hyAx2RjCDw/RL6/jfPQZPL7vN3RvDl8qh1YmxXg1mnMT5xJ9lcNx61koF8A3OadduFCB
        qdttRyrKAjkvw5C782F1bmKn0gxFfrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693380274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axaL9ZP5OcS0CsYrai2CnzHIn/ti9r5RP/T3400Brzo=;
        b=ljRs8UXjvGxGJvoXN9gpt0j+FVCZg3sBwuUCgfsmdmuRGsF4tI62+qmaTgVOZdUyFK2HX6
        LXEwJbISgzRpwGDQ==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id B54F22C142;
        Wed, 30 Aug 2023 07:24:33 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
        id A416E4A0399; Wed, 30 Aug 2023 09:24:33 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mick@ics.forth.gr, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kexec: Cleanup riscv_kexec_relocate
In-Reply-To: <20230830063435.1105726-1-songshuaishuai@tinylab.org> (Song
        Shuai's message of "Wed, 30 Aug 2023 14:34:35 +0800")
References: <20230830063435.1105726-1-songshuaishuai@tinylab.org>
X-Yow:  They collapsed....  like nuns in the street...
 they had no teen appeal!
Date:   Wed, 30 Aug 2023 09:24:33 +0200
Message-ID: <mvmmsy956xa.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30 2023, Song Shuai wrote:

> @@ -52,21 +42,27 @@ SYM_CODE_START(riscv_kexec_relocate)
>  	 * the start of the loop below so that we jump there in
>  	 * any case.
>  	 */
> -	la	s8, 1f
> -	sub	s8, s8, s7
> -	csrw	CSR_STVEC, s8
> +	la	s6, 1f
> +	sub	s6, s6, s4
> +	csrw	CSR_STVEC, s6
> +
> +	/*
> +	 * With C-extension, here we get 42 Bytes and the next
> +	 * .align directive would pad zeros here up to 44 Bytes.
> +	 * So manually put a nop here to avoid zeros padding.
> +	*/
> +	nop
>  
>  	/* Process entries in a loop */
>  .align 2

While you are at it, I'd suggest being explicit about .palign
vs. .balign.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
