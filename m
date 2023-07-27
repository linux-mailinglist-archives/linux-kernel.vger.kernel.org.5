Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B935F765BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjG0SxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjG0SxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:53:04 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE41E47
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:53:03 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5661d846419so2069869eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483983; x=1691088783;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC4nonI38Pnq4+oOIpUu/kne/9Z2ecJz6vjIQJOSR3A=;
        b=T09DiJAi30cyiCiDHld/qNEtBQ+anmB5AgqVcoyca152S5UH0zSiL2P11kS4s750aL
         /beA4ou0I/3G8RO4lCp4q0LAFbAkV51BmXocaIzLpWPARI27xqjOQ4PorB0pkZAjunwF
         l/ZqDV+W8ucN0FDc/D+vwzfhN5NqJ61VHu8RD2esbfkeOjqThfi/rnGS6Xtu2K1t63/C
         U9aXnafCtoEXBMI0GoANo9CllpH4dd+AxiONXr7ABc3Dxcj/8b6jqUZ6n870g0LUrhWh
         kvBkW6FSQpGGduV+Osxjz3Iee07NP1XUqdFOtszY2YvUXm1k9nWY2lMQ68y3h/yC0c35
         5oGg==
X-Gm-Message-State: ABy/qLa/6HNOp+3GFJqp7me9VvpsIOutM8HjDSoWVciwy7I8bSgG9s4T
        ycV/AJo78U2BMXwlmW6uzrHO85BLxJF5n3D8PLnZa2tChoLQ
X-Google-Smtp-Source: APBJJlGuZig8DSBJjCDdGYmVanNuxiATylJFPkC8Exx/ZiCYfKYe/s2SvWxq3aSZBIKz09o0XijVQtOzLCqF4zXzjCjhevwb9U/6
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a13:b0:3a4:14c1:20f5 with SMTP id
 bk19-20020a0568081a1300b003a414c120f5mr96517oib.6.1690483982911; Thu, 27 Jul
 2023 11:53:02 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:53:02 -0700
In-Reply-To: <ZMK9C+iq3y8POOGp@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ccc7906017c79e0@google.com>
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
>> 
>> commit a52f58b34afe095ebc5823684eb264404dad6f7b
>> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Date:   Mon Jul 24 18:54:10 2023 +0000
>> 
>>     mm: handle faults that merely update the accessed bit under the VMA lock
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1783585ea80000
>> start commit:   [unknown] 
>> git tree:       linux-next
>
> #syz test linux-next a52f58b34afe095ebc5823684eb264404dad6f7b

"linux-next" does not look like a valid git repo address.

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
