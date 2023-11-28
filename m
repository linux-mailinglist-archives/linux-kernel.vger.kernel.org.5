Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC27FB965
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjK1LZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbjK1LZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:25:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8AAD60;
        Tue, 28 Nov 2023 03:25:30 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B0A82195A;
        Tue, 28 Nov 2023 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701170729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgMlDqCEMti1tWEV4w0pWYe9MRlT/WzXID9W1NpeXw0=;
        b=BbbKWMmmKaQrhIyb2KL6NpH9DDIGUGVP+hPGD5QCUcS6X4Hr0oBnRDuf1b3xRaZpxJitkm
        nx8r/gv7jLOAO9h8sIRcCLGDv1rhNgqWuWHGJ7ah3cxLK7G1MZtthXRtKbUzAphJfJYWCL
        27Ab0kO7Q7aTIYNxJI5IumkJ30JCpcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701170729;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgMlDqCEMti1tWEV4w0pWYe9MRlT/WzXID9W1NpeXw0=;
        b=OqOvDLmLGZwIjekxgW6yZGcd83xjaN7OTKoc4Bz+CG9jrO4cHbkIF7FMgGnxkr0wQoGRZZ
        CnZbmSG5J27X0OBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F21441343E;
        Tue, 28 Nov 2023 11:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id isDDOijOZWUIAwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Tue, 28 Nov 2023 11:25:28 +0000
Message-ID: <9be0159e-1762-6c07-e6eb-a86f1c780118@suse.cz>
Date:   Tue, 28 Nov 2023 12:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] efi/unaccepted: Fix off-by-one when checking for
 overlapping ranges
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Michael Roth <michael.roth@amd.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>, stable@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20231103151354.110636-1-michael.roth@amd.com>
 <30ff0335-3d9c-7d54-85d0-5898320f4e1f@suse.cz>
 <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAMj1kXF-B_1MJahfFg72cgcmZ9dMvqiEm8WGGejkqRFN=JreEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.21
X-Spamd-Result: default: False [3.21 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.19)[-0.959];
         NEURAL_SPAM_LONG(3.50)[0.999];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 12:21, Ard Biesheuvel wrote:
> On Fri, 3 Nov 2023 at 16:30, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 11/3/23 16:13, Michael Roth wrote:
>> > When a task needs to accept memory it will scan the accepting_list
>> > to see if any ranges already being processed by other tasks overlap
>> > with its range. Due to an off-by-one in the range comparisons, a task
>> > might falsely determine that an overlapping range is being accepted,
>> > leading to an unnecessary delay before it begins processing the range.
>> >
>> > Fix the off-by-one in the range comparison to prevent this and slightly
>> > improve performance.
>> >
>> > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
>> > Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
>> > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>>
>> More justification for introducing a common ranges_overlap() helper somewhere :)
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>
> 
> Thanks, I'll take this as a fix.

Ping, can't see it in mainline nor -next?

> 
>> > ---
>> > v2:
>> >  * Improve commit message terminology (Kirill)
>> > ---
>> >  drivers/firmware/efi/unaccepted_memory.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
>> > index 135278ddaf62..79fb687bb90f 100644
>> > --- a/drivers/firmware/efi/unaccepted_memory.c
>> > +++ b/drivers/firmware/efi/unaccepted_memory.c
>> > @@ -100,7 +100,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>> >        * overlap on physical address level.
>> >        */
>> >       list_for_each_entry(entry, &accepting_list, list) {
>> > -             if (entry->end < range.start)
>> > +             if (entry->end <= range.start)
>> >                       continue;
>> >               if (entry->start >= range.end)
>> >                       continue;
>>
> 

