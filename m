Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ADA7EE600
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbjKPRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:35:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66453181;
        Thu, 16 Nov 2023 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EGB0vGjW+NZmH1KV7ZusM44EJIy7WocoQO8gjJ04laQ=; b=hmM7Xeaa9/7wgUcUiyV0v0TOOr
        q11CzoIpaSMRn3jbe5Ik3K2TqwgoIH54hHbgK3ZwBEnNXgnfs2i3gs1SZ88ub4PKjZY5HdA1RSPbK
        nOpMy0eEiglW7sOx8q8LKM0oKmRaIG4I5RFWs9hHmddY9/mDh1o0JPDDIZJTe5UMkxwEEdd/rMiRa
        fqoaTQn3rZUbRhNm4g1yq8ZwFjYovjI5yE7gl4aXI2kLYKQxgSoz5k/UU6Vba1eBr+TnBgoOvc7oF
        1D9bxFrjyDMA9tsR3PzgEd+gFbrRDqM+PTOPII+lMN5bfl1wzJ8cmQdD7iGuJGw48Kiq4OZ/fvklq
        6XySaSTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r3gH4-0049tr-0z;
        Thu, 16 Nov 2023 17:35:30 +0000
Date:   Thu, 16 Nov 2023 09:35:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Modules: Introduce boot-time module signature
 flexibility
Message-ID: <ZVZS4hw5dGB4aPz3@bombadil.infradead.org>
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
 <20230914112739.112729-2-alessandro.carminati@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914112739.112729-2-alessandro.carminati@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:27:38AM +0000, Alessandro Carminati (Red Hat) wrote:
> This commit introduces a novel boot argument parameter that provides an
> advanced level of control over the verification of module signatures
> during the initial stages of booting. With this enhancement, we gain the
> capability to postpone the verification of module signatures to after
> intrd stage is finished.
> 
> Given that bootloader-provided artifacts are commonly employed
> post-verification,

Is such a thing expressed with a kernel config? If so then shouldn't
this be default for those uses cases?

> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>  include/linux/module.h  |  4 +++
>  kernel/module/main.c    | 14 ++++++-----
>  kernel/module/signing.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index a98e188cf37b..9899aeac43b0 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -34,6 +34,10 @@
>  
>  #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
>  
> +#ifdef CONFIG_MODULE_SIG
> +extern int module_sig_check_wait;
> +#endif

Please add under is_module_sig_enforced. That's one new line Vs 3 new ones.

I see the code which skips module signature verification and the knobs
but I don't see the code which complete the promise to do the actual
signature verification post initrd / initramfs state. What gives?

  Luis
