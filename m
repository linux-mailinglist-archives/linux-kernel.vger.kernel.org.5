Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E5B7908D4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjIBRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIBRQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 13:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC8CE5B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693674911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3rwdnX+8EZ4iBHiYpc5/Ea7123YR1lUghk+ZipZcao=;
        b=EwwMXEdjLkGZnPEwmr094GbWe3ZqTy4MAxNfijwJC3QCyjIfsuJx+FkojM6ITQEXIlJyH7
        dwFmSz193EJecjN5b7eNtc6YM9wRxBGBSv8EMJH/6GA7FKg/k1Zgk/8Zm6samOiNS3oV+6
        v86IaD6GEBEjclkaSKU4Qh7byYzKSQ0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-njeT9I9aPr6qD0yD-7I-6A-1; Sat, 02 Sep 2023 13:15:09 -0400
X-MC-Unique: njeT9I9aPr6qD0yD-7I-6A-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c1fe87fc29so1086015ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 10:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693674908; x=1694279708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3rwdnX+8EZ4iBHiYpc5/Ea7123YR1lUghk+ZipZcao=;
        b=KlcBxTc8/GL1lJ5cO6jWwmRn4gRg6ER6ruPnA+Fvr6O0Un9HmjP7n/j59t15TfpKTn
         wmAGBh80+Mhw0KMeQN2zkC31MlSpXlguTubAzuNUekbb2ifJJ+MU885yuwCi3wqJUylQ
         AWHxA+Qc81ucYMI1rciegxvKVgKPppc8oDl8i1gAN6FJ7UUNGTCKjLt8yRK8PWUqf/5b
         U43lhWpC1G/wXoKfpLZwi+6DFeIizJHs32wf777QVAl9750Cc/GoN72j/Vq0MogY5o/d
         1h0mrHvMyoESLs10LfR3BdeqmUZFlKcK+aonc/xkUR59bjlJJ9NKTfP03lHSYIUXO6bK
         nfnw==
X-Gm-Message-State: AOJu0YyKWkcnIYcWBKHYWVB3ep9hVWfGZDbAtuFF1ifpjwqrJjHWmeSL
        HvJmF0NACswD+qT000k36U1nSwyjyBY/rO14tcmb28AtjOt8UijVAu49bJibMM+3wsIAnxz7h85
        tGgXwfNb4d9f0tLT7B5jwsLRPSCu/lJX0
X-Received: by 2002:a17:902:d48f:b0:1bd:e64c:5c71 with SMTP id c15-20020a170902d48f00b001bde64c5c71mr6094314plg.21.1693674908657;
        Sat, 02 Sep 2023 10:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV+kHQJSiPr1V0gPMpOP/VEJoJGjTZsePWvjrleo29ncyzGxiqPnw6LtKQTRBk5IScMHgk4A==
X-Received: by 2002:a17:902:d48f:b0:1bd:e64c:5c71 with SMTP id c15-20020a170902d48f00b001bde64c5c71mr6094301plg.21.1693674908327;
        Sat, 02 Sep 2023 10:15:08 -0700 (PDT)
Received: from ?IPV6:240d:1a:c0d:9f00:64d6:da05:8423:9cd6? ([240d:1a:c0d:9f00:64d6:da05:8423:9cd6])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001bde65894c8sm4845411plb.268.2023.09.02.10.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 10:15:07 -0700 (PDT)
Message-ID: <05e68275-3919-555e-f2df-016aa83b72e4@redhat.com>
Date:   Sun, 3 Sep 2023 02:15:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs/ntfs3: Fix potential use-after-free in
 ntfs_init_from_boot()
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230812154736.975753-1-syoshida@redhat.com>
Content-Language: en-US
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20230812154736.975753-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On 8/13/23 00:47, Shigeru Yoshida wrote:
> KASAN found the following issue:
> 
> BUG: KASAN: use-after-free in memcmp+0x172/0x1c0
> Read of size 8 at addr ffff88802d88a002 by task repro/4557
> 
> CPU: 0 PID: 4557 Comm: repro Not tainted 6.5.0-rc5-00296-gf8de32cc060b-dirty #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xd3/0x1b0
>  print_report+0xc4/0x630
>  ? __virt_addr_valid+0x5e/0x2d0
>  ? __phys_addr+0xc6/0x140
>  kasan_report+0xda/0x110
>  ? memcmp+0x172/0x1c0
>  ? memcmp+0x172/0x1c0
>  memcmp+0x172/0x1c0
>  ? __bread_gfp+0x79/0x310
>  ntfs_fill_super+0x722/0x43a0
>  ? put_ntfs+0x330/0x330
>  ? vsprintf+0x30/0x30
>  ? set_blocksize+0x2c0/0x360
>  get_tree_bdev+0x43e/0x7d0
>  ? put_ntfs+0x330/0x330
>  vfs_get_tree+0x88/0x350
>  path_mount+0x69f/0x1ec0
>  ? kmem_cache_free+0xf0/0x4a0
>  ? finish_automount+0xa50/0xa50
>  ? putname+0x105/0x140
>  __x64_sys_mount+0x293/0x310
>  ? copy_mnt_ns+0xb60/0xb60
>  ? syscall_enter_from_user_mode+0x26/0x80
>  do_syscall_64+0x39/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f2d6bf29eaa
> Code: 48 8b 0d 71 df 0a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 c8
> RSP: 002b:00007ffcf8924638 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000423e00 RCX: 00007f2d6bf29eaa
> RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 00007ffcf8924770
> RBP: 00007ffcf8924800 R08: 00007ffcf8924670 R09: 0000000000000000
> R10: 0000000000000040 R11: 0000000000000202 R12: 00007ffcf8924978
> R13: 00007ffcf8924988 R14: 0000000000402c65 R15: 00007f2d6c014a60
>  </TASK>
> 
> dev_size variable is used to calculate the LBO of the alternative boot
> in ntfs_init_from_boot().  dev_size is set to the number of bytes of
> the device, but it can be modified when the NTFS sector size and the
> media sector size are different.  So, using dev_size can cause the
> above issue in that case.
> 
> This patch fixes this issue by resetting dev_size to the actual number
> of bytes of the device before calculating the LBO of the alternative
> boot.
> 
> Fixes: 6a4cd3ea7d77 ("fs/ntfs3: Alternative boot if primary boot is corrupted")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  fs/ntfs3/super.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 1a02072b6b0e..43b698353840 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1067,7 +1067,10 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  out:
>  	if (err == -EINVAL && !bh->b_blocknr && dev_size > PAGE_SHIFT) {
>  		u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
> -		u64 lbo = dev_size - sizeof(*boot);
> +		u64 lbo;
> +
> +		dev_size = bdev_nr_bytes(sb->s_bdev);
> +		lbo = dev_size - sizeof(*boot);
>  
>  		/*
>  	 	 * Try alternative boot (last sector)

