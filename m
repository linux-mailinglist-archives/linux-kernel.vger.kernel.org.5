Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D120E75BBA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGUAwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGUAwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:52:32 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7402B271E;
        Thu, 20 Jul 2023 17:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ofNP4BiKlo56+J4pAMQ9X8dyJ9W7gZc/qKAuUv0l19U=; b=WeWvfZCedKNjUTgjGnm4btqGfh
        zUC7pLWRsTXLxrcqS4TNbOH+aDubqIooD2MWVIIF5dvl8YdvlrZSF+e92B4QrC1Ku0tgX2aALppZ+
        JVCnapGX5BsQs13+MVBOZxpJu+bwVB+GEK4q9X8EMkm6BW3WeLX+wdPkGNBPyoValhNuxzkfUyVQ2
        10cuJnG54yp4/ZKJcpl9a6a2YEuXshbCQFlQSn3nMPUv1rYblYZ7MaGEmvoyDx1W8PXXVmAn0CgjI
        o+x2vSa2/cncKgLs/G/1ByrjPNq7kjBYcJg8N2+V+JRGGY1g+G3d5SJSkxGeKrV5Ftjr8EbLJi2v7
        0tAA6rYw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qMeNf-000FxV-3R; Fri, 21 Jul 2023 02:52:27 +0200
Received: from [123.243.13.99] (helo=192-168-1-114.tpgi.com.au)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qMeNd-000NG2-Ji; Fri, 21 Jul 2023 02:52:26 +0200
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
To:     syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <000000000000ee69e80600ec7cc7@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
Date:   Fri, 21 Jul 2023 02:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000000000000ee69e80600ec7cc7@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26975/Thu Jul 20 09:29:20 2023)
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 5:06 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    03b123debcbc tcp: tcp_enter_quickack_mode() should be static
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ac9ffaa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
> dashboard link: https://syzkaller.appspot.com/bug?extid=14736e249bce46091c18
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f36c6a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8e73aa80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/348462fb61fa/disk-03b123de.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/33375730f77f/vmlinux-03b123de.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b6882fbac041/bzImage-03b123de.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com

Thanks, I'll take a look this evening.
