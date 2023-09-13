Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CA79F122
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjIMSbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9F1019BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694629871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC1iAdZfWrUGsp4bU1Qc1SNFa5jCnzf3CLM577YlA44=;
        b=N+vZadgUmk69SqXDzXhbX222My4CNVW58cRTONv/V8fxlADSZ4ptf0+xEBL0yKCj9WYIvk
        WhjSgwluiWuOZ62Gx+XRRXDpoZManVKDIi7yYB7GR89Nusr5Pm4x2mnw2gbCeaP6CWFrGR
        TAZEFhe4f/zatf1/TIVk63jo5FzpD+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-hVyEM4YZMaOdrs2aAH98tQ-1; Wed, 13 Sep 2023 14:31:08 -0400
X-MC-Unique: hVyEM4YZMaOdrs2aAH98tQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B09E802C15;
        Wed, 13 Sep 2023 18:31:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC8532026D68;
        Wed, 13 Sep 2023 18:31:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 20:30:15 +0200 (CEST)
Date:   Wed, 13 Sep 2023 20:30:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, oe-kbuild-all@lists.linux.dev,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] seqlock: change __seqprop() to return the function
 pointer
Message-ID: <20230913183010.GA12423@redhat.com>
References: <20230913154956.GA26245@redhat.com>
 <202309140117.J5VH7p4z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309140117.J5VH7p4z-lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14, kernel test robot wrote:
>
> Hi Oleg,

Hi kernel test robot, thank you very much.

> >> include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Yes, a lot of seqcount_t helpers pass the "const seqcount_t *s" to
__seqprop_ptr(s) and this is wrong.

Before this patch __seqprop(s) did "(void *)(s)" and this masked the
problem.

I've updated __seqprop_##lockname##_ptr() for this reason, but didn't
notice that __seqprop_ptr() should be changed too.

Oleg.

