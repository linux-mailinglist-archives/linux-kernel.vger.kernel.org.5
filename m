Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256B789AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjH0CHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjH0CGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:06:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77884119;
        Sat, 26 Aug 2023 19:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+9WTEtdJoJCdWG/RW/iQ4SvvA0PSXrKGPAz3wgthcMM=; b=v98jyUypfXy2g3KPttVluyqAaX
        Wv05VqDdXl4GcezmDMflND5YpP3R9szkoVnwJCR0HFMfkAmaAidU0nzDWpZOcaDJV0Ex74z3RXl8X
        zMIh+11cKBYDjtreX22RKoiBFKBwEMcrUK1fVqzlUY9o0KWlSMg73pziPR6FAawHVV9xwZ7lwslnx
        YjF62Tu6pKljXWrDjBjKqpXl8Cjg12d5Qag4GoRWWflAVQgAUxL8MwG+uMQEwzpPbHs6B12kQXk+F
        M5P0ycqT8BWC+O2MwfakU8NI5QaGnmeb6VdZfU+9yAZzJOu14gvRACWY23eaB9BQt4uRdokNRvoaa
        Qwf8OQiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qa5Ah-001D9H-0v;
        Sun, 27 Aug 2023 02:06:35 +0000
Date:   Sun, 27 Aug 2023 03:06:35 +0100
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
Message-ID: <20230827020635.GQ3390869@ZenIV>
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me>
 <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 06:25:58PM -0700, Joshua Hudson wrote:
> I am presuming you mean "Are you sure this not a hardware issue?"
> 
> I am sure it is not, for two reasons.
> 
> 1) If it were a hardware issue I would still expect the two device
> nodes (whole disk and partition) to report the *same* data.
> 
> 2) I have since developed a workaround involving BLKFLSDEV. The
> workaround is really ugly.

Whole disk and all partitions have page caches of their own.
There is no coherency between those; write through one, then
read through another and you are not guaranteed that read won't
see the stale cached data.

Doctor, it hurts when I do it...

Incidentally, read from device/write to the place you've read via
file/read from device again also has no coherency warranties, for
exact same reason.

IOW, not a bug.
