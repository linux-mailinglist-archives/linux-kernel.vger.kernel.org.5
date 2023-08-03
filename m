Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8B76E4A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjHCJiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjHCJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:37:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C665E468B;
        Thu,  3 Aug 2023 02:36:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0341219D4;
        Thu,  3 Aug 2023 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goH0RGRJhK/fH7zf9HOfwIEiuL8jO8QFiZpqtIWmMRU=;
        b=idJP/bqJMlFV8Z4SD8NT3qylf/Q5haz9vMLly6Aks76OLgyNjYBQBuPlJELdvXSqhQc/wn
        eWT7ydzq7defa0ZVcrm9o/N85F6Wd3oDNHUugOYWvKgMBoE9XY5kPZBktuUF+00QnmRdfq
        Ayh2Jn26k0GqeqebmASpfmDatyfbz8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691055405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=goH0RGRJhK/fH7zf9HOfwIEiuL8jO8QFiZpqtIWmMRU=;
        b=el9ojAmSgdIsxss/3BGTff0xvJ7J71SqHIDjuwLRyN/SpWelmabz8pYD0a39vcLrQqyvqi
        rSFVrFcYCzGSsnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 780A91333C;
        Thu,  3 Aug 2023 09:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EhiBHC11y2Q1eAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Aug 2023 09:36:45 +0000
Message-ID: <bc156898-b350-d1d4-c978-15bce94bf6f8@suse.cz>
Date:   Thu, 3 Aug 2023 11:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4 1/2] mm: Remove kmem_valid_obj()
Content-Language: en-US
To:     thunder.leizhen@huaweicloud.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
References: <20230802130918.1132-1-thunder.leizhen@huaweicloud.com>
 <20230802130918.1132-2-thunder.leizhen@huaweicloud.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230802130918.1132-2-thunder.leizhen@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 15:09, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Function kmem_dump_obj() will splat if passed a pointer to a non-slab
> object. So no one will call it directly. It is always necessary to call
> kmem_valid_obj() first to determine whether the passed pointer to a
> valid slab object. Then merging kmem_valid_obj() into kmem_dump_obj()
> will make the code more concise. So convert kmem_dump_obj() to work the
> same way as vmalloc_dump_obj(). After this, no one calls kmem_valid_obj()
> anymore, and it can be safely removed.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

No problem if this goes through rcu tree due to patch 2/2.

