Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E987D984F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbjJ0Mcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbjJ0Mcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:32:48 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6910A;
        Fri, 27 Oct 2023 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698409965;
        bh=PpcsZRP4hkvBDAQ2XBd6sP/O26p2Kk1rAGMQFr2SSuk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ctsCWHutHWwQ1sLy/FSZlur/NzDKdS4FhnQk91SSqlKtQpuKSSP9F3F9+ccDP3RSc
         k7wwV3FZz788xRl02meyuLwKUEaz0IYI3U4hevEob4AvQCiOtAwr+kGANU4NOZMDNa
         NjKdEh601gp/Ls5OLps9nZeX910lVnHVNQhuAIrw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7D48A1287460;
        Fri, 27 Oct 2023 08:32:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id T1MDS27-eUfW; Fri, 27 Oct 2023 08:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698409965;
        bh=PpcsZRP4hkvBDAQ2XBd6sP/O26p2Kk1rAGMQFr2SSuk=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ctsCWHutHWwQ1sLy/FSZlur/NzDKdS4FhnQk91SSqlKtQpuKSSP9F3F9+ccDP3RSc
         k7wwV3FZz788xRl02meyuLwKUEaz0IYI3U4hevEob4AvQCiOtAwr+kGANU4NOZMDNa
         NjKdEh601gp/Ls5OLps9nZeX910lVnHVNQhuAIrw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A1B7E1287462;
        Fri, 27 Oct 2023 08:32:43 -0400 (EDT)
Message-ID: <d4157726d924a3ddad477923d6bcb4a8e6a55e60.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 4/6] tpm: Support TPM2 sized buffers (TPM2B)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Julien Gomes <julien@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Date:   Fri, 27 Oct 2023 08:32:42 -0400
In-Reply-To: <20231024011531.442587-5-jarkko@kernel.org>
References: <20231024011531.442587-1-jarkko@kernel.org>
         <20231024011531.442587-5-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-24 at 04:15 +0300, Jarkko Sakkinen wrote:
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -7,22 +7,32 @@
>  #include <linux/tpm.h>
>  
>  /**
> - * tpm_buf_init() - Initialize from the heap
> + * tpm_buf_init() - Initialize a TPM buffer
>   * @buf:       A @tpm_buf
> + * @sized:     Represent a sized buffer (TPM2B)
> + * @alloc:     Allocate from the heap
>   *
>   * Initialize all structure fields to zero, allocate a page from the
> heap, and
>   * zero the bytes that the buffer headers will consume.
>   *
>   * Return: 0 or -ENOMEM
>   */
> -int tpm_buf_init(struct tpm_buf *buf)
> +int tpm_buf_init(struct tpm_buf *buf, bool alloc, bool sized)

I think it creates a phenomenally confusing interface to use multiple
booleans because, unlike flags, it's not self describing at point of
use.  The confusion is enormously heightened here by having the doc
book arguments be the reverse of the actual function prototype (I just
tripped over this).

The alloc flag is particularly counter intuitive: if you pass in an
allocated buffer, you expect to be responsible for freeing it again,
but that's not how you use it; you really use it like a reset not an
alloc, which looks odd because you already created a separate
tpm_buf_reset function which can't be used in this case.

Why not replace the alloc flags with two reset functions: one for TPM2B
buffers and one for command buffers?

James

