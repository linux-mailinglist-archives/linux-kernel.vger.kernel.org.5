Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1127C9636
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 22:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjJNUBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjJNUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 16:01:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62210CC;
        Sat, 14 Oct 2023 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Qx6rCJtGnmnzbwc9tTPUP7Vp17ZzyuVXPDYRTh3fyrI=;
        t=1697313711; x=1698523311; b=CvZJiQ5R/YAI99CbCAFPhZMyMZzSgEWREUZLi5Qtkc75v56
        MiYV5Yq3aFYaUdUvzaMhKCiYCdvuW9XnE/a4wkaHG08TnTpO4A/2RDw04VtTYTMagRxSaSn8yVmJD
        zhp00GehfvbNM0fe/5JuLcxthAiQ60S+e/opXxhX+suaE0iYTnORzcJ6qd6MYty/nmYH8+KTYAboc
        WKErbhg709W/SeKKOsTCDB8xwiLjWrBJjufBPGP6Mql19D34/4JJldQpBBUWL88PqIJbp5IhtYu0v
        LA6w0wgubvJE54Z0a40eUWfqbMP9+KpxF1XftLMte7GjvYROT0smyvnQWBHSBYkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qrkpW-00000006DPi-1nVX;
        Sat, 14 Oct 2023 22:01:46 +0200
Message-ID: <fec9cfe4436786f6f9b61ee6e9bb7766efb29d34.camel@sipsolutions.net>
Subject: Re: [PATCH] rfkill: fix deadlock in rfkill_send_events
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Simon Horman <horms@kernel.org>, Edward AD <twuufnxlz@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+509238e523e032442b80@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Date:   Sat, 14 Oct 2023 22:01:45 +0200
In-Reply-To: <20231014072943.GV29570@kernel.org>
References: <20231013110638.GD29570@kernel.org>
         <20231014024321.1002066-2-twuufnxlz@gmail.com>
         <20231014072943.GV29570@kernel.org>
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

On Sat, 2023-10-14 at 09:29 +0200, Simon Horman wrote:
> On Sat, Oct 14, 2023 at 10:43:22AM +0800, Edward AD wrote:
> > Hi Simon Horman,
> > On Fri, 13 Oct 2023 13:06:38 +0200, Simon Horman wrote:
> > > I am wondering if you considered moving the rfkill_sync() calls
> > > to before &data->mtx is taken, to avoid the need to drop and
> > > retake it?
> > If you move rfkill_sync() before calling &data->mtx, more code will be =
added=20
> > because rfkill_sync() is in the loop body.
>=20
> Maybe that is true. And maybe that is a good argument for
> not taking the approach that I suggested. But I do think it
> is simpler from a locking perspective, and that has some merit.
>=20

FWIW, I missed this patch and discussion until now, but I already fixed
the issue differently:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3Df2ac54ebf85615a6d78f5eb213a8bbeeb17ebe5d

There was never any need to hold the data->mtx for anything but the list
manipulation, and even that isn't _really_ needed since the 'data' is
completely fresh and not seen anywhere else yet.

(I'll also note that the subject of this thread is wrong since this was
never an *actual* deadlock, just a *possible* one reported by lockdep.)

johannes
