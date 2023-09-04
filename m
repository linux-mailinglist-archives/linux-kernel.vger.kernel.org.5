Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC67911B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349603AbjIDG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbjIDG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:57:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64E11A;
        Sun,  3 Sep 2023 23:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ML3nN0Bovw/HBwQG6YVdv3gL++y5/3rFGx6GGczGCis=;
        t=1693810640; x=1695020240; b=P1ZLi6DGpReD2zSdvNT7Q/UeDBrHqldsWHtVX4tGtN4n5z5
        xDI5U3AOwTKGZ8MbdJ1cduLYBTiOZQXpdVskQIZU6VoCB6HDmJe2b/YPjWXwKG6IH+pwraa9ywl7N
        2cx/wfVw+pN4fLFpzvBNCukokACNy7Z9/Y7rci4fAz/EPa+REWJRVsdPYWgNICRoiCL+lFbeUNwAa
        CDfI5YXCIE3A1wSg/HZhqus3pmuaLvZobldb0qzPltexpDYnenLlsBQtbQRPLtH0pF8a5L3lZu6T+
        LipEn74Sp/nbC3bcd0IV+N+5lhzwFtmVYqOkbGUSbk0d1zND+Sgye/25IX/KzN0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qd3WL-00ChVX-20;
        Mon, 04 Sep 2023 08:57:13 +0200
Message-ID: <cf6ab60c42705625a7b1d71e53db0edb78fe6e2d.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_link_release_channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     syzbot <syzbot+9817a610349542589c42@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 04 Sep 2023 08:57:11 +0200
In-Reply-To: <000000000000bcd80b06046a98ac@google.com>
References: <000000000000bcd80b06046a98ac@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-02 at 18:48 -0700, syzbot wrote:
>=20
> WARNING: CPU: 0 PID: 7597 at net/mac80211/chan.c:2021 ieee80211_link_rele=
ase_channel+0x19f/0x200 net/mac80211/chan.c:2021
>=20

That's a lockdep warning, so it's kind of a known issue. I don't know if
I've yet encountered this specific way to get the locking checks
screaming, but generally we knew for a while that the locking was a bit
messy and possibly to some extent broken (*).

Anyway, point is - this is basically the reason I did this series:
https://lore.kernel.org/linux-wireless/20230828115927.116700-41-johannes@si=
psolutions.net/

so this should go away - though sadly only in -next. Per the footnote, I
believe that the issue in the current kernel is mostly not an issue, and
it should only happen with multi-link in the first place. There may be
an issue in what syzbot found, processing a multi-link response or
something though.

johannes

(*) in many cases it's not _actually_ broken because we hold some common
outer lock anyway, so no data races are possible
