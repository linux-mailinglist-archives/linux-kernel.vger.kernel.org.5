Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744DA7810E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378726AbjHRQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbjHRQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:48:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7814216;
        Fri, 18 Aug 2023 09:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33CCA60DE8;
        Fri, 18 Aug 2023 16:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BBEC433C7;
        Fri, 18 Aug 2023 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692377278;
        bh=ffwrM7oSAftx1Cnprra7dW7c42Lu0hghbHAVilDl5dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWR7wu4GcwPFTchj3h2hNbu7tSss1eVOvwXsfweO7v01k+t5TjMTs9fOWfqC2/xg5
         uzVnm6jqODuTMStsXEdK4prxH9PUAMdVMbbJCHef3A85H1APd5VoysDrH5UIdyiuhr
         MXXR6QS7tFKdGiBAu8SSmxJMJE67FnLevHUL6LrdV8lF4HAXbN8VSzFXvqkisqPW8T
         81WiYgeUdoK3LYz94++hF9OD2rHrJn3VmHFgU+LZW6uE0hR2kIiJ10g2UEO5wXLxCQ
         dReFRD+5SEHBqy0GDD5mzqnrLjkr8itW6DvHt8R7+pKtpo2j/or4wzK2lcyuh9YBKg
         7vgxzaBksawEw==
Received: (nullmailer pid 146296 invoked by uid 1000);
        Fri, 18 Aug 2023 16:47:57 -0000
Date:   Fri, 18 Aug 2023 11:47:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     devicetree@vger.kernel.org, kernel-team@meta.com,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,ima,kexec,of: use memblock_free_late from
 ima_free_kexec_buffer
Message-ID: <169237726559.146063.4251885159536892099.robh@kernel.org>
References: <20230817135759.0888e5ef@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817135759.0888e5ef@imladris.surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Aug 2023 13:57:59 -0400, Rik van Riel wrote:
> The code calling ima_free_kexec_buffer runs long after the memblock
> allocator has already been torn down, potentially resulting in a use
> after free in memblock_isolate_range.
> 
> With KASAN or KFENCE, this use after free will result in a BUG
> from the idle task, and a subsequent kernel panic.
> 
> Switch ima_free_kexec_buffer over to memblock_free_late to avoid
> that issue.
> 
> Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to
> drivers/of/kexec.c")
> Cc: stable@kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Mike Rappoport <rppt@kernel.org>
> ---
>  drivers/of/kexec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!

