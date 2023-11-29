Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445117FD0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjK2Ida (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2Id2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:33:28 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5102019B0;
        Wed, 29 Nov 2023 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iL44Hr2Utbt8Rb40hYFfR3Yl3GOU2Y+nYu/SSloZ/X0=;
        t=1701246814; x=1702456414; b=B6n9/g6ITd6f4HA4PHYrxMnsj2Jr5FKm/W9Cex+mkmirzZ6
        uZl0WTaT89gHVqDfVVo/byLg2puPHaSGr793dffsGjLjYBakFj7KH9T93ptI1EH56KVrQgFlLK6wq
        wmGi3QAThBm5SngEVMB1HZ1+gVa5VnZKAQsWxZtj6MVwVLptm1c8nT9Qpd+v6cp3FL50UGl1rS7LH
        B7rYzsXfjXYt1ZuhCuIkebZxFf2+waQSSbCCFyQnVBEuVnVBTvH5v3d4vq1PP938eiU7Gji5/Jz1H
        sBrpKW0xu2EdKeeF+xzqe1jVYRgvFLV9T93FDiEfl9+a6aGUXB2WPi28w5ZyICAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r8G0b-00000008abj-0RXH;
        Wed, 29 Nov 2023 09:33:25 +0100
Message-ID: <56d8b3b9099d3935a7b53e976fa998f06fbfd9a5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: sband's null check should precede params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Date:   Wed, 29 Nov 2023 09:33:23 +0100
In-Reply-To: <tencent_DE78F66DB82F496F9894B8E826EC8ACE0C0A@qq.com>
References: <6c7765f13b715e67637438c6dffaa5a369758519.camel@sipsolutions.net>
         <tencent_DE78F66DB82F496F9894B8E826EC8ACE0C0A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-29 at 16:18 +0800, Edward Adam Davis wrote:
> On Wed, 29 Nov 2023 07:57:07 +0100, Johannes Berg wrote:
> > > [Analysis]
> > > When ieee80211_get_link_sband() fails to find a valid sband and first=
 checks
> > > for params in sta_link_apply_parameters(), it will return 0 due to ne=
w_link
> > > being 0, which will lead to an incorrect process after sta_apply_para=
meters().
> > >=20
> > > [Fix]
> > > First obtain sband and perform a non null check before checking the p=
arams.
> >=20
> > Not sure I can even disagree with that analysis, it seems right, but ..=
.
> >=20
> > > +	if (!link || !link_sta)
> > > +		return -EINVAL;
> > > +
> > > +	sband =3D ieee80211_get_link_sband(link);
> > > +	if (!sband)
> > > +		return -EINVAL;
> > > +
> > >  	/*
> > >  	 * If there are no changes, then accept a link that doesn't exist,
> > >  	 * unless it's a new link.
> >=20
> > There's a comment here which is clearly not true after this change,
> > since you've already returned for !link_sta?
> No, after applying my patch, it will return due to !sband.
>=20

Right, OK, but the way I read the comment (now) is that it wanted to
accept it in that case?

That said, I just threw the patch into our internal testing machinery
quickly (probably has more MLO tests than upstream hostap for now), and
it worked just fine ...

Maybe we should just remove the comment?

johannes
