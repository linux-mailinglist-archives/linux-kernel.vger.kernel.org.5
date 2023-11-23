Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61A7F6310
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346124AbjKWPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346108AbjKWPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:33:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432FD43
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lcBqM8Wl6XOhrKp7ul/lshfIyYoQqNbwEPoZDFKrPwY=; b=PeUjdDV6c4u9zzodFRg2rl4FY4
        1qAC0oL3gk3f8k+NsVk3o7qaXBvwK+enhseLX45OB8UejZd+o7oK0x7vyWnG3WBu8uxfKlPFwvGZV
        YxWhY+fFkeWG3XimhrZYTD8VjVhVPet1T2I+/jcPyrl6+LoLVI6qhDdevEDAQ1/pG/T6mtvoQMM4s
        wI/GWuR9pNSg2aQT2MOLc+vsv0SdkaugHEx9kgaKQ54a159r8ur3ySZuaWdsLXdRnAivbT/yBien2
        tz39hGt0LCnpPtNKz8SYnIZinOOfvqAZaTPTikaXt11Aslf0Xsw030lBcdeG370FXJyvpFV9ZL1mr
        emueBlXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6BhX-007feJ-Mn; Thu, 23 Nov 2023 15:33:11 +0000
Date:   Thu, 23 Nov 2023 15:33:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        fengwei.yin@intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, hughd@google.com, david@redhat.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Message-ID: <ZV9wt4+F/soWxVhR@casper.infradead.org>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
 <87a5r4988r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5b0e168a-dd43-80d4-2eeb-5c8a5d470f5e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0e168a-dd43-80d4-2eeb-5c8a5d470f5e@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 05:09:04PM +0800, zhangpeng (AS) wrote:
> > > +		pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> > > +						  vmf->address, &vmf->ptl);
> > > +		if (ptep) {
> > > +			/*
> > > +			 * Recheck pte with ptl locked as the pte can be cleared
> > > +			 * temporarily during a read/modify/write update.
> > > +			 */
> > > +			if (unlikely(!pte_none(ptep_get(ptep))))
> > > +				ret = VM_FAULT_NOPAGE;
> > > +			pte_unmap_unlock(ptep, vmf->ptl);
> > > +			if (unlikely(ret))
> > > +				return ret;
> > > +		}
> > > +
> > Need to deal with ptep == NULL.  Although that is high impossible.
> 
> If ptep == NULL, we may just need to return VM_FAULT_SIGBUS.
> I'll add it in the next version.

no?  wouldn't ptep being NULL mean that the ptep has been replaced with
a PMD entry, and thus should return NOPAGE?
