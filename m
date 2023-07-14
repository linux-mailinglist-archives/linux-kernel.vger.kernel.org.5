Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DAE7531EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjGNG1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjGNG1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30B10D4;
        Thu, 13 Jul 2023 23:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70DD161C15;
        Fri, 14 Jul 2023 06:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792A5C433C7;
        Fri, 14 Jul 2023 06:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689316030;
        bh=c3Cyfkv+SZy5VmgtRQ3j2i501qpHew8qxvq8scls6SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pw6p5qPaBiYXC9imxMcFQ1UKmoth5rzV+n7xPbyoSWJcXqNz8wQS+Txb3YDrw87WR
         327pVCW6xz2h/+kbSTaJN4TS0wqfstxYEFqrnHS0BXejr4YVdHpUXWFNNiTM9ONAWu
         I2CCFpfQHU34X/JaO0j7MxEwJUUWgtcBMuUgR1p5M15IVU5kOAyLhYfXEgCxG7WGDh
         EdzscCliaIRX8eFucCUkXlA3SFcb+vc74KHAvYc5jK4WLZ1VaJkeNdciL7lkhFUYcR
         +5ySC1w4MtdCVHf7xr+eAFCMrkUyv3tUtXrtCw9/4IS5/dqU9pHq2IGQN/OxLN5mdN
         2kYx3WqSs2Rcg==
Date:   Thu, 13 Jul 2023 23:27:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20230714062708.GH913@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230713074042.GF2199@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713074042.GF2199@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:40:42AM -0700, Eric Biggers wrote:
> On Tue, Jul 11, 2023 at 05:37:31PM +0200, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > 
> > This series provides cryptographic implementations using the vector
> > crypto extensions.
> > 
> > v13 of the vector patchset dropped the patches for in-kernel usage of
> > vector instructions, I picked the ones from v12 over into this series
> > for now.
> > 
> > My basic goal was to not re-invent cryptographic code, so the heavy
> > lifting is done by those perl-asm scripts used in openssl and the perl
> > code used here-in stems from code that is targetted at openssl [0] and is
> > unmodified from there to limit needed review effort.
> > 
> > With a matching qemu (there are patches for vector-crypto flying around)
> > the in-kernel crypto-selftests (also the extended ones) are very happy
> > so far.
> 
> Where does this patchset apply to?  I tried torvalds/master, linux-next/master,
> riscv/for-next, and cryptodev/master.  Nothing worked.  When sending a
> patch(set), please always use the '--base' option to 'git format-patch', or
> explicitly mention where it applies to, or provide a link to a git repo.
> 

Hi Heiko, any update on this?  I would like to review, and maybe test, this
patchset but there's no way for me to do so.

- Eric
