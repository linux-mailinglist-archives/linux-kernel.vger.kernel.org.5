Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AA9777F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbjHJRWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjHJRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0EA270A;
        Thu, 10 Aug 2023 10:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C97BC6649A;
        Thu, 10 Aug 2023 17:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7251C433C7;
        Thu, 10 Aug 2023 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691688169;
        bh=/pIjiu0uvnZYpRPBi219eWRbEc6h/Stq3OzO7FTbMhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8M0sFbkMVGd8rEicSBj1VPTL8iPWlIZ/WH/0r3GP4VxwmQhlMYA0jH9CRduGYpYn
         auKAoeHFMxVSPaOEedOQwKOvnAJz3AvCV6gWY96XNsqu6pE2E/3cMyGQrMT7XkE0PG
         G/8cz+QGRiwU14HPSqxeYbMaHZMjToq6h7Pn8TajPxLQlxanuWM2Cx2VAKS0RxeG7Y
         rn53ecsFphbd2oRKZaFqxcRFK7TO+rLWhUendWQ50gy+S5aymabhOMmBX27aa1sJqQ
         tZzuYJ/6v4jO6UVKQMkbTS9EVeVGXY9EeWGvgCb3YszFnLaAIEIw665yE1y26irbWM
         NzgsdUn9PIG8w==
Date:   Thu, 10 Aug 2023 10:22:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
Message-ID: <20230810102247.699ddc14@kernel.org>
In-Reply-To: <7c44c161-9c86-8c60-f031-6d77d6c28c20@huawei.com>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
        <20230809070302.GR94631@unreal>
        <7c44c161-9c86-8c60-f031-6d77d6c28c20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 15:45:50 +0800 Jijie Shao wrote:
> on 2023/8/9 15:03, Leon Romanovsky wrote:
> > On Wed, Aug 09, 2023 at 10:09:02AM +0800, Jijie Shao wrote: =20
> >> From: Hao Chen <chenhao418@huawei.com>
> >>
> >> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate s=
ome
> >> items to a string for content, and we add '\n' and '\0' in the last
> >> two bytes of content.
> >>
> >> strscpy() will add '\0' in the last byte of destination buffer(one of
> >> items), it result in finishing content print ahead of schedule and some
> >> dump content truncation.
> >>
> >> One Error log shows as below:
> >> cat mac_list/uc
> >> UC MAC_LIST:
> >>
> >> Expected:
> >> UC MAC_LIST:
> >> FUNC_ID  MAC_ADDR            STATE
> >> pf       00:2b:19:05:03:00   ACTIVE
> >>
> >> The destination buffer is length-bounded and not required to be
> >> NUL-terminated, so just change strscpy() to memcpy() to fix it. =20
> > I think that you should change to strtomem() and not use plain memcpy().
> >
> > Thanks =20
>=20
> Hi:
>=20
> We tried to replace memcpy with strtomem, but errors was reported during=
=20
> compilation:
> /kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In=20
> function =E2=80=98hclge_dbg_fill_content.part.0=E2=80=99:
> /kernel/include/linux/compiler_types.h:397:38: error: call to=20
> =E2=80=98__compiletime_assert_519=E2=80=99 declared with attribute error:=
 BUILD_BUG_ON=20
> failed: !__builtin_constant_p(_dest_len) || _dest_len =3D=3D (size_t)-1
>  =C2=A0 397 |=C2=A0 _compiletime_assert(condition, msg, __compiletime_ass=
ert_,=20
> __COUNTER__)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> /kernel/include/linux/compiler_types.h:378:4: note: in definition of=20
> macro =E2=80=98__compiletime_assert=E2=80=99
>  =C2=A0 378 |=C2=A0=C2=A0=C2=A0 prefix ## suffix();=C2=A0=C2=A0=C2=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 ^~~~~~
> /kernel/include/linux/compiler_types.h:397:2: note: in expansion of=20
> macro =E2=80=98_compiletime_assert=E2=80=99
>  =C2=A0 397 |=C2=A0 _compiletime_assert(condition, msg, __compiletime_ass=
ert_,=20
> __COUNTER__)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 ^~~~~~~~~~~~~~~~~~~
> /kernel/include/linux/build_bug.h:39:37: note: in expansion of macro=20
> =E2=80=98compiletime_assert=E2=80=99
>  =C2=A0=C2=A0 39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert=
(!(cond),=20
> msg)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~
> /kernel/include/linux/build_bug.h:50:2: note: in expansion of macro=20
> =E2=80=98BUILD_BUG_ON_MSG=E2=80=99
>  =C2=A0=C2=A0 50 |=C2=A0 BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed=
: " #condition)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 ^~~~~~~~~~~~~~~~
> /kernel/include/linux/string.h:302:2: note: in expansion of macro=20
> =E2=80=98BUILD_BUG_ON=E2=80=99
>  =C2=A0 302 |=C2=A0 BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||=C2=
=A0 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 ^~~~~~~~~~~~
> /kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:115:4:=
=20
> note: in expansion of macro =E2=80=98strtomem=E2=80=99
>  =C2=A0 115 |=C2=A0=C2=A0=C2=A0 strtomem(pos, result[i]);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 ^~~~~~~~
>=20
> In the strtomem macro, __builtin_object_size is used to calculate the=20
> _dest_len.
> We tried to print the _dest_len directly, and the result was -1.
> How can we solve this?

Let's add Kees in case he has a immediate recommendation on use of
strtomem() vs memcpy() for this case..
