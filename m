Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939267F3E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjKVHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjKVHKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:10:48 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C387090;
        Tue, 21 Nov 2023 23:10:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F058267373; Wed, 22 Nov 2023 08:10:40 +0100 (CET)
Date:   Wed, 22 Nov 2023 08:10:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: linux-next: manual merge of the kvm tree with the vfs-brauner
 tree
Message-ID: <20231122071040.GA4104@lst.de>
References: <20231122125539.5a7df3a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122125539.5a7df3a3@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:55:39PM +1100, Stephen Rothwell wrote:
> index 06142ff7f9ce,bf2965b01b35..000000000000
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@@ -203,9 -203,8 +203,10 @@@ enum mapping_flags 
>   	/* writeback related tags are not used */
>   	AS_NO_WRITEBACK_TAGS = 5,
>   	AS_LARGE_FOLIO_SUPPORT = 6,
> - 	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
> + 	AS_RELEASE_ALWAYS = 7,	/* Call ->release_folio(), even if no private data */
> + 	AS_UNMOVABLE	= 8,	/* The mapping cannot be moved, ever */
>  +	AS_STABLE_WRITES,	/* must wait for writeback before modifying
>  +				   folio contents */
>   };

Note that AS_STABLE_WRITES, is a fix for 6.7, so this will probably
end up getting reordered.  It might also be worth to remove all the
explicit number assignments here to make the merge conflict resolution
a bit easier in the future.
