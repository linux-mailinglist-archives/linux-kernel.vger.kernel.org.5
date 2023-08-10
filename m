Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDA777513
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjHJJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjHJJ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:57:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6126A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:57:23 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76af2cb7404so59481285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691661442; x=1692266242;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFnzMmW2nOgscH6EbG0mZZ0e91cllCalnRXRCz77A2Y=;
        b=S6QISacR/Y4+2d8wZ5WC2d7vFyBSS0C/E9Old8gBu6yIUWmq69oVcQP8/Mtsr0/a5B
         uhwVA+46oRZiH4FOVSBLu2NtValFxe619PokzHWHogXl5NvWqHcJkbC1OkuifnpNAak9
         FeKWiPTrtWsmppYRGmj9lhTnODxsF8dDtY+ks2mSLHAFekCDBJ+Fvq+yRHzJvhjVEW/8
         0ab2zoGyEs4GVDRwPvJ76dvqXkQ4LYPnlBZG35n17ngusSHhqqUK5Qx7HumcxaIUZRHI
         OaQ46dcPYC0bBIErZdKshPxn57NhOzIZOl23qKX4Ov5JIlVNh4hOtFxOq6GWP+DCtV6P
         D3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661442; x=1692266242;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFnzMmW2nOgscH6EbG0mZZ0e91cllCalnRXRCz77A2Y=;
        b=EM1bAE2rygliQdkTgqoM/q+I5vXXR4lxTp6POoCydACdSdLewnm33m7tpFsq2wXBxX
         O9qs3eok7Ktoh/NV1E25tT8ntUWKsAbs2X/rCteWVFbCAx0dQ2BuflR29HNo6f9IZ2M0
         N4KwCoFOtGcGpNuqUGn5XXOpB7NYcCv5Bcqa2U5I9kaEPCHcXRuFiAvxawgD4u06Qric
         uaic8sfQzBWkcQhxBz9G/aB5RKsp/PrhoKHtQD+rmwj1Z50EGfS/6Y3KZapHZp5l3C9e
         32/6d25L1dFy/ekDXU4R/IEyYt7r3o3HieI71YLpsaqxlY6wB3e7fBRlaVD4cp+KPIXM
         AoTA==
X-Gm-Message-State: AOJu0YyjXkzNPGTq9C3OHbudPw92nFY/c4QNo+uPUmKVlI5znxPfigZT
        slDo3HoTVio1ThPGSNgxSaucdA==
X-Google-Smtp-Source: AGHT+IHOfshJXbVh9LwKh65uF9o94Xhc4gOkIIwGcaZglpHe2F5AK672tGyZs2tmDvHmq8es5o32Lg==
X-Received: by 2002:a05:620a:2588:b0:76c:81b1:498f with SMTP id x8-20020a05620a258800b0076c81b1498fmr1948938qko.14.1691661442579;
        Thu, 10 Aug 2023 02:57:22 -0700 (PDT)
Received: from hsinchu26 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p11-20020a637f4b000000b005501b24b1c9sm1117996pgn.62.2023.08.10.02.57.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Aug 2023 02:57:21 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:57:16 +0000
From:   Andy Chiu <andy.chiu@sifive.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        ebiggers@kernel.org, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 06/12] RISC-V: crypto: add Zvbb+Zvbc accelerated GCM
 GHASH implementation
Message-ID: <20230810095715.GA6929@hsinchu26>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-7-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711153743.1970625-7-heiko@sntech.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:37:37PM +0200, Heiko Stuebner wrote:
Hi Heiko,

> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Add a gcm hash implementation using the Zvbb+Zvbc crypto extensions.
> It gets possibly registered alongside the Zbc-based variant, with a higher
> priority so that the crypto subsystem will be able to select the most
> performant variant, but the algorithm itself will still be part of the
> crypto selftests that run during registration.
> 

All newly added crypto algorithms are passing on my side, except for
this one. I was testing on a QEMU and toolchain that support the
frozen spec.

It seems like it was failing on a small 16-Byte input. Here are the
input, expected digest and the (mismatched-)result.

(gdb) x/2gx vec->key
0xffffffff8163cc38:     0x03db81ed4dbfa6df      0x61f030f895ffcaff
(gdb) x/2gx vec->plaintext
0xffffffff8163cc50:     0xc04a60a5562a2b95      0xb6405ba056662bb3
(gdb) x/2gx vec->digest
0xffffffff8163cc68:     0xb65bc5d20aeb53da      0x60dafec32c80c44f
(gdb) x/2gx result
0xff20000000943bb8:     0x0000000000000000      0xb18de0d5e7abcf10

And here is the bootlog, do you have any idea?
[    5.007043] alg: shash: riscv64_zvbb_zvbc_ghash test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
[    5.008164] alg: self-tests for ghash using riscv64_zvbb_zvbc_ghash failed (rc=-22)
[    5.008450] ------------[ cut here ]------------
[    5.009226] alg: self-tests for ghash using riscv64_zvbb_zvbc_ghash failed (rc=-22)
[    5.010678] WARNING: CPU: 1 PID: 87 at crypto/testmgr.c:5867 alg_test+0x3e2/0x41e
[    5.011792] Modules linked in:
[    5.013314] CPU: 1 PID: 87 Comm: cryptomgr_test Not tainted 6.2.2-02529-g4b0fb43edd0f-dirty #37
[    5.014037] Hardware name: riscv-virtio,qemu (DT)
[    5.014582] epc : alg_test+0x3e2/0x41e
[    5.014938]  ra : alg_test+0x3e2/0x41e
[    5.015256] epc : ffffffff80677744 ra : ffffffff80677744 sp : ff2000000095bd70
[    5.015718]  gp : ffffffff81c896b8 tp : ff6000000464d280 t0 : ffffffff81a2c970
[    5.016171]  t1 : ffffffffffffffff t2 : 2d2d2d2d2d2d2d2d s0 : ff2000000095be80
[    5.016616]  s1 : ffffffffffffffea a0 : 0000000000000047 a1 : ffffffff81a97c70
[    5.017078]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
[    5.017582]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
[    5.018079]  s2 : 000000000000000e s3 : ff60000002adf200 s4 : ff60000002adf280
[    5.018576]  s5 : 0000000000000171 s6 : 00000000000000b8 s7 : 0000000000000088
[    5.019083]  s8 : ffffffffffffffff s9 : 00000000000000b8 s10: 0000000000002e00
[    5.019584]  s11: ffffffff8127fd78 t3 : ffffffff81ca0f17 t4 : ffffffff81ca0f17
[    5.020074]  t5 : ffffffff81ca0f18 t6 : ff2000000095bb88
[    5.020455] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[    5.021234] [<ffffffff80677744>] alg_test+0x3e2/0x41e
[    5.021906] [<ffffffff8067490e>] cryptomgr_test+0x28/0x4a
[    5.022306] [<ffffffff80055ba0>] kthread+0xe0/0xf6
[    5.022710] [<ffffffff80003edc>] ret_from_exception+0x0/0x16
[    5.023755] ---[ end trace 0000000000000000 ]---

Thanks,
Andy
