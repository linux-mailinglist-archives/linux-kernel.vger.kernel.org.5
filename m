Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C679B433
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359750AbjIKWSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbjIKTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:12:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7584F9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0uS/NLFKJ9+qD9P+01ghNQdJPyz/lWBftVtleHZ4QS8=; b=QD4FezIUTZYL/WXDGcAcsHQCpr
        wARKzFwH3TOiA36ptvXZbEXU9Y0PRUmK/dsSYQdokaUamK0LM6Zxuzh5fdWRERGPxReRjCOLJek4a
        XGkSeJpk3hF7elK7ssVrZzWchmFh/XKbE8F16O5QTAbZGi1UwZ2vYSfwozmkYkWD2pftNCPFwylxd
        5FL30Mkz1SHB6eDPOvta8lL8+17TadtEoWN3vct43JyvbX8FDT9tz0Ew5f48uzjnrB5B7ZngESOR9
        MMncgwSwYYtyBSrVTLdo9/Zoh1eMgLmGgz4bofq1gnMMQKtnZAPCSYfCEQOSj+8+CYQtB57pQzc8z
        qqGymnGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfmKb-002bfo-3g; Mon, 11 Sep 2023 19:12:21 +0000
Date:   Mon, 11 Sep 2023 20:12:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>,
        syzbot <syzbot+55cc72f8cc3a549119df@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (7)
Message-ID: <ZP9mla26MWqKKUZ7@casper.infradead.org>
References: <000000000000d099fa0604f03351@google.com>
 <0465d13d-83b6-163d-438d-065d03e9ba76@intel.com>
 <ZP8VcUIXTjvR3z54@casper.infradead.org>
 <f3379aeb-f394-8c99-5143-f93e82400320@intel.com>
 <ZP9D0q5MSVFobNbZ@casper.infradead.org>
 <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb936bdb-6473-a956-8431-fe95f5940acc@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 09:55:37AM -0700, Dave Hansen wrote:
> On 9/11/23 09:44, Matthew Wilcox wrote:
> > After fixing your two typos, this assembles to 176 bytes more code than
> > my version.  Not sure that's great.
> 
> Maybe I'm a fool, but 176 bytes of text bloat isn't scaring me off too
> much.  I'd much rather have that than another window into x86 goofiness
> to maintain.
> 
> Does that 176 bytes translate into meaningful performance, or is it just
> a bunch of register bit twiddling that the CPU will sail through?

I'm ... not sure how to tell.  It's 1120 bytes vs 944 bytes and crawling
through that much x86 assembly isn't my idea of a great time.  I can
send you objdump -dr for all three options if you like?  Maybe there's
a quick way to compare them that I've never known about.
