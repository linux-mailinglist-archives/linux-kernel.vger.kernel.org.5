Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA12F7F29AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjKUKDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjKUKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:03:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E68B9;
        Tue, 21 Nov 2023 02:03:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 62A3D2189D;
        Tue, 21 Nov 2023 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1700560985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6qoyWwClhugI9VZwP6suNYgWlewOSxpRzOpSziEEZA=;
        b=GtHeePB6BAvXazbBiyL1UhF0JAInm19ujuhcw5kw+/Qvx1GNMz4oUpUo1s/sVBfGLgA1It
        jJU9QZUXN+/Z9jVWwKQEnu/4Ys/ubA7LGk8g9CwJ7PIafqdZNpYWM4c384UA4EMWtpp1p1
        MvztAt2ayDrSs7n/uaTn1dY1jxW/Lpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1700560985;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6qoyWwClhugI9VZwP6suNYgWlewOSxpRzOpSziEEZA=;
        b=G+BlnnucPVfo1qGtny6AHeirbbuuvmiz0hwFHEYdV/WWHTgyQboeY9pZe0G/1jL52EAm+Y
        /Gm5nhaq2+vidiDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31A5E138E3;
        Tue, 21 Nov 2023 10:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WSFiC1mAXGVgPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Nov 2023 10:03:05 +0000
Message-ID: <a6472546-b169-a88c-66a5-972d54edcd76@suse.cz>
Date:   Tue, 21 Nov 2023 11:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm/slab: move slab merge from slab_common.c to slub.c
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, corbet@lwn.net,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231120091214.150502-1-sxwjean@me.com>
 <20231120091214.150502-5-sxwjean@me.com>
 <CAB=+i9RFxqFg2jz3ULbmmswqp0K7SK8O9Uv1=wpUZMQUtSGB1Q@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9RFxqFg2jz3ULbmmswqp0K7SK8O9Uv1=wpUZMQUtSGB1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.17
X-Spamd-Result: default: False [0.17 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         BAYES_HAM(-0.03)[55.48%];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         FREEMAIL_TO(0.00)[gmail.com,me.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 09:54, Hyeonggon Yoo wrote:
> On Mon, Nov 20, 2023 at 6:13 PM <sxwjean@me.com> wrote:
>>
>> From: Xiongwei Song <xiongwei.song@windriver.com>
>>
>> Since slab allocator has been removed. There is no users about slab
>> merge except slub. This commit is almost to revert
>> commit 423c929cbbec ("mm/slab_common: commonize slab merge logic").
>>
>> Also change all prefix of slab merge related functions, variables and
>> definitions from "slab/SLAB" to"slub/SLUB".
> 
> Could you please elaborate a little bit?
> I am not sure if I understand what the last two patches of this series
> are useful for.
> 
> - Why rename variable/function/macro names?
> - Why move merge related functions from slab_common.c to slub.c?

In my series I have moved functions that were part of allocation/free hot
paths as there should be performance benefits if they are all in the same
compilation unit.

>   (I mean merging slab_common.c and slub.c into single file might make sense
>    but why move only some parts of one into the other?)

OTOH slub.c becomes quite big, so I think it would make sense to not merge
mm/slab_common.c fully. The non-hot code that's handling e.g. the caches
creation and management, such as what this patch is moving, could certainly
stay away from mm/slub.c. We could just pick a more descriptive name for
slab_common.c.

I'd even investigate if more parts of slub.c could be split out (to a new
file/files) without compromising the hot paths, i.e. sysfs, debugging etc.

