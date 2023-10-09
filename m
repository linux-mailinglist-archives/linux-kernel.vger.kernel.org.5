Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CB7BD5A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjJIIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345569AbjJIIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:50:23 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E224AAB;
        Mon,  9 Oct 2023 01:50:17 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A28040E01AD;
        Mon,  9 Oct 2023 08:50:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VK1GH2ouBi-G; Mon,  9 Oct 2023 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696841413; bh=7CYvLIY8aEUYixz53xDspma+Kfy7X++I/AJmqD2YYBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9NCjqZy8oOr8+/2Ju2DeJGv4/5D9dJ+nPfiL6g5fpjbbxwJZFfml2So6s0F+/fHG
         wB5nm5N0xWlBwVWaIT1WvLCqbDJyFbnNi/v1uD7WSgbLvmcM1sD4YOLKRXtWyNSpXE
         ENdLK1nD79+nljxaj/O5Wv2CbqbrD/SiBSZURnKWsUZliv4BuqCY2KOwyokpgqIY9A
         fZY29NFPi3157GWXAafq5BSuJDhgKrbcFoa+g2pfH38RsMzz243+v9Eii8zb65ns2P
         rT+iIlIVl9Jam2R0N/BsktzLjbhQgyOKL/CoFuMTUncXzyDoEjS7JQHF8pCoA+nzkd
         CUW4iZGip8FXVDK8Qq3+4IGcAlVLsMxX7XVoSU52Jd/qDjYfIa7CWQr4AWcJAixvBM
         gXxmkCi7+F4AFPTt0aVDyyJ1mV7yXQht2dJNBZHPNf42IOd+fe+PAhAsfEoqGo6LLK
         VKoJNe57Z62RGrloC0Kp+7Sgc5rqNYjMdVZlAHI0R2cXf8sIlGjytUj+KNh0vgsuc3
         4AHCY0a9PwTePAbV9ltJwH8LZb0UdAGE9hb/TAQTxw+MmvSY4cf4vBDW4+C4kt7DL+
         ad0IbBNcJOPL3/bhBeLIE5lIAmMw/aNm+ZYyrpKYaU6NZnOxaHUYQedvdUXY0xUObs
         JdqF9cVlm8adE85YUs4bopDo=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8570C40E01AE;
        Mon,  9 Oct 2023 08:50:05 +0000 (UTC)
Date:   Mon, 9 Oct 2023 10:50:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, "Li, Lili" <lili.li@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] EDAC/igen6: Fix slab-use-after-free in
 igen6_unregister_mci()
Message-ID: <20231009085000.GAZSO+uD336B0/qGbQ@fat_crate.local>
References: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
 <20231008105740.GAZSKLJMLfbiDbZlm8@fat_crate.local>
 <CY8PR11MB713434F22846F9002DB6238C89CEA@CY8PR11MB7134.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713434F22846F9002DB6238C89CEA@CY8PR11MB7134.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:39:25AM +0000, Zhuo, Qiuxu wrote:
> Rechecked the igen6_edac code, it has already done the exact opposite
> of the allocation steps on the unreg patch below:

allocation and *assignment*. And it doesn't do them in the exact
opposite way. Look again.

> In the reg path:
>   igen6_probe()
>       igen6_pvt = kzalloc()    // Step a
>       igen6_register_mci()
>           mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers, 0) // 0 means igen6 itself manages 'pvt_info'.
>           mci->pvt_info = &igen6_pvt->imc[mc];  
>           edac_mc_add_mc(mci)    // Step b
> 
> In the unreg path:
>   igen6_remove()
>       igen6_unregister_mcis()
>             edac_mc_free(mci)     // Step B
>       kfree(igen6_pvt)        // Step A
> 
> I assume that when calling edac_mc_alloc() with sz_pvt=0, 'pvt_info' is managed 
> by the EDAC driver, not the EDAC core. Therefore, the EDAC core should not kfree 
> 'pvt_info' unconditionally in this scenario.

That would mean that the EDAC core would have to remember whether it
allocated a private struct for the driver. Which is not needed - if the
driver has allocated it, the same driver can free it before calling
edac_mc_free().

> So the problem occurred in Step B when the EDAC core mistakenly kfreed
> 'pvt_info,' which should have been kfreed in Step A. 'pvt_info' is
> managed by the igen6_edac driver, not the EDAC core.

Your silly driver is allocating a single struct igen6_pvt and then it is
assigning pointers of the embedded struct igen6_imc elements from the
array in igen6_pvt:

	mci->pvt_info = &igen6_pvt->imc[mc];

to the pvt pointer. I.e., only a *part* of that allocated memory.

Then, it is calling

	edac_mc_free(mci);

on the mci which frees only that array element - not how it got
allocated and then at the end, in the remove function, you do

	kfree(igen6_pvt);

where the array elements have been freed and then KASAN rightfully
complains.

So no, you're doing it wrong.

You either need to alloc the pvt in igen6_register_mci() and free it in
igen6_unregister_mcis(), *before* edac_mc_free() or ...

> A simple fix is to set mci->pvt_info = NULL just before Step B, but it
> may seem a bit magical.

... do that which is a hack.

And looking at your driver, it is doing it wrong - it seems it doesn't
understand what the point of mci->pvt_info is.

Instead of passing around

	struct mem_ctl_info *mci

to all the functions that need

	struct igen6_imc *imc

so that you can do

	struct igen6_imc *imc = mci->pvt_info;

in them, which is exactly what that private pointer is actually for(!),
or to do to_mci() on the containing edac device, you're using that mc
index to index into the global igen6_pvt->imc[] array.

igen6_get_dimm_config() is the only function that does it right.

So this driver needs to be fixed properly to pass around that mci
pointer, like the others do. Not this bolted on hack.

> Similar issues could also occur in the following drivers where the
> EDAC core should NOT kfreed the pvt_info as these 'pvt_info' are
> managed by the specific EDAC drivers themselves (sz_pvt = 0).
>
>   drivers/edac/amd8111_edac.c
>     dev_info->edac_dev->pvt_info = dev_info;

That one is not even using edac_mc_free().

>   drivers/edac/cpc925_edac.c
>     dev_info->edac_dev->pvt_info = dev_info;

That's the wrong one - it is:

        mci = edac_mc_alloc(edac_mc_idx, ARRAY_SIZE(layers), layers,
                            sizeof(struct cpc925_mc_pdata));

	...

        pdata = mci->pvt_info;

and that's handled by the EDAC core only.

>   drivers/edac/x38_edac.c
>     mci->pvt_info = window; // This is even an ioremap() memory and requires iounmap() to release it.

static void x38_remove_one(struct pci_dev *pdev)

	...

	iounmap(mci->pvt_info);


How about you slow down, take a piece of paper, draw the allocation and
assignment ordering and try to understand what exactly the idea behind
it is? Look at how the other drivers do it, there are good examples
in there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
