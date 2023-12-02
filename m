Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B61801E16
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 19:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjLBSMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBSMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 13:12:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EB5119;
        Sat,  2 Dec 2023 10:12:28 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0031FC84;
        Sat,  2 Dec 2023 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701540746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKKElGndb6jN6rikp3anJK9MKgurw4EhN7S3f9KMiUc=;
        b=ByOOKiBBXs+G3CgixWcwoXU3Hyu4zmCk9TmLBfsVSk8pBxGedDHCd6lkkTPuMpDKhu2LL1
        PnSG1s0PGnmUKFe2qe+W6bc7m+wDUpoTal8ywk+TjsMQwgijTwlcRD1xyD8LcbcoRCBmz2
        NSlXi/lyMNuxajN8qNKmZoot0fsCdCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701540746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKKElGndb6jN6rikp3anJK9MKgurw4EhN7S3f9KMiUc=;
        b=1zhMsnvgSMeU8la4Atp2i3gCjqg1uEtRtc+ehyUAiGzJiqir6Zia+chgwKpS1vDnA1TI6p
        Tc1fKsaOEuor/8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07E3513808;
        Sat,  2 Dec 2023 18:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id A+4tAYpza2WtbAAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Sat, 02 Dec 2023 18:12:26 +0000
Message-ID: <67b155dd-3731-489e-c3bd-333cb7e90801@suse.cz>
Date:   Sat, 2 Dec 2023 19:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Content-Language: en-US
To:     "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
        Kees Cook <keescook@chromium.org>,
        "sxwjean@me.com" <sxwjean@me.com>
Cc:     "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
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
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <PH0PR11MB51923F916D8FB7D94270BBA7EC80A@PH0PR11MB5192.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         SUBJECT_HAS_CURRENCY(1.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FREEMAIL_TO(0.00)[windriver.com,chromium.org,me.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[16];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FREEMAIL_CC(0.00)[gmail.com,linux.com,kvack.org,kernel.org,google.com,lge.com,linux.dev,lwn.net,arndb.de,linux-foundation.org,linuxfoundation.org,vger.kernel.org];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.80
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 05:23, Song, Xiongwei wrote:
> 
> 
>> -----Original Message-----
>> From: Kees Cook <keescook@chromium.org>
>> Sent: Saturday, December 2, 2023 1:48 AM
>> To: sxwjean@me.com
>> Cc: vbabka@suse.cz; 42.hyeyoo@gmail.com; cl@linux.com; linux-mm@kvack.org;
>> penberg@kernel.org; rientjes@google.com; iamjoonsoo.kim@lge.com;
>> roman.gushchin@linux.dev; corbet@lwn.net; arnd@arndb.de; akpm@linux-
>> foundation.org; gregkh@linuxfoundation.org; linux-doc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Song, Xiongwei <Xiongwei.Song@windriver.com>
>> Subject: Re: [RFC PATCH 2/3] mm/slub: unify all sl[au]b parameters with "slab_$param"
>> 
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and know the
>> content is safe.
>> 
>> On Fri, Dec 01, 2023 at 11:15:04AM +0800, sxwjean@me.com wrote:
>> > From: Xiongwei Song <xiongwei.song@windriver.com>
>> >
>> > Since the SLAB allocator has been removed, so we need to clean up the
>> > sl[au]b_$params. However, the "slab/SLAB" terms should be keep for
>> > long-term rather than "slub/SLUB". Hence, we should use "slab_$param"
>> > as the primary prefix, which is pointed out by Vlastimil Babka. For more
>> > information please see [1].
>> >
>> > This patch is changing the following slab parameters
>> > - slub_max_order
>> > - slub_min_order
>> > - slub_min_objects
>> > - slub_debug
>> > to
>> > - slab_max_order
>> > - slab_min_order
>> > - slab_min_objects
>> > - slab_debug
>> > as the primary slab parameters in
>> > Documentation/admin-guide/kernel-parameters.txt and source, and rename all
>> > setup functions of them too. Meanwhile, "slub_$params" can also be passed
>> > by command line, which is to keep backward compatibility. Also mark all
>> > "slub_$params" as legacy.
>> 
>> *If* we do this, I think the old names need to be recognized, perhaps

Yes, they are already recognized by the patch.

>> with a boot pr_warn() about their deprecation/renaming for several
>> releases (likely across LTSes). I think it's not a good idea to
>> wholesale rename these with no warning. That's going to cause a lot of
>> surprises and broken userspace...
> 
> Oh, yes, that's a good idea. Will update.

I'd wait for a while with the warnings, no need to rush.

> Regards,
> Xiongwei
>> 
>> --
>> Kees Cook

