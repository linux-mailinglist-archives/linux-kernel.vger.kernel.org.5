Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B377C152
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjHNUJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjHNUJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:09:42 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE3610CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:09:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 825C340E0140;
        Mon, 14 Aug 2023 20:09:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EJ64VzB5O4Do; Mon, 14 Aug 2023 20:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692043769; bh=3Q28RWhd5iP6+WOLfurk9uNVbHCq/BuGNh+wEqLETwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVulu9a+TLbDoFaF2N+Z4rRLT2srg7vOkVtV1YUtUwENLNFPLMTGftOlR/FdIZ70t
         7J5nrkxSQxOicHZk2KVJ18a9MTumXxCXQ06FHmv2ciiVnh43DBBjIW83DxgWIeGL+w
         PQ1yRZh+y8X3MSrELNMlW78HsS1oa1pIWaYdKAs2G/aawA26qJw9qRwlKE9cxMao1y
         cnIqCPc8wLN0XSRc3cCoUVqN7ScQuObko9AFCvCWeGupyyRG3MHhNt3FdIUnmVbeBF
         rvcnN7UDBwgVFZjiQ6gn+nIZUCZt1myezHgbl870ZjS+he6qLi//h9GMFV0d2y2eEW
         tGLfGtOpSmNRthQ93QDU+UVAHqw8OGpKU4Zeb6PlgA5g2Rk6cNaY/PHGPmf5PqJGWd
         62GNyI0Z3yG1KOmmpVph53u8j2cVPdsHp2qE4JzPvrtKORVpN6ePPWIdCFO1Df2Zw6
         UEk+T4+sdNsMUtmeMwHKZ1xkafAxpGm5BLuNRT2uhLmbwu7wklWrNd0CzY1pAU3XUf
         5W0+G1u1TdlZqeYfhVBX5z6zCofJLVaFgMtLPNVvY0YIqf0Mk2XQ9saOixX3w5i04T
         HTA5KtxCWbxpm5NgHKmcechaXOZS6etkFm9VW5494XR64O4ATRGNHEKpMYinWw0m8r
         C9c+ikVmQ7X4mxMUdHOVi74w=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4110740E0195;
        Mon, 14 Aug 2023 20:09:21 +0000 (UTC)
Date:   Mon, 14 Aug 2023 22:09:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: Re: [PATCH v2 00/11] Fix up SRSO stuff
Message-ID: <20230814200916.GJZNqJ7H3MaO0ZTO5/@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local>
 <20230814195153.2zxtp6zx552trgh6@treble>
 <20230814200128.ioas5lk2r3yzfkkv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814200128.ioas5lk2r3yzfkkv@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:01:28PM -0700, Josh Poimboeuf wrote:
> How about:
> 
>   "both the RET in zen_untrain_ret() and the LEA in srso_untrain_ret()"
> 
> ?

Yeah, or the "instruction sequences starting at srso_safe_ret and
retbleed_return_thunk" (that's what it's called now) "must start at
a cacheline boundary."

Because the LEA was ADD but that changed so saying "the instruction
sequences" just works.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
