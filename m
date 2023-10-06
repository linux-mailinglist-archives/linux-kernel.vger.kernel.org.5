Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB47BBABE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjJFOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjJFOsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:48:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DBBCF;
        Fri,  6 Oct 2023 07:48:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1391C433C8;
        Fri,  6 Oct 2023 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696603700;
        bh=tpz2lJHsFpXAdojf/r2F+CjbjlhID/zdHJhAMnUPoCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pw4cglRdfnNQIC+v8UHZFG9a8HZIFKlwmn8crhYx3+RrtDuK/Umh0/7FsERtCn7R4
         yEaIj7ty0itLM2i1EjAWcqxRaQDxBDvKKBCk4aSis+ZYZGyJ7rirPb8+wvJcfTe2X6
         ORJvvnuzdLyrsQnhNN/1hn19HGLs6ceD84WuebNp0U08JxkqLJeJANE51iAQfxUKxc
         NjMyXpnXhWpL/Fpew1ALhW7OrQpKPE8ZTT9MBfOmzjIanNM2T7svMBG08yXegkygnx
         iTMvKnL+r2rU66lKgBvyFyBLiVz1aqQZDgZx0RD/aBKRNa5ytE46xX8PqmZ2Iu0aNn
         WkJqroi9ENOfw==
Date:   Fri, 6 Oct 2023 16:48:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     rdunlap@infradead.org, wenjia@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        netdev@vger.kernel.org, raspl@linux.ibm.com, sfr@canb.auug.org.au,
        alibuda@linux.alibaba.com, wintera@linux.ibm.com,
        guwen@linux.alibaba.com, tonylu@linux.alibaba.com,
        jaka@linux.ibm.com
Subject: Re: [PATCH net] net/smc: Fix dependency of SMC on ISM
Message-ID: <ZSAeL1aLpkXVweg6@kernel.org>
References: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
 <20231006125847.1517840-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006125847.1517840-1-gbayer@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 02:58:47PM +0200, Gerd Bayer wrote:
> When the SMC protocol is built into the kernel proper while ISM is
> configured to be built as module, linking the kernel fails due to
> unresolved dependencies out of net/smc/smc_ism.o to
> ism_get_smcd_ops, ism_register_client, and ism_unregister_client
> as reported via the linux-next test automation (see link).
> This however is a bug introduced a while ago.
> 
> Correct the dependency list in ISM's and SMC's Kconfig to reflect the
> dependencies that are actually inverted. With this you cannot build a
> kernel with CONFIG_SMC=y and CONFIG_ISM=m. Either ISM needs to be 'y',
> too - or a 'n'. That way, SMC can still be configured on non-s390
> architectures that do not have (nor need) an ISM driver.
> 
> Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-next/d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org/
> Co-developed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
