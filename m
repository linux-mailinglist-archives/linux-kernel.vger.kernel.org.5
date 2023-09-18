Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913157A49EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbjIRMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbjIRMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:32 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1EBA;
        Mon, 18 Sep 2023 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=xh40g7onQJNZ9MEsk7XfawwcORdpcbcgjNtD+Y0h5Fk=; b=SPRUd/HAHZz9PTcv+s6BbJOT23
        7lIZF+3OCTvJnVUeOFsircb4rpwG2I7umMNaulDTTiIFTiZXCrC6aKNCV+Bp6o3+W6lWh8CLUwXOn
        soVPGGE/x5OULLiV7mihLpNMprKI9WGxkXHN+9i+jth74dRqojZllrQ+f/+cI7FQb9QkMUv8h/wPN
        l5+hgqGKbChhgqC0+jT4N7xaMn2l6uxJsZy9HokGXXbE0IB2n1TFssU01I4CdeT2ch/Lja4O9nzXv
        d41gdvl1117ZtEQYASAg2jjjN10WkzmnrlOochRMQU4y9fg6WP7m0fbxC5lhoDo34bSzfZhnm7HgI
        WxZbY4GQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qiDZ3-000Lm8-Fy; Mon, 18 Sep 2023 14:41:21 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qiDZ2-000AOR-Vk; Mon, 18 Sep 2023 14:41:21 +0200
Subject: Re: [syzbot] [bpf?] WARNING in bpf_mprog_pos_after
To:     syzbot <syzbot+2558ca3567a77b7af4e3@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com,
        yonghong.song@linux.dev
References: <000000000000bf4d0c06059b3c95@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d3ecc822-00aa-7d66-c8c0-44ac7bff919e@iogearbox.net>
Date:   Mon, 18 Sep 2023 14:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000000000000bf4d0c06059b3c95@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27035/Mon Sep 18 09:40:43 2023)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 7:15 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ca5ab9638e92 Merge branch 'selftests-classid'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=110ef2c2680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
> dashboard link: https://syzkaller.appspot.com/bug?extid=2558ca3567a77b7af4e3
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Will take a look, thx.
