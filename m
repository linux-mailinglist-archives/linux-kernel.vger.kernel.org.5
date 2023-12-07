Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1607B80921A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443876AbjLGUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:15:11 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61528170F;
        Thu,  7 Dec 2023 12:15:18 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9e179b217so402185a34.0;
        Thu, 07 Dec 2023 12:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980117; x=1702584917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytNDdKy1mnEm3e+yRbuE/HnHivt5uF3IXJRUZqNhUno=;
        b=mEa0a6rzS1oeICoVtcbftTkkjs341I0HaON9WkC5oS+ilW4BTpjvvAlMbjZmtc7P+r
         8d8TeFDbnhtPH/wAEC1to4Ce/SkDY0omOVRJjBAF3ysAgRWiSwyu/FCst/Zeqiwd1JJD
         yqeAzJFYE8OAx3i8JR2OpUDycclC4OftS3T3DMKu5U2wvlCN4FXM/LjyveyIzVQHd6LH
         zoRW2r/nLCWW8bXFmO3Dt7Fe8N0/YpglxGX1KMA5RAJ7z+Yb77xwDb83svvcS4FD7M7O
         QOyhRUS41jwZeLyQINBO3t6NHWLMaUTbehJzKYJfNXIhwdGd/E1x3HqD/Ajyj3YXzXTJ
         AlRA==
X-Gm-Message-State: AOJu0YzX77qTx0j0OLLYmQlGpuW44n3qtqxENWMjKcJ5/hxA8OI2Tflu
        qiIXTAq/9VbElyNoEsnzp9d//eEYew==
X-Google-Smtp-Source: AGHT+IFFpMDZK/yIr6hZpE4r1FjYZtPYedvtJwcGCyDCOPoNAYk8TdQZMuSyWAZEu2Vjduf1L9uMfA==
X-Received: by 2002:a05:6830:124e:b0:6d9:d144:c9a9 with SMTP id s14-20020a056830124e00b006d9d144c9a9mr2599082otp.22.1701980117581;
        Thu, 07 Dec 2023 12:15:17 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l16-20020a9d7350000000b006d9d3d0e145sm84403otk.10.2023.12.07.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:15:16 -0800 (PST)
Received: (nullmailer pid 3350191 invoked by uid 1000);
        Thu, 07 Dec 2023 20:15:16 -0000
Date:   Thu, 7 Dec 2023 14:15:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/4] powerpc/machdep: Define 'compatibles' property in
 ppc_md and use it
Message-ID: <20231207201516.GA3348285-robh@kernel.org>
References: <e6cf01d41502b15e688b6f5aa5c3b68c62b8ac64.1701878821.git.christophe.leroy@csgroup.eu>
 <9da79892e7ff433095a7bf42e86aef02ab86b5c1.1701878821.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da79892e7ff433095a7bf42e86aef02ab86b5c1.1701878821.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:13:34PM +0100, Christophe Leroy wrote:
> Most probe functions that do not use the 'compatible' string do
> nothing else than checking whether the machine is compatible with
> one of the strings in a NULL terminated table of strings.
> 
> Define that table of strings in ppc_md structure and check it directly
> from probe_machine() instead of using ppc_md.probe() for that.
> 
> Keep checking in ppc_md.probe() only for more complex probing.
> 
> All .compatible could be replaced with a single element NULL
> terminated list but that's not worth the churn. Can be do incrementaly
> in follow-up patches.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/machdep.h            |  1 +
>  arch/powerpc/kernel/setup-common.c            |  2 ++
>  arch/powerpc/platforms/40x/ppc40x_simple.c    |  9 +++------
>  arch/powerpc/platforms/512x/mpc512x_generic.c |  4 +---
>  arch/powerpc/platforms/52xx/lite5200.c        | 10 +---------
>  arch/powerpc/platforms/52xx/mpc5200_simple.c  | 10 +---------
>  arch/powerpc/platforms/83xx/mpc830x_rdb.c     | 10 +---------
>  arch/powerpc/platforms/83xx/mpc831x_rdb.c     | 10 +---------
>  arch/powerpc/platforms/83xx/mpc837x_rdb.c     | 10 +---------
>  arch/powerpc/platforms/85xx/corenet_generic.c |  2 +-
>  arch/powerpc/platforms/85xx/tqm85xx.c         | 10 +---------
>  11 files changed, 14 insertions(+), 64 deletions(-)

> -/*
> - * Called very early, MMU is off, device-tree isn't unflattened
> - */

Certainly an out of date comment as the unflattened API was being 
called.

Reviewed-by: Rob Herring <robh@kernel.org>
