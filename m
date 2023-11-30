Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300197FF38F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbjK3P0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjK3P0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:26:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBD810E5;
        Thu, 30 Nov 2023 07:26:18 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F54721B21;
        Thu, 30 Nov 2023 15:26:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F24E713AB1;
        Thu, 30 Nov 2023 15:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id cXTBOpapaGXbYQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Thu, 30 Nov 2023 15:26:14 +0000
Message-ID: <414847ea-b7e7-aa05-5e2d-de50788d9b4d@suse.cz>
Date:   Thu, 30 Nov 2023 16:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 16/33] mm: slub: Let KMSAN access metadata
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
 <20231121220155.1217090-17-iii@linux.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231121220155.1217090-17-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++++++++
X-Spam-Score: 12.69
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 2F54721B21
X-Spamd-Result: default: False [12.69 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.00)[20.85%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[24];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FREEMAIL_CC(0.00)[linux.ibm.com,google.com,gmail.com,googlegroups.com,vger.kernel.org,kvack.org,arm.com,linux.dev];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 23:01, Ilya Leoshkevich wrote:
> Building the kernel with CONFIG_SLUB_DEBUG and CONFIG_KMSAN causes
> KMSAN to complain about touching redzones in kfree().
> 
> Fix by extending the existing KASAN-related metadata_access_enable()
> and metadata_access_disable() functions to KMSAN.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 169e5f645ea8..6e61c27951a4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -700,10 +700,12 @@ static int disable_higher_order_debug;
>  static inline void metadata_access_enable(void)
>  {
>  	kasan_disable_current();
> +	kmsan_disable_current();
>  }
>  
>  static inline void metadata_access_disable(void)
>  {
> +	kmsan_enable_current();
>  	kasan_enable_current();
>  }
>  

