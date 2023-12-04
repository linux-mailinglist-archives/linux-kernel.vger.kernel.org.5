Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23894804063
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjLDUua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjLDUu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:50:28 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1216C6;
        Mon,  4 Dec 2023 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IvcuO1hSSnoLO74Nmy5OlV/+o+qw+L0ddRc9j5Pdrsw=;
        t=1701723034; x=1702932634; b=CT36PECD5yMVg7dW6ttKWy5WxO34gZuf8tZ8YZLpO9v7gqV
        dGXGRrVlLKshihCIfetnS2kv+oH5D8nNFUgJ2zBhpktqrRVeVkZz8rvf7xCHlBIftcigZh9HlPj7e
        p6kfoY5uJk9SFdxxNUXqjBRPjZvLnldBUcFbvjBbOEE5lTiYgz/OxOyZqtDawQoiOU4l0abwyg7Rl
        JvPTmdE4TUnwYFe4m48cBpXZ2DcDVgMRQ/aBGm6faGYoAN52Fg5qvQUArrecEpcpXMCiU6gBcdeKD
        nvvnAe/pWWoiOzEJgsRPtfTYsd2Iw7FCBoVBVhCPrvJb08bNcdw5TSGud4Fr7W6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1rAFte-0000000FFlL-3cj6;
        Mon, 04 Dec 2023 21:50:31 +0100
Message-ID: <71d0f8424661b0d7b2c371e422416854790e477a.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 4.14] wifi: cfg80211: lock wiphy mutex for
 rfkill poll
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Mon, 04 Dec 2023 21:50:29 +0100
In-Reply-To: <20231204203735.2095033-1-sashal@kernel.org>
References: <20231204203735.2095033-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
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

On Mon, 2023-12-04 at 15:37 -0500, Sasha Levin wrote:
>=20
> +++ b/net/wireless/core.c
> @@ -202,7 +202,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkil=
l, void *data)
>  {
>  	struct cfg80211_registered_device *rdev =3D data;
> =20
> +	wiphy_lock(&rdev->wiphy);

This can't even _build_ on this old kernel?!

Anyway, my locking rework only went into 6.7, so this doesn't make sense
in any stable kernel, it's just not required.

johannes
