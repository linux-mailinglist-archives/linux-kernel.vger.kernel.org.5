Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27077DD286
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346134AbjJaQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346284AbjJaQpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:45:25 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730B273D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:36:04 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4SKbNw3bKHz1r1sM;
        Tue, 31 Oct 2023 17:36:00 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4SKbNv719Xz1qqlW;
        Tue, 31 Oct 2023 17:35:59 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id gPAjuvIpFzIo; Tue, 31 Oct 2023 17:35:58 +0100 (CET)
X-Auth-Info: 7WVihqLGSDRZy2DvJB4lOgCCHp8jng0ZYt5id1i0l8Oow3unYQFAovJz6kwHdGof
Received: from igel.home (aftr-62-216-205-72.dynamic.mnet-online.de [62.216.205.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 31 Oct 2023 17:35:58 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 943A12C12E3; Tue, 31 Oct 2023 17:35:57 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nelson Chu <nelson@rivosinc.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH v7 1/3] riscv: Avoid unaligned access when relocating
 modules
In-Reply-To: <CAJM55Z-v0EwrZp876DdLSzad2u55nJV_uBs_+MUJDqFW5MTPkA@mail.gmail.com>
        (Emil Renner Berthing's message of "Tue, 31 Oct 2023 06:11:47 -0700")
References: <20231031-module_relocations-v7-0-6f4719b64bf7@rivosinc.com>
        <20231031-module_relocations-v7-1-6f4719b64bf7@rivosinc.com>
        <CAJM55Z-v0EwrZp876DdLSzad2u55nJV_uBs_+MUJDqFW5MTPkA@mail.gmail.com>
X-Yow:  Could I have a drug overdose?
Date:   Tue, 31 Oct 2023 17:35:57 +0100
Message-ID: <878r7iiwb6.fsf@igel.home>
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

On Okt 31 2023, Emil Renner Berthing wrote:

>> +static int riscv_insn_rmw(void *location, u32 keep, u32 set)
>> +{
>> +	u16 *parcel = location;
>> +	u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
>> +
>> +	insn &= keep;
>> +	insn |= set;
>> +
>> +	parcel[0] = cpu_to_le32(insn);
>
> Why cpu_to_le32(insn)? Unless I've misunderstood something downcasting unsigned
> to unsigned values in C (eg. from u32 to u16) is defined to always discard the
> most signifcant bits, so cpu_to_le16(insn) should be fine.

cpu_to_le32(insn) can't be right here anyway, since it also swaps the
two u16 halves and would be the same as cpu_to_le16(insn >> 16) on big
endian.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
