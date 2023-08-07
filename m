Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7C772FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjHGT4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHGTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:55:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB08210F8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:55:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8010762122
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF749C433C8;
        Mon,  7 Aug 2023 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438154;
        bh=FLpUoUU84HaNScz6NMB6ng+JKBq4Mbm3GQuEgZXmsjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fV3gVUGLXIRTvLORYRTNW3aOv4XrPqCslAQjeGgwBPl1NgR2yTTb0I+WksrZXheCT
         zO7w09X0E+WrMG+vJw0GDyfZyRZuoTAR0QLYK5dnMlCxaFWCOD431iPRX1nPP4paEE
         2t4OVADEWhqHXcf1IxRHlUZYNqeZkrdf8tgdPTCxlozTwuyLBcrq5anVtP3rtDgv0g
         /Y/Wm/b/wzbAE/2QRO1gs+G+5tUr2bCqxYxEwoXaFAFzrudvkFrfT4dkIqRxRFJZzL
         GU3NNckeOIGONWxzngMxqjkuavMRTIEVNSnLudWMtNuxQs5UudL30+nabeu3GtXtSZ
         vRXJHXW3SWC0w==
Date:   Mon, 7 Aug 2023 12:55:53 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up w/ sbi->log_sectors_per_block
Message-ID: <ZNFMSde8S7ratVw6@google.com>
References: <20230523123521.67656-1-chao@kernel.org>
 <fafcfeosil5yqwn2wcdx33im2mq4xkejw6bx7h2in3ay5h6znj@facx4rrg4p65>
 <ZM1PwzoqSt05KqTp@google.com>
 <b3685d22-1be2-2376-5242-0e9a0f5471f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3685d22-1be2-2376-5242-0e9a0f5471f8@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07, Chao Yu wrote:
> On 2023/8/5 3:21, Jaegeuk Kim wrote:
> > On 08/04, Shinichiro Kawasaki wrote:
> > > On May 23, 2023 / 20:35, Chao Yu wrote:
> > > > Use sbi->log_sectors_per_block to clean up below calculated one:
> > > > 
> > > > unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
> > > 
> > > Hello Chao,
> > > 
> > > When I ran workloads on f2fs using v6.5-rcX with fixes [1][2] and a zoned block
> > > devices with 4kb logical block size, I observe mount failure as follows. When
> > > I revert this commit, the failure goes away.
> > > 
> > > [  167.781975][ T1555] F2FS-fs (dm-0): IO Block Size:        4 KB
> > > [  167.890728][ T1555] F2FS-fs (dm-0): Found nat_bits in checkpoint
> > > [  171.482588][ T1555] F2FS-fs (dm-0): Zone without valid block has non-zero write pointer. Reset the write pointer: wp[0x1300,0x8]
> > > [  171.496000][ T1555] F2FS-fs (dm-0): (0) : Unaligned zone reset attempted (block 280000 + 80000)
> > > [  171.505037][ T1555] F2FS-fs (dm-0): Discard zone failed:  (errno=-5)
> > > 
> > > The patch replaced "sbi->log_blocksize - SECTOR_SHIFT" with
> > > "sbi->log_sectors_per_block". However, I think these two are not equal when the
> > > device has 4k logical block size. The former uses Linux kernel sector size 512
> > > byte. The latter use 512b sector size or 4kb sector size depending on the
> > > device. mkfs.f2fs obtains logical block size via BLKSSZGET ioctl from the device
> > > and reflects it to the value sbi->log_sector_size_per_block. This causes
> > > unexpected write pointer calculations in check_zone_write_pointer(). This
> > > resulted in unexpected zone reset and the mount failure.
> > > 
> > > I think this patch needs revert. What do you think?
> > 
> > Yeah, applied the revert.
> 
> Jaegeuk, could you please send the patch to mailing list?

I sent. Thanks.

> 
> Thanks,
> 
> > 
> > > 
> > > [1] https://lkml.kernel.org/linux-f2fs-devel/20230711050101.GA19128@lst.de/
> > > [2] https://lore.kernel.org/linux-f2fs-devel/20230804091556.2372567-1-shinichiro.kawasaki@wdc.com/
