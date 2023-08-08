Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A37773586
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 02:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHHAsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 20:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHHAs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E52170B;
        Mon,  7 Aug 2023 17:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B87086233B;
        Tue,  8 Aug 2023 00:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EBEC433C7;
        Tue,  8 Aug 2023 00:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691455708;
        bh=6PjpG/yBmovC2lWrM3FLycfIZttTgbH8fpSd7ReR39U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ub5fxKJRhB9BYv+vYgp/sIPn13iURlxUQS/3XAlSYx+Fzqzb5X89wfRZg6aUWiWgS
         P+YPKIjH1mCILpaTqJqwgbU+TuL29luYo6Esx79wqW8BuLevBPMc10XBAYWeOkqlOl
         o44h3MTnpYhCLwfAiQoVLp48wbJSdBkGhDP5iGySoL/kmu8Fyt9O6i/l20HrDOr8hu
         b+ko4crNwqkio+8FY5nQvsPwDIN5/QyF9K1lIXvFKWNJRApvHVVx9lFPBnIVdKMLYy
         2aQsz0BwzmDwm3Fg5zJFRNsS4RKAUplV4Hg3DafLTgwSbk7Sn4nck8NlkxrE05i2vF
         ztVYlUaGxzTgg==
Message-ID: <eefdd25f-502c-8ab4-c49b-f1cb2c6bfd2a@kernel.org>
Date:   Tue, 8 Aug 2023 08:48:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: clean up w/
 sbi->log_sectors_per_block"
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        stable@vger.kernel.org
References: <20230807195219.371131-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230807195219.371131-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/8 3:52, Jaegeuk Kim wrote:
> This reverts commit bfd476623999118d9c509cb0fa9380f2912bc225.
> 
> Shinichiro Kawasaki reported:
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
> [1] https://lkml.kernel.org/linux-f2fs-devel/20230711050101.GA19128@lst.de/
> [2] https://lore.kernel.org/linux-f2fs-devel/20230804091556.2372567-1-shinichiro.kawasaki@wdc.com/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: bfd476623999 ("f2fs: clean up w/ sbi->log_sectors_per_block")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
