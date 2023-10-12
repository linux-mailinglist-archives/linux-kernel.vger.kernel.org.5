Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7102F7C77C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442408AbjJLUSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347403AbjJLUSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:18:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86CDD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hc6HCNMBp8IlLh8DN5mOo6xzjEiwvUjh2K14S7K06EQ=; b=UXgboL6T6vWj55vMADPJkX8CSk
        gvNHxS4VgKU8FrVZzda+94awkU07ZZcPRsaGdhBlL2sW01X3iIeBEHS+NBA3QfgmYJCZ01kbHKCAM
        zJ2ni/YxaRuJ6vKxvrE6jcmZ1EXo0/XfWVJMWDc6RNf7Gav4qipw0vtwcGLx9St8wToVsY4RIa6gE
        vmKc72e3sILpfqrMBe4+91KN/qYgvJjqo/UumT38BjjGUD2ioIo53ez5BuRfvzDtyIojYPspUaQHd
        3IVUG5m0jh2JXRGOQh3V7GVe1ZItZaidt1wC1x6/Z1tQpo+ze7A/Z3vrEX0QbMQkwJaJJH6jne61i
        l30AfPHw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qr28n-000gUf-0E;
        Thu, 12 Oct 2023 20:18:41 +0000
Date:   Thu, 12 Oct 2023 13:18:32 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Seamus Connor <sconnor@purestorage.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [WIP] configfs: improve item creation performance
Message-ID: <ZShUmLU3X5QMiWQH@google.com>
Mail-Followup-To: Seamus Connor <sconnor@purestorage.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20231011213919.52267-1-sconnor@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011213919.52267-1-sconnor@purestorage.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:39:19PM -0700, Seamus Connor wrote:
> On my machine, creating 40,000 Items in a single directory takes roughly
> 40 seconds. With this patch applied, that time drops down to around 130
> ms.

Nice.

> @@ -207,7 +212,10 @@ static struct configfs_dirent *configfs_new_dirent(struct configfs_dirent *paren
>  		return ERR_PTR(-ENOENT);
>  	}
>  	sd->s_frag = get_fragment(frag);
> -	list_add(&sd->s_sibling, &parent_sd->s_children);
> +	if (configfs_dirent_is_pinned(sd))
> +		list_add_tail(&sd->s_sibling, &parent_sd->s_children);
> +	else
> +		list_add(&sd->s_sibling, &parent_sd->s_children);
>  	spin_unlock(&configfs_dirent_lock);

This is subtle.  Your patch description of course describes why we are
partitioning the items and attributes, but that will get lost into the
memory hole very quickly.  Please add a comment.

> @@ -449,6 +454,10 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  
>  	spin_lock(&configfs_dirent_lock);
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
> +
> +		if (configfs_dirent_is_pinned(sd))
> +			break;
> +
>  		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
>  		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
>  			struct configfs_attribute *attr = sd->s_element;

There's a lack of symmetry here.  The pinned check is an inline
function, whereas the `CONFIGFS_NOT_PINNED` check is an open-coded
bitmask.  Why not just:

```
		if (sd->s_type & CONFIGFS_IS_PINNED)
			break;
```

Plus, aren't the pinned/not-pinned checks redundant?  Can't we avoid the
extra conditional?


```
	spin_lock(&configfs_dirent_lock);
	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
-		if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
-		    !strcmp(configfs_get_name(sd), dentry->d_name.name)) {
+		/*
+		 * The dirents for config_items are pinned in the
+		 * dcache, so configfs_lookup() should never be called
+		 * for items.  Thus, we're only looking up attributes.
+		 *
+		 * s_children is ordered so that attributes
+		 * (CONFIGFS_NOT_PINNED) come before items (see
+		 * configfs_new_dirent().  If we have reached a child item,
+		 * we are done looking.
+		 */
+		if (!(sd->s_type & CONFIGFS_NOT_PINNED))
+			break;
+
+		if (!strcmp(configfs_get_name(sd), dentry->d_name.name)) {
			struct configfs_attribute *attr = sd->s_element;
			umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
```

> -void configfs_hash_and_remove(struct dentry * dir, const char * name)
> -{
> -	struct configfs_dirent * sd;
> -	struct configfs_dirent * parent_sd = dir->d_fsdata;

Man, I thought we removed this years ago:
https://lkml.indiana.edu/hypermail/linux/kernel/0803.0/0905.html.  No
idea why that patch didn't land.

Thanks,
Joel

-- 

Life's Little Instruction Book #222

	"Think twice before burdening a friend with a secret."

			http://www.jlbec.org/
			jlbec@evilplan.org
