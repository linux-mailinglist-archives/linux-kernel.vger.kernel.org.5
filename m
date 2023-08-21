Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9327832AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjHUTzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHUTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FB910F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD73645A5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CA6C433C8;
        Mon, 21 Aug 2023 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692647705;
        bh=OtS0lXvjSqrdtcvC2Entbq8JIg6ohW/Oy05329jwwgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NOugbvpyR7UafA5FNrIHZAykho9OmDjFtQqwWW8syFK0kWpeAJRJJkaaMzikOc9Jb
         8ahzspVx498tINYTAmYTNm4LXn8WvM2yJftuzhLF/+I1NB+QpiBRyqhv1vDQtmlrqS
         RNPzGXsdTdXgnTieH2k2YBlNhymnEu4gGRnG2bTMndzVKju8qajSPGOrADMflRKbXq
         dmaGMd7Wg5yFXACjVaou2GViF7kSJTFlwzcSkJFY2bcQjqkAwX6FWxbvyMkRrKcPkG
         9/ftRUoEKzfSb9CMRK4p0eohDslbZQondYXhn3cJRu9besnC2gcuSm2KkzHFczotkO
         jgXtRiXT5MRcA==
Date:   Mon, 21 Aug 2023 14:55:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/2] PCI: implement custom llseek method for
 PCI resource entries in sysfs
Message-ID: <20230821195501.GA367249@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821072956.114193-2-valesini@yandex-team.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In subject, to match history:

  PCI: Implement custom llseek for sysfs resource entries

On Mon, Aug 21, 2023 at 12:29:56PM +0500, Valentine Sinitsyn wrote:
> Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"), mmapable
> sysfs entries have started to receive their f_mapping from the iomem
> pseudo filesystem, so that CONFIG_IO_STRICT_DEVMEM is honored in sysfs
> (and procfs) as well as in /dev/[k]mem.

s/mmapable/mmappable/ (there's precedent for both, but by analogy with
"mappable", I think "mmappable" makes more sense)

> This resulted in a userspace-visible regression:
> 
> 1. Open a sysfs PCI resource file (eg. /sys/bus/pci/devices/*/resource0)
> 2. Use lseek(fd, 0, SEEK_END) to determine its size
> 
> Expected result: a PCI region size is returned.
> Actual result: 0 is returned.
> 
> The reason is that PCI resource files residing in sysfs use
> generic_file_llseek(), which relies on f_mapping->host inode to get the
> file size. As f_mapping is now redefined, f_mapping->host points to an
> anonymous zero-sized iomem_inode which has nothing to do with sysfs file
> in question.
> 
> Implement a custom llseek method for sysfs PCI resources, which is
> almost the same as proc_bus_pci_lseek() used for procfs entries.
> 
> This makes sysfs and procfs entries consistent with regards to seeking,
> but also introduces userspace-visible changes to seeking PCI resources
> in sysfs:
> 
> - SEEK_DATA and SEEK_HOLE are no longer supported;
> - Seeking past the end of the file is prohibited while previously
>   offsets up to MAX_NON_LFS were accepted (reading from these offsets
>   was always invalid).
> 
> Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>

It'd be nice but not essential to tweak commit log as above.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Looks like the patch didn't get to lkml, resending
> 
>  drivers/pci/pci-sysfs.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index ab32a91f287b..42eaeb8d4a4f 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -967,6 +967,8 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_io->attr.mode = 0600;
>  	b->legacy_io->read = pci_read_legacy_io;
>  	b->legacy_io->write = pci_write_legacy_io;
> +	/* See pci_create_attr() for motivation */
> +	b->legacy_io->llseek = pci_llseek_resource;
>  	b->legacy_io->mmap = pci_mmap_legacy_io;
>  	b->legacy_io->f_mapping = iomem_get_mapping;
>  	pci_adjust_legacy_attr(b, pci_mmap_io);
> @@ -981,6 +983,8 @@ void pci_create_legacy_files(struct pci_bus *b)
>  	b->legacy_mem->size = 1024*1024;
>  	b->legacy_mem->attr.mode = 0600;
>  	b->legacy_mem->mmap = pci_mmap_legacy_mem;
> +	/* See pci_create_attr() for motivation */
> +	b->legacy_io->llseek = pci_llseek_resource;
>  	b->legacy_mem->f_mapping = iomem_get_mapping;
>  	pci_adjust_legacy_attr(b, pci_mmap_mem);
>  	error = device_create_bin_file(&b->dev, b->legacy_mem);
> @@ -1138,6 +1142,14 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
>  	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
>  }
>  
> +static loff_t pci_llseek_resource(struct file *filep,
> +				  struct kobject *kobj __always_unused,
> +				  struct bin_attribute *attr,
> +				  loff_t offset, int whence)
> +{
> +	return fixed_size_llseek(filep, offset, whence, attr->size);
> +}
> +
>  /**
>   * pci_remove_resource_files - cleanup resource files
>   * @pdev: dev to cleanup
> @@ -1195,8 +1207,15 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
>  			res_attr->mmap = pci_mmap_resource_uc;
>  		}
>  	}
> -	if (res_attr->mmap)
> +	if (res_attr->mmap) {
>  		res_attr->f_mapping = iomem_get_mapping;
> +		/*
> +		 * generic_file_llseek() consults f_mapping->host to determine
> +		 * the file size. As iomem_inode knows nothing about the
> +		 * attribute, it's not going to work, so override it as well.
> +		 */
> +		res_attr->llseek = pci_llseek_resource;
> +	}
>  	res_attr->attr.name = res_attr_name;
>  	res_attr->attr.mode = 0600;
>  	res_attr->size = pci_resource_len(pdev, num);
> -- 
> 2.34.1
> 
