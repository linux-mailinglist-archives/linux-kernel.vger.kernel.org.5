Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF17F53A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjKVWqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKVWqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:46:02 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8AD8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:45:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1r5vyj-0007xT-Si; Wed, 22 Nov 2023 23:45:53 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1r5vyj-00AuMF-4Q; Wed, 22 Nov 2023 23:45:53 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1r5vyj-003Mus-1S; Wed, 22 Nov 2023 23:45:53 +0100
Date:   Wed, 22 Nov 2023 23:45:53 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v13 4/6] nvmem: core: Rework layouts to become regular
 devices
Message-ID: <20231122224553.cfklcv6rew6ktixj@pengutronix.de>
References: <20231011111529.86440-1-miquel.raynal@bootlin.com>
 <20231011111529.86440-5-miquel.raynal@bootlin.com>
 <20231122220240.4jg245vblnh6d5zy@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122220240.4jg245vblnh6d5zy@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

sorry for answering to my own mail, I forgot something I noticed later.

On 23-11-22, Marco Felsch wrote:
> Hi Miquel,
> 
> thanks a lot for your effort on this. Please see my comments inline.
> 
> On 23-10-11, Miquel Raynal wrote:
> > Current layout support was initially written without modules support in
> > mind. When the requirement for module support rose, the existing base
> > was improved to adopt modularization support, but kind of a design flaw
> > was introduced. With the existing implementation, when a storage device
> > registers into NVMEM, the core tries to hook a layout (if any) and
> > populates its cells immediately. This means, if the hardware description
> > expects a layout to be hooked up, but no driver was provided for that,
> > the storage medium will fail to probe and try later from
> > scratch. Even if we consider that the hardware description shall be
> > correct, we could still probe the storage device (especially if it
> > contains the rootfs).
> > 
> > One way to overcome this situation is to consider the layouts as
> > devices, and leverage the existing notifier mechanism. When a new NVMEM
> > device is registered, we can:
> > - populate its nvmem-layout child, if any
> > - try to modprobe the relevant driver, if relevant

I'm not sure why we call of_request_module() the driver framework should
handle that right?

> > - try to hook the NVMEM device with a layout in the notifier

The last part is no longer true since you don't use the notifier
anymore.

> > And when a new layout is registered:
> > - try to hook all the existing NVMEM devices which are not yet hooked to
> >   a layout with the new layout
> > This way, there is no strong order to enforce, any NVMEM device creation
> > or NVMEM layout driver insertion will be observed as a new event which
> > may lead to the creation of additional cells, without disturbing the
> > probes with costly (and sometimes endless) deferrals.
> > 
> > In order to achieve that goal we need:
> > * To keep track of all nvmem devices
> > * To create a new bus for the nvmem-layouts with minimal logic to match
> >   nvmem-layout devices with nvmem-layout drivers.
> > All this infrastructure code is created in the layouts.c file.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Tested-by: Rafał Miłecki <rafal@milecki.pl>

...

> > @@ -944,19 +872,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >  			goto err_put_device;
> >  	}
> >  
> > -	/*
> > -	 * If the driver supplied a layout by config->layout, the module
> > -	 * pointer will be NULL and nvmem_layout_put() will be a noop.
> > -	 */
> > -	nvmem->layout = config->layout ?: nvmem_layout_get(nvmem);
> > -	if (IS_ERR(nvmem->layout)) {
> > -		rval = PTR_ERR(nvmem->layout);
> > -		nvmem->layout = NULL;
> > -
> > -		if (rval == -EPROBE_DEFER)
> > -			goto err_teardown_compat;
> > -	}

Since this logic will be gone and the layout became a device the fixup
hook for the layout is more than confusing. E.g. the imx-ocotp driver
uses the layout to register a fixup for a cell which is fine but the
hook should be moved from the layout[-dev] to the config. Please see
below.

> > -
> >  	if (config->cells) {
> >  		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
> >  		if (rval)
> > @@ -975,7 +890,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >  	if (rval)
> >  		goto err_remove_cells;
> >  
> > -	rval = nvmem_add_cells_from_layout(nvmem);
> > +	rval = nvmem_populate_layout(nvmem);
> >  	if (rval)
> >  		goto err_remove_cells;

Also why do we populate the nvmem-layout device infront of the nvmem
device?

> >  
> > @@ -983,16 +898,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
> >  
> >  	rval = device_add(&nvmem->dev);
> >  	if (rval)
> > -		goto err_remove_cells;
> > +		goto err_destroy_layout;
> > +
> >  
> >  	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> >  
> >  	return nvmem;
> >  
> > +err_destroy_layout:
> > +	nvmem_destroy_layout(nvmem);
> >  err_remove_cells:
> >  	nvmem_device_remove_all_cells(nvmem);
> > -	nvmem_layout_put(nvmem->layout);
> > -err_teardown_compat:
> >  	if (config->compat)
> >  		nvmem_sysfs_remove_compat(nvmem, config);
> >  err_put_device:
> > @@ -1014,7 +930,7 @@ static void nvmem_device_release(struct kref *kref)
> >  		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
> >  
> >  	nvmem_device_remove_all_cells(nvmem);
> > -	nvmem_layout_put(nvmem->layout);
> > +	nvmem_destroy_layout(nvmem);
> >  	device_unregister(&nvmem->dev);
> >  }
> >  

...

> > diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> > index 2905f9e6fc2a..a0ea8326605a 100644
> > --- a/include/linux/nvmem-provider.h
> > +++ b/include/linux/nvmem-provider.h
> > @@ -9,6 +9,7 @@
> >  #ifndef _LINUX_NVMEM_PROVIDER_H
> >  #define _LINUX_NVMEM_PROVIDER_H
> >  
> > +#include <linux/device.h>
> >  #include <linux/device/driver.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > @@ -154,15 +155,13 @@ struct nvmem_cell_table {
> >  /**
> >   * struct nvmem_layout - NVMEM layout definitions
> >   *
> > - * @name:		Layout name.
> > - * @of_match_table:	Open firmware match table.
> > + * @dev:		Device-model layout device.
> > + * @nvmem:		The underlying NVMEM device
> >   * @add_cells:		Will be called if a nvmem device is found which
> >   *			has this layout. The function will add layout
> >   *			specific cells with nvmem_add_one_cell().
> >   * @fixup_cell_info:	Will be called before a cell is added. Can be
> >   *			used to modify the nvmem_cell_info.
> > - * @owner:		Pointer to struct module.
> > - * @node:		List node.
> >   *
> >   * A nvmem device can hold a well defined structure which can just be
> >   * evaluated during runtime. For example a TLV list, or a list of "name=val"
> > @@ -170,17 +169,19 @@ struct nvmem_cell_table {
> >   * cells.
> >   */
> >  struct nvmem_layout {
> 
> Since this became a device now should we refelct this within the struct
> name, e.g. nvmem_layout_dev, nvmem_ldev, nvm_ldev?
> 
> Regards,
>   Marco
> 
> > -	const char *name;
> > -	const struct of_device_id *of_match_table;
> > +	struct device dev;
> > +	struct nvmem_device *nvmem;
> >  	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
> >  			 struct nvmem_layout *layout);
> >  	void (*fixup_cell_info)(struct nvmem_device *nvmem,
> >  				struct nvmem_layout *layout,
> >  				struct nvmem_cell_info *cell);

I speak about this hook. This should be moved into the config, maybe
also renamed to fixup_dt_cell_info() or so to not confuse the users. If
we move that hook and remove the add_cells hook there are only two
members left for the cross-link.

Regards,
  Marco
