Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53D7D395E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjJWOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJWOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:32:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944BF10C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:32:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so80315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698071559; x=1698676359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7Ps051HvRlmuSmZt6ySV7oSekeUA2kCbjCKb5l7ziM=;
        b=uvKnkHw77Rk5JQxOuV6Gyr1JRQhiOjDx2r51CknutZKxusQYijPpuxSRnlRnvzrid4
         nAVNDJrADLBRQcWH9s+Iv54DpPiIF3GhQknGgkXQIllWKPoUT4Nf2hdnwXW1GjRcoXxl
         iusq/oOdTDD+HLCna8SgCR53apQcZgKhzPed9Mw5UUT+URh1BnvBk7NCV6R1cbyjtOHE
         gUlyo2chYyRmNpqcj1ON1M51xRD4kHrZ+xz7GO8nUXyWq9u9jIxfabV8Vuz8P00cYnFh
         64+B7HhMRL6E4V7VCwDKqVxhB+msr4qFWVmcaOHRINKdvdaoK5hH923w0+rn12vv5ZFF
         4G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071559; x=1698676359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7Ps051HvRlmuSmZt6ySV7oSekeUA2kCbjCKb5l7ziM=;
        b=HnEDjNALsrpd+n1uj+gMyW8litNzbRjnZbpeGz5jVdsEYJz4T8/updRW0cP1HeaGJ9
         OnIzfi2MnElbp3N01bRx0yrK+MGY60P60b2PmTNq3JYO2inplmmUMP5V+KFgx5Ps/81N
         1/kx3bh43e/1Y4Ax8LFi6a5FmfHMooz8BtBhhmdwJP2LQgIRBJFnVeT8HpzsI5BU2jp9
         hfPJF+cfaNkNdZDheUBxmNpIs1Z4UHKptKbLr6hHy6+ohdm3AYLvPBYol/fbZWsPZJPW
         0LKDGZixlbq7+ftb/69mMQ/9mR/S3eCQ1qNA3I5U94adSKfDBYn5dXoDEydIC7e5OiG9
         fovw==
X-Gm-Message-State: AOJu0Yz2NHRLfAhlqkJuJOFrUCwF78ecuY6i5E1FAVNmZ8pgmFT5ahit
        I71QLSXT/OVflcLwR7Kom12R13b/psPG5lk6eXwbUeWGFCU=
X-Google-Smtp-Source: AGHT+IHAinTaD2IPkmrEEQ4xgusnoom1aIf5qYF1x2jdlSWU/o73N6AWOkqes0mM/TyNQLfyKWZ4YQ==
X-Received: by 2002:a05:600c:4a22:b0:408:2b:5956 with SMTP id c34-20020a05600c4a2200b00408002b5956mr278116wmp.6.1698071558828;
        Mon, 23 Oct 2023 07:32:38 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c471300b00405959bbf4fsm9691663wmo.19.2023.10.23.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:32:38 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:32:35 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v2 00/11] arm64: ptdump: View the second stage page-tables
Message-ID: <ZTaEAyuoEQ3cSbjT@google.com>
References: <20231019144032.2943044-1-sebastianene@google.com>
 <ZTI4FcFkgwnLv0-1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTI4FcFkgwnLv0-1@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:19:33AM +0100, Vincent Donnefort wrote:
> On Thu, Oct 19, 2023 at 02:40:21PM +0000, Sebastian Ene wrote:
> > Hi,
> > 
> > This can be used as a debugging tool for dumping the second stage
> > page-tables under debugfs.
> > 
> > From the previous feedback I re-worked the series and added support for
> > guest page-tables dumping under VHE & nVHE configuration. I extended the
> > list of reviewers as I missed the interested parties in the first round. 
> > 
> > When CONFIG_NVHE_EL2_PTDUMP_DEBUGFS is enabled under pKVM environment,
> > ptdump registers the 'host_stage2_kernel_page_tables' entry with debugfs.
> > Guests are registering a file named '%u_guest_stage2_page_tables' when
> > they are created. 

Hi,

> 
> I believe guests entries should be also available for nVHE and VHE.
> 

Yes, we support dumping the guest stage-2 pagetables with this under
both modes. The host stage-2 is available only in
kvm.arm.mode="protected".

> > 
> > This allows us to dump the host stage-2 page-tables with the following command:
> > cat /sys/kernel/debug/host_stage2_kernel_page_tables.
> 
> As it needs the debugfs anyway, this should probably live in the kvm/ debugfs
> folder, while the VMs ptdump should be placed in their respective folder.
> 
> This is quite easy, you should get access to the global kvm_debugfs_dir and
> struct kvm->debugfs_dentry.
>

Right, I was thinking to place them under kvm/ debugfs entry but then I
noticed that ptdump files are not registered under this path.

> > 
> > The output is showing the entries in the following format:
> > <IPA range> <size> <descriptor type> <access permissions> <mem_attributes>
> > 
> > The tool interprets the pKVM ownership annotation stored in the invalid
> > entries and dumps to the console the ownership information. To be able
> > to access the host stage-2 page-tables from the kernel, a new hypervisor
> > call was introduced which allows us to snapshot the page-tables in a host
> > provided buffer. The hypervisor call is hidden behind CONFIG_NVHE_EL2_DEBUG
> > as this should be used under debugging environment.
> > 
> > Link to the first version:
> > https://lore.kernel.org/all/20230927112517.2631674-1-sebastianene@google.com/
> > 
> > Changelog:
> >   v1 -> v2:
> >   * use the stage-2 pagetable walker for dumping descriptors instead of
> >     the one provided by ptdump.
> > 
> >   * support for guests pagetables dumping under VHE/nVHE non-protected
> > 
> > Thanks,
> > 
> > 
> > Sebastian Ene (11):
> >   KVM: arm64: Add snap shooting the host stage-2 pagetables
> >   arm64: ptdump: Use the mask from the state structure
> >   arm64: ptdump: Add the walker function to the ptdump info structure
> >   KVM: arm64: Move pagetable definitions to common header
> >   arm64: ptdump: Introduce stage-2 pagetables format description
> >   arm64: ptdump: Add hooks on debugfs file operations
> >   arm64: ptdump: Register a debugfs entry for the host stage-2
> >     page-tables
> >   arm64: ptdump: Parse the host stage-2 page-tables from the snapshot
> >   arm64: ptdump: Interpret memory attributes based on runtime
> >     configuration
> >   arm64: ptdump: Interpret pKVM ownership annotations
> >   arm64: ptdump: Add support for guest stage-2 pagetables dumping
> > 
> >  arch/arm64/include/asm/kvm_asm.h              |   1 +
> >  arch/arm64/include/asm/kvm_pgtable.h          |  85 +++
> >  arch/arm64/include/asm/ptdump.h               |  27 +-
> >  arch/arm64/kvm/Kconfig                        |  12 +
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   8 +-
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  18 +
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 103 ++++
> >  arch/arm64/kvm/hyp/pgtable.c                  |  98 ++--
> >  arch/arm64/kvm/mmu.c                          |   3 +
> >  arch/arm64/mm/ptdump.c                        | 487 +++++++++++++++++-
> >  arch/arm64/mm/ptdump_debugfs.c                |  42 +-
> >  11 files changed, 822 insertions(+), 62 deletions(-)
> > 
> > -- 
> > 2.42.0.655.g421f12c284-goog
> > 
