Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF02B771D07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjHGJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjHGJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:21:22 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46C1703;
        Mon,  7 Aug 2023 02:21:17 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 05B42103.A9A9A
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 05B42103;
        Mon,  7 Aug 2023 11:21:14 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691400073;
        bh=pVmZuIzag398flw4SkU/Ks3/qpR3wQd+pxQKgYORXPg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ms7/Ke76H8j4jeSWuhdpKC9gQ8DvXYKuleAlmShPCRq2JMc2WkqOGzyUbHZV9saen
         QwBsJPlGe5KlXeHUQBzHgcqlpd66GPc9iR32RYDhuWA9h9236L4UKxkeTHMFe9OlKs
         nZgxlQvl8i4ErR7vf9BSUDMr6DCjt8r0YivYz/OY=
Received: from [192.168.44.147] (unknown [77.241.232.19])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id AF16ED4F64AC2;
        Mon,  7 Aug 2023 11:21:13 +0200 (CEST)
Message-ID: <f0e29d32-286d-8973-dc34-93f1d8005787@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 11:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] selftests/sgx: Ensure correct secinfo struct
 alignment in test enclave.
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-4-jo.vanbulck@cs.kuleuven.be>
 <4f4c7b98a707a7d5916d8e62681cc1a4b772dde4.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <4f4c7b98a707a7d5916d8e62681cc1a4b772dde4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 06:00, Huang, Kai wrote:> We already have __aligned.  Can 
you provide more information in what
> circumstances that __aligned isn't enough to guarantee the alignment?
> 
> We have a lot of kernel code which has __aligned but doesn't have volatile.

Thank you. I also dug deeper into this and the proper fix is indeed not 
to make the variable volatile.

The real problem is that the inline assembly does not have the "memory" 
clobber to tell the compiler that the "assembly code performs memory 
reads or writes to items other than those listed in the input and output 
operands (for example, accessing the memory pointed to by one of the 
input parameters)" [1].

I checked that, depending on the optimizations and compiler (gcc vs 
clang), the compiler may indeed reorder the write to secinfo.flags to 
_after_ the inline asm block. Declaring secinfo as volatile fixed that, 
but the proper fix is of course to properly include a "memory" clobber 
for the asm block.

I'll include a fix to include a "memory" clobber for the inline asm 
block in the next patch revision.

[1] 
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers-1
