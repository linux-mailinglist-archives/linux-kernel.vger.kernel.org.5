Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951237DF796
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376853AbjKBQYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjKBQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:24:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56312D;
        Thu,  2 Nov 2023 09:24:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBABC433C8;
        Thu,  2 Nov 2023 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698942279;
        bh=1oyVMjQI7OXHCUtZSgK71uJyeSsja11PK2zu0Sgh3ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciKD3SqqJbMFjIcI6bCCYkwFV34fiO2ArRgF5fXcYKuOaGXb4Wyi9zozkY1GPacll
         Wb4+rsmrOAiUFpUvVmXoDHyclytLXtYqrhZkU0PpNpIyYDeZGFKHZDDWtqHWW99OuO
         qo3jhEw/diJ1a/cjqpth3wyK9LJTK2A2KbT6VwEC/UhcdzfCTDR5j8l+p9MS2DAQxb
         LzKQyThoycm/wTmhlnVYtsizofoKOqeGHL2Li2UrkzPUXr3zUUph4Dx0xK0JakNnV7
         d57GUWFGv9wIfjooWNbwoPxilLaGhd+yLjY93dOc3Y/tHVaznNMcGB6moDDpowdxsF
         zbisHCIeWrzQg==
Date:   Thu, 2 Nov 2023 17:24:27 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v13 15/35] fs: Export anon_inode_getfile_secure() for use
 by KVM
Message-ID: <20231102-freihalten-vorsah-fdd68051b005@brauner>
References: <20231027182217.3615211-1-seanjc@google.com>
 <20231027182217.3615211-16-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231027182217.3615211-16-seanjc@google.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:21:57AM -0700, Sean Christopherson wrote:
> Export anon_inode_getfile_secure() so that it can be used by KVM to create
> and manage file-based guest memory without need a fullblow filesystem.
> The "standard" anon_inode_getfd() doesn't work for KVM's use case as KVM
> needs a unique inode for each file, e.g. to be able to independently
> manage the size and lifecycle of a given file.
> 
> Note, KVM doesn't need a "secure" version, just unique inodes, i.e. ignore
> the name.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Before we enshrine this misleading name let's rename this to:

create_anon_inode_getfile()

I don't claim it's a great name but it's better than *_secure() which is
very confusing. So just:

struct file *create_anon_inode_getfile(const char *name,
                                       const struct file_operations *fops,
                                       void *priv, int flags)

May also just remove that context_inode argument from the exported
function. The only other caller is io_uring. And neither it nor this
patchset need the context_inode thing afaict. Merge conflict risk is
extremely low so carrying that as part of this patchset is fine and
shouldn't cause huge issues for you.
