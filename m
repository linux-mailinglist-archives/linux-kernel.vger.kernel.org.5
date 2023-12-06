Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060BA807330
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442076AbjLFO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378993AbjLFO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:59:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F1F9A;
        Wed,  6 Dec 2023 06:59:36 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2472F21E31;
        Wed,  6 Dec 2023 14:59:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F01D2136CD;
        Wed,  6 Dec 2023 14:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id Z+zDOVWMcGXmQgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 06 Dec 2023 14:59:33 +0000
Message-ID: <d5dff423-40a1-3789-e5ba-68e6c0ab6130@suse.cz>
Date:   Wed, 6 Dec 2023 15:59:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
        "sxwjean@me.com" <sxwjean@me.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231201031505.286117-1-sxwjean@me.com>
 <20231201031505.286117-3-sxwjean@me.com> <202312010945.7C5DB1FBB@keescook>
 <PH0PR11MB51923F916D8FB7D94270BBA7EC80A@PH0PR11MB5192.namprd11.prod.outlook.com>
 <67b155dd-3731-489e-c3bd-333cb7e90801@suse.cz>
 <202312021329.86D56FA@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202312021329.86D56FA@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [10.13 / 50.00];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         SUBJECT_HAS_CURRENCY(1.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         DMARC_NA(1.20)[suse.cz];
         RCVD_COUNT_THREE(0.00)[3];
         ARC_NA(0.00)[];
         MX_GOOD(-0.01)[];
         BAYES_HAM(-0.06)[61.00%];
         RCPT_COUNT_TWELVE(0.00)[16];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[windriver.com,me.com,gmail.com,linux.com,kvack.org,kernel.org,google.com,lge.com,linux.dev,lwn.net,arndb.de,linux-foundation.org,linuxfoundation.org,vger.kernel.org];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 10.13
X-Rspamd-Queue-Id: 2472F21E31
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 22:30, Kees Cook wrote:
> On Sat, Dec 02, 2023 at 07:12:25PM +0100, Vlastimil Babka wrote:
>> On 12/2/23 05:23, Song, Xiongwei wrote:
>> > 
>> > 
>> 
>> Yes, they are already recognized by the patch.
> 
> Ah, sorry, I missed that. I didn't see it when I skimmed earlier.
> 
>> >> with a boot pr_warn() about their deprecation/renaming for several
>> >> releases (likely across LTSes). I think it's not a good idea to
>> >> wholesale rename these with no warning. That's going to cause a lot of
>> >> surprises and broken userspace...
>> > 
>> > Oh, yes, that's a good idea. Will update.
>> 
>> I'd wait for a while with the warnings, no need to rush.
> 
> Better to start ASAP, yeah?

I find it a bit obnoxious to accept the slub_* names in one kernel release
and immediately warn in the next one. I'd let the people who read the
news/docs adjust on their own first :) After all, we wouldn't be warning
about something that's dangerous if not acted upon immediately, or something.
