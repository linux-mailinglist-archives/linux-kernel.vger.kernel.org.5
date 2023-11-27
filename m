Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFC67F9DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjK0KmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjK0KmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:42:13 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43819A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:42:13 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Sf2GB1VjKz1qtrG;
        Mon, 27 Nov 2023 11:42:10 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4Sf2GB03Yzz1qqlc;
        Mon, 27 Nov 2023 11:42:09 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id tm617zSg7y19; Mon, 27 Nov 2023 11:42:09 +0100 (CET)
X-Auth-Info: +DnrhnZblEGlOzb3XeBn1Jt2rs2WUKWMccr42/2aPU5JxxGUkqgQeHc3hbITbzys
Received: from igel.home (aftr-62-216-205-201.dynamic.mnet-online.de [62.216.205.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 27 Nov 2023 11:42:09 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id CE2AA2C1CD6; Mon, 27 Nov 2023 11:42:08 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] riscv: Safely remove entries from relocation list
In-Reply-To: <20231122-module_linking_freeing-v3-1-8e9e412a3305@rivosinc.com>
        (Charlie Jenkins's message of "Wed, 22 Nov 2023 15:31:41 -0800")
References: <20231122-module_linking_freeing-v3-0-8e9e412a3305@rivosinc.com>
        <20231122-module_linking_freeing-v3-1-8e9e412a3305@rivosinc.com>
X-Yow:  Are we live or on tape?
Date:   Mon, 27 Nov 2023 11:42:08 +0100
Message-ID: <87bkbfzddr.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22 2023, Charlie Jenkins wrote:

> @@ -683,17 +700,29 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
>  
>  	if (!found) {
>  		rel_head = kmalloc(sizeof(*rel_head), GFP_KERNEL);
> +
> +		if (!rel_head)
> +			return -ENOMEM;
> +
>  		rel_head->rel_entry =
>  			kmalloc(sizeof(struct list_head), GFP_KERNEL);
> +
> +		if (!rel_head->rel_entry)
> +			return -ENOMEM;

This leaks rel_head on error.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
