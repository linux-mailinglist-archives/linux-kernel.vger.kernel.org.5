Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5B7BF413
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442501AbjJJHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442492AbjJJHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:23:04 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D684BC4;
        Tue, 10 Oct 2023 00:22:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 124271BF206;
        Tue, 10 Oct 2023 07:22:55 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1qq74r-00GHj6-Tn; Tue, 10 Oct 2023 09:22:49 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
References: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
        <2023101036-fleshy-dude-aec0@gregkh> <87v8bfc83f.fsf@48ers.dk>
        <2023101018-venomous-uncured-47cf@gregkh>
Date:   Tue, 10 Oct 2023 09:22:49 +0200
In-Reply-To: <2023101018-venomous-uncured-47cf@gregkh> (Greg KH's message of
        "Tue, 10 Oct 2023 08:33:35 +0200")
Message-ID: <87r0m3c56e.fsf@48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:

 > On Tue, Oct 10, 2023 at 08:19:48AM +0200, Peter Korsgaard wrote:
 >> >>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:
 >> 
 >> > On Tue, Oct 10, 2023 at 12:26:14AM +0200, Javier Carrasco wrote:
 >> >> syzbot has found an uninit-value bug triggered by the dm9601 driver [1].
 >> >> 
 >> >> This error happens because the variable res is not updated if the call
 >> >> to dm_read_shared_word returns an error. In this particular case -EPROTO
 >> >> was returned and res stayed uninitialized.
 >> >> 
 >> >> This can be avoided by checking the return value of dm_read_shared_word
 >> >> and propagating the error if the read operation failed.
 >> >> 
 >> >> [1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955
 >> >> 
 >> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
 >> >> Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
 >> >> ---
 >> >> Changes in v2:
 >> >> - Remove unnecessary 'err == 0' case
 >> >> - Link to v1: https://lore.kernel.org/r/20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com
 >> >> ---
 >> >> drivers/net/usb/dm9601.c | 7 ++++++-
 >> >> 1 file changed, 6 insertions(+), 1 deletion(-)
 >> 
 >> > What commit id does this fix?
 >> 
 >> It has been there since the beginning, so:
 >> 
 >> Fixes: d0374f4f9c35cdfbee0 ("USB: Davicom DM9601 usbnet driver")
 >> 
 >> Acked-by: Peter Korsgaard <peter@korsgaard.com>

 > Great, can someone add a cc: stable@ tag for this too please?

Cc: stable@vger.kernel.org

-- 
Bye, Peter Korsgaard
