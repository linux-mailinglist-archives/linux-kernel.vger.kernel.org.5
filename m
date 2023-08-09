Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE05775E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjHILwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjHILwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:52:01 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A4196
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1691581918;
        bh=FXRfUXGd2rFM2eDblJy+lJeshZKsKGXJHpID2161kOk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BI60Fa2uZO0GeJOSS4LS3Az3RXy0EB0C0QDnXbdoOvTVMrb86c3iosRvuG72h6oML
         O+NzlnrAWY9Ja8PQ4kREwdW2tay+ix3yYMmF9lddryGQBZugSERvUYdrexrE4Pfjki
         LZrqErGqo0l+Lq0qnP2KDH2AvH6R30sWHSsPYBkM=
Received: from [IPv6:2409:8a0c:2a4:2170:40dc:a500:81f0:2] (unknown [IPv6:2409:8a0c:2a4:2170:40dc:a500:81f0:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B1CAC659AD;
        Wed,  9 Aug 2023 07:51:52 -0400 (EDT)
Message-ID: <b6b596a1311d9a26e19ee831a2f8161c175c4ad6.camel@xry111.site>
Subject: Re: [PATCH v1 5/6] objtool: Add skipped member in struct reloc
From:   Xi Ruoyao <xry111@xry111.site>
To:     Peter Zijlstra <peterz@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Wed, 09 Aug 2023 19:51:35 +0800
In-Reply-To: <20230803121103.GE214207@hirez.programming.kicks-ass.net>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
         <1690272910-11869-6-git-send-email-yangtiezhu@loongson.cn>
         <20230725115959.GE3765278@hirez.programming.kicks-ass.net>
         <b111cb87-3f30-860a-640b-2f7264a16838@loongson.cn>
         <20230803121103.GE214207@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-03 at 14:11 +0200, Peter Zijlstra wrote:
> On Thu, Aug 03, 2023 at 07:36:24PM +0800, Tiezhu Yang wrote:
>=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
".long " __stringify_label(c) "b - .\n\t"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
>=20
> > I discussed offline with the engineers who are familiar with gnu
> > assembler of LoongArch, maybe it can modify the gnu assembler
> > to use R_LARCH_32_PCREL to replace a pair of R_LARCH_ADD32 and
> > R_LARCH_SUB32, then I will test it again and drop this change if
> > possible.

Hmm, but I don't like the idea to disallow users having GAS <=3D 2.41 from
using ORC unwinder.

Can we emit the R_LARCH_32_PCREL reloc with an explicit .reloc
directive?

> Yes, this is exactly what PC relative relocations are for.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
