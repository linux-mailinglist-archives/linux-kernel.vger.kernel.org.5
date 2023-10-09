Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B357BEBE7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377993AbjJIUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:48:42 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758692;
        Mon,  9 Oct 2023 13:48:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6FD4C0002;
        Mon,  9 Oct 2023 20:48:36 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1qpxB0-00FbYD-V5; Mon, 09 Oct 2023 22:48:30 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
References: <20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com>
Date:   Mon, 09 Oct 2023 22:48:30 +0200
In-Reply-To: <20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com>
        (Javier Carrasco's message of "Mon, 09 Oct 2023 20:52:55 +0200")
Message-ID: <87zg0rcyjl.fsf@48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Javier" == Javier Carrasco <javier.carrasco.cruz@gmail.com> writes:

 > syzbot has found an uninit-value bug triggered by the dm9601 driver [1].
 > This error happens because the variable res is not updated if the call
 > to dm_read_shared_word returns an error or if no data is read (see
 > __usbnet_read_cmd()). In this particular case -EPROTO was returned and
 > res stayed uninitialized.

 > This can be avoided by checking the return value of dm_read_shared_word
 > and returning an error if the read operation failed or no data was read.

 > [1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955

 > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
 > Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
 > ---
 >  drivers/net/usb/dm9601.c | 9 ++++++++-
 >  1 file changed, 8 insertions(+), 1 deletion(-)

 > diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
 > index 48d7d278631e..e223daa93229 100644
 > --- a/drivers/net/usb/dm9601.c
 > +++ b/drivers/net/usb/dm9601.c
 > @@ -222,13 +222,20 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 >  	struct usbnet *dev = netdev_priv(netdev);
 
 >  	__le16 res;
 > +	int err;
 
 >  	if (phy_id) {
 >  		netdev_dbg(dev->net, "Only internal phy supported\n");
 >  		return 0;
 >  	}
 
 > -	dm_read_shared_word(dev, 1, loc, &res);
 > +	err = dm_read_shared_word(dev, 1, loc, &res);
 > +	if (err <= 0) {
 > +		if (err == 0)
 > +			err = -ENODATA;

Looking at dm_read(), it doesn't look like we can end up here with err
== 0, but OK.

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
