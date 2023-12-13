Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89B811ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442130AbjLMT0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLMT0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:26:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8AEE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:26:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E92C433C8;
        Wed, 13 Dec 2023 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702495614;
        bh=vXpR4g1rcKpfov2gki4D3V32WfdQEc9ZzcOiXga2fos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=skJ63w2JJxY92R1Z/iMNX3UN2vkjIuGi7xe0eIiEDGCzoZfnWOh+K7I9tF3Y/giVv
         B+T74AxmzdDjELcoGGBMyAZjh2MGPJkdqJhjcbNawRObyOQw8T4d/08NXz66xlvzlE
         TOmLDfIH5PW56Gu78D53InFDdhKG+yxSvpjlkEGUn01f95XApJzRgaWsrv51LgCODX
         rmR1xdkXMTKPnrnpDh6RmWr0uC//0cGKk/UrDT2M71UIDc3bLcshPpkTrBrEF4jxM6
         MdyepV52qruZ0S8wnlSIEKRvuAgGinfP2ZQyTlRaO9Q8xbZQo7hdEkuHmnhApEFXnv
         JGf8Exp+APwWw==
Date:   Wed, 13 Dec 2023 13:26:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Harris <jim.harris@samsung.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci/iov: fix kobject_uevent() ordering in sriov_enable()
Message-ID: <20231213192652.GA1054534@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170249390826.436889.13896090394795622449.stgit@bgt-140510-bm01.eng.stellus.in>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 06:58:28PM +0000, Jim Harris wrote:
> Wait to call kobject_uevent() until all of the associated changes are done,
> including updating the num_VFs value.

This seems right to me.  Can we add a little rationale to the commit
log?  E.g., something about how num_VFs is visible to userspace via
sysfs and we don't want a race between (a) userspace reading num_VFs
because of KOBJ_CHANGE and (b) the kernel updating num_VFs?  (If
that's the actual reason.)

If there's a problem report about this, include that reference as
well.

> Suggested by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/pci/iov.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 25dbe85c4217..3b768e20c7ab 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -683,8 +683,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	if (rc)
>  		goto err_pcibios;
>  
> -	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>  	iov->num_VFs = nr_virtfn;
> +	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>  
>  	return 0;
>  
> 
