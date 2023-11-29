Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9E7FD228
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjK2JQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjK2JPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:15:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C41FDF;
        Wed, 29 Nov 2023 01:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eQwJTZYRx3LOEKLgH4dhH9QWBCcY6L5CkgMzMJz45eY=;
        t=1701249312; x=1702458912; b=SnkI84eNdN/GEVkd1IOO5NmO8V0GpjbGCmElF8Lpsgm6eR5
        YWwlDj9f0++zN9YUYcPq2KevMbPXFBTqi64VYj+V3d6LFwXbnXZS6YdwqMtKjJSRvHS+TfvPBsa2P
        xu60wjRE68S3xzsmFBbr5Ks6Ce74giMv+Qv1FHWefwZ2JMXIc5r7o2AHZ3vW5gdseESVGvH8jemEL
        iW0BIDe9n+fLIHF8DysA4VWcxdn07tSBRCGQxAhOz1Hg7WfRbK0XPgJvYSueTvvy3TzZYprbgp7tH
        gUdodW7lSKqIGIpwJqHEHFBbldRc6ayHmHdR7lw+Ake3VZpKH8o5nSDNa+BmI78g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r8Gev-00000008bo2-0c7n;
        Wed, 29 Nov 2023 10:15:05 +0100
Message-ID: <52e6ba0affb1648edd3ffd25fb6d8199a39a2f51.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: sband's null check should precede params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Date:   Wed, 29 Nov 2023 10:15:03 +0100
In-Reply-To: <tencent_6E9CA7EF46E452C90650899D2ECFEEFE4C06@qq.com>
References: <56d8b3b9099d3935a7b53e976fa998f06fbfd9a5.camel@sipsolutions.net>
         <tencent_6E9CA7EF46E452C90650899D2ECFEEFE4C06@qq.com>
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

On Wed, 2023-11-29 at 16:48 +0800, Edward Adam Davis wrote:
> On Wed, 29 Nov 2023 09:33:23 +0100, Johannes Berg wrote:
> > > > > [Analysis]
> > > > > When ieee80211_get_link_sband() fails to find a valid sband and f=
irst checks
> > > > > for params in sta_link_apply_parameters(), it will return 0 due t=
o new_link
> > > > > being 0, which will lead to an incorrect process after sta_apply_=
parameters().
> > > > >=20
> > > > > [Fix]
> > > > > First obtain sband and perform a non null check before checking t=
he params.
> > > >=20
> > > > Not sure I can even disagree with that analysis, it seems right, bu=
t ...
> > > >=20
> > > > > +	if (!link || !link_sta)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	sband =3D ieee80211_get_link_sband(link);
> > > > > +	if (!sband)
> > > > > +		return -EINVAL;
> > > > > +
> > > > >  	/*
> > > > >  	 * If there are no changes, then accept a link that doesn't exi=
st,
> > > > >  	 * unless it's a new link.
> > > >=20
> > > > There's a comment here which is clearly not true after this change,
> > > > since you've already returned for !link_sta?
> > > No, after applying my patch, it will return due to !sband.
> > >=20
> >=20
> > Right, OK, but the way I read the comment (now) is that it wanted to
> > accept it in that case?
> >=20
> > That said, I just threw the patch into our internal testing machinery
> > quickly (probably has more MLO tests than upstream hostap for now), and
> > it worked just fine ...
> >=20
> > Maybe we should just remove the comment?
> Do you mean to delete the comments below?
>    3         /*
>    2          * If there are no changes, then accept a link that doesn't =
exist,
>    1          * unless it's a new link.
> 1800          */
>=20

Right, it doesn't seem correct any more?

johannes
