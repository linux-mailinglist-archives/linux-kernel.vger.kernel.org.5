Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C3D7F4909
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjKVOfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjKVOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:35:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BECD47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:35:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D35C433C7;
        Wed, 22 Nov 2023 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700663700;
        bh=Mqs5y4yUtAnpQhNl5oklydm8euubbQ9EWewbjA5KJdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+pnI5g2v4NCiN+ggQWfkNW5IApj8lCKgkLMmndCPepkimS6e3iLnfR1QEthtdtwg
         l23Oz6lCStNFbzNZkjzT0C9kEkvuLbbmD4v1X+1z56sBlHG1L6tj4coPef4+j0jXlF
         /jSDoBW1J4yDfR7Li9htL3/zxd5oHaQ8hq6ej6lw=
Date:   Wed, 22 Nov 2023 14:34:55 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yewon Choi <woni9911@gmail.com>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        threeearcat@gmail.com
Subject: Re: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <2023112257-polymer-banknote-4869@gregkh>
References: <20231122122005.GA4661@libra05>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122122005.GA4661@libra05>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:20:08PM +0900, Yewon Choi wrote:
> In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
> and vmci_host_dev->context may cause uninitialized data access.
> 
> One of possible execution flows is as follows:
> 
> CPU 1 (vmci_host_do_init_context)
> =====
> vmci_host_dev->context = vmci_ctx_create(...) // 1
> vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2
> 
> CPU 2 (vmci_host_poll)
> =====
> if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
> 	context = vmci_host_dev->context; // 4
> 	poll_wait(..., &context->host_context.wait_queue, ...);
> 
> While ct_type serves as a flag indicating that context is initialized,
> there is no memory barrier which prevents reordering between
> 1,2 and 3, 4. So it is possible that 4 reads uninitialized
> vmci_host_dev->context.
> In this case, the null dereference occurs in poll_wait().
> 
> In order to prevent this kind of reordering, we change plain accesses
> to ct_type into smp_load_acquire() and smp_store_release().
> 
> Signed-off-by: Yewon Choi <woni9911@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> index abe79f6fd2a7..e83b6e0fe55b 100644
> --- a/drivers/misc/vmw_vmci/vmci_host.c
> +++ b/drivers/misc/vmw_vmci/vmci_host.c
> @@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
>  {
>  	struct vmci_host_dev *vmci_host_dev = filp->private_data;
>  
> -	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> +	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {

This is getting tricky, why not use a normal lock to ensure that all is
safe?  close isn't on a "fast path", so this shouldn't be a speed issue,
right?

thanks,

greg k-h
