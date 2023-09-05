Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64523792D82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjIESlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbjIESk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:40:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8084DCA;
        Tue,  5 Sep 2023 11:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63522B811F0;
        Tue,  5 Sep 2023 17:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF91EC433C9;
        Tue,  5 Sep 2023 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693933317;
        bh=mThYv1c/WI3ngnEzjtqtEjf2q7BjLiPOQqRT8IGrZOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RcbSxa3jHO8JUcpi+WHHVSy/m6ZYdQiKimofL7kfdfqHUZ+TrAsRdEGOY3EIFpGjv
         zMy9pCsxQXD+//9DJ9RvNQcvi7xkruPsSkfuKdL1hRq1aZOjS8CRIIHCbhK28k80s1
         fxG+sycfULbyqNQWEm5dXJA/65lQhr0Cp5ldiIyr95BfUoe+SwLhioyMlCSyCk6756
         48RTssiFRCztDtkPCjH87wfyHvQ8L5An0w8fLIDb1kp2AWB8mphF03UjNPJJQEl44b
         Px0RT45NDY7vzyzqTf/XO9THN+m6AngW1SRBLxpbivox+wSl0kI8qQN+9NHaJiiUS3
         3bMzZ2LQDCePQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5739965a482so25036eaf.0;
        Tue, 05 Sep 2023 10:01:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz1159ubDxukKAZD7OU2Anp3tkFj6eTZ2qEsB8yb6ye02BYEg1p
        MdwZfumninS0xVAZevV6SpKpry4oiTDiz5EI5+M=
X-Google-Smtp-Source: AGHT+IFAK4dtzb++2HWZ/ZhTysfNhvI2JjVyiO8c/8f7djVX6k7wZRKWpl70eMohMUoV3D551VrrLyaf4jZm6Hk8nPU=
X-Received: by 2002:a4a:db95:0:b0:56c:a9fe:f701 with SMTP id
 s21-20020a4adb95000000b0056ca9fef701mr9856349oou.3.1693933317136; Tue, 05 Sep
 2023 10:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230905095914.1699335-1-konstantin.meskhidze@huawei.com>
In-Reply-To: <20230905095914.1699335-1-konstantin.meskhidze@huawei.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 6 Sep 2023 02:01:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQif7ka6agzEFikiDSHYT_y-Q6dwegjcbhuQj_GPmDXiQ@mail.gmail.com>
Message-ID: <CAK7LNAQif7ka6agzEFikiDSHYT_y-Q6dwegjcbhuQj_GPmDXiQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix possible buffer overflow
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 6:59=E2=80=AFPM Konstantin Meskhidze
<konstantin.meskhidze@huawei.com> wrote:
>
> Buffer 'new_argv' is accessed without bound check after accessing with
> bound check via 'new_argc' index.
>
> Fixes: e298f3b49def ("kconfig: add built-in function support")
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---


Applied to linux-kbuild.
Thanks.

--=20
Best Regards
Masahiro Yamada
