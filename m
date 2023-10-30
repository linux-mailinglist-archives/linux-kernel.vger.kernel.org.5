Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204847DB7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjJ3KP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjJ3KP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:15:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE19827D;
        Mon, 30 Oct 2023 03:05:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE44C433C7;
        Mon, 30 Oct 2023 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698660335;
        bh=q2jj8oxrfz7CssFUIk0zwbvKuyNiJw3gFwh7Y3M0PYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cdl9weJZfU1KuCAWrOHpMAhanvwzgZzuNmGXuZxXyq5Cjti6bWzUFcv7X5dzaB06i
         a5dZ/IzWVzF5qrXOHLM9OAw8mi5GE+qNJoM/jqHQ6gFIgrQTG/530VQjU45K8Ikd5l
         HF72g2nasiux4sD7LFBhgsMnROFL/Tgf5WmWJ1h96qogOZ9pwka2ksz5FZ2oTstQD4
         4QAcaip0E15CluZVmK/e+MVpYWSU5oQvF6Hg/ggab3c+2L1zVvgv+4b9pNQWEYP5L6
         0IBEBT6a+NOEYyvLWsglJkaEcbsxdj9eSC6Ilw3WtDBFJgSmc8nOgsWIwv8Oyli8u1
         +Yg5QCBe2xtTA==
Date:   Mon, 30 Oct 2023 11:05:29 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm-x86 tree
Message-ID: <20231030-ignorant-liebschaft-6d603ab43494@brauner>
References: <20231030134806.24510492@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030134806.24510492@canb.auug.org.au>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 01:48:06PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kvm-x86 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> arch/x86/kvm/../../../virt/kvm/guest_memfd.c: In function 'kvm_gmem_get_file':
> arch/x86/kvm/../../../virt/kvm/guest_memfd.c:280:35: error: passing argument 1 of 'get_file_rcu' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   280 |         if (file && !get_file_rcu(file))
>       |                                   ^~~~
>       |                                   |
>       |                                   struct file *
> In file included from include/linux/backing-dev.h:13,
>                  from arch/x86/kvm/../../../virt/kvm/guest_memfd.c:2:
> include/linux/fs.h:1046:47: note: expected 'struct file **' but argument is of type 'struct file *'
>  1046 | struct file *get_file_rcu(struct file __rcu **f);
>       |                           ~~~~~~~~~~~~~~~~~~~~^
> 
> Caused by commit
> 
>   fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> 
> interacting with commit
> 
>   0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
> 
> from the vfs-brauner tree.
> 
> I have applied the following merg resolution patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 30 Oct 2023 13:35:38 +1100
> Subject: [PATCH] fix up for "KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
>  guest-specific backing memory"
> 
> interacting with "file: convert to SLAB_TYPESAFE_BY_RCU"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  virt/kvm/guest_memfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 94bc478c26f3..7f62abe3df9e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -276,9 +276,7 @@ static struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
>  
>  	rcu_read_lock();
>  
> -	file = rcu_dereference(slot->gmem.file);
> -	if (file && !get_file_rcu(file))
> -		file = NULL;
> +	file = get_file_rcu(&slot->gmem.file);
>  
>  	rcu_read_unlock();

Stephen, thanks for the suggested fixup.

Afaict, the guest_memfds pin the kvm instance. If a guest_memfd is
closed and last fput() is called the file pointer remains stashed in all
relevant gmem->file slots until guest_memfd->release::kvm_gmem_release()
is called. And kvm_gmem_release() sets all relevant gmem->file instances
to NULL via rcu_assign_pointer().

So afaict, the gmem->file pointer isn't part of the reference counting
but rather it just caches the result of the reference counting. And it's
then cleared when that reference goes down to zero.

Basically, I think this is akin to commit 61d4fb0b349e ("file, i915: fix
file reference for mmap_singleton()") which is in -next and the
discussion we had in
https://lore.kernel.org/r/20231025-formfrage-watscheln-84526cd3bd7d@brauner

So that means we can't to loop here which is what get_file_rcu() would
do. Otherwise you might end up spinning. Because last close of
guest_memfd fput() puts the last reference. Now all concurrent
gmem->file kvm_gmem_get_file() callers will see f_count at zero. And it
might well take a while until the kernel calls
guest_memfd->release::kvm_gmem_release() and NULLs the pointer. So
get_file_rcu() would retry and loop because it thinks that the pointer
is part of the reference counting.

So iiuc you want get_file_active() here which also takes the
rcu_read_lock() for you.

@Paolo and @Sean, does that make sense and is the series for v6.7 or
just already in -next for v6.8?

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 94bc478c26f3..a4c194b0b22c 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -272,17 +272,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)

 static struct file *kvm_gmem_get_file(struct kvm_memory_slot *slot)
 {
-       struct file *file;
-
-       rcu_read_lock();
-
-       file = rcu_dereference(slot->gmem.file);
-       if (file && !get_file_rcu(file))
-               file = NULL;
-
-       rcu_read_unlock();
-
-       return file;
+       return get_file_active(&slot->gmem.file);
 }

 static struct file_operations kvm_gmem_fops = {
