Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E387C788BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbjHYO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbjHYO2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:28:33 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B31995;
        Fri, 25 Aug 2023 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=icpdtukZEwDUOix5x9ObHjr4ZbjXlgBrYTfK907GSfI=; b=UKBytyyKZYw3JF/zHzs/PoNhCO
        80cFvXNsTJf/2NtDDqK5PAFy5GloqDUeFgW2p7NtPWpSNXmK9XhyRivnOyssNuxee7kMaP4uwZbBn
        Fgz5qQ3nET+tOYtOsWIsrZaBZOoFdGgbLGicYdV24N8t41A1wNeWBSk9IyvECtMLEahQM1vdLU9N4
        ts/LS80zOa8EhbjSd5dTpxUA3V/G90X9edD9me7m98nZMZeEM3lbPu/zgnT7JYYXzrIy7e0kXBlgW
        U43sDE6wBhlokfiwWWqTc9kBKqCdNwWZPLVYzz5H8CLMLc2fZPmPYNukb9YMD6gFKl45sKx7Q8rCw
        TrMmAYeA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qZXnO-000Jop-Bs; Fri, 25 Aug 2023 16:28:18 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qZXnO-000UPX-B3; Fri, 25 Aug 2023 16:28:18 +0200
Subject: Re: [PATCH V2] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
To:     Oleg Nesterov <oleg@redhat.com>, Yonghong Song <yhs@fb.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
 <20230822120549.GA22091@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <05c66b19-d083-57df-b1ee-73035613df36@iogearbox.net>
Date:   Fri, 25 Aug 2023 16:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230822120549.GA22091@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 8/22/23 2:05 PM, Oleg Nesterov wrote:
> get_pid_task() makes no sense, the code does put_task_struct() soon after.
> Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
> put_task_struct(), this allows to do get_task_struct() only once before
> return.
> 
> While at it, kill the unnecessary "if (!pid)" check in the "if (!*tid)"
> block, this matches the next usage of find_pid_ns() + get_pid_task() in
> this function.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Could you rebase this against bpf-next tree so this can run through our BPF
CI? Right now the CI cannot pick the patch up due to merge conflict [0].

Thanks,
Daniel

   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230822120549.GA22091@redhat.com/
