Return-Path: <linux-kernel+bounces-1147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC7814B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C972835DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DAB37156;
	Fri, 15 Dec 2023 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QEP7jk7Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CE36AFF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fpNr8tLv7DaR3O7eSvBZDrzrhRmQRH0saU7oGWLT/Ng=; b=QEP7jk7QKVzggKrwd8F8h78Y8i
	Xxq+GkDU4ZLXQka8SyG5MAc6oqRvmsXdnT3l6YfPtOzsakpYEMzl4/iV7V4icASVErZ82fn8xG82Q
	H7WPX35sxIEx+ESMNW3lj3J9A1v08xQ44JW4HOewQwkIlJr1oCxavk2JBTDqmq0JzOS3kk2l0EsuC
	YmvPhA8C0eMlPugu4A70uwIjwQ07tjkbuCUSfEC61c/9H4bdFe7wmHLdSKZm4dwdWFtizJHmXeA8U
	YfvrugFq3wI7xqhwlHp6b5WIkA6TyvCDDJ9cNIdgRU44UQUK6NVRpGE5LjSThBIP0wyQ5AHb29Uw8
	JvSBWkRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE9h0-000Yy1-IV; Fri, 15 Dec 2023 15:01:34 +0000
Date: Fri, 15 Dec 2023 15:01:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
	ziy@nvidia.com, xuyu@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: fix getting incorrect page mapping during
 page migration
Message-ID: <ZXxqTjZR0OAvjaXr@casper.infradead.org>
References: <e60b17a88afc38cb32f84c3e30837ec70b343d2b.1702641709.git.baolin.wang@linux.alibaba.com>
 <ZXxn/0oixJxxAnpF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXxn/0oixJxxAnpF@casper.infradead.org>

On Fri, Dec 15, 2023 at 02:51:43PM +0000, Matthew Wilcox wrote:
> I'm not saying no to this fix, but dump_mapping() is supposed to be
> resilient against this.  Is the issue that 'dentry' is NULL, or is it
> some field within dentry that is NULL?  eg, would this fix your
> case?

Uh, dentry is an on-stack dentry.  So obviously it's a pointer within it
that's NULL.  Maybe this, having stared at the implementation of %pd?

+++ b/fs/inode.c
@@ -588,7 +588,8 @@ void dump_mapping(const struct address_space *mapping)
        }

        dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
-       if (get_kernel_nofault(dentry, dentry_ptr)) {
+       if (get_kernel_nofault(dentry, dentry_ptr) ||
+           !dentry->d_parent || !dentry->d_name) {
                pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
                                a_ops, ino, dentry_ptr);
                return;


