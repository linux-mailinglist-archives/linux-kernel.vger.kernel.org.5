Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98878BEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjH2Gqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjH2Gqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:46:35 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E92CE7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1693291545;
        bh=5AkBjHkJ4WI+1x5Ygt8sxJSWjs6pPOabw9NZYf8A9v4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KB/0HVmMhPzCzyfrCRhogior74gf0wAipL3ZWHvmfYauDvpn7IzO6ucKj3nv6W+KC
         p6EUft8iVmSZjC0BRFde19VIRreOuy3iO0ee7l2JoCHBlXb+3YTyHbHmDTJErzzrbE
         PHgL/d3w4GiCyd2L4LVHNXrUiSDFUKb+ZRWBpTyI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E22B56599B;
        Tue, 29 Aug 2023 02:45:43 -0400 (EDT)
Message-ID: <b826520103c7462b0c2f10a7bc69347799d1217b.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Define the symbol fault as a local label in
 fpu.S
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Date:   Tue, 29 Aug 2023 14:45:42 +0800
In-Reply-To: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
References: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-29 at 14:28 +0800, Tiezhu Yang wrote:
> The initial aim is to silence the following objtool warnings:
>=20
> =C2=A0 arch/loongarch/kernel/fpu.o: warning: objtool: _save_fp_context() =
falls through to next function fault()
> =C2=A0 arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp_context=
() falls through to next function fault()
> =C2=A0 arch/loongarch/kernel/fpu.o: warning: objtool: _save_lsx_context()=
 falls through to next function fault()
> =C2=A0 arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx_contex=
t() falls through to next function fault()
> =C2=A0 arch/loongarch/kernel/fpu.o: warning: objtool: _save_lasx_context(=
) falls through to next function fault()
> =C2=A0 arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx_conte=
xt() falls through to next function fault()
>=20
> Obviously, the symbol fault is not a function, it is just a local label,

Hmm why?  To me this seems a function.  We don't branch to it but store
its address (a "function pointer") in the extable.

And these warnings do not make any sense to me:

/* snip */

> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index b4032de..7defe50 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -521,7 +521,7 @@ SYM_FUNC_START(_restore_lasx_context)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jr=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0ra

_restore_lasx_context returns with this instruction.  How can it fall
through into fault?

> =C2=A0SYM_FUNC_END(_restore_lasx_context)

> -SYM_FUNC_START(fault)
> +SYM_CODE_START_LOCAL(fault)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0li.w=C2=A0=C2=A0=C2=A0=C2=
=A0a0, -EFAULT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# failure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0jr=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0ra
> -SYM_FUNC_END(fault)
> +SYM_CODE_END(fault)

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
