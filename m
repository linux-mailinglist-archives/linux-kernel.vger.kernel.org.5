Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7278E745
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbjHaHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHaHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:38:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA6CE7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:38:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 67BD11F461;
        Thu, 31 Aug 2023 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693467519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebgBG0RLwLmIMQg+1oRZIYWqmTbT4BUmYz+e+XMMGzs=;
        b=0QbxmE/kzjx494L3zHc49U3LYfBdeDSeV19g9gRQsdipWBT8+mBNZLgnXwdStzM95Kp5WR
        3J2wROppfuMqCLzGFvfUWEFjoOE42jKkqy3Ntm4hwOQ5KgWBJ2bVzDHzIbstSAQxllT+ei
        l5R/VQf7lD7tQ825RxNm5z3DOVTo4h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693467519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebgBG0RLwLmIMQg+1oRZIYWqmTbT4BUmYz+e+XMMGzs=;
        b=RJrcdxvJk6qcTzk9cik1uiQ2CjFIdbMpOuFL/XPRcr41qjbjuMWH+h4QuS0KeEZHVsz2M9
        6TBzWXoAua58WOCg==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id EAD3C2C142;
        Thu, 31 Aug 2023 07:38:38 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
        id DB03A4A0399; Thu, 31 Aug 2023 09:38:38 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mick@ics.forth.gr, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kexec: Cleanup riscv_kexec_relocate
In-Reply-To: <FBD24A55B409E4DF+71a45adc-2e20-ea3c-a8ea-7341862991c6@tinylab.org>
        (Song Shuai's message of "Thu, 31 Aug 2023 14:55:54 +0800")
References: <20230830063435.1105726-1-songshuaishuai@tinylab.org>
        <mvmmsy956xa.fsf@suse.de>
        <FBD24A55B409E4DF+71a45adc-2e20-ea3c-a8ea-7341862991c6@tinylab.org>
X-Yow:  Gibble, Gobble, we ACCEPT YOU ---
Date:   Thu, 31 Aug 2023 09:38:38 +0200
Message-ID: <mvmy1hr4q69.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31 2023, Song Shuai wrote:

> Hi, Andreas:
>
> 在 2023/8/30 15:24, Andreas Schwab 写道:
>> On Aug 30 2023, Song Shuai wrote:
>> 
>>> @@ -52,21 +42,27 @@ SYM_CODE_START(riscv_kexec_relocate)
>>>   	 * the start of the loop below so that we jump there in
>>>   	 * any case.
>>>   	 */
>>> -	la	s8, 1f
>>> -	sub	s8, s8, s7
>>> -	csrw	CSR_STVEC, s8
>>> +	la	s6, 1f
>>> +	sub	s6, s6, s4
>>> +	csrw	CSR_STVEC, s6
>>> +
>>> +	/*
>>> +	 * With C-extension, here we get 42 Bytes and the next
>>> +	 * .align directive would pad zeros here up to 44 Bytes.
>>> +	 * So manually put a nop here to avoid zeros padding.
>>> +	*/
>>> +	nop
>>>     	/* Process entries in a loop */
>>>   .align 2
>> While you are at it, I'd suggest being explicit about .palign
>> vs. .balign.
>> 
> How about this commemt:

My suggestion is to change .align 2 in the last line to .palign 2 as
part of the cleanup.  The meaning of .align is target dependent, and
someone not familiar with RISC-V may misinterpret it.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
