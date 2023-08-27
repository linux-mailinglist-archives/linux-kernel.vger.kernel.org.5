Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E73789B59
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 06:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjH0ERa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 00:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjH0ERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 00:17:22 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9808E1AC;
        Sat, 26 Aug 2023 21:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P6YFESwJ8CS4wS0/xXDwMGJAD8dyySjIqkTublqcYoc=; b=XRa6jbgCFmTtisegbM3tfAuVdf
        trUXr5rTH0/8dmrshEZoEPnfpgzdSKBSr84mgLrHql/rLKo0PREGguo+D8guZZc/znVZ0esCNVjWw
        hK+h4EpG0Re6Qdh00B49hqOfAEyGT+7ry4IwFpJX9Pbq8Ru3lHzRgYepu8UNQL9TeBK+uKTeBMcER
        zYKUQNIIM2fwr+9tPizytQs4QLA0as8W+088wngs3gI+Xjz8hG22PptQeBbJr1eHLnuNvKANOSInh
        IYNs6Dx8C//O+4qa3/ag0vWriT7OUBJvoEzh8apTQ+Q1Rr5LUMCgKhF4LIBN5lekcjAyzAXgDc6mJ
        JY1L1zfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qa7DA-001EkI-1Q;
        Sun, 27 Aug 2023 04:17:16 +0000
Date:   Sun, 27 Aug 2023 05:17:16 +0100
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
Message-ID: <20230827041716.GR3390869@ZenIV>
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me>
 <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
 <20230827020635.GQ3390869@ZenIV>
 <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 07:38:57PM -0700, Joshua Hudson wrote:
> "Whole disk and all partitions have page caches of their own."
> 
> That's so bad.
> 
> I can think of numerous cases where this will cause problems; including
> some I encountered last year and did not understand at the time. Manipulating
> EFI partitions through the whole disk device makes sense because FAT filesystems
> *know their offset on the disk*, and some of the existing tools really
> don't like being
> given a partition device.

Explain, please.  How does FAT filesystem know its offset on disk?
Since when?  It had always been possible to copy a FAT image into
a partition verbatim and it works no matter where on disk that
partition happens to be...

Has that changed at some point?  Do you have any references?  Ideally
with some kind of rationale for that weirdness...

Or am I misparsing what you wrote?
