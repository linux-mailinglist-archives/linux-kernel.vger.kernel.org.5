Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE27B4FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjJBKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbjJBKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:11:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1E9B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:11:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595CFC433C8;
        Mon,  2 Oct 2023 10:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696241483;
        bh=6/GELyyqIkbot26vZx4tB+2IWue2NOsDgFUms0fr5iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKIdOPt7lYVpPTPAJIl23+JG/EbWgzXMgmer3+6sJ/u2D1qmsWL6meBQLK57IKt/D
         UrZWTNiMAFETg+FsfHHxAg/2rpamQ2LJ/df5i4ane3s1vCXbir9GPLcewgz8HhxB0O
         s5o7Oi7hxqhONR8ls4LF+bBJMFS2+dtQebWOg8+5DDh/uaRk+Vx+D7QqwMHKI0s8xV
         /w1PUNN1she/cnaqzRiRIxepZHy0EfNN6uJE1nJBEl23SbKkMmclyYg1b4+kBhbQMa
         E+ujjAO8POp5/DTetRgpbpKO010y5mFjUu6HpGsDTL+D4wqYoZ748zKylN7p4fCA7f
         s+J/fUjb6T5Lg==
Date:   Mon, 2 Oct 2023 11:11:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>, Yu Hao <yhao016@ucr.edu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
Message-ID: <20231002101117.GA175828@google.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
 <687864524.118195.1681799447034.JavaMail.zimbra@nod.at>
 <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com>
 <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com>
 <977347543.226888.1682011999468.JavaMail.zimbra@nod.at>
 <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com>
 <412779912.228444.1682023015809.JavaMail.zimbra@nod.at>
 <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com>
 <1366603418.245114.1682236940160.JavaMail.zimbra@nod.at>
 <951e4cf7-a0ea-b3ec-931d-e6a394ddc2ab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <951e4cf7-a0ea-b3ec-931d-e6a394ddc2ab@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Apr 2023, Zhihao Cheng wrote:

> 在 2023/4/23 16:02, Richard Weinberger 写道:
> > ----- Ursprüngliche Mail -----
> > > Von: "chengzhihao1" <chengzhihao1@huawei.com>
> > > > > root@syzkaller:~# cat /proc/mtd
> > > > > dev:    size   erasesize  name
> > > > > mtd0: 00020000 00001000 “mtdram test device”
> > > > 
> > > > Hmm, mtdram should be fine, erasesize is not zero.
> > > > 
> > > 
> > > I guess the zero-erasesize mtd device is dynamically generated in
> > > runtime, after looking through the code, I find erasesize is
> > > initiallized in specific flash driver and it won't be updated later(eg.
> > > ioctl\sysctl). And some mtd devices may have zero erasesize, eg.
> > > drivers/mtd/devices/mchp23k256.c[1]. Unfortunately, I don't know how to
> > > load/simulate this mtd, maybe it requires a real device? If we load this
> > > mtd device as ubi, it will trigger the problem?
> > 
> > Indeed. I guess qemu can emulate such chips.
> > So better fix UBI to reject attaching of mtd's with erasesize being 0.
> > (Please note, we cannot test for MTD_NO_ERASE, this one means there is no
> > erase method).
> 
> Phram is an exception, it has erase function but is set flag 'MTD_CAP_RAM'.
> May I interpret 'MTD_NO_ERASE' as erase function is not necessary?

For better or worse, someone has applied to have this report associated
with a CVE which means a bunch of companies and individuals are going to
be tracking it.

What is the current status please?

Is this deemed to be a real issue?

Did the report culminate in a posted patch?

Any help would be gratefully received.

-- 
Lee Jones [李琼斯]
