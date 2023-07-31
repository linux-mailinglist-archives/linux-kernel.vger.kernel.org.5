Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0C5769B69
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjGaPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjGaPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:54:42 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10651197
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:54:38 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qQVEA-0000u1-0a;
        Mon, 31 Jul 2023 15:54:34 +0000
Date:   Mon, 31 Jul 2023 16:54:01 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: core: append offset to cell name in sysfs
Message-ID: <ZMfZGSDtd5OXtc39@makrotopia.org>
References: <ZLaZ7fzUSsa0Igx1@makrotopia.org>
 <20230731174506.00368411@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731174506.00368411@xps-13>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Mon, Jul 31, 2023 at 05:45:06PM +0200, Miquel Raynal wrote:
> Hi Daniel,
> 
> daniel@makrotopia.org wrote on Tue, 18 Jul 2023 14:55:57 +0100:
> 
> > The device tree node names are not required to be unique. Append the
> > offset to the name to make cell nodes with identical names become
> > accessible via sysfs and avoid kernel stackdump caused by
> > sysfs: cannot create duplicate filename '...'
> > 
> > Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/nvmem/core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 70e951088826d..90fe9dc30f8ba 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -480,7 +480,9 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> >  	/* Initialize each attribute to take the name and size of the cell */
> >  	list_for_each_entry(entry, &nvmem->cells, node) {
> >  		sysfs_bin_attr_init(&attrs[i]);
> > -		attrs[i].attr.name = devm_kstrdup(&nvmem->dev, entry->name, GFP_KERNEL);
> > +		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
> > +						    "%s@%d", entry->name,
> > +						    entry->offset);
> 
> Shouldn't we use %s@%x instead to match the DT descriptions?

True, I agree.

> 
> >  		attrs[i].attr.mode = 0444;
> >  		attrs[i].size = entry->bytes;
> >  		attrs[i].read = &nvmem_cell_attr_read;
> 
> I plan another version of the series which triggered these patches, if
> you don't mind I will squash patch 1 into my patches and pick this one
> as a preparation change (likely with the above fix if you agree and
> without the Fixes tag).

Yes, sure, please go ahead.


Cheers


Daniel

> 
> Thanks,
> Miquèl
