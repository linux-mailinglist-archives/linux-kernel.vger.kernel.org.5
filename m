Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195FE7B2D44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjI2HwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2HwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:52:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316319F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:52:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 420442184D;
        Fri, 29 Sep 2023 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695973923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l9VVzv02o4WRA98orkHiu8nrFyRKKzi6xw/V93yd2RM=;
        b=Cmpiv8dYLTAS7ODmjq0zBDGTxqwkYvvkUlRrz1HSZGFU8Dp4jyc9dMb7IU8Xa21N+dNTpi
        N6toD89lz4RXBb6bbU02LmSfgATXPONaec+6W87NbNeyRpdkZTV2yxY8Ua7bjTkZyBffQ0
        EQEPcQedaqTpdiim3JykUfvIduev3zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695973923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l9VVzv02o4WRA98orkHiu8nrFyRKKzi6xw/V93yd2RM=;
        b=Pg2f+c6NkCkkWDkGvz9/i/pmJcPOrFXFO7a5iuV0qaZidexahYfoJbxcYZyJhFuWKsm3zw
        fKh4zgQeYyV4uQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18ECD1390A;
        Fri, 29 Sep 2023 07:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yfxCBSOCFmVmWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Sep 2023 07:52:03 +0000
Message-ID: <70699482-f413-d7b8-6378-48bc915d1ecb@suse.cz>
Date:   Fri, 29 Sep 2023 09:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab fixes for 6.6-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab fixes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fixes-for-6.6-rc4

There are two fixes:

- a stable fix to prevent list corruption when destroying caches with
leftover objects, by Rafael Aquini

- a fix for a gotcha in kmalloc_size_roundup() when calling it with too high
size, discovered when recently a networking call site had to be fixed (for
a different issue), by David Laight

Thanks,
Vlastimil

----------------------------------------------------------------
David Laight (1):
      slab: kmalloc_size_roundup() must not return 0 for non-zero size

Rafael Aquini (1):
      mm/slab_common: fix slab_caches list corruption after kmem_cache_destroy()

 mm/slab_common.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)
