Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073AD813250
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjLNN6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjLNN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B027D118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702562300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJb/JZ5DIeJAEZiRa30hG/dhyz0C7/rbH/xtFkoJWDc=;
        b=DoMdXbp4JoThD7Qzc/v5pGhM+Y6XfrVsDeSbxvPNXF3jEqhOWHl9BplknOOahgVS9N3kQq
        Kcv6TRWxLjbKppNZL34vFGVGsNpLKDU50fuYxo6SP5ApLU3+qSgqimMtk6eauhD8Yd4Zi/
        eq7pUKPSZVTx5af50gSN80LeoMnS1kA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-JAdFm6cGMUeaBVsxUKF-kA-1; Thu, 14 Dec 2023 08:58:17 -0500
X-MC-Unique: JAdFm6cGMUeaBVsxUKF-kA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5e1ee53972dso36007367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562297; x=1703167097;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJb/JZ5DIeJAEZiRa30hG/dhyz0C7/rbH/xtFkoJWDc=;
        b=w8qgpV7f8Y9V9hkMg1PwdGJpaR2fJcQPKmERjeFL4lIgEE2DISs4Yg4QQWb39TnnjU
         Q7tSfdgH4uOXURwWujentGvBvT1Zt/5890x7o0Ylb7Y6nXefUdDAAOmrRfxymIybTVQ8
         DCldpFg85Qr6OVBPjR1E0w/8kSRFiawOkaDymBie8NKQvchbJhjSE7HhSb+U7P1VAF+y
         CyiMsySEtZZ25S7ea5Nqbz2CUWWfYb17xz2mSJsiK4+xBvUQP+nagXr9mEFSN+XBDwl7
         1Xv73jXhoCrUaQshSc44XzPcdWWjNgdOJPdWJC4vYjIZSET567E9dN2AjzXkLZiexjd1
         lQfg==
X-Gm-Message-State: AOJu0YxrtaQlZvQBlPdEeWanrqJJ4GvCC8sthzzMroyZg86dZN1RkgKo
        fffjwyvYDOFpyOUMf+SaFxWRnvZEoWlnkR+7ITiwBlyurE+CGDSUpB1ZtWwhPoOrzGyiAGB5xB8
        tyQS5TZb9Hw9amIJ48ygBILwF
X-Received: by 2002:a0d:d845:0:b0:5e3:ca00:9967 with SMTP id a66-20020a0dd845000000b005e3ca009967mr446801ywe.51.1702562297077;
        Thu, 14 Dec 2023 05:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS7kdvyTqXPlUr1rZsJgktdjWBr/8U3nDefOdKeX0+UOYgJ1x+/oj6T1jy3NVpQiwvjdBVdQ==
X-Received: by 2002:a0d:d845:0:b0:5e3:ca00:9967 with SMTP id a66-20020a0dd845000000b005e3ca009967mr446787ywe.51.1702562296787;
        Thu, 14 Dec 2023 05:58:16 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id w3-20020a0cf703000000b0067f11d1829asm99352qvn.20.2023.12.14.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:58:16 -0800 (PST)
Date:   Thu, 14 Dec 2023 22:58:12 +0900 (JST)
Message-Id: <20231214.225812.609786828308701015.syoshida@redhat.com>
To:     kuniyu@amazon.com
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com,
        nogikh@google.com, syzkaller@googlegroups.com
Subject: Re: [PATCH net] net: Return error from sk_stream_wait_connect() if
 sk_wait_event() fails
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20231214134615.55389-1-kuniyu@amazon.com>
References: <20231214.223106.2284573595890480656.syoshida@redhat.com>
        <20231214134615.55389-1-kuniyu@amazon.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 22:46:14 +0900, Kuniyuki Iwashima wrote:
> From: Shigeru Yoshida <syoshida@redhat.com>
> Date: Thu, 14 Dec 2023 22:31:06 +0900 (JST)
>> On Thu, 14 Dec 2023 17:46:22 +0900, Kuniyuki Iwashima wrote:
>> > From: Shigeru Yoshida <syoshida@redhat.com>
>> > Date: Thu, 14 Dec 2023 14:09:22 +0900
>> >> The following NULL pointer dereference issue occurred:
>> >> 
>> >> BUG: kernel NULL pointer dereference, address: 0000000000000000
>> >> <...>
>> >> RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
>> >> RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
>> >> <...>
>> >> Call Trace:
>> >>  <TASK>
>> >>  dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
>> >>  inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
>> >>  sock_sendmsg_nosec net/socket.c:730 [inline]
>> >>  __sock_sendmsg+0x83/0xe0 net/socket.c:745
>> >>  ____sys_sendmsg+0x443/0x510 net/socket.c:2558
>> >>  ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
>> >>  __sys_sendmsg+0xa6/0x120 net/socket.c:2641
>> >>  __do_sys_sendmsg net/socket.c:2650 [inline]
>> >>  __se_sys_sendmsg net/socket.c:2648 [inline]
>> >>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
>> >>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>> >>  do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
>> >>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> >> 
>> >> sk_wait_event() returns an error (-EPIPE) if disconnect() is called on the
>> >> socket waiting for the event. However, sk_stream_wait_connect() returns
>> >> success, i.e. zero, even if sk_wait_event() returns -EPIPE, so a function
>> >> that waits for a connection with sk_stream_wait_connect() may misbehave.
>> >> 
>> >> In the case of the above DCCP issue, dccp_sendmsg() is waiting for the
>> >> connection. If disconnect() is called in concurrently, the above issue
>> >> occurs.
>> >> 
>> >> This patch fixes the issue by returning error from sk_stream_wait_connect()
>> >> if sk_wait_event() fails.
>> >> 
>> >> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
>> >> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>> > 
>> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> > 
>> > I guess you picked this issue from syzbot's report.
>> > https://lore.kernel.org/netdev/0000000000009e122006088a2b8d@google.com/
>> > 
>> > If so, let's give a proper credit to syzbot and its authors:
>> > 
>> > Reported-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
>> 
>> Hi Kuniyuki-san,
>> 
>> Thank you very much for your review. I didn't notice the syzbot's
>> report. Actually, I found this issue by running syzkaller on my
>> machine.
> 
> Thanks for clarifying.
> 
> I'm also running syzkaller locally and used to add
> 
>   Reported-by: syzbot <syzkaller@googlegroups.com>
> 
> But, it was confusing for syzbot's owners, and I got a mail from one of
> the authors, Aleksandr Nogikh.  Since then, if syzkaller found an issue
> that was not on the syzbot dashboard, I have used
> 
>   Reported-by: syzkaller <syzkaller@googlegroups.com>

Thanks for your information. This tag looks great, so I will use this
next time I send a fix found by local syzkaller :)

Thanks,
Shigeru

> 
> .  FWIW, here's Aleksandr's words from the mail.
> 
> ---8<---
> Maybe it would be just a little more clear if instead of
> Reported-by: syzbot <syzkaller@googlegroups.com>
> you'd write
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> if the bug was found only by a local syzkaller instance, because
> otherwise it implies that the bug was found by syzbot, which is not
> really the case here :)
> ---8<---
> 
> 
>> 
>> Now, I tested this patch with syzbot, and it looks good.
>> 
>> Reported-and-tested-by: syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com
> 
> This time, this tag is best.
> 
> Thanks!
> 
> 

