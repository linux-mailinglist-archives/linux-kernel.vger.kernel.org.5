Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6CD7F5D34
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344903AbjKWLC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjKWLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:02:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C6D67;
        Thu, 23 Nov 2023 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1700737362;
        bh=uqbk3lyeqSjwPRhuNVxLOm4uc+e6PUbNsNGKGUbeIeg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iyceZfyQVViQ82WYOcVcZ3y8up/cjELd3RnGCnxCtDVEh/Zdegj+Tdx+Q6R9CdMR2
         ufdh6WYHbLsidP6MHaX27LNzygxAa4UQG3lxH0RJrtLXsxNggd3NFS67DNAra/5yzJ
         KtKZLWiLvuPFOaEQkqAZPXsfRceh7q/qS5GjjygijnLUR8AJgn++JFpcba1aH+Lp4x
         Kvgnz9wzcGN5Jff6NgAhZ/Gn2c1ZnP34y/764x88gSJC9YFj4o9kPHjN2KmXTmrpow
         HxbkjRbzEXlnzxSSvNVHJFxcL8aZ1mW9BoNz0iKYg0a1gnQBAoJv0ivTtNGxXgXByd
         0dtv+xpjv7WHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbZvh2jNPz4xRn;
        Thu, 23 Nov 2023 22:02:40 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Zhao Ke <ke.zhao@shingroup.cn>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, shenghui.qu@shingroup.cn,
        luming.yu@shingroup.cn, dawei.li@shingroup.cn
Subject: Re: [PATCH v1] powerpc: Add PVN support for HeXin C2000 processor
In-Reply-To: <2023112317-ebook-dreamless-0cfe@gregkh>
References: <20231123093611.98313-1-ke.zhao@shingroup.cn>
 <2023112317-ebook-dreamless-0cfe@gregkh>
Date:   Thu, 23 Nov 2023 22:02:35 +1100
Message-ID: <871qcgspf8.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Thu, Nov 23, 2023 at 05:36:11PM +0800, Zhao Ke wrote:
>> HeXin Tech Co. has applied for a new PVN from the OpenPower Community
>> for its new processor C2000. The OpenPower has assigned a new PVN
>> and this newly assigned PVN is 0x0066, add pvr register related
>> support for this PVN.
>> 
>> Signed-off-by: Zhao Ke <ke.zhao@shingroup.cn>
>> Link: https://discuss.openpower.foundation/t/how-to-get-a-new-pvr-for-processors-follow-power-isa/477/10
>> ---
>> 	v0 -> v1:
>> 	- Fix .cpu_name with the correct description
>> ---
>> ---
>>  arch/powerpc/include/asm/reg.h            |  1 +
>>  arch/powerpc/kernel/cpu_specs_book3s_64.h | 15 +++++++++++++++
>>  arch/powerpc/kvm/book3s_pr.c              |  1 +
>>  arch/powerpc/mm/book3s64/pkeys.c          |  3 ++-
>>  arch/powerpc/platforms/powernv/subcore.c  |  3 ++-
>>  drivers/misc/cxl/cxl.h                    |  3 ++-
>>  6 files changed, 23 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index 4ae4ab9090a2..7fd09f25452d 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -1361,6 +1361,7 @@
>>  #define PVR_POWER8E	0x004B
>>  #define PVR_POWER8NVL	0x004C
>>  #define PVR_POWER8	0x004D
>> +#define PVR_HX_C2000	0x0066
>>  #define PVR_POWER9	0x004E
>>  #define PVR_POWER10	0x0080
>>  #define PVR_BE		0x0070
>
> Why is this not in sorted order?

It's semantically sorted :D

ie. HX_C2000 is most similar to POWER8, but is newer than it.

PVR_BE is out of place, I'll fix that.

cheers
