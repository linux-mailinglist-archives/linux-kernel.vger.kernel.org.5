Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6280EEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376838AbjLLOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjLLOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:38:22 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB5D58E;
        Tue, 12 Dec 2023 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MuRcQ
        e8TLduVxtKfy1rz4cfp+MGhgey/aKEAQHKMeIQ=; b=iCR6IfLwb77oFKk3PSsDF
        AneEfzfYTO2kesT1zet5Z6czWeWqnSVCnsdsQXNC82sR1TesQxFnnwdqLmg+1xqj
        iYy4OTMxYectvo+iCMWTkhGzzk7LXx6Fh6tB4c2vzd9wbzfQJPd5X6+W3BIeWZhl
        lO+cXGdegZg78V3epI3fow=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
        by zwqz-smtp-mta-g2-4 (Coremail) with SMTP id _____wDXHjFMcHhlJtaRFQ--.5895S2;
        Tue, 12 Dec 2023 22:38:05 +0800 (CST)
From:   chenguanxi11234@163.com
To:     rafael@kernel.org
Cc:     chen.haonan2@zte.com.cn, chenguanxi11234@163.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH linux-next] kernel/power: Use kmap_local_page() in snapshot.c
Date:   Tue, 12 Dec 2023 22:38:04 +0800
Message-Id: <20231212143804.3887-1-chenguanxi11234@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0jZAOmnccbEUsBNw3f-Uh6TmO-6JGgU+PJazmjFASczHQ@mail.gmail.com>
References: <CAJZ5v0jZAOmnccbEUsBNw3f-Uh6TmO-6JGgU+PJazmjFASczHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXHjFMcHhlJtaRFQ--.5895S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1fKFWkZF4kAF1fCry8Xwb_yoW8Ar4fpr
        4DAFyDC3yYvFyUta4IqFnYkry5XwnIyw4fXF43A3WfurnI9wnFqr12q3WUGw1ayr4xJFWr
        ZrZrKF4kuFn5K37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8b15UUUUU=
X-Originating-IP: [117.176.219.50]
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBngVD+letfDvy8QADsf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What I've learned is that kmap_atomic() disables page-faults and 
preemption (the latter only for !PREEMPT_RT kernels).In my opinion, 
the code between the mapping and un-mapping in this patch does not 
depend on the above-mentioned side effects.So I simply replaced 
kmap_atomic() with kmap_local_page(). If I'm wrong, please explain it to me. 
Thank you.

>
>> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
>> ---
>>  kernel/power/snapshot.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index 50a15408c3fc..feef0d4d3288 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -1487,11 +1487,11 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
>>         s_page = pfn_to_page(src_pfn);
>>         d_page = pfn_to_page(dst_pfn);
>>         if (PageHighMem(s_page)) {
>> -               src = kmap_atomic(s_page);
>> -               dst = kmap_atomic(d_page);
>> +               src = kmap_local_page(s_page);
>> +               dst = kmap_local_page(d_page);
>>                 zeros_only = do_copy_page(dst, src);
>> -               kunmap_atomic(dst);
>> -               kunmap_atomic(src);
>> +               kunmap_local(dst);
>> +               kunmap_local(src);
>>         } else {
>>                 if (PageHighMem(d_page)) {
>>                         /*
>> @@ -1499,9 +1499,9 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
>>                          * data modified by kmap_atomic()
>>                          */
>>                         zeros_only = safe_copy_page(buffer, s_page);
>> -                       dst = kmap_atomic(d_page);
>> +                       dst = kmap_local_page(d_page);
>>                         copy_page(dst, buffer);
>> -                       kunmap_atomic(dst);
>> +                       kunmap_local(dst);
>>                 } else {
>>                         zeros_only = safe_copy_page(page_address(d_page), s_page);
>>                 }
>> --
>> 2.25.1
>>

