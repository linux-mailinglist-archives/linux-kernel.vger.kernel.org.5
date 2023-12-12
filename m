Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE94F80E4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjLLHLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLLHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:11:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33DED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 23:11:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A353C433C9;
        Tue, 12 Dec 2023 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702365111;
        bh=mAmUSentyWLmxS3uIGWIk1/WaLIBgAtASobEkLuZlvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k5Od11fzDY5KMknbUEDyOS5n59hXgpWpDno++QZ6xjmcPaPcEsafwrSrEjApDSC4h
         t7ixBPBEmBsPs+nQs1l2SU/llp3dhp/jgsu4RhCeYvhVGxP+XbsbiOEYNspmF8kjZL
         aBu0Sw3RE2NiVj8ZIWsaTqsDW0njBI24wNHouv7LxNv8gjChTb+uNuiIzBLJ9yaN1p
         Ipkg52K2CDW1XVuUKil0GjZmPnqUm5rHHr8G9mBNBuHpob2r0Zzh6I4yhVFs7ZOZ3C
         mzOpta/DA47V14vrwI6EuFnhfcZ8uSUcA7O3KqGUxvgVk4Y1jU2xmK7F+p3Bi2FBVO
         heNSrKqzhwU0Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so66679581fa.2;
        Mon, 11 Dec 2023 23:11:51 -0800 (PST)
X-Gm-Message-State: AOJu0Ywyo9yPrKG9CxJK9vgL4SYITliZEJDsvNu7Iy1rffH0wf9Odfgx
        ywIV6BdS4KbAoStJR2FB9qXrbse5MSctI0izoyA=
X-Google-Smtp-Source: AGHT+IFOwmyXSlMHNCihbFQURemSWuU5fLaZxVeC+4D0v54JRt+64Efmqtk8z5oD2pOuRTub/XTcFcsK5ie5zv0RSJI=
X-Received: by 2002:a2e:9856:0:b0:2ca:16d0:9e9a with SMTP id
 e22-20020a2e9856000000b002ca16d09e9amr1456456ljj.92.1702365109470; Mon, 11
 Dec 2023 23:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
 <20231013074540.8980-5-masahisa.kojima@linaro.org> <CAMj1kXEFPwqd=Ksc_HuoNSwRUyCNka4E7cWZgkgMq7XHcu2VFA@mail.gmail.com>
 <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>
In-Reply-To: <CADQ0-X8DJk02oKabzQcMwqKFjr6A6LDWaQDCndKybC6D=9M7vg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 Dec 2023 08:11:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEB6XajecjXe3oX2nagO8foajdwZ99SiC_dD8WBjr+93w@mail.gmail.com>
Message-ID: <CAMj1kXEB6XajecjXe3oX2nagO8foajdwZ99SiC_dD8WBjr+93w@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] efivarfs: automatically update super block flag
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 06:39, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ard,
>
> On Mon, 11 Dec 2023 at 19:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Oct 2023 at 09:47, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > efivar operation is updated when the tee_stmm_efi module is probed.
> > > tee_stmm_efi module supports SetVariable runtime service,
> > > but user needs to manually remount the efivarfs as RW to enable
> > > the write access if the previous efivar operation does not support
> > > SerVariable and efivarfs is mounted as read-only.
> > >
> > > This commit notifies the update of efivar operation to
> > > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > > operation supports SetVariable.
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >
> > Unfortunately, I have identified a problem with this approach.
> >
> > There are cases where there are multiple instances of struct
> > superblock are associated with the efivarfs file system [0].
> >
> > So I reworked the patch a little - please take the time to double
> > check that I did not make any mistakes here.
> >
> > [0] https://lore.kernel.org/linux-efi/20231208163925.3225018-8-ardb@google.com/T/#u
>
> I think you are referring to this patch[1]?
> The modification should be OK, also I have tested it works as expected.
>
> Thank you very much for fixing this.
>

Thank you Masahisa.
