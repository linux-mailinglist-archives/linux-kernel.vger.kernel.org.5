Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10BE7569C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGQQ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGQQ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29197E1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B298161182
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC7DC433C7;
        Mon, 17 Jul 2023 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689613195;
        bh=otdaFhyLKG+XHCXyb9xUtpzUYG/IftW+/iX9ZL3v1oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIx1Ml97/RaJkcUh9lRv0d/pz49piIYrmHAK/4Eb4lnHirGTLR/mSuNDfoBzjQW/T
         vi5PKE6/TtKJ4kIchW3JpStwWALkj25rzroPr0qq2aQOlwkjJkBYvrlSsR0vKkkfmL
         PRSg4kJiyq9iV6mYahecmAq9DPJkgoN8kB46Uz9c=
Date:   Mon, 17 Jul 2023 18:59:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <2023071724-twiddling-morale-157e@gregkh>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
 <20230717075147.43326-4-miquel.raynal@bootlin.com>
 <2023071717-channel-supernova-4cc9@gregkh>
 <20230717183323.49a55ad0@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717183323.49a55ad0@xps-13>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:33:23PM +0200, Miquel Raynal wrote:
> Hi Greg,
> 
> gregkh@linuxfoundation.org wrote on Mon, 17 Jul 2023 16:32:09 +0200:
> 
> > On Mon, Jul 17, 2023 at 09:51:47AM +0200, Miquel Raynal wrote:
> > > The binary content of nvmem devices is available to the user so in the
> > > easiest cases, finding the content of a cell is rather easy as it is
> > > just a matter of looking at a known and fixed offset. However, nvmem
> > > layouts have been recently introduced to cope with more advanced
> > > situations, where the offset and size of the cells is not known in
> > > advance or is dynamic. When using layouts, more advanced parsers are
> > > used by the kernel in order to give direct access to the content of each
> > > cell, regardless of its position/size in the underlying
> > > device. Unfortunately, these information are not accessible by users,
> > > unless by fully re-implementing the parser logic in userland.
> > > 
> > > Let's expose the cells and their content through sysfs to avoid these
> > > situations. Of course the relevant NVMEM sysfs Kconfig option must be
> > > enabled for this support to be available.
> > > 
> > > Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> > > group member will be filled at runtime only when relevant and will
> > > remain empty otherwise. In this case, as the cells attribute group will
> > > be empty, it will not lead to any additional folder/file creation.
> > > 
> > > Exposed cells are read-only. There is, in practice, everything in the
> > > core to support a write path, but as I don't see any need for that, I
> > > prefer to keep the interface simple (and probably safer). The interface
> > > is documented as being in the "testing" state which means we can later
> > > add a write attribute if though relevant.
> > > 
> > > There is one limitation though: if a layout is built as a module but is
> > > not properly installed in the system and loaded manually with insmod
> > > while the nvmem device driver was built-in, the cells won't appear in
> > > sysfs. But if done like that, the cells won't be usable by the built-in
> > > kernel drivers anyway.  
> > 
> > Wait, what?  That should not be an issue here, if so, then this change
> > is not correct and should be fixed as this is NOT an issue for sysfs
> > (otherwise the whole tree wouldn't work.)
> > 
> > Please fix up your dependancies if this is somehow not working properly.
> 
> I'm not sure I fully get your point.
> 
> There is no way we can describe any dependency between a storage device
> driver and an nvmem layout. NVMEM is a pure software abstraction, the
> layout that will be chosen depends on the device tree, but if the
> layout has not been installed, there is no existing mechanism in
> the kernel to prevent it from being loaded (how do you know it's
> not on purpose?).

Once a layout has been loaded, the sysfs files should show up, right?
Otherwise what does a "layout" do?  (hint, I have no idea, it's an odd
term to me...)

thanks,

greg k-h
