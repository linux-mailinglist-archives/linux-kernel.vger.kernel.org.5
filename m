Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A447F790A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKXQe7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 11:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:34:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A31733;
        Fri, 24 Nov 2023 08:35:03 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F5591FF97;
        Fri, 24 Nov 2023 16:35:02 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8259B132E2;
        Fri, 24 Nov 2023 16:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 6bIsDLLQYGVsRwAAn2gu4w
        (envelope-from <colyli@suse.de>); Fri, 24 Nov 2023 16:34:58 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR
From:   Coly Li <colyli@suse.de>
In-Reply-To: <54706535-208b-43b5-814f-570ffa7b29bb@kernel.dk>
Date:   Sat, 25 Nov 2023 00:34:44 +0800
Cc:     Markus Weippert <markus@gekmihesg.de>,
        Bcache Linux <linux-bcache@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Zheng Wang <zyytlz.wz@163.com>, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Stefan_F=C3=B6rster?= <cite@incertum.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Transfer-Encoding: 8BIT
Message-Id: <910112B4-168D-4ECC-B374-7E6668B778F9@suse.de>
References: <ZV9ZSyDLNDlzutgQ@pharmakeia.incertum.net>
 <be371028-efeb-44af-90ea-5c307f27d4c6@leemhuis.info>
 <71576a9ff7398bfa4b8c0a1a1a2523383b056168.camel@gekmihesg.de>
 <989C39B9-A05D-4E4F-A842-A4943A29FFD6@suse.de>
 <1c2a1f362d667d36d83a5ba43218bad199855b11.camel@gekmihesg.de>
 <3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de>
 <c47d3540ece151a2fb30e1c7b5881cb8922db915.camel@gekmihesg.de>
 <B68E455A-D6EB-4BB9-BD60-F2F8C3C8C21A@suse.de>
 <54706535-208b-43b5-814f-570ffa7b29bb@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spamd-Bar: ++++++++
X-Spam-Score: 8.63
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 2F5591FF97
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of colyli@suse.de) smtp.mailfrom=colyli@suse.de
X-Spamd-Result: default: False [8.63 / 50.00];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         TO_DN_SOME(0.00)[];
         MV_CASE(0.50)[];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.35)[76.36%];
         MID_RHS_MATCH_FROM(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[163.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(2.68)[0.894];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,kernel.dk:email,gekmihesg.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FREEMAIL_CC(0.00)[gekmihesg.de,vger.kernel.org,leemhuis.info,163.com,incertum.net,linuxfoundation.org,lists.linux.dev];
         RCVD_TLS_ALL(0.00)[];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023年11月25日 00:31，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 11/24/23 9:29 AM, Coly Li wrote:
>> 
>> 
>>> 2023?11?24? 23:14?Markus Weippert <markus@gekmihesg.de> ???
>>> 
>>> Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
>>> node allocations") replaced IS_ERR_OR_NULL by IS_ERR. This leads to a
>>> NULL pointer dereference.
>>> 
>>> BUG: kernel NULL pointer dereference, address: 0000000000000080
>>> Call Trace:
>>> ? __die_body.cold+0x1a/0x1f
>>> ? page_fault_oops+0xd2/0x2b0
>>> ? exc_page_fault+0x70/0x170
>>> ? asm_exc_page_fault+0x22/0x30
>>> ? btree_node_free+0xf/0x160 [bcache]
>>> ? up_write+0x32/0x60
>>> btree_gc_coalesce+0x2aa/0x890 [bcache]
>>> ? bch_extent_bad+0x70/0x170 [bcache]
>>> btree_gc_recurse+0x130/0x390 [bcache]
>>> ? btree_gc_mark_node+0x72/0x230 [bcache]
>>> bch_btree_gc+0x5da/0x600 [bcache]
>>> ? cpuusage_read+0x10/0x10
>>> ? bch_btree_gc+0x600/0x600 [bcache]
>>> bch_gc_thread+0x135/0x180 [bcache]
>>> 
>>> The relevant code starts with:
>>> 
>>>   new_nodes[0] = NULL;
>>> 
>>>   for (i = 0; i < nodes; i++) {
>>>       if (__bch_keylist_realloc(&keylist, bkey_u64s(&r[i].b->key)))
>>>           goto out_nocoalesce;
>>>   // ...
>>> out_nocoalesce:
>>>   // ...
>>>   for (i = 0; i < nodes; i++)
>>>       if (!IS_ERR(new_nodes[i])) {  // IS_ERR_OR_NULL before
>>> 028ddcac477b
>>>           btree_node_free(new_nodes[i]);  // new_nodes[0] is NULL
>>>           rw_unlock(true, new_nodes[i]);
>>>       }
>>> 
>>> This patch replaces IS_ERR() by IS_ERR_OR_NULL() to fix this.
>>> 
>>> Fixes: 028ddcac477b ("bcache: Remove unnecessary NULL point check in
>>> node allocations")
>>> Link:
>>> https://lore.kernel.org/all/3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de/
>>> Cc: stable@vger.kernel.org
>>> Cc: Zheng Wang <zyytlz.wz@163.com>
>>> Cc: Coly Li <colyli@suse.de>
>>> Signed-off-by: Markus Weippert <markus@gekmihesg.de>
>> 
>> Added into my for-next.  Thanks for patching up.
> 
> We should probably get this into the current release, rather than punt
> it to 6.8.

Yes, copied. So far I don’t have other bcache patches for 6.7, I feel I might be redundant if I send you another for -rc4 series with this single patch.

Could you please directly take it into -rc4?

Thanks.

Coly Li
