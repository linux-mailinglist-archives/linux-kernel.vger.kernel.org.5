Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C28751D66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjGMJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjGMJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:37:13 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5115211C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:37:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F37451BF207;
        Thu, 13 Jul 2023 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689241029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4n03VlwqNrTzGxnzSe3ZU7Gn2htAMkWYJH1ovqAe1uk=;
        b=gNtOQxpIUU3NyuNaletbc9HPDxJSzj1Ztx+wzywiX5PSiuOBkc26oFy2XNX7gyiJqxCbid
        35RF32A0Szbpupb5gtiR4Q5X91vCyJ+bUqLV6/seQDXeWDBFbSnUttzt+3e10zsJcv90eU
        Kt0+7QPL7Uk9zwjw9iY37pRL2jj69w2Ily/RpDR5yolDfEEFiydnam5b8K94qohtPyJZ1G
        wjjKwhF4MHY9YfJWaxkuV3BAhKGBPuL3etK/1LTkcB31t/IxU7wPgTLp8XrOGZDhRLelTZ
        QUIfvjZzFX0EzvedBP3dkVCexBtSpDo65CxKl42r2ZWnyxEbkL5SFh9uyi1gGg==
Date:   Thu, 13 Jul 2023 11:37:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH RESEND v5 2/2] nvmem: core: Expose cells through sysfs
Message-ID: <20230713113707.6ae8c5de@xps-13>
In-Reply-To: <0affe06b-08ad-aadf-c936-2c93b5e2b904@linaro.org>
References: <20230713075508.485072-1-miquel.raynal@bootlin.com>
        <20230713075508.485072-4-miquel.raynal@bootlin.com>
        <0affe06b-08ad-aadf-c936-2c93b5e2b904@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Thu, 13 Jul 2023 10:16:46 +0100:

> This one seems to be an extra patch in the series :-)

True /o\ It got mixed with the real series during the "resend"...

> 
> 
> 
> On 13/07/2023 08:55, Miquel Raynal wrote:
> > The binary content of nvmem devices is available to the user so in the
> > easiest cases, finding the content of a cell is rather easy as it is
> > just a matter of looking at a known and fixed offset. However, nvmem
> > layouts have been recently introduced to cope with more advanced
> > situations, where the offset and size of the cells is not known in
> > advance or is dynamic. When using layouts, more advanced parsers are
> > used by the kernel in order to give direct access to the content of each
> > cell, regardless of its position/size in the underlying
> > device. Unfortunately, these information are not accessible by users,
> > unless by fully re-implementing the parser logic in userland.
> > 
> > Let's expose the cells and their content through sysfs to avoid these
> > situations. Of course the relevant NVMEM sysfs Kconfig option must be
> > enabled for this support to be available.
> > 
> > Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> > group member will be filled at runtime only when relevant and will
> > remain empty otherwise. In this case, as the cells attribute group will
> > be empty, it will not lead to any additional folder/file creation.
> > 
> > Exposed cells are read-only. There is, in practice, everything in the
> > core to support a write path, but as I don't see any need for that, I
> > prefer to keep the interface simple (and probably safer). The interface
> > is documented as being in the "testing" state which means we can later
> > add a write attribute if though relevant.
> > 
> > There is one limitation though: if a layout is built as a module but is
> > not properly installed in the system and loaded manually with insmod
> > while the nvmem device driver was built-in, the cells won't appear in
> > sysfs. But if done like that, the cells won't be usable by the built-in
> > kernel drivers anyway.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/nvmem/core.c | 121 ++++++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 113 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 3f8c7718412b..8b49b12501e2 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -325,6 +325,43 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
> >   	return nvmem_bin_attr_get_umode(nvmem);
> >   }  
> >   > +static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,  
> > +					    const char *id, int index);
> > +
> > +static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
> > +				    struct bin_attribute *attr, char *buf,
> > +				    loff_t pos, size_t count)
> > +{
> > +	struct nvmem_cell_entry *entry;
> > +	struct nvmem_cell *cell = NULL;
> > +	size_t cell_sz, read_len;
> > +	void *content;
> > +
> > +	entry = attr->private;
> > +	cell = nvmem_create_cell(entry, entry->name, 0);
> > +	if (IS_ERR(cell))
> > +		return PTR_ERR(cell);
> > +
> > +	if (!cell)
> > +		return -EINVAL;
> > +
> > +	content = nvmem_cell_read(cell, &cell_sz);
> > +	if (IS_ERR(content)) {
> > +		read_len = PTR_ERR(content);
> > +		goto destroy_cell;
> > +	}
> > +
> > +	read_len = min_t(unsigned int, cell_sz - pos, count);
> > +	memcpy(buf, content + pos, read_len);
> > +	kfree(content);
> > +
> > +destroy_cell:
> > +	kfree_const(cell->id);
> > +	kfree(cell);
> > +
> > +	return read_len;
> > +}
> > +
> >   /* default read/write permissions */
> >   static struct bin_attribute bin_attr_rw_nvmem = {
> >   	.attr	= {
> > @@ -346,8 +383,14 @@ static const struct attribute_group nvmem_bin_group = {
> >   	.is_bin_visible = nvmem_bin_attr_is_visible,
> >   };  
> >   > +/* Cell attributes will be dynamically allocated */  
> > +static struct attribute_group nvmem_cells_group = {
> > +	.name		= "cells",
> > +};
> > +
> >   static const struct attribute_group *nvmem_dev_groups[] = {
> >   	&nvmem_bin_group,
> > +	&nvmem_cells_group,
> >   	NULL,
> >   };  
> >   > @@ -406,6 +449,58 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,  
> >   		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
> >   }  
> >   > +static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)  
> > +{
> > +	struct bin_attribute **cells_attrs, *attrs;
> > +	struct nvmem_cell_entry *entry;
> > +	unsigned int ncells = 0, i = 0;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&nvmem_mutex);
> > +
> > +	if (list_empty(&nvmem->cells))
> > +		goto unlock_mutex;
> > +
> > +	/* Allocate an array of attributes with a sentinel */
> > +	ncells = list_count_nodes(&nvmem->cells);
> > +	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
> > +				   sizeof(struct bin_attribute *), GFP_KERNEL);
> > +	if (!cells_attrs) {
> > +		ret = -ENOMEM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	attrs = devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribute), GFP_KERNEL);
> > +	if (!attrs) {
> > +		ret = -ENOMEM;
> > +		goto unlock_mutex;
> > +	}
> > +
> > +	/* Initialize each attribute to take the name and size of the cell */
> > +	list_for_each_entry(entry, &nvmem->cells, node) {
> > +		sysfs_bin_attr_init(&attrs[i]);
> > +		attrs[i].attr.name = devm_kstrdup(&nvmem->dev, entry->name, GFP_KERNEL);
> > +		attrs[i].attr.mode = 0444;
> > +		attrs[i].size = entry->bytes;
> > +		attrs[i].read = &nvmem_cell_attr_read;
> > +		attrs[i].private = entry;
> > +		if (!attrs[i].attr.name) {
> > +			ret = -ENOMEM;
> > +			goto unlock_mutex;
> > +		}
> > +
> > +		cells_attrs[i] = &attrs[i];
> > +		i++;
> > +	}
> > +
> > +	nvmem_cells_group.bin_attrs = cells_attrs;
> > +
> > +unlock_mutex:
> > +	mutex_unlock(&nvmem_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >   #else /* CONFIG_NVMEM_SYSFS */  
> >   >   static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,  
> > @@ -998,20 +1093,30 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >   	if (rval)
> >   		goto err_remove_cells;  
> >   > +	rval = nvmem_add_cells_from_layout(nvmem);  
> > +	if (rval)
> > +		goto err_remove_cells;
> > +
> > +	rval = nvmem_add_cells_from_fixed_layout(nvmem);
> > +	if (rval)
> > +		goto err_remove_cells;
> > +
> > +	rval = nvmem_add_cells_from_layout(nvmem);
> > +	if (rval)
> > +		goto err_remove_cells;
> > +
> > +#ifdef CONFIG_NVMEM_SYSFS
> > +	rval = nvmem_populate_sysfs_cells(nvmem);
> > +	if (rval)
> > +		goto err_remove_cells;
> > +#endif
> > +
> >   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);  
> >   >   	rval = device_add(&nvmem->dev);  
> >   	if (rval)
> >   		goto err_remove_cells;  
> >   > -	rval = nvmem_add_cells_from_fixed_layout(nvmem);  
> > -	if (rval)
> > -		goto err_remove_cells;
> > -
> > -	rval = nvmem_add_cells_from_layout(nvmem);
> > -	if (rval)
> > -		goto err_remove_cells;
> > -
> >   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);  
> >   >   	return nvmem;  

