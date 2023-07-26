Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F009D7640D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjGZU7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGZU7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:59:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021D1727;
        Wed, 26 Jul 2023 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rd57pq0Dg+xjZNuOIKlvVzndHeeNvzT3YeN/hCDmQAw=; b=mwxBsW1OlES3CWdoOHff9DXNgW
        FYIj4R8Uhlu1jhTh79DQLqThcydr2XQmaLzgfuR3Kbl1SphhhFBSF8tOALkyqsdOoxnGi/pAiwG0i
        l3bQsWZEBFZ3OWrO8rGfoZRDv6edHhEKLXslQGe2OfQo2972nbo0u4agKUpkK9msuF9Q2GnZNMLWc
        DYO8IOczxQVS5yQjajYoMh9vca/3Fq0B0D0ew0DkOQuHVRhbMCHNLBxjf9DT4uAcLkBvV32TAluME
        p3Agn72JLPqaYESS0LHxHHtu7xvkMUB8xfVruBiYjS4S6zbwKWOX9ylVPgjrnweIBnmP3tdHTxSkt
        Ex7nSO2A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOlb8-00BWOO-1r;
        Wed, 26 Jul 2023 20:59:06 +0000
Date:   Wed, 26 Jul 2023 13:59:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZMGJGlJ7XSG+2vjY@bombadil.infradead.org>
References: <20230626123252.73dbc139@endymion.delvare>
 <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
 <ZKLRaq3pzzE2gfws@dhcp22.suse.cz>
 <ZKhf8bi/eBDhaihD@bombadil.infradead.org>
 <ZKuaZepw51Nriqr8@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKuaZepw51Nriqr8@dhcp22.suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:43:01AM +0200, Michal Hocko wrote:
> On Fri 07-07-23 11:56:49, Luis Chamberlain wrote:
> > On Mon, Jul 03, 2023 at 03:47:22PM +0200, Michal Hocko wrote:
> > > On Fri 30-06-23 16:05:33, Luis Chamberlain wrote:
> > > [...]
> > > > What prevents code from racing the free with a random module_put()
> > > > called by some other piece of code?
> > > 
> > > Wouldn't be ref count a garbage already? How can you race when freeing
> > > if module_put fail?
> > 
> > It could yes, ie, so this risks at all being junk.
> 
> Could you be more specific please? I still do not see a scenario where
> module string name would be junk while refcount itself would be a valid
> memory.

That is true, but if refcount is invalid so will the memory for the
string.

> > So best IMHO is
> > to tidy up all the get / puts and add respective tests to fix all
> > this mess with proper messages as needed. My cursory review of the
> > refcnt stuf is I see some races possible.
> 
> It would likely be better to use refcount_t instead of atomic_t.

Patches welcomed.

> > While I'd be happy to help debugging aids, adding accesses to random
> > memory for a string seems more risk prone.
> 
> If there is really a scenario when module could be unloaded leaving
> dangling struct module behind then we have a real problem as this is
> exported to userspace IIRC. Not to mention module_get/put calls
> modifying memory (UAF).

That doesn't mean issues could not exist, given its all protected under
privileged execution. All I'm suggesting is I look at this code and
don't trust it, and think it could use some love. The selftests for kmod
could be used to stress test but also stress-ng now also has module load
and unloading so if there are races we can likely exploit them with
either the kmod selftest or stress-ng module loading.

  Luis
