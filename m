Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF97F762C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjKXOSC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 09:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjKXOR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:17:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE1919A5;
        Fri, 24 Nov 2023 06:18:05 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0E01FE7D;
        Fri, 24 Nov 2023 14:18:04 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BCFCE139E8;
        Fri, 24 Nov 2023 14:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id l0A5GpiwYGXWIAAAn2gu4w
        (envelope-from <colyli@suse.de>); Fri, 24 Nov 2023 14:18:00 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: bcache: kernel NULL pointer dereference since 6.1.39
From:   Coly Li <colyli@suse.de>
In-Reply-To: <1c2a1f362d667d36d83a5ba43218bad199855b11.camel@gekmihesg.de>
Date:   Fri, 24 Nov 2023 22:17:46 +0800
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Zheng Wang <zyytlz.wz@163.com>, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Stefan_F=C3=B6rster?= <cite@incertum.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Bcache Linux <linux-bcache@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de>
References: <ZV9ZSyDLNDlzutgQ@pharmakeia.incertum.net>
 <be371028-efeb-44af-90ea-5c307f27d4c6@leemhuis.info>
 <71576a9ff7398bfa4b8c0a1a1a2523383b056168.camel@gekmihesg.de>
 <989C39B9-A05D-4E4F-A842-A4943A29FFD6@suse.de>
 <1c2a1f362d667d36d83a5ba43218bad199855b11.camel@gekmihesg.de>
To:     Markus Weippert <markus@gekmihesg.de>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6E0E01FE7D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023年11月24日 21:55，Markus Weippert <markus@gekmihesg.de> 写道：
> 
> On Fri, 2023-11-24 at 21:46 +0800, Coly Li wrote:
>> 
>> 
>>> 2023年11月24日 21:29，Markus Weippert <markus@gekmihesg.de> 写道：
>>> 
>>>> On 23.11.23 14:53, Stefan Förster wrote:
>>>>> 
>>>>> starting with kernel 6.1.39, we see the following error message
>>>>> with
>>>>> heavy I/O loads. We needed to revert
>>>> 
>>>> Thx for the report. I assume that problem still occurs with the
>>>> latest
>>>> 6.1.y kernel?
>>>> 
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.39&id=68118c339c6e1e16ae017bef160dbe28a27ae9c8
>>>> 
>>>> FWIW, that is mainline commit 028ddcac477b69 ("bcache: Remove
>>>> unnecessary NULL point check in node allocations") [v6.5-rc1].
>>>> 
>>>> Did a quick check and noticed a fix for that change was recently
>>>> mainlined as f72f4312d43883 ("bcache: replace a mistaken IS_ERR()
>>>> by
>>>> IS_ERR_OR_NULL() in btree_gc_coalesce()") [v6.7-rc2-post]:
>>>> https://lore.kernel.org/all/20231118163852.9692-1-colyli@suse.de/
>>>> 
>>>> It is expected to soon be interegrated into a 6.1.y kernel.
>>>> 
>>>> But maybe it's something else. I CCed the involved people, they
>>>> might
>>>> know.
>>> 
>>> We applied f72f4312d43883 to the current Debian kernel (based on
>>> 6.1.55) but it didn't help, same stack trace.
>>> Looking at the description, __bch_btree_node_alloc() should never
>>> be
>>> able to return NULL anyway after
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.39&id=7ecea5ce3dc17339c280c75b58ac93d8c8620d9f
>>> But I didn't verify all callers, so this might still be correct, if
>>> it's not always initialized with the return value of
>>> __bch_btree_node_alloc().
>>> 
>>> Anyway, I think we fixed it by applying this:
>>> 
>>> diff -Naurp a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
>>> --- a/drivers/md/bcache/btree.c 2023-09-23 11:11:13.000000000 +0200
>>> +++ b/drivers/md/bcache/btree.c 2023-11-24 13:13:09.840013759 +0100
>>> @@ -1489,7 +1489,7 @@ out_nocoalesce:
>>> bch_keylist_free(&keylist);
>>> 
>>> for (i = 0; i < nodes; i++)
>>> - if (!IS_ERR(new_nodes[i])) {
>>> + if (!IS_ERR_OR_NULL(new_nodes[i])) {
>>> btree_node_free(new_nodes[i]);
>>> rw_unlock(true, new_nodes[i]);
>>> }
>>> 
>> 
>> The above change is what commit f72f4312d43883 ("bcache: replace a
>> mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()” does.
> 
> But f72f4312d43883 reverts @@ -1340,7 +1340,7 @@, while the patch we
> applied reverts @@ -1487,7 +1487,7 @@ instead.
> Applying f72f4312d43883 didn't help for us.
> 

OK, I know what you mean.  Yes, your fix is necessary too.

Would you like to post patch for your fix?

Thanks.

Coly Li


>> 
>> Although the above patch is suggested to go into 6.5+ kernel, for
>> this condition it should go into all stable kernels where commit
>> 028ddcac477b69 ("bcache: Remove unnecessary NULL point check in node
>> allocations”) were merged into.
[snipped]
