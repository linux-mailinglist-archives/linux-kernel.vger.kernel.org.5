Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8B765BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjG0Sue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjG0Sub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:50:31 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEFF19A7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:50:29 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6bc7b12ee26so598545a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483829; x=1691088629;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSKGCew+LNfabW3yh1/xiFsSSUY3CKeeb05ZwnBCtJU=;
        b=O4XEa5dET9oD09DkK64xUH88onm5klK0c5AwfmgRpvUhxswz1OgFyus/PGvv1myCRm
         Wl16S+xB/mzL0b5jsWKycKoFLbaSNc+6gnMJPJm2iypia0SmJ0EzKho+VCDEIyzK5e62
         BtgoOR7/JXFhznkVRrF5lCA4T26hP/7Hia/O3E2TYdlmUx3QMOcLi6x8VB3qPXrH7E88
         RidhsLs26Ox6n14pIWELKSAoMfB6VjLuKub8j//KI71jPINj8RpvlZD3bgVahWJjZngo
         o/0FHy++ia1AYoC323OKYw2gYVV5h3MPZTEzgSni/Iq0FqaU3TZ0jtbzNGNCsm49/yrE
         9vxg==
X-Gm-Message-State: ABy/qLapNAUQ9BUHPIxr0cBhgUVdbJh7sgnlPKJAgBus6YTCdWGilI8O
        akHdoT6MBk3MKy8B2LhxhvqWKwQXFPPhdLRlM9zsFCv6NrlK
X-Google-Smtp-Source: APBJJlE9iMzZ4f3wPhlPp8kdxaP2U4uEsqOvvW/15vs7hrkkBy1xr+3UP3+qyVFyGTtVIEStRTmIVEE4UL1+k0t+ubQdtfUUt03C
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5b16:b0:1bb:470c:901c with SMTP id
 ds22-20020a0568705b1600b001bb470c901cmr296245oab.7.1690483828929; Thu, 27 Jul
 2023 11:50:28 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:50:28 -0700
In-Reply-To: <ZMK8ch6N/s3mbK6F@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f3ae506017c704b@google.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
From:   syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
To:     willy@infradead.org
Cc:     akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jul 25, 2023 at 11:57:22PM -0700, syzbot wrote:
>> syzbot has bisected this issue to:
>
> FWIW, this is unrelated to the previous issue.  It's the caller of
> mas_walk() that has violated the locking constraints, and mas_walk() is
> simply reporting the issue.  Is there a way to get syzbot to understand
> that it needs to unwind the call-stack further to decide who to blame?
>
>> commit a52f58b34afe095ebc5823684eb264404dad6f7b
>> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Date:   Mon Jul 24 18:54:10 2023 +0000
>> 
>>     mm: handle faults that merely update the accessed bit under the VMA lock
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1783585ea80000
>> start commit:   [unknown] 
>> git tree:       linux-next
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1443585ea80000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1043585ea80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f481ab36ce878b84
>> dashboard link: https://syzkaller.appspot.com/bug?extid=8645fe63c4d22c8d27b8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1697cec9a80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1566986ea80000
>
> #syz test

want 2 args (repo, branch), got 4

>
> diff --git a/mm/memory.c b/mm/memory.c
> index 20a2e9ed4aeb..57b271108bdc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3567,6 +3567,12 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		return 0;
>  	}
>  copy:
> +	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma->anon_vma) {
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +		vma_end_read(vmf->vma);
> +		return VM_FAULT_RETRY;
> +	}
> +
>  	/*
>  	 * Ok, we need to copy. Oh, well..
>  	 */
