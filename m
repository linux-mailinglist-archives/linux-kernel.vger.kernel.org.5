Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE87FA515
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjK0Pov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjK0Pou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:44:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6203619A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:44:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B9BC433C8;
        Mon, 27 Nov 2023 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701099895;
        bh=gvIJxTodTVCzgI7+DCND4759lIJLFTQk3aIMqIUYV+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAbOfEmf9G1gGLkJt3Y5A0jNlDZHEvGgGrNrCOotLf5Frk67z4tI6hhL/0f9dSUUV
         zjG1M/pbvAT4Mdl7X5gPeIyzi7CsTPpbvodP87CXI4wZwUbHX7VAYO/MJs/6stz7gH
         S2ULbgZnt8VepBsg1NEHiALEbzfFu9jJ/8pZPORUjJeF455exQQ57haCUydSQdAK5P
         idI0DvN32TrI+4v3Sfpw9Ourig+8tbTXpEYdOQT4lKtnKmW18/+UStn5SXBSDPboMy
         CWEJAZN7BF6+Mw6sStSCFTGVoGvxIm1xkAraG4fUqYYeljwxonDwcBfnaT/58ArMWZ
         fgmFqRdRqwNeg==
Date:   Mon, 27 Nov 2023 08:44:52 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127141857.GA25833@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:18:57PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 11:32:08AM +0100, Daniel Wagner wrote:
> > +static ssize_t lba_ms_show(struct device *dev, struct device_attribute *attr,
> > +		char *buf)
> > +{
> > +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> > +
> > +	return sysfs_emit(buf, "%d\n", ns->ms);
> > +}
> > +static DEVICE_ATTR_RO(lba_ms);
> 
> I'd probably spell out metadata_size, or probably even better
> metadata_bytes to match the unit postfixes elsewhere in the block code.

Should this even be an nvme specific attribute? I thought we should have
blk-integrity.c report its 'tuple_size' attribute instead. That should
work as long as we're not dealing with extended metadata at least, but
that's kind of a special format that doesn't have block layer support.
