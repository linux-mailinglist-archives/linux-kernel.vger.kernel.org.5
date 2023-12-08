Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BC8098C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjLHBuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHBuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:50:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40B10DA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:50:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87CFC433C7;
        Fri,  8 Dec 2023 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702000211;
        bh=8AivNxnB656tRHSe2fXOSDD3zu3/bxUYioH4swsST14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9qCwfZ0UskUmg58lyYLFKsRZ9IZ4oanS1CsN6cMTPCzg+zCKc/1FB28mjRRHKJlF
         112+HURh2Nek5ZybJ/TVFD4ISNyuLVOOu78sZoC60/iUenWdHFoqVihoSD+IxCbBo6
         HFRieHRA8Y8CQVEkZgVXwEdv1geDJalhGAQ2DifSWNhIYACcb2gFGzWPw1mOgEH1wm
         d86xd5XyLjh02lEYL+XQD/l1y7QfRLhNqTHIx4EKrcayFRpid563bS0QT4bBKY7U7w
         L5f6D65LGAQMG5O5f1cVANxhYNHkqSOftS5dtwT7DbD6NF7UYtM1mheqbTBIIz3IkE
         HqQuqOc5GjoGg==
Date:   Thu, 7 Dec 2023 20:50:05 -0500
From:   Guo Ren <guoren@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix SMP when shadow call stacks are enabled
Message-ID: <ZXJ2TaXU7dhjphl5@gmail.com>
References: <20231121211958.3158576-1-samuel.holland@sifive.com>
 <CABCJKufwox6C5BprNF=rDUxfV532OcawqZBsv5hFejJgrfZ+FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKufwox6C5BprNF=rDUxfV532OcawqZBsv5hFejJgrfZ+FA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:40:55AM -0800, Sami Tolvanen wrote:
> Hi Samuel,
> 
> On Tue, Nov 21, 2023 at 1:20 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
> >
> > This fixes two bugs in SCS initialization for secondary CPUs. First,
> > the SCS was not initialized at all in the spinwait boot path. Second,
> > the code for the SBI HSM path attempted to initialize the SCS before
> > enabling the MMU. However, that involves dereferencing the thread
> > pointer, which requires the MMU to be enabled.
> >
> > Fix both issues by setting up the SCS in the common secondary entry
> > path, after enabling the MMU.
> 
> Thanks for the patch! Looks like my qemu setup doesn't hit this issue,
> but nevertheless, the fix looks good to me.
Because there is no function call in relocate_enable_mmu :)

> 
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
> 
> Sami
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
