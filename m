Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E157708EF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjHDTVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHDTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7436E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549DC620F9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 19:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88680C433C7;
        Fri,  4 Aug 2023 19:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691176900;
        bh=MWsb2DdQYJWtGNKDyuUQFngOkZf1+l6/DVDp5rm0/EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmgohbXmO42MLHw37bUmYKkYI3JQmG8/8uqnf66nwVAxRF925dnb1Xs99X1nJ7DwA
         E7y+uLv8ynN/3yiWE0I2dbvgRVegQ5Hqle7MbmQSsvY2jACPTL0mjxClN01yEwR5XL
         LzQ+Qr67yVjKLJ1TwIXQ3OLrvt2za321FNaUjG67g1Debm2ty4WoomGa+6tdK6vGsi
         9ceVc6h/4OJDGo6EaoQ75YVR84CdKDUXIvtfKOFzjHfkTwFlHDdMdD/kmPjotHm9bQ
         DG50rXghJns43omeR9LCPyBxr/sNbHIm+RC6xPvYdEIAwsjg+O2ifJrRbbwQmFt1Wi
         Sj10LwdZDHTjg==
Date:   Fri, 4 Aug 2023 12:21:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chao Yu <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up w/ sbi->log_sectors_per_block
Message-ID: <ZM1PwzoqSt05KqTp@google.com>
References: <20230523123521.67656-1-chao@kernel.org>
 <fafcfeosil5yqwn2wcdx33im2mq4xkejw6bx7h2in3ay5h6znj@facx4rrg4p65>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fafcfeosil5yqwn2wcdx33im2mq4xkejw6bx7h2in3ay5h6znj@facx4rrg4p65>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04, Shinichiro Kawasaki wrote:
> On May 23, 2023 / 20:35, Chao Yu wrote:
> > Use sbi->log_sectors_per_block to clean up below calculated one:
> > 
> > unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
> 
> Hello Chao,
> 
> When I ran workloads on f2fs using v6.5-rcX with fixes [1][2] and a zoned block
> devices with 4kb logical block size, I observe mount failure as follows. When
> I revert this commit, the failure goes away.
> 
> [  167.781975][ T1555] F2FS-fs (dm-0): IO Block Size:        4 KB
> [  167.890728][ T1555] F2FS-fs (dm-0): Found nat_bits in checkpoint
> [  171.482588][ T1555] F2FS-fs (dm-0): Zone without valid block has non-zero write pointer. Reset the write pointer: wp[0x1300,0x8]
> [  171.496000][ T1555] F2FS-fs (dm-0): (0) : Unaligned zone reset attempted (block 280000 + 80000)
> [  171.505037][ T1555] F2FS-fs (dm-0): Discard zone failed:  (errno=-5)
> 
> The patch replaced "sbi->log_blocksize - SECTOR_SHIFT" with
> "sbi->log_sectors_per_block". However, I think these two are not equal when the
> device has 4k logical block size. The former uses Linux kernel sector size 512
> byte. The latter use 512b sector size or 4kb sector size depending on the
> device. mkfs.f2fs obtains logical block size via BLKSSZGET ioctl from the device
> and reflects it to the value sbi->log_sector_size_per_block. This causes
> unexpected write pointer calculations in check_zone_write_pointer(). This
> resulted in unexpected zone reset and the mount failure.
> 
> I think this patch needs revert. What do you think?

Yeah, applied the revert.

> 
> [1] https://lkml.kernel.org/linux-f2fs-devel/20230711050101.GA19128@lst.de/
> [2] https://lore.kernel.org/linux-f2fs-devel/20230804091556.2372567-1-shinichiro.kawasaki@wdc.com/
