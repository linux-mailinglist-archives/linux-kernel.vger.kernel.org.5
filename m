Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F775AFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGTN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGTN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:29:09 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD08D2701
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:28:44 -0700 (PDT)
Received: from localhost (unknown [10.10.165.16])
        by mail.ispras.ru (Postfix) with ESMTPSA id 445A2407675E;
        Thu, 20 Jul 2023 13:22:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 445A2407675E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1689859355;
        bh=yZMlngbh3YKbzLA0HIeJWnW6IMjTlDcM5F2W41AYGrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUB6OW3MSaCKf93RcbWVMQPkAVesm0BoP36zT9/9Rx5JcDN+3NQAC64L4Ay/67wiv
         TothD/T/TeyAo1G586LQW7skGrfPNrwmnAUYkRegS/aVi2IPl0s86BgpbSu6aMsjqO
         +0wKkltPmgpYXPWIO6dDHfawnu6e9NB4stmNdF2M=
Date:   Thu, 20 Jul 2023 16:22:34 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot <syzbot+160a7250e255d25725eb@syzkaller.appspotmail.com>
Cc:     kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, toke@toke.dk,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [syzbot] [afs?] general protection fault in skb_queue_tail (3)
Message-ID: <5tu3vxj3bs4crdypi75bv5e5a4wazsuwze5kas3yao2ng65gtd@6a7gfrtsyc6o>
References: <0000000000000de35905ead6dcc1@google.com>
 <000000000000ea91fa0600816cb8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ea91fa0600816cb8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/15 12:22AM, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 061b0cb9327b80d7a0f63a33e7c3e2a91a71f142
> Author: Fedor Pchelkin <pchelkin@ispras.ru>
> Date:   Wed May 17 15:03:17 2023 +0000
> 
>     wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12253b7ca80000
> start commit:   98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=701f2aae1cb0470e
> dashboard link: https://syzkaller.appspot.com/bug?extid=160a7250e255d25725eb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1482f0b6880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119e4dce880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Seems reasonable since the reproducer here manages to modify ENDPOINT0
attrs and this leads to the invalid behaviour in different ways - the one
is this bug and another is the one fixed by the commit which syzbot
bisected. Those attempts to modify ENDPOINT0 are now prohibited with this
commit. So I think the result is correct (apart from that this issue is
not related to afs).

#syz fix: wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

