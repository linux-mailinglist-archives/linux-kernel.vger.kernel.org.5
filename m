Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113D87580DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjGRP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjGRP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:29:24 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046A1723
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:29:20 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qLmdW-00007C-2y;
        Tue, 18 Jul 2023 15:29:15 +0000
Date:   Tue, 18 Jul 2023 16:29:07 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmem: core: clear sysfs attributes for each NVMEM
 device
Message-ID: <ZLavw9ZyXMWMqTu_@makrotopia.org>
References: <ZLaZ03PzkbPNJQ3b@makrotopia.org>
 <e155a4bf-46b7-c07a-f3e0-80fae8108f56@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e155a4bf-46b7-c07a-f3e0-80fae8108f56@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:55:56PM +0100, Srinivas Kandagatla wrote:
> HI Daniel,
> 
> On 18/07/2023 14:55, Daniel Golle wrote:
> > Set nvmem_cells_group.bin_attrs to NULL in case of an NVMEM device not
> > having any cells in order to make sure sysfs attributes of a previously
> > registered NVMEM device are not accidentally reused for a follow-up
> > device which doesn't have any cells.
> > 
> > Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs")
> 
> These patches are dropped out of nvmem next branch as it was breaking some
> existing users.

Ok. I've encountered those commits in linux-next and can confirm that
they were definitely also breaking things here, hence my patches at
least partially fixing that.

I agree that reverting them for now and reworking them seems to be the
better option in this case, hence my patches won't be needed as such.

> 
> 
> --srini
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >   drivers/nvmem/core.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 6c04a9cf6919f..70e951088826d 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -458,9 +458,10 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> >   	mutex_lock(&nvmem_mutex);
> > -	if (list_empty(&nvmem->cells))
> > +	if (list_empty(&nvmem->cells)) {
> > +		nvmem_cells_group.bin_attrs = NULL;
> >   		goto unlock_mutex;
> > -
> > +	}
> >   	/* Allocate an array of attributes with a sentinel */
> >   	ncells = list_count_nodes(&nvmem->cells);
> >   	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
