Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5C7EF7B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjKQTNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:13:15 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CDAC5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:13:11 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5AEF440E0199;
        Fri, 17 Nov 2023 19:13:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EG6AgXXuyaF7; Fri, 17 Nov 2023 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700248387; bh=qd/m7qtc5JsyS+Bk5EH7vdXV4yKIrZrxAIziQWZ5NNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUb/Bt4VIM2/LiWOlBGvKSrveY6/QFk37LBygxEhVb3Yiu3Cwpgpf/+tFYv8L/bjW
         SmJAY9NAcp4H5OvrSTwb1oguosYcarSm9Ssz2H1nPYjHEZ+pHJekO+gKSKioESztgx
         /DuUmokzn3L9qH1ACdMmDY/GLTeHLlkJELUl5w2I3KF9JdZFzAeThDAFdLqIgQsaty
         jatzo/oFBxkvBfE70cnA+tlciGle3Mh2EqpPe4QLI1H1YnIBdfCissvW6JiJCRrPyo
         gqxLasitDhYxZwXhggBPX+J5oxwCYX5A255/QWq5bvj5XS1y5BXX6kvt5Cp4vvLk7q
         cq5mrIUq989d1cqkVLx/j88FtF9AVlUhQ0XVbqZ/7DX4UlMEucvQsfKBuvXzDywYG0
         jwu8N12Rguk77IvJ3f/KJ7eTiJ/wazhcnhVKIsu5aqs91GWye/Gsf++Bal/vI2oVlf
         sNy8NyaVm9ipTNdmN2uilEiHO+FAKW74s6IBrmqIhDN4ve5zznxcISX8Kxxtumhv6Z
         jSQ1yg9cdpLgw7wfIrx26/48pK0k/4ZDaMtjKPW7MlWx2cTLFi/uKvdHcblKJjuutW
         AAt5DxJ1Pn0inRroMO/G830vDdKjlpl/2TDsH4vkY78z4v7E2AhCQcEaBHHldGCJem
         FH0f8mNpCO5ljqAa1UpkRSkk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9A7340E0032;
        Fri, 17 Nov 2023 19:12:50 +0000 (UTC)
Date:   Fri, 17 Nov 2023 20:12:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Message-ID: <20231117191243.GHZVe7K4vN9n5M92gb@fat_crate.local>
References: <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk>
 <864270.1700230337@warthog.procyon.org.uk>
 <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local>
 <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
 <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:44:10AM -0500, Linus Torvalds wrote:
> So the test robot load is kind of odd.

So looking at that. IINM, its documentation says:

https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/Documentation

case-msync:
Create N sparse files, each with a size of $MemTotal. For each sparse file,
start a process to write 1/2N of the sparse file's size. After the write,
do a msync to make sure the change in memory has reached the file.

Is that something userspace usually does?

Some distributed, shared thing logging to the same file?

I obviously have no effing clue what userspace does...

> Not that I think that David's KUnit test is necessarily much of a real
> load either. so...

Which begs the question: what are our priorities here?

I wouldn't want to optimize some weird loads. Especially if you have
weird loads which perform differently depending on what uarch
"optimizations" they sport.

I guess optimizing for the majority of machines - modern FSRM ones which
can do "rep; movsb" just fine - is one way to put it. And the rest is
best effort.

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
