Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3178A02E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjH0QaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjH0QaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:30:05 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322ACDA;
        Sun, 27 Aug 2023 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5i8D4HHHlCmzPLAKSkeyTIr3vFv/H5xpN5LHdgMFSxQ=; b=j36J1xWqSa+oYPiz9puySZkcWY
        gVhNZtK7r4tUpW6vze3OPSxMJ7eZH8iioI1bAE+sa0qOPcHzGYnaVwdYwr8x++Z5fh59DtGon2X3D
        sraDzol7yJL73vAWs7uqHmtxfFfE0xFYWpmrD93sHYy9rOe4xIj283YLHg2zrce1aP3FWk7iG/wQg
        xbdlemjBfP0rm9fAG9bdOy+Q5iqJObbMPSxF2tMCQPZ0AHPCuuO4/h2kKMLxW2dlSpKn6fJy5cD7P
        End8Tfsx0tCVZcZ1/xaJz8PHa6E6r3RI8I4cxixnlelH81LVtUAcXYHEwlNzdVkiDK7c3QC+QK2mT
        +xtWb5YQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qaIeG-001Lyf-0U;
        Sun, 27 Aug 2023 16:30:00 +0000
Date:   Sun, 27 Aug 2023 17:30:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Joshua Hudson <joshudson@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Cache coherency bug: stale reads on /dev/sda1
Message-ID: <20230827163000.GS3390869@ZenIV>
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me>
 <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
 <20230827020635.GQ3390869@ZenIV>
 <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
 <20230827041716.GR3390869@ZenIV>
 <CA+jjjYRY4+ZwX6OJQ1Ax16i5roRh-BPePPjyGv7coxvBrxXiEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jjjYRY4+ZwX6OJQ1Ax16i5roRh-BPePPjyGv7coxvBrxXiEQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 07:39:03AM -0700, Joshua Hudson wrote:
> (Good news: finally found the invisible button to edit reply quote)
> 
> Offset 0x1C into the FAT filesystem is defined as "Count of hidden
> sectors preceding
> the partition that contains this FAT volume." It's been there since
> DOS 3.0. The Linux
> Kernel does not care what's in this field, but I have tools that have
> a hard time of it
> not being there. One example of a tool is BootDuet.
> 
> The rationale is to reduce the number of tools that have to walk the
> partition table, the
> most obvious one being the boot sector itself which doesn't have room.

???

That makes no sense whatsoever; "boot sector" here is the first sector
of _partition_, not that of the entire disk (that would be MBR).

To quote the same wikipedia,
----
A volume boot record (VBR) (also known as a volume boot sector,
a partition boot record or a partition boot sector) is a type of boot
sector introduced by the IBM Personal Computer. It may be found on a
partitioned data storage device, such as a hard disk, or an unpartitioned
device, such as a floppy disk, and contains machine code for bootstrapping
programs (usually, but not necessarily, operating systems) stored in other
parts of the device. On non-partitioned storage devices, it is the first
sector of the device. On partitioned devices, it is the first sector of
an individual partition on the device, with the first sector of the entire
device being a Master Boot Record (MBR) containing the partition table.
----

So your rationale doesn't work - you need to know where the partition is
just to read the sector that contains that field.  Or have access to
something that can be asked to read from partition, as opposed to the
entire disk (kernel, for example), but that something can usually be
asked where the hell does partition start.

On anything with UEFI the first sector of the entire disk is likely to be
the "protective MBR" in the beginning of GPT.  No BPB in that on in real
MBR, and in any case - which of the FAT filesystems would it refer to?

Not familiar with BootDuet and currently there's a lot on my platter,
so I'm not about to go and RTFS through it.  Your description really
doesn't seem to make any sense, though...
