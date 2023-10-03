Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88D27B7392
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjJCV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjJCV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:56:34 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD76FA6;
        Tue,  3 Oct 2023 14:56:29 -0700 (PDT)
Received: from [IPv6:::1] ([172.56.208.25])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 393LuLfx1774372
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 3 Oct 2023 14:56:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 393LuLfx1774372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1696370182;
        bh=JGXoPDpVIwpDAQlAmBH7cVkr1uUMtGdTK2Hqhc1cWn4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=eTdINgIeNHw/7g3Si2TcTTh7m6TFd3tOiAe9TwxyLGQX9E/EJQl0PUtSg07F+iO17
         aolP4DVZLJoJSvmWlt8an9bvhlKUsdt4giue8oz+YjS27W/8mJdR/mnItouUlQAHh+
         ibLnCi7D/OVgUg4XdX85OsQrPteYqvkr2smMXvTWYE842FUSagdJSNO6FjJR/xcE05
         T18QWXwcQ6iNEGtH2hBFsmawVxQL6mEz+FRgDOMRiekbBcapSXPQhjXhxZJO/Divi8
         DfsIheb0tlYCShJVxIGZM1sNMSuog9DPTSpj9lsmBjkHtDqC8YGFyK25mWrl15Ohm7
         55LmKyABtEl3A==
Date:   Tue, 03 Oct 2023 14:56:09 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     linux-kernel@vger.kernel.org,
        tip-bot2 for Yuntao Wang <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC:     Yuntao Wang <ytcoode@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Fix incorrect startup_gdt_descr.size
User-Agent: K-9 Mail for Android
In-Reply-To: <169632239730.3135.5499875554711156270.tip-bot2@tip-bot2>
References: <20230807084547.217390-1-ytcoode@gmail.com> <169632239730.3135.5499875554711156270.tip-bot2@tip-bot2>
Message-ID: <CBF7285B-C6F9-4539-ADA2-A626EAE1A73F@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 3, 2023 1:39:57 AM PDT, tip-bot2 for Yuntao Wang <tip-bot2@linut=
ronix=2Ede> wrote:
>The following commit has been merged into the x86/boot branch of tip:
>
>Commit-ID:     001470fed5959d01faecbd57fcf2f60294da0de1
>Gitweb:        https://git=2Ekernel=2Eorg/tip/001470fed5959d01faecbd57fcf=
2f60294da0de1
>Author:        Yuntao Wang <ytcoode@gmail=2Ecom>
>AuthorDate:    Mon, 07 Aug 2023 16:45:47 +08:00
>Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>CommitterDate: Tue, 03 Oct 2023 10:28:29 +02:00
>
>x86/boot: Fix incorrect startup_gdt_descr=2Esize
>
>Since the size value is added to the base address to yield the last valid
>byte address of the GDT, the current size value of startup_gdt_descr is
>incorrect (too large by one), fix it=2E
>
>[ mingo: This probably never mattered, because startup_gdt[] is only used
>         in a very controlled fashion - but make it consistent neverthele=
ss=2E ]
>
>Fixes: 866b556efa12 ("x86/head/64: Install startup GDT")
>Signed-off-by: Yuntao Wang <ytcoode@gmail=2Ecom>
>Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>Link: https://lore=2Ekernel=2Eorg/r/20230807084547=2E217390-1-ytcoode@gma=
il=2Ecom
>---
> arch/x86/kernel/head64=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/kernel/head64=2Ec b/arch/x86/kernel/head64=2Ec
>index 49f7629=2E=2Ebbc2179 100644
>--- a/arch/x86/kernel/head64=2Ec
>+++ b/arch/x86/kernel/head64=2Ec
>@@ -80,7 +80,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] =3D =
{
>  * while the kernel still uses a direct mapping=2E
>  */
> static struct desc_ptr startup_gdt_descr =3D {
>-	=2Esize =3D sizeof(startup_gdt),
>+	=2Esize =3D sizeof(startup_gdt)-1,
> 	=2Eaddress =3D 0,
> };
>=20

Well, it never mattered because there wasn't enough space at the end for a=
n extra entry, but it is still Technically Correct=E2=84=A2=2E
