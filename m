Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B057D07CA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJTFtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjJTFti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:49:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CB7CA;
        Thu, 19 Oct 2023 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yMF4pcHvul9aj3NPNIUSsgOOjrOeA7W4g86fUYpJouU=;
        t=1697780976; x=1698990576; b=h9quspUkPVO9QA1faW25l+Frsw8hu5AqyMQKAAEhUahbSgU
        RNujxoaoF/F5hD+y5aniUX0Plx8R3OrjR+uP/2/vsZZ8ItpQkQeCrC68OQDv5Av082ahdSkRkgIXe
        fbW4PDXxNab90Mysx7U8H7FX4oLJEwKYEhHhIn2E+9P6pyi1HyD66bZBUOfL6QS9xzId64nszxzk8
        DyqI0+K8w+ZCSkNLY3mfbnfH7oYYibU4BcaAkm23dKFSVxJWwm3s2xxyCR++zXpQnPH8WT2mfz9av
        bvcnpWCP1LMEHzPwUNOTFy8Qaen6ggT0FF95fN1hq0sqPzzMOL3mwcKVOhf9wLTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qtiO1-0000000ENZE-015f;
        Fri, 20 Oct 2023 07:49:29 +0200
Message-ID: <007e30c2fe785e2f3fd7ffae9b85b7903f46e48c.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the net-next tree with the wireless
 tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Fri, 20 Oct 2023 07:49:27 +0200
In-Reply-To: <20231019144004.0f5b2533@kernel.org>
References: <20231012113648.46eea5ec@canb.auug.org.au>
         <987ecad0840a9d15bd844184ea595aff1f3b9c0c.camel@sipsolutions.net>
         <20231019144004.0f5b2533@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-19 at 14:40 -0700, Jakub Kicinski wrote:
> On Thu, 12 Oct 2023 10:10:10 +0200 Johannes Berg wrote:
> > > I fixed it up (I just used the latter, there may be more needed) =20
> >=20
> > Just using net-next/wireless-next is fine, I actually noticed the issue
> > while I was merging the trees to fix the previous conflicts here.
>=20
> Resolved the conflict in 041c3466f39d, could you double check?

I don't see anything there, but I guess that means it's good? Code looks
fine.

> Also, there's another direct return without freeing the key in
> ieee80211_key_link(), is that one okay ?

*sigh*

No, it's not. I think that means I resolved the previous merge there
incorrectly, because it's OK in wireless and broken in wireless-next,
and it had been fixed in d097ae01ebd4 ("wifi: mac80211: fix potential
key leak").

Anyway, thanks for checking and noticing! Will fix.

johannes
