Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8243E7CA951
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjJPN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:27:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD3AD;
        Mon, 16 Oct 2023 06:27:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A32006732D; Mon, 16 Oct 2023 15:27:30 +0200 (CEST)
Date:   Mon, 16 Oct 2023 15:27:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
Message-ID: <20231016132730.GA27013@lst.de>
References: <20231016070211.39502-1-gmazyland@gmail.com> <20231016070531.GA28537@lst.de> <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com> <0c7f0599-40de-417a-842d-d0aba842d115@kernel.org> <5831286b-e3d0-4b87-9c5c-dbcb420d1b67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5831286b-e3d0-4b87-9c5c-dbcb420d1b67@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:46:03PM +0200, Milan Broz wrote:
> The problem is that we (for simplicity) decided to use kernel SED-ioctl interface that
> internally wraps OPAL command to SCSI SECURITY command only. It means, that all devices

No, it doesn't.  It uses the properly specified protocol for each
layer.  That is NVMe uses NVMe Security Send/Receive, SCSI uses the
SCSI protocol, and libata translats for ATA devices.

> that can use ATA-12 just cannot work with this kernel interface (unlike userspace which
> can decide which wrapper to use).

It supports all devices that actually speak ATA perfectly fine, take
a look at ata_scsi_security_inout_xlat.

>
> And IMO it is not correct - if it was designed only for some servers with directly connected
> devices, then it is really not generic OPAL support. It should work for any hw that supports it.

Let's get off your crack pipe before we continue.  It is designed and
implemented to support the security protocols exactly as spec'ed.

You seem to have found devices that claim to be SCSI, but actually
require ATA passthrough for security.  That's no secret cabal to lock
out non-server hardware but just proper protocol design.

> For USB, it actually works quite nice with the patch (ignoring usual bugs in firmware).

So move it into usb if you can convince the usb maintainers that they
are fine with it.

>
>>
>> Note that nowhere in your patch do you test if you are talking to an ATA device.
>
> Yes, I know. I expected the command to be rejected if not supported.

Good luck.  Cheap storage hardware trips up on unknown commands all the
time.

> IMO it is quite similar to discard/TRIM support...

Where we also don't support weird ATA commands directly from sd
for good reason.

