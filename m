Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB867CA018
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJPHFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJPHFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:05:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E3D9;
        Mon, 16 Oct 2023 00:05:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A2B468AA6; Mon, 16 Oct 2023 09:05:31 +0200 (CEST)
Date:   Mon, 16 Oct 2023 09:05:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
Message-ID: <20231016070531.GA28537@lst.de>
References: <20231016070211.39502-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016070211.39502-1-gmazyland@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:02:11AM +0200, Milan Broz wrote:
> All common USB/SATA or USB/NVMe adapters I tested need this patch.
> 
> In short, these steps are run for OPAL support check:
>   1) Storage driver enables security driver flag (security_supported).
>      USB-attached storage drivers will enable it in a separate patchset.
>      SCSI and NNVMe drivers do it already. If the flag is not enabled,
>      no following steps are run, and OPAL remains disabled.
>   2) SCSI device enumerates SECURITY IN/OUT command support. If detected,
>      SECURITY ON/OUT wrapper is used (as in the current code).
>      If not, new ATA-12 pass-thru wrapper is used instead.
>   3) SED OPAL code tries OPAL discovery command for the device.
>      If it receives a correct reply, OPAL is enabled for the device.
>      If SCSI SECURITY or ATA-12 command with discovery command is rejected,
>      OPAL remains disabled.
> 
> Note, USB attached storage needs an additional patchset sent separately
> as requested by USB driver maintainers (it contains required changes
> related to USB quirk processing).

This just feels wrong.  These adapters are broken if they can't
translated, and we should not put ATA command submission into
sd.c.

> +	cdb[0] = ATA_12;
> +	cdb[1] = (send ? 5 /* ATA_PROTOCOL_PIO_DATA_IN */ : 4 /* ATA_PROTOCOL_PIO_DATA_OUT */) << 1;
> +	cdb[2] = 2 /* t_length */ | (1 << 2) /* byt_blok */ | ((send ?  0 : 1) << 3) /* t_dir */;
> +	cdb[3] = secp;
> +	put_unaligned_le16(len / 512, &cdb[4]);
> +	put_unaligned_le16(spsp, &cdb[6]);
> +	cdb[9] = send ? 0x5e /* ATA_CMD_TRUSTED_SND */: 0x5c /* ATA_CMD_TRUSTED_RCV */;


Also avoid all these crazy long lines, and please use the actual
constants.  Using a good old if/else is actually a very good way to
structure the code in a somewhat readable way.

> +		if (sdkp->security)
> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_sec_submit);
> +		else
> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_ata12_submit);

Messed up indentation here.

besides the fact that the statement is fundamentally wrong and you'll
start sending ATA command to random devices.
