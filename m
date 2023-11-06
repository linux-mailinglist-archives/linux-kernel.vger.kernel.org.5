Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79AB7E286E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjKFPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:16:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876DAD8;
        Mon,  6 Nov 2023 07:16:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC322C433C8;
        Mon,  6 Nov 2023 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699283789;
        bh=zDZFduCEDJmeuVjp8rHp1YK3z18DtyX3wrd2wnaF+Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMMyAp8P8d1YZR+ToLbBSMxg7E0h+nAM09J8k36AJrgWT3pLgMKJv3rUJwYZoBC+5
         /7HcfewbvKZBV+XxkAhBXKfAMpJI5v88gc4Hx8N8Z+ws3elm72tPTVmOM+mru/Ax7o
         hgKcBnrkjrOwDRP6ZT7ROB1Yw66jbjLQJ8E14gCmpX61VhuiBziDh0K7mRiqlcqPKr
         f2Apj/1uFkrm0Y9QqXxL4Y0uZAXlZ2WeCIdMR3xorlstgRMc5NC4/sI8S+JkZDghFD
         iwus793QJkToU2FLLBik2jgcjMG6YyKIg5FBdgreEw23GWddN78m4uMrF2NWf2K1cn
         BhSHwanj5lm1w==
Date:   Mon, 6 Nov 2023 16:16:16 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 14/34] fs: Rename anon_inode_getfile_secure() and
 anon_inode_getfd_secure()
Message-ID: <20231106-kondor-anfahren-23157efabaef@brauner>
References: <20231105163040.14904-1-pbonzini@redhat.com>
 <20231105163040.14904-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231105163040.14904-15-pbonzini@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 05:30:17PM +0100, Paolo Bonzini wrote:
> The call to the inode_init_security_anon() LSM hook is not the sole
> reason to use anon_inode_getfile_secure() or anon_inode_getfd_secure().
> For example, the functions also allow one to create a file with non-zero
> size, without needing a full-blown filesystem.  In this case, you don't
> need a "secure" version, just unique inodes; the current name of the
> functions is confusing and does not explain well the difference with
> the more "standard" anon_inode_getfile() and anon_inode_getfd().
> 
> Of course, there is another side of the coin; neither io_uring nor
> userfaultfd strictly speaking need distinct inodes, and it is not
> that clear anymore that anon_inode_create_get{file,fd}() allow the LSM
> to intercept and block the inode's creation.  If one was so inclined,
> anon_inode_getfile_secure() and anon_inode_getfd_secure() could be kept,
> using the shared inode or a new one depending on CONFIG_SECURITY.
> However, this is probably overkill, and potentially a cause of bugs in
> different configurations.  Therefore, just add a comment to io_uring
> and userfaultfd explaining the choice of the function.
> 
> While at it, remove the export for what is now anon_inode_create_getfd().
> There is no in-tree module that uses it, and the old name is gone anyway.

That's great, thanks.

> If anybody actually needs the symbol, they can ask or they can just use
> anon_inode_create_getfile(), which will be exported very soon for use
> in KVM.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
