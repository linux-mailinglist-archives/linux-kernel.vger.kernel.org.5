Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED45805401
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbjLEMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjLEMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:21:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE8EC6;
        Tue,  5 Dec 2023 04:21:24 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A75501FB92;
        Tue,  5 Dec 2023 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701778882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLKfBbW7xxWM4CsEXWIqWY4fdOEzjqiwq5r4FFnDjsM=;
        b=MbZbntuhGu0PcmxsNvhrDm1Nl7eikwyCVH+1Z+L5uy5XKseEEJdbyn9hHhmfdKUbFX4KoP
        azeEpfd8Of8wjIDKG+FD+GnRsNuZaqN8Cue+sYvQZEQb8acBRnCFmqyplxlrepANjk4LPe
        ICPNoPkBG2oNhka9IhggAro+CzEJPBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701778882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLKfBbW7xxWM4CsEXWIqWY4fdOEzjqiwq5r4FFnDjsM=;
        b=/yERIUnxMviXTF8/0KvBEBx/xUijvqixL1zYDc2+TVi5saHdiMB15w9WqfqA/LQWm/M8bw
        MCQKgvBBhY+GkXDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 91709138FF;
        Tue,  5 Dec 2023 12:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id HWN7I8IVb2XNXAAAn2gu4w
        (envelope-from <jack@suse.cz>); Tue, 05 Dec 2023 12:21:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 11DADA07DB; Tue,  5 Dec 2023 13:21:22 +0100 (CET)
Date:   Tue, 5 Dec 2023 13:21:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, chrubis@suse.cz, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>
Subject: ext4 data corruption in 6.1 stable tree (was Re: [PATCH 5.15
 000/297] 5.15.140-rc1 review)
Message-ID: <20231205122122.dfhhoaswsfscuhc3@quack3>
References: <20231124172000.087816911@linuxfoundation.org>
 <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
 <20231127155557.xv5ljrdxcfcigjfa@quack3>
 <CAEUSe7_PUdRgJpY36jZxy84CbNX5TTnynqU8derf0ZBSDtUOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_PUdRgJpY36jZxy84CbNX5TTnynqU8derf0ZBSDtUOqw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[22];
         DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:url,suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[suse.cz,linaro.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,sladewatkins.net,gmx.de,mit.edu];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon 27-11-23 11:32:12, Daniel D�az wrote:
> On Mon, 27 Nov 2023 at 09:56, Jan Kara <jack@suse.cz> wrote:
> > On Fri 24-11-23 23:45:09, Daniel D�az wrote:
> > > On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.140 release.
> > > > There are 297 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc1.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > We are noticing a regression with ltp-syscalls' preadv03:
> >
> > Thanks for report!
> >
> > > -----8<-----
> > >   preadv03 preadv03
> > >   preadv03_64 preadv03_64
> > >   preadv03.c:102: TINFO: Using block size 512
> > >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
> > >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
> > >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
> > >   preadv03.c:102: TINFO: Using block size 512
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> > >   preadv03.c:102: TINFO: Using block size 512
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> > >   preadv03.c:102: TINFO: Using block size 512
> > >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
> > >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
> > >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
> > >   preadv03.c:102: TINFO: Using block size 512
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> > >   preadv03.c:102: TINFO: Using block size 512
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> > >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> > > ----->8-----
> > >
> > > This is seen in the following environments:
> > > * dragonboard-845c
> > > * juno-64k_page_size
> > > * qemu-arm64
> > > * qemu-armv7
> > > * qemu-i386
> > > * qemu-x86_64
> > > * x86_64-clang
> > >
> > > and on the following RC's:
> > > * v5.10.202-rc1
> > > * v5.15.140-rc1
> > > * v6.1.64-rc1
> >
> > Hum, even in 6.1? That's odd. Can you please test whether current upstream
> > vanilla kernel works for you with this test? Thanks!
> 
> Yes, this is working for us on mainline and next:
>   https://qa-reports.linaro.org/lkft/linux-mainline-master/tests/ltp-syscalls/preadv03
>   https://qa-reports.linaro.org/lkft/linux-next-master/tests/ltp-syscalls/preadv03
> c.fr. 6.1:
>   https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/tests/ltp-syscalls/preadv03
> 
> Greetings!

So I've got back to this and the failure is a subtle interaction between
iomap code and ext4 code. In particular that fact that commit 936e114a245b6
("iomap: update ki_pos a little later in iomap_dio_complete") is not in
stable causes that file position is not updated after direct IO write and
thus we direct IO writes are ending in wrong locations effectively
corrupting data. The subtle detail is that before this commit if ->end_io
handler returns non-zero value (which the new ext4 ->end_io handler does),
file pos doesn't get updated, after this commit it doesn't get updated only
if the return value is < 0.

The commit got merged in 6.5-rc1 so all stable kernels that have
91562895f803 ("ext4: properly sync file size update after O_SYNC direct
IO") before 6.5 are corrupting data - I've noticed at least 6.1 is still
carrying the problematic commit. Greg, please take out the commit from all
stable kernels before 6.5 as soon as possible, we'll figure out proper
backport once user data are not being corrupted anymore. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
