Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28387C4B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjJKG7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbjJKG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:59:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA9C9;
        Tue, 10 Oct 2023 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4M6imKxtdJE19FbvYIuupVV35F4/3W3m3pR3DRZhbLQ=;
        t=1697007550; x=1698217150; b=UWDpGBg1tsJMhyNGX8kCz0x1YNEUguz/lI4Ub5xE1fkfaiF
        yM2CuujxCdev4q1uyjXHH2YGIK3JAaNJWSm2uUxmssb6gMKe6ruzMiVIejk0p2PwVOzl3kkhM+xRm
        8Z8YN5+fVwHMM+KhpFtYHqPMhxPZsc2DfqCpkdkayzcrl4tnz5eXbYzOjmyGbZweDx/2JUWHLVEjY
        fSC4vapGP+0Unkgj2x8wvclwSbvA9kklJeDQP14Ubff7VZWX2C5d7pFvZGvSLuBinE8YR2iHHr3M/
        aegy5v9RJGndnGZYKi6AKSTbhakiMvmV+WZH0b2IMetzojIGO8UqkE0JJAt+bmkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqTBR-00000001d2I-1HSW;
        Wed, 11 Oct 2023 08:59:05 +0200
Message-ID: <844b47b618a2ef91f6dcfe2cb88ccd92ad278a6a.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] [net?] memory leak in ieee80211_add_key
From:   Johannes Berg <johannes@sipsolutions.net>
To:     syzbot <syzbot+c7f9b4282ce793ea2456@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Date:   Wed, 11 Oct 2023 08:59:04 +0200
In-Reply-To: <000000000000230b04060765c8d0@google.com>
References: <000000000000230b04060765c8d0@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 17:19 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    af95dc6fdc25 Merge tag 'pci-v6.6-fixes-2' of git://git.ke=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D111f914168000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D92fc678f64486=
a09
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc7f9b4282ce793e=
a2456
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12874a7e680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17eba91168000=
0
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8bc195198bd8/dis=
k-af95dc6f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/769216d795c4/vmlinu=
x-af95dc6f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8ceb9e44a618/b=
zImage-af95dc6f.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c7f9b4282ce793ea2456@syzkaller.appspotmail.com
>=20
> executing program
> executing program
> BUG: memory leak
> unreferenced object 0xffff8881419b3000 (size 1024):
>   comm "syz-executor294", pid 5023, jiffies 4294944772 (age 13.090s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 18 30 9b 41 81 88 ff ff  .........0.A....
>   backtrace:
>     [<ffffffff8157491b>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
>     [<ffffffff8157491b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
>     [<ffffffff848575dc>] kmalloc include/linux/slab.h:603 [inline]
>     [<ffffffff848575dc>] kzalloc include/linux/slab.h:720 [inline]
>     [<ffffffff848575dc>] ieee80211_key_alloc+0x5c/0x590 net/mac80211/key.=
c:603
>     [<ffffffff8482b0d2>] ieee80211_add_key+0x162/0x540 net/mac80211/cfg.c=
:500

I think already fixed by
https://patchwork.kernel.org/project/linux-wireless/patch/20231005210917.13=
977-2-johannes@sipsolutions.net/
though the patch isn't in the tree yet - will take care of it later
today (I hope).

johannes
