Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C957EEAFD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjKQCRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:17:44 -0500
Received: from p3plwbeout17-03.prod.phx3.secureserver.net (p3plsmtp17-03-2.prod.phx3.secureserver.net [173.201.193.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2822EC2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 18:17:41 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id 3oQMrHXpzRBA43oQNrShF8; Thu, 16 Nov 2023 19:17:39 -0700
X-CMAE-Analysis: v=2.4 cv=WanJ12tX c=1 sm=1 tr=0 ts=6556cd44
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=TT3OXX8_H1iH7GK2:21 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10
 a=t7CeM3EgAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=TlpUs8yM1Nx5ixtUQMgA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22 a=b0R6z3OkPTeaBGj_aaBY:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  3oQMrHXpzRBA4
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.90])
        by smtp06.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1r3oQM-00063O-FT; Fri, 17 Nov 2023 02:17:39 +0000
Message-ID: <748e3619-6569-2f71-7ed1-f67225892e14@squashfs.org.uk>
Date:   Fri, 17 Nov 2023 02:17:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] squashfs: squashfs_read_data need to check if the length
 is 0
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lizhi Xu <lizhi.xu@windriver.com>
Cc:     syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
References: <0000000000000526f2060a30a085@google.com>
 <20231116031352.40853-1-lizhi.xu@windriver.com>
 <20231116134332.285510d340637171d2fe968c@linux-foundation.org>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20231116134332.285510d340637171d2fe968c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfPaHxhWB8AlONqti6fk0Il/mSHpwpY8m7Odf17tgDcdcVa1CwBZvmbUwDwIksFKL7MkNAhcfdeXF7uSpW5dQ2kru2gDgaNa+EYDLbf7hO/h94YRY6yy+
 ybi9mio24R4INS/pa2jEADr4b4xjXG+1R8IiiMfdIuO5gMi9G1cGsFhg2ItLaMvviVf0ML4+BOiEshL0VdfEU3r63KFfmTy5anOp8fLJGnHh8Xya2XTpa/Qt
 RSrcG0xvdAaQvS5pKHoSLQ==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 21:43, Andrew Morton wrote:
> On Thu, 16 Nov 2023 11:13:52 +0800 Lizhi Xu <lizhi.xu@windriver.com> wrote:
> 
>> when the length passed in is 0, the subsequent process should be exited.
> 
> Thanks, but when fixing a bug, please always describe the runtime
> effects of that bug.  Amongst other things, other people need this
> information to be able to decide which kernel versions need patching.
> 
>> Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com
> 
> Which is a reason why we're now adding the "Closes:" tag after
> Reported-by:.

Which is also one reason why you should always run scripts/checkpatch.pl
on your patch.  This alerted me to the need for a "Closes:" tag
after Reported-by: on the last patch I sent.

> 
> I googled the sysbot email address and so added
> 
> Closes: https://lkml.kernel.org/r/0000000000000526f2060a30a085@google.com
> 
> to the changelog.

Thanks.  That is indeed the sysbot issue that the patch fixes.

> 
> I'll assume that a -stable kernel backport is needed.
> 
> 

Yes.

Phillip

