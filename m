Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C17B7D0DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376941AbjJTKrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377168AbjJTKrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:47:08 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C792707
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1697798756;
        bh=nfBnGhYJ5nTVpGtNot+ccu217gvsTSZcpqyIbJ5SNno=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FsDnEWZstoHAyPtaA8IZgbliKyj3niakr5++vfQvgtLJqA06Djx0gpI8/Zlh5OZmJ
         WKnSFQThqMHP3EBcdPWPQQ7LdR9ESNCZ2z3U1ZRCFPIfZ5ztuZpNFN7DCFSePGyOy8
         jSXeaCQUwOMvkdCijqxV34ClVd7CkiEHTD1BBOG0=
Received: from [192.168.124.14] (unknown [113.140.11.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id C12B966AA2;
        Fri, 20 Oct 2023 06:45:54 -0400 (EDT)
Message-ID: <23a3ebe302f77db630edc52b23afb812f31f103e.camel@xry111.site>
Subject: Re: [PATCH v3 0/8] Add objtool and orc support for LoongArch
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Date:   Fri, 20 Oct 2023 18:45:48 +0800
In-Reply-To: <a967ebeb-f19d-4e36-3547-80e838ad2fa0@loongson.cn>
References: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
         <CAAhV-H4wqO0=+EOhyH+t=0bpiX2DayddVArB=x_yzVvmX9OW1g@mail.gmail.com>
         <a967ebeb-f19d-4e36-3547-80e838ad2fa0@loongson.cn>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 18:28 +0800, Tiezhu Yang wrote:
> On 10/20/2023 04:51 PM, Huacai Chen wrote:
> > Cross compiling on X86 for LoongArch fails:
> >=20
> > =C2=A0=C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> > =C2=A0=C2=A0 DESCEND objtool
> > make[5]: *** No rule to make target
> > '/usr/lib/gcc/x86_64-redhat-linux/8/include/stdbool.h', needed by
> > '/home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/exec-cmd.o=
'.
> > Stop.
> > make[4]: *** [Makefile:80:
> > /home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd-i=
n.o]
> > Error 2
> > make[3]: *** [Makefile:82:
> > /home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd.a=
]
> > Error 2
> > make[2]: *** [Makefile:73: objtool] Error 2
> > make[1]: *** [/home/chenhuacai/linux-official.git/Makefile:1355:
> > tools/objtool] Error 2
> > make: *** [Makefile:234: __sub-make] Error 2
>=20
> It seems that there is no stdbool.h in your cross compile environment.
>=20
> It works well with the following steps, you can try it.

/* snip */

> find /opt -name stdbool.h
> /opt/cross-tools/lib/gcc/loongarch64-unknown-linux-gnu/14.0.0/include/std=
bool.h
> /opt/cross-tools/loongarch64-unknown-linux-gnu/include/c++/14.0.0/tr1/std=
bool.h

The problem is HOSTCC cannot find stdbool.h, not (target) CC.  So these
two files are not relevant.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
