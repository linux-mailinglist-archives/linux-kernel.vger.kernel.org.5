Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A777593FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGSLMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGSLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:12:12 -0400
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 04:12:11 PDT
Received: from mail.mu-ori.me (mail.mu-ori.me [185.189.151.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0D186
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mu-ori.me; s=mail;
        t=1689764599; bh=U6L9qf57aZ+piH/Y4yyE5WrcMXFqI5zBHQ7zUeMMado=;
        h=Date:From:To:Subject:From;
        b=VHjBV+EyciLX5c4tMPbkLVezmAkXeWygc0xO0L5F7LEW1D6fFLpn/c12pE+BdB6vi
         lSmQ1y/i9dvwJmTpc8XU4qNTsiVR4M5z6e0Tngo2gH314EBHLfwmd2L++ilWMp9Jl7
         l9xaE8HkemRMHISl+Fkab0fjiNfQC69pSKeBlxOFIG2FuLtAcDbL8X85Phb7RT/Rat
         eZdWbefoPqtgoV9KCaSB9Ys1XaXfCPBPK/sAIvEQd97drmg4MqhJu7kQA6rwD8G2W/
         ZweUDlSyBYI5Xs887kaGzM7HZqr6ufK1AL8GHpkoqVa9Et1ittsd2hIktYsCym9Zzq
         Rdtu5Nhogf2xA==
Received: from webm.mu-ori.me (localhost [127.0.0.1])
        by mail.mu-ori.me (Postfix) with ESMTPSA id 9D2B3613AD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:03:19 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 11:03:19 +0000
From:   "Drew B." <subs@mu-ori.me>
To:     linux-kernel@vger.kernel.org
Subject: Misbehavior with setsockopt timeval structure with -fpack-struct
 enabled
Message-ID: <559f4003c263a7aaa873cbc80947cc57@mu-ori.me>
X-Sender: subs@mu-ori.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!
I've got a very strange behavior on Linux and OS X build of the same 
source code. To be specific, when I try to set socket timeout option:

...
struct timeval timeout;
timeout.tv_sec = 0;
timeout.tv_usec = 1;
ret = setsockopt(so, SOL_SOCKET, SO_RCVTIMEO, &timeout, 
sizeof(timeout));
...

with -fpack-struct enabled, on Linux machine the size of timeval struct 
is 16 bytes (as well as unpacked), while on OS X it's 12 for packed and 
16 for unpacked. In which case I get an error while trying to apply the 
setting to the socket. I dug a little bit deeper and the following piece 
of code in net/core/sock.c:

...
int sock_copy_user_timeval(struct __kernel_sock_timeval *tv,
			   sockptr_t optval, int optlen, bool old_timeval)
{
	if (old_timeval && in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
		struct old_timeval32 tv32;

		if (optlen < sizeof(tv32))
			return -EINVAL;

		if (copy_from_sockptr(&tv32, optval, sizeof(tv32)))
			return -EFAULT;
		tv->tv_sec = tv32.tv_sec;
		tv->tv_usec = tv32.tv_usec;
	} else if (old_timeval) {
		struct __kernel_old_timeval old_tv;

		if (optlen < sizeof(old_tv))
			return -EINVAL;
		if (copy_from_sockptr(&old_tv, optval, sizeof(old_tv)))
			return -EFAULT;
		tv->tv_sec = old_tv.tv_sec;
		tv->tv_usec = old_tv.tv_usec;
	} else {
		if (optlen < sizeof(*tv))
			return -EINVAL;
		if (copy_from_sockptr(tv, optval, sizeof(*tv)))
			return -EFAULT;
	}

	return 0;
}
EXPORT_SYMBOL(sock_copy_user_timeval);
...

So, to be specific (same or similar logics goes through the function in 
respective places):
if (optlen < sizeof(tv32))
	return -EINVAL;
Which means, that it doesn't consider whether the structure is packed or 
not, it always compares against unpacked (?) structure == 16 bytes (for 
now).

Is it expected?

Kind regards,
Drew.
