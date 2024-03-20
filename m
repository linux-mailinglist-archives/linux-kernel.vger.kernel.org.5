Return-Path: <linux-kernel+bounces-108703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B17880EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2301C282FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A383B79F;
	Wed, 20 Mar 2024 09:43:00 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FF381AC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927779; cv=none; b=jyeEdNj+aVlpesTcBTk+3b2sLJvmXbdqd6soeOgqRhbHFw9qvRBknZon85HR/53sSWgcpgDOe1mx9sIrOtuabMiPtEkKjtdCDceMBf9OtyB0ZzaVJ0426pz9OUY5gOtr3oXc/hTZ2flCSepYMtm+2l6e8vT8gbflXY+Ei3aseTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927779; c=relaxed/simple;
	bh=DNJw44BGlAXSM17lOwQozV3G2sE2GRZ3K3k74HcLxoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jt0k+4yAlf1wYV5tnRMlmgRuoFTP37dxV7hfwFPtwIMFGUJLAtphbr5V5kkNFY7eScD2wt+cGwg8xBUHIaUihvvpj609h2mshl1bWrOTvm49ZdrvjM+RyyBfxqnEZKBOmERlZbznIz53NkiOdeMzy8fnLTfKI8J6rXzyyqDaQkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42K9grZU037117;
	Wed, 20 Mar 2024 18:42:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Wed, 20 Mar 2024 18:42:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42K9grgL037114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 18:42:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2b75a26f-6c8b-40b3-8ea7-d2cf275b58fe@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 18:42:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-2-osalvador@suse.de>
 <20240319162430.3e76504d06f12edc107029a4@linux-foundation.org>
 <d82aedb5-9406-4808-96b4-1d9ef63485a3@I-love.SAKURA.ne.jp>
 <Zfp40dsYSlCouvJW@localhost.localdomain>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Zfp40dsYSlCouvJW@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/20 14:49, Oscar Salvador wrote:
> This should have the follwing on top:
> 
>  diff --git a/mm/page_owner.c b/mm/page_owner.c
>  index 2613805cb665..e477a71d6adc 100644
>  --- a/mm/page_owner.c
>  +++ b/mm/page_owner.c
>  @@ -222,8 +222,11 @@ static void dec_stack_record_count(depot_stack_handle_t handle,
>   {
>          struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
>   
>  -       if (stack_record)
>  -               refcount_sub_and_test(nr_base_pages, &stack_record->count);
>  +       if (!stack_record)
>  +               return;
>  +
>  +       if (refcount_sub_and_test(nr_base_pages, &stack_record->count))
>  +               WARN(1, "%s refcount went to 0 for %u handle\n", __func__, handle);
>   }
> 
> 

That fixed this problem. Thank you.

-------- Forwarded Message --------
Date: Wed, 20 Mar 2024 01:31:03 -0700
In-Reply-To: <4362246e-d804-43de-800b-a7840b70919a@I-love.SAKURA.ne.jp>
Message-ID: <000000000000410e3b061413692b@google.com>
Subject: Re: [syzbot] [mm?] WARNING: refcount bug in __reset_page_owner
From: syzbot <syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com

Tested on:

commit:         a4145ce1 Merge tag 'bcachefs-2024-03-19' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131b1d66180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f47e8dfa53b0b11
dashboard link: https://syzkaller.appspot.com/bug?extid=98c1a1753a0731df2dd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13972985180000

Note: testing is done by a robot and is best-effort only.


