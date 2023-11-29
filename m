Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6B7FCF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjK2G5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2G5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:57:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B460A170B;
        Tue, 28 Nov 2023 22:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=o+ruwW4g+vXqotGBgvYVAqikIMr9ZibjwJBBiNvt/1o=;
        t=1701241037; x=1702450637; b=g7e52XAcp8k3t9kvrSac43LUO1SRdqmfhXd72w+/xEuTcHk
        pzwfKFwWO0FN0B7iYep1cUzxkAV8nm/sEpC3FX5tjfgPPn5oKr8zWt3VVzH0GiVqO+8ZZtL41jC4x
        d1s5BdS0JuhTy7pVOOskemXDdO/vN8VsFDZxvZXR/0yAhEI7zEcW1kWccZ5X1+U4PSMo0zTByVBya
        0oGWhMloJS3dfwff4+rrn6DUUq0dqv39gU5CRukXazfErw5/mrm45UuCjfkjEEPgUrQWPn47P8vzn
        vulqDmIXftJK3p7dp0VD/m4Cjxpz8UtNZcPTtgI/vyp/Z+WLn4bVB0TY/YMyVDCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r8EVQ-00000008Y6r-2148;
        Wed, 29 Nov 2023 07:57:08 +0100
Message-ID: <6c7765f13b715e67637438c6dffaa5a369758519.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: sband's null check should precede params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Date:   Wed, 29 Nov 2023 07:57:07 +0100
In-Reply-To: <tencent_0CCA1979CFA30DC8A5CF8DDC92365DCE5D07@qq.com>
References: <000000000000efc64705ff8286a1@google.com>
         <tencent_0CCA1979CFA30DC8A5CF8DDC92365DCE5D07@qq.com>
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

On Wed, 2023-11-29 at 13:48 +0800, Edward Adam Davis wrote:
>=20
> [Analysis]
> When ieee80211_get_link_sband() fails to find a valid sband and first che=
cks=20
> for params in sta_link_apply_parameters(), it will return 0 due to new_li=
nk=20
> being 0, which will lead to an incorrect process after sta_apply_paramete=
rs().
>=20
> [Fix]
> First obtain sband and perform a non null check before checking the param=
s.

Not sure I can even disagree with that analysis, it seems right, but ...

> +	if (!link || !link_sta)
> +		return -EINVAL;
> +
> +	sband =3D ieee80211_get_link_sband(link);
> +	if (!sband)
> +		return -EINVAL;
> +
>  	/*
>  	 * If there are no changes, then accept a link that doesn't exist,
>  	 * unless it's a new link.

There's a comment here which is clearly not true after this change,
since you've already returned for !link_sta?

johannes
