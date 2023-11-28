Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7427FC3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376277AbjK1TC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjK1TCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:02:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE22CC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:03:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF7C433C8;
        Tue, 28 Nov 2023 19:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701198181;
        bh=2SQ8nvZfspwKy1et1VHxsaVcIH7exyr+AqAnPoaC4q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIqofS+xJmG1Hdyo9mOGQ7WWhrSLt7JnhNRiAWWhDW2eqrXLV0YqBF8x+IAXTCBAY
         7SrHq5chBNn6+yG3xBeuSrOzyGVYcEB2MOLhc+OJ6mszIcKIjAU3cD7YSGSZNHvExx
         iYqofMI4dh+xkcF3HxISDhGdR35hcd14Lnhulw9kOXo0S9mSOVFlhtqbtXjSLHpy9K
         aKYswY96frh8VpfXZaUrbK9KqE3eOtZffK5w2EIBqGQpwhV1YcGJFW44LTBc9wTKsF
         cYf0Hnp6I6V7NSC/Lx3cziaEoI3BJc7dUG/e1U+YupqvYDFQzK8tpsFpJJWR96lSdv
         FOFUi6jQo9ODg==
Date:   Tue, 28 Nov 2023 12:02:58 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWY5YkYJ4Pf0meiD@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
 <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
 <20231128130508.GA8221@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128130508.GA8221@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 02:05:08PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 09:46:43AM -0700, Keith Busch wrote:
> > > 
> > > Yes.  But does it care about the tuple size, or the actual size of the
> > > metadata field even if is bigger than the PI tuple?
> > 
> > tuple_size is the same value as metadata size regardless of PI usage.
> > See nvme_init_integrity() for how this driver sets it:
> > 
> > 	integrity.tuple_size = ns->ms;
> 
> Yes, for the case where we actually support integrity in the kernel
> for a given device.  But if the device has a metadata size larger than
> the PI size we still support it, and just let the device strip/insert
> the PI.

I'm pretty sure that isn't right. We already support PI regardless of
the metadata size as long as the PI field is in the first 8 bytes.
Strip/insert doesn't even work if metadata is larger than a PI field.
For any metadata case where PI isn't used, the driver requests
allocating an empty buffer for the purpose.

> And if nvme-cli wants to report detailed information about
> the namespace it probably needs to report the actual metadata size
> as the tuple size won't be reported given that we're never initializing
> the kernel PI support.

I don't understand. For any namespace with a metadata size, even if the
namespace format doesn't have PI support, we still register an
"integrity" profile with no-ops to get that unused buffer just so the
block layer can access the format. We alyways set the tuple_size to the
namespace metadata-size so the kernel buffer is correctly sized.

This all works as long as the metadata is separate (not extended) and
kernel has CONFIG_BLK_DEV_INTEGRITY.
