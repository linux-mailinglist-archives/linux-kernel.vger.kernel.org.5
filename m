Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099017F5BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjKWJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKWJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:49:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C9ED41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:49:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso6494a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700732962; x=1701337762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53mgz2I67bBPUMmao+k8i5+WtnPQJvvF0nHCuvFZ/vw=;
        b=aapx+ZPV5dvUGPk96AEXNjBd74j0OFjlRx4h0Yg85inhanPwlAR0enX+Uv+maKpICc
         X+l4aFrooVKKX7ZQgqxFldl6HLbA1ICkdWIq+X4ghqyvi8GeIHLwx6OwuPc6DzeBpZaz
         8cP7rXzmUTFYX4M+4WaeeNj10RF7B0o6WYe4aj1HNlBE6kweb+d8R1rpAEcVra7QBIL7
         6mhm7Sx7SSysW87LtTyRiLKwuLzGecsGF768aGUWVe1QZwDot3SO8uoqHTnqKLAwvcqY
         NWBHLH5y+VMo+Bw6Anod+BOjIOF8KNRCCJWCDXg8jAw5kdw6hLIDbNAi5F2l3FMxJ2Qu
         +qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732962; x=1701337762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53mgz2I67bBPUMmao+k8i5+WtnPQJvvF0nHCuvFZ/vw=;
        b=QGIXgx1IC+eBvA91yk1NzPZvwgZ7sG713so3/MZwLB01tnZAy7nOe4v349D8oqT5yB
         IDkf8u12cUBst5qVwG6Ua4NPm2SW8+Rd+F4jnT3azEJpHWDjZ7f9vqLu7pCt3UZdjiQt
         EMWXxvsKTEMftzD5nybFBT5QvWbrR/x2ZlUKKReSjyH18RQClM5nr5VdPXfjyYJTt4KP
         8AwXr2WuQkhi0v/aAaAyaDeGAWo2tU+p/hA57R8r6XdMjy9rFkZ6ZBl5vkF5YaL/D0cr
         zsNz0Lu26lg0hx5FSNx7dFoUj7ha5DZGE/uvOL3ZxlM3lYpQK8A21OyPhY5HeMSEedzQ
         A/Bw==
X-Gm-Message-State: AOJu0YxTiI7kNluVHN70Hb6xZdUnmsd4/UBsqYQWoVTbpGq2z4m3GKob
        y+w0V0tdKGECUrenkK0/uIlGXA==
X-Google-Smtp-Source: AGHT+IGcKXGwNmDsBQqKA/iG8b0gT6CgYkVFrfoOHPHcaUQILJhKYcBEUn/xAg67qiro7eA/qQPVkA==
X-Received: by 2002:a05:6402:3815:b0:544:466b:3b20 with SMTP id es21-20020a056402381500b00544466b3b20mr242943edb.5.1700732961713;
        Thu, 23 Nov 2023 01:49:21 -0800 (PST)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332c0aace23sm1162986wrc.105.2023.11.23.01.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:49:20 -0800 (PST)
Date:   Thu, 23 Nov 2023 09:49:17 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     will@kernel.org, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v3 00/10] arm64: ptdump: View the second stage page-tables
Message-ID: <ZV8gHfnrFzhdjjw5@google.com>
References: <20231115171639.2852644-2-sebastianene@google.com>
 <ZV6MVYI8J6NFS9Wl@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV6MVYI8J6NFS9Wl@linux.dev>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:18:45PM +0000, Oliver Upton wrote:

Hi Oliver,

> Hi Seb,
> 
> On Wed, Nov 15, 2023 at 05:16:30PM +0000, Sebastian Ene wrote:
> > Hi,
> > 
> > This can be used as a debugging tool for dumping the second stage
> > page-tables.
> > 
> > When CONFIG_PTDUMP_STAGE2_DEBUGFS is enabled, ptdump registers 
> > '/sys/debug/kvm/<guest_id>/stage2_page_tables' entry with debugfs
> > upon guest creation. This allows userspace tools (eg. cat) to dump the
> > stage-2 pagetables by reading the registered file.
> > 
> > Reading the debugfs file shows stage-2 memory ranges in following format:
> > <IPA range> <size> <descriptor type> <access permissions> <mem_attributes>
> > 
> > Under pKVM configuration(kvm-arm.mode=protected) ptdump registers an entry
> > for the host stage-2 pagetables in the following path:
> > /sys/debug/kvm/host_stage2_page_tables/
> > 
> > The tool interprets the pKVM ownership annotation stored in the invalid
> > entries and dumps to the console the ownership information. To be able
> > to access the host stage-2 page-tables from the kernel, a new hypervisor
> > call was introduced which allows us to snapshot the page-tables in a host
> > provided buffer. The hypervisor call is hidden behind CONFIG_NVHE_EL2_DEBUG
> > as this should be used under debugging environment.
> 
> While I think the value of the feature you're proposing is great, I'm
> not a fan of the current shape of this series.
> 
> Reusing note_page() for the stage-2 dump is somewhat convenient, but the
> series pulls a **massive** amount of KVM details outside of KVM:
> 
>  - Open-coding the whole snapshotting interface with EL2 outside of KVM.
>    This is a complete non-starter for me; the kernel<->EL2 interface
>    needs to be owned by the EL1 portions of KVM.
> 
>  - Building page-table walkers using the KVM pgtable library outside of
>    KVM.
> 
>  - Copying (rather than directly calling) the logic responsible for
>    things like FWB and PGD concatenation.
> 
>  - Hoisting the definition of _software bits_ outside of KVM. I'm less
>    concerned about hardware bits since they have an unambiguous meaning.
> 
> I think exporting the necessary stuff from ptdump into KVM will lead to
> a much cleaner implementation.
> 

Right, I had to import a lot of definitions from KVM, especially for the
prot_bits array and for the IPA size retrieval. I think it would be less
intrusive the other way around, to pull some ptdump hooks into kvm.

> -- 
> Thanks,
> Oliver

Thanks,
Seb
