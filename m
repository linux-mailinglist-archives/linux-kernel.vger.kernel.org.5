Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9877C97D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjHOIi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjHOIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:38:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB31BC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=al9YvRhXrCID7rvrAGEaXvsCD6aM0+cRJENNBXgLi/Q=; b=lMbv5Z33BcMEFd+CDt5zk+R+qL
        my9RDkxgQ+RmwqydkBpUBfoe0jm25tnmOk0ASqXNBdr9t0vS8qwGfnaqNBGcZJlqK8nSNlXBoRrQk
        y6n7MoCKo1HuRFv/86B2EJMx3XA7XjDT+hvZBUvja7/3Zd4j/VD+JjmqDkCqm9sErALYpqzQlHKjF
        ICsGBZFS071ikSCJcTglQhxqUyjfZz/338UG/MAwQywZb41fg2EePGVDson1mVKDhJkfTq68vLW1D
        yjjNcrMVyNsj9tiHlLMje4mhcWBUqxGBv5lbXaoVu54TbxIoes1+SRAOTKy6WgiGuLphGo1SfJffW
        BBmwhHrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVpYW-00Biwe-2w;
        Tue, 15 Aug 2023 08:37:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A145300222;
        Tue, 15 Aug 2023 10:37:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E8B720307341; Tue, 15 Aug 2023 10:37:36 +0200 (CEST)
Date:   Tue, 15 Aug 2023 10:37:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Message-ID: <20230815083736.GA927436@hirez.programming.kicks-ass.net>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
 <20230814112144.GF776869@hirez.programming.kicks-ass.net>
 <64da55624c6c1_2138e294cf@dwillia2-xfh.jf.intel.com.notmuch>
 <20230814164804.GO776869@hirez.programming.kicks-ass.net>
 <20230814221503.GA919179@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814221503.GA919179@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 12:15:03AM +0200, Peter Zijlstra wrote:

> This seems to actually work. I'll try and write some coherent comments
> tomorrow -- it's definitely too late for that now.

Clearly I should have gone to bed before sending this patch, not after.
Let me try that again.
