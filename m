Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02CE772E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHGTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHGTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5310F6;
        Mon,  7 Aug 2023 12:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E19F6214F;
        Mon,  7 Aug 2023 19:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA79C433C9;
        Mon,  7 Aug 2023 19:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691435114;
        bh=vj7yPuzGEvJgfOwFDmfH291cTF5ku4Wjtfo7UF0sd2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UDolCBsl4LaTO3H1wF5qqWgbkXUyYU9y18gcN6eR0Nic0vHMJ7k/2Jnjyo1c3a0D+
         PfZzRcm25LaORBnSIybhk6ZrFmMSsI+jXH1sXNxVbLt9lVJvNLD4uxBmDzkmSjl1wV
         ZwpxrdQYIVDgeVK1kIO/rKFpvRd9c6KZPlKvnPwUCQG2oQps84SmBWrhfwT65h8SVV
         mlQxqVlOYuDdAVyPLMooKNIwJc2wfTzVdYjoL0hyFt/JJNmNzZ85lWtn+Y1DCj8DSg
         KgXjUcNifwH9AJZzKUNJb5YUbvyeJknrQNPwALueSuqXOXEce5KAgox0ahDNYEkxho
         zDDWj8FkxAY6Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1bed90ee8b7so2759658fac.0;
        Mon, 07 Aug 2023 12:05:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YwhfJ9Pqi4Vn/efrxcWqgv7PeZX/OnQtnmw4GcmKMNccScoW1IT
        YBWtctg2+lmQ9x4MNYP9HiwvIJql+pFUQlBqBLQ=
X-Google-Smtp-Source: AGHT+IH7Ew8bpH86wxn76wP4F4p87DNK+1GJ1cS0SvR6WaOL3WRhowZsZUU+05WJBqCuT0el+IivzRQBJ/TYXaZU64w=
X-Received: by 2002:a05:6870:468a:b0:1bb:88f0:f41a with SMTP id
 a10-20020a056870468a00b001bb88f0f41amr9729226oap.26.1691435113701; Mon, 07
 Aug 2023 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230729214138.79902-1-sergeantsagara@protonmail.com>
 <CAK7LNAR_Egr+G9_HmGfrmFAEQ0Tznmbff0w9cJ=1biV5P4PmNQ@mail.gmail.com> <875y5rsd6c.fsf@protonmail.com>
In-Reply-To: <875y5rsd6c.fsf@protonmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Aug 2023 04:04:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2XKRisvMkB+dw3ZnExYuy9U8xB9BXnXy2FvqZWrRk-g@mail.gmail.com>
Message-ID: <CAK7LNAS2XKRisvMkB+dw3ZnExYuy9U8xB9BXnXy2FvqZWrRk-g@mail.gmail.com>
Subject: Re: [PATCH] scripts: merge_config: Add flag to prevent unsetting
 config option
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 7, 2023 at 1:13=E2=80=AFPM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
>
> On Sun, 06 Aug, 2023 23:19:55 +0900 "Masahiro Yamada" <masahiroy@kernel.o=
rg> wrote:
> > On Sun, Jul 30, 2023 at 6:42=E2=80=AFAM Rahul Rameshbabu
> > <sergeantsagara@protonmail.com> wrote:
> >>
> >> Overriding a previously defined entry for a config option with 'is not=
 set'
> >> may be undesirable in some fragment configuration setups.
> >
> > Then, you should remove the 'is not set' entry from the fragment.
>
> I had a feeling that was the expectation. Just for reference, my flow
> for generating fragments looks like the following.
>
>   1. make allnoconfig
>   2. make menuconfig   # select the options that I desire for the fragmen=
t


Sorry, I could not understand
how these steps generate a fragment file.

You will get a full .config file
after 'make menuconfig'.





> We can drop this patch if this is the expected developer flow. I
> realized that overriding with 'is not set' entries in a fragment is
> likely desirable, so I made this behavior change as part of a flag that
> can be set by the user.
>
> --
> Thanks,
>
> Rahul Rameshbabu
>


--=20
Best Regards
Masahiro Yamada
