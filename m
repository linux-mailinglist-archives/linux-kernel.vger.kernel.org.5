Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92E784A05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHVTOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHVTOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:14:15 -0400
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [IPv6:2801:82:80ff:7fff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EFCED;
        Tue, 22 Aug 2023 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1692731639;
        bh=r2WY21HfAxQdW/OWjI0vSq9iHNBngP94lJY11ZPFXYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMszPhc+4JW59+jJOJMnozhXRUKgRC8kVYdFX5Dkp4InXzwN0Ut3269sz3sprhBiA
         6JdsxwKE0+KhjoUAGevhartrtNsvGoHPYjdwCDtnJAkvuvZeuubFc71U1zOile6WsG
         +dy4V1sz91Mli3xyKgT8KDApfnQbW5uzO4r9jJaa7U1yh6tvIVBR35P+w13loMdr2U
         6QMVcqiUHhq/WyVCFHfnICDIUtActpR4nkwAyAgGodlzmSc0ImkfX9hinFSi85KWh8
         rOX5DGfeFfKar+w1zmRgNonKlWBLmZM8egYuhATDAZjODXCaL3+YAHryrbuR6xEVkT
         17TGJG9jDT5hA==
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id 6D5FF3620360; Tue, 22 Aug 2023 16:13:59 -0300 (-03)
Date:   Tue, 22 Aug 2023 16:13:59 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     Song Liu <song@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>, AceLan Kao <acelan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Message-ID: <ZOUI9yDzjxuFP68E@fisica.ufpr.br>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <CAPhsuW5Od9tczboEBxC8gn+2XLkEbirfCUm7WuJBey5MKQjwDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW5Od9tczboEBxC8gn+2XLkEbirfCUm7WuJBey5MKQjwDA@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Liu (song@kernel.org) wrote on Tue, Aug 22, 2023 at 03:56:04PM -03:
> >From systemd code, i.e. function delete_md(), this error:
> 
> [ 205.957004] systemd-shutdown[1]: Stopping MD /dev/md124p1 (259:6).
> [ 205.964177] systemd-shutdown[1]: Could not stop MD /dev/md124p1:
> Device or resource busy
> 
> is most likely triggered by ioctl(STOP_ARRAY).
> 
> And based on the code, I think the ioctl fails here:
> 
>         if (cmd == STOP_ARRAY || cmd == STOP_ARRAY_RO) {
>                 /* Need to flush page cache, and ensure no-one else opens
>                  * and writes
>                  */
>                 mutex_lock(&mddev->open_mutex);
>                 if (mddev->pers && atomic_read(&mddev->openers) > 1) {
>                         mutex_unlock(&mddev->open_mutex);
>                         err = -EBUSY;
>                         goto out;        ////////////////////// HERE
>                 }
>                 if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
>                         mutex_unlock(&mddev->open_mutex);
>                         err = -EBUSY;
>                         goto out;
>                 }
>                 did_set_md_closing = true;
>                 mutex_unlock(&mddev->open_mutex);
>                 sync_blockdev(bdev);
>         }

Probably. The problem is why doesn't it manage to flush the page cache? I find
strange that the problem appears only when trying to stop the array, I get it
when trying to umount the filesystem, where it also hangs because of the same
reason. The kworker thread runs continuously using 100% cpu of only 1 core.

These are all similar symptoms of the underlying problem which I complained
about days ago: the system doesn't manage to write to the disks, which stay
nearly idle. If you wait long enough without issuing writes, which can be
several hours, it'll eventually flush the page cache and proceed to a "normal"
umount or reboot.

The bug is dependent on the rate of writes and also on uptime; it rarely
appears soon after boot, and increases as times passes.
