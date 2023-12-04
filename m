Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA2803E78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjLDTev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjLDTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:34:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9FBCE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:34:54 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7748F1FE6D;
        Mon,  4 Dec 2023 19:34:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53667139AA;
        Mon,  4 Dec 2023 19:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id x9KfE9wpbmUPMwAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Mon, 04 Dec 2023 19:34:52 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/4] SLUB: cleanup hook processing
Date:   Mon, 04 Dec 2023 20:34:39 +0100
Message-Id: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM8pbmUC/x3MQQqAIBBA0avErBtIyxZdJVqYjTkUGg5FEN09a
 fkW/z8glJkEhuqBTBcLp1ig6gpcsHEl5KUYdKNbpZsOZT9ndDvZeB4YUtoEvfGmU622vXJQwiO
 T5/ufjtP7fnAR5D9kAAAA
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
X-Spamd-Bar: ++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [8.39 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         BAYES_HAM(-0.00)[38.82%];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,gmail.com,google.com,kvack.org,vger.kernel.org,googlegroups.com,suse.cz];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 8.39
X-Rspamd-Queue-Id: 7748F1FE6D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a spin-off of preparatory patches from the percpu array series
[1] as they are IMHO useful on their own and simple enough to target
6.8, while the percpu array is still a RFC.

To avoid non-trivial conflict, the series is also rebased on top of the
SLAB removal branch. [2]

[1] https://lore.kernel.org/all/20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.8/slab-removal

---
Vlastimil Babka (4):
      mm/slub: fix bulk alloc and free stats
      mm/slub: introduce __kmem_cache_free_bulk() without free hooks
      mm/slub: handle bulk and single object freeing separately
      mm/slub: free KFENCE objects in slab_free_hook()

 mm/slub.c | 109 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 36 deletions(-)
---
base-commit: 4a38e93b3a7e6669c44929fed918b1494e902dd7
change-id: 20231204-slub-cleanup-hooks-f5f54132a61c

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

