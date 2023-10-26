Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3831D7D7C31
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjJZF1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJZF1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C0111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698297979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wqJae009xBE3KugPekEbv710hZP/gPekJx6jWnYEm18=;
        b=JgAT0G3BB849gntQyo50lTSDuWijcogLeE8jAimsuRdNV32LBZ+88cGs1aib3mP43L/zpE
        iimHtyKfGV8/z2itQxlP5qJNXWu3aKurAZnwUrMymWg+2WXoOy39DSzcsX2bgRrIsJaK5P
        IFWZ0kpwen6DxBw57UKHIq5VuwKO7Z8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-v4aJkHuFPK27zSqJpXdX2A-1; Thu, 26 Oct 2023 01:26:16 -0400
X-MC-Unique: v4aJkHuFPK27zSqJpXdX2A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c515541a25so4508031fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297975; x=1698902775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqJae009xBE3KugPekEbv710hZP/gPekJx6jWnYEm18=;
        b=q262l0Tf44EBIDctLa58GXEmmt2u4TKgIM1i/emdqsc5zGJVSmcZ6Ka0Nu98UVNVHI
         TBkr/UKthN4yeSoJlTvODvdov/8iHAthCtukppGwy+ZYV8xVJLEAj6AFOJUvDKOq7TjL
         Qaey5OtMnpTmjnjOcUBtG3sIHnAei/iZR8+S3vzPTCkcF+h33FMEu8vONrEjOfwpE6iv
         EbP1iMWawKndXnC233wWhdl+Evaq1waO1y7nnZBW+/HCGMLKgiVOhszdGelbsiBfDlko
         Xn083OlGRu/TlBIL16S8mXbSd7ylNWOKB3xEIIs6xz2pF1lmZ/Rs9sU39J960YoSb8Yv
         Ty1A==
X-Gm-Message-State: AOJu0YxN5RWHW7Fs+66yEBXHWvQJJFT8I+8mIAgeHoHhh6rHJe+HR1pw
        R+FOo/cVGA6Sf15/00uo+Bmj8okxEQWQTXZjc3Qn2X35NrSi1bIxEp37PTRVe96OjXTgdJ9/V8Y
        +eTt/3RSuKUEFxzq3IiQO85sv
X-Received: by 2002:a2e:7a0b:0:b0:2c5:1075:5ec9 with SMTP id v11-20020a2e7a0b000000b002c510755ec9mr10995820ljc.13.1698297975210;
        Wed, 25 Oct 2023 22:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvK8TcWtAa7HeN38eCIs/EyjZjcjRrw4ST8tbuymn5lLBsYCwz56XxpCAwv10LfG1bqXWNzw==
X-Received: by 2002:a2e:7a0b:0:b0:2c5:1075:5ec9 with SMTP id v11-20020a2e7a0b000000b002c510755ec9mr10995811ljc.13.1698297974852;
        Wed, 25 Oct 2023 22:26:14 -0700 (PDT)
Received: from redhat.com ([2.52.26.119])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b0032dc24ae625sm13339764wrr.12.2023.10.25.22.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:26:14 -0700 (PDT)
Date:   Thu, 26 Oct 2023 01:26:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        sfr@canb.auug.org.au, leiyang@redhat.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: fix use-after-free in _compat_vdpa_reset
Message-ID: <20231026012326-mutt-send-email-mst@kernel.org>
References: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 04:13:14PM -0700, Si-Wei Liu wrote:
> When the vhost-vdpa device is being closed, vhost_vdpa_cleanup() doesn't
> clean up the vqs pointer after free. This could lead to use-after-tree
> when _compat_vdpa_reset() tries to access the vqs that are freed already.
> Fix is to set vqs pointer to NULL at the end of vhost_vdpa_cleanup()
> after getting freed, which is guarded by atomic opened state.
> 
>   BUG: unable to handle page fault for address: 00000001005b4af4
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 16a80a067 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 4 PID: 40387 Comm: qemu-kvm Not tainted 6.6.0-rc7+ #3
>   Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.8.2 09/14/2022
>   RIP: 0010:_compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
>   Code: 90 90 90 0f 1f 44 00 00 41 55 4c 8d ae 08 03 00 00 41 54 55 48
>   89 f5 53 4c 8b a6 00 03 00 00 48 85 ff 74 49 48 8b 07 4c 89 ef <48> 8b
>   80 88 45 00 00 48 c1 e8 08 48 83 f0 01 89 c3 e8 73 5e 9b dc
>   RSP: 0018:ff73a85762073ba0 EFLAGS: 00010286
>   RAX: 00000001005b056c RBX: ff32b13ca6994c68 RCX: 0000000000000002
>   RDX: 0000000000000001 RSI: ff32b13c07559000 RDI: ff32b13c07559308
>   RBP: ff32b13c07559000 R08: 0000000000000000 R09: ff32b12ca497c0f0
>   R10: ff73a85762073c58 R11: 0000000c106f9de3 R12: ff32b12c95b1d050
>   R13: ff32b13c07559308 R14: ff32b12d0ddc5100 R15: 0000000000008002
>   FS:  00007fec5b8cbf80(0000) GS:ff32b13bbfc80000(0000)
>   knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000001005b4af4 CR3: 000000015644a003 CR4: 0000000000773ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __die+0x20/0x70
>    ? page_fault_oops+0x76/0x170
>    ? exc_page_fault+0x65/0x150
>    ? asm_exc_page_fault+0x22/0x30
>    ? _compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
>    vhost_vdpa_open+0x57/0x280 [vhost_vdpa]
>    ? __pfx_chrdev_open+0x10/0x10
>    chrdev_open+0xc6/0x260
>    ? __pfx_chrdev_open+0x10/0x10
>    do_dentry_open+0x16e/0x530
>    do_open+0x21c/0x400
>    path_openat+0x111/0x290
>    do_filp_open+0xb2/0x160
>    ? __check_object_size.part.0+0x5e/0x140
>    do_sys_openat2+0x96/0xd0
>    __x64_sys_openat+0x53/0xa0
>    do_syscall_64+0x59/0x90
>    ? syscall_exit_to_user_mode+0x22/0x40
>    ? do_syscall_64+0x69/0x90
>    ? syscall_exit_to_user_mode+0x22/0x40
>    ? do_syscall_64+0x69/0x90
>    ? do_syscall_64+0x69/0x90
>    ? syscall_exit_to_user_mode+0x22/0x40
>    ? do_syscall_64+0x69/0x90
>    ? exc_page_fault+0x65/0x150
>    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> Fixes: 10cbf8dfaf93 ("vhost-vdpa: clean iotlb map during reset for older userspace")
> Fixes: ac7e98c73c05 ("vhost-vdpa: fix NULL pointer deref in _compat_vdpa_reset")

So these two are all in next correct?

I really do not like it how 10cbf8dfaf936e3ef1f5d7fdc6e9dada268ba6bb
introduced a regression and then apparently we keep fixing things up?

Can I squash these 3 commits?


> Reported-by: Lei Yang <leiyang@redhat.com>
> Closes: https://lore.kernel.org/all/CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com/
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 9a2343c45df0..30df5c58db73 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1355,6 +1355,7 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
>  	vhost_vdpa_free_domain(v);
>  	vhost_dev_cleanup(&v->vdev);
>  	kfree(v->vdev.vqs);
> +	v->vdev.vqs = NULL;
>  }
>  
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
> -- 
> 2.39.3

