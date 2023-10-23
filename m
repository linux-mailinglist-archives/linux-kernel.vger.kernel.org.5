Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6B7D28A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjJWCmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJWCmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:42:46 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30613E
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:42:44 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39N2fuu22514359
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 22 Oct 2023 19:41:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39N2fuu22514359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023101201; t=1698028917;
        bh=/FyxLFJpdyGgPFlWMuscXJXr9IiE9nMwl9kTBhkCwbk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=CJWoyCAsAV8zCdBdlvxqgHxpb8s2yvUrvNiDW2/LACkmc2iFhjqIbMHF7fu2sJ1uR
         6kdrLV5CHAzkkjoHIy00F4Tex/14tAxWyB3/XWsAFldqXZuphkIeFP/OgoJfQS0Y7W
         wgxh4ORNZ8emuie/W5eC1OSj8QZRdB21I53ziCNe5Dm9/iFGENkLUdBubp9qOVVbux
         3qzUYt0boIvL/zARtpsLyU8C9dBHiYRF0/Wa4iAGfLm0iDeFVJX5+5hNMJswiNXPBa
         iS5H/XOod+1ZZq2X5TM5qCnlAzd7U/JXlp9lT4HIY29yQqbxgllqqt9s5KR33LFNUZ
         6TH8hkSwkk7hw==
Date:   Sun, 22 Oct 2023 19:41:54 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     John Sperbeck <jsperbeck@google.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Zac Tang <zactang@google.com>, Cloud Hsu <cloudhsu@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
User-Agent: K-9 Mail for Android
In-Reply-To: <20231023023121.1464544-1-jsperbeck@google.com>
References: <20231023023121.1464544-1-jsperbeck@google.com>
Message-ID: <4FDF6E7A-C6E2-415D-A82B-342DAE6BD561@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 22, 2023 7:31:21 PM PDT, John Sperbeck <jsperbeck@google=2Ecom> =
wrote:
>The physical memory range that kexec selects for the compressed
>bzimage target kernel, might not be where it runs from=2E  The
>startup_64() code in head_64=2ES copies itself out of the way
>before the decompression so it doesn't clobber itself=2E
>
>If the start of the memory range selected by kexec is above
>LOAD_PHYSICAL_ADDR (0x01000000 by default), then the copy remains
>within the memory area=2E  But if the start is below this range,
>then the copy will likely end up outside the range=2E
>
>Usually, this will be harmless because not much memory is in use
>at the time of the pre-decompression copy, so there is little
>to accidentally clobber=2E  However, an unlucky choice for the
>adress of the kernel and the initrd could put the initrd in harm's
>way=2E  For example:
>
>    0x00400000 - physical address for target kernel
>    0x03ff8000 - physical address of seven-page initrd
>    0x0302c000 - size of uncompressed kernel (about 50 Mbytes)
>
>The decompressed kernel will span 0x01000000 through 0x0402c000,
>which will overwrite the initrd=2E
>
>If the kexec code restricts itself to physical addresses above
>0x01000000, then the pre-decompression copy and the decompression
>itself will stay within the bounds of the memory kexec selected
>(unless a non-default value is used in the target kernel for
>CONFIG_PHYSICAL_START, which will change LOAD_PHYSICAL_ADDR,
>but that's probably unsolvable unless the target kernel were to
>somehow communicate this to kexec)=2E
>
>Signed-off-by: John Sperbeck <jsperbeck@google=2Ecom>
>---
> arch/x86/kernel/kexec-bzimage64=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/kexec-bzimage64=2Ec b/arch/x86/kernel/kexec-=
bzimage64=2Ec
>index a61c12c01270=2E=2Ed6bf6c13dab1 100644
>--- a/arch/x86/kernel/kexec-bzimage64=2Ec
>+++ b/arch/x86/kernel/kexec-bzimage64=2Ec
>@@ -36,7 +36,7 @@
>  */
> #define MIN_PURGATORY_ADDR	0x3000
> #define MIN_BOOTPARAM_ADDR	0x3000
>-#define MIN_KERNEL_LOAD_ADDR	0x100000
>+#define MIN_KERNEL_LOAD_ADDR	0x1000000
> #define MIN_INITRD_LOAD_ADDR	0x1000000
>=20
> /*

This doesn't make any sense to me=2E There is already a high water mark fo=
r his much memory the kernel needs until an initrd or setup_data item can a=
ppear=2E This is just a hack, please fix it properly=2E
