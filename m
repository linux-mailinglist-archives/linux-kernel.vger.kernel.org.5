Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC757F4918
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjKVOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbjKVOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:37:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE51D50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:37:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f78dcf036so558036f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700663819; x=1701268619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5S0ovat1Ld2/p/rdzb9E9NFKi5bx+S+NSv6XEPWCA8=;
        b=a1IL6JxiomiglK4bQTsue5iX/4n4XCebmYh6rnozYrWgJIXY8J9nGv9fi/qVMqoW6c
         1VVtSvZFSGHBhhiS4Ivqebpn2wAQ8cg2HLDlY3HFunhecNjvnd1f9L3JSuAQqhE8ncYX
         FmgabwB6dS6TTE2k0LrN7noshcSbve5ACmD8vzU2amaY8vDUfk+wAq1mr62hWlHeVMHV
         JxxaS93BWOAhEt00oEgN9hQNBXv9vEQx5mdev+KbLXI1KyCbEev/cI09FnH1F0T3vBLt
         LtqC0PQ/jfP1o9KU9bulNxqA+VvrPcDfn/N+GfL2YoXeAp//vIrdsoK/YhsEW+TtbWlu
         uldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663819; x=1701268619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5S0ovat1Ld2/p/rdzb9E9NFKi5bx+S+NSv6XEPWCA8=;
        b=wXVFM90RUd/+Rn8+104ATd4abpAy3zL+onop3ijObh+iFsHkdiOl7dwSNMlMUH2HU8
         g2JfVlUuSWldb+ZyneNqL2axAov4Th6gslgNjzvY0JwZa1QIVgIGFma9Gr4GaB4bvUJn
         TooBqy25qbCmGOOSKLCBlbsjhHKtJPUntU3x9SlWhfpn+JdjtA216WCmMBLUFLMcbSbI
         tL3iTnKWVW757IRqgHQbZxQBxj6uxs8fUt0RWrln3H7DuOXrl8vRcy/TmQ4SDRCgmYAH
         EURU18H/nDlaV+p5mX4JqgkXbBkNVD6B+wTXLOhhcmoB4XZLzVbwFenhFTV+71egS9+T
         lEyg==
X-Gm-Message-State: AOJu0YxaP59scQW2WwQVabo/7erPaAqi+xGcAGxdANB6VJaB6AfKyGUd
        Sd5ExCYxu4aewn+/ojuL5hMkSQ==
X-Google-Smtp-Source: AGHT+IGyi7J+6h3rxcZ1JVou4fsnecYhJwWBZMFmSSMHEMqUjB8YcptrGlhNGF3SydnM1LCIg+pqew==
X-Received: by 2002:a5d:47af:0:b0:332:d504:c10a with SMTP id 15-20020a5d47af000000b00332d504c10amr549068wrb.19.1700663818745;
        Wed, 22 Nov 2023 06:36:58 -0800 (PST)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d584d000000b00332cb0937f4sm7730008wrf.33.2023.11.22.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:36:58 -0800 (PST)
Date:   Wed, 22 Nov 2023 14:36:54 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v3 05/10] arm64: ptdump: Add hooks on debugfs file
 operations
Message-ID: <ZV4SBp-8Y9lLItrh@google.com>
References: <20231115171639.2852644-2-sebastianene@google.com>
 <20231115171639.2852644-7-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115171639.2852644-7-sebastianene@google.com>
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

On Wed, Nov 15, 2023 at 05:16:35PM +0000, Sebastian Ene wrote:
> Introduce callbacks invoked when the debugfs entry is accessed from
> userspace. This hooks will allow us to allocate and prepare the memory
> resources used by ptdump when the debugfs file is opened/closed.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/include/asm/ptdump.h |  7 +++++
>  arch/arm64/mm/ptdump_debugfs.c  | 53 +++++++++++++++++++++++++++++++--
>  2 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index 1f6e0aabf16a..9b2bebfcefbe 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -20,9 +20,16 @@ struct ptdump_info {
>  	const struct addr_marker	*markers;
>  	unsigned long			base_addr;
>  	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
> +	int (*ptdump_prepare_walk)(void *file_priv);
> +	void (*ptdump_end_walk)(void *file_priv);
>  };
>  
>  void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
> +
> +struct ptdump_info_file_priv {
> +	struct ptdump_info	info;
> +	void			*file_priv;
> +};
>  #ifdef CONFIG_PTDUMP_DEBUGFS
>  #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
>  void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> index 7564519db1e6..3bf5de51e8c3 100644
> --- a/arch/arm64/mm/ptdump_debugfs.c
> +++ b/arch/arm64/mm/ptdump_debugfs.c
> @@ -7,7 +7,8 @@
>  
>  static int ptdump_show(struct seq_file *m, void *v)
>  {
> -	struct ptdump_info *info = m->private;
> +	struct ptdump_info_file_priv *f_priv = m->private;
> +	struct ptdump_info *info = &f_priv->info;
>  
>  	get_online_mems();
>  	if (info->ptdump_walk)
> @@ -15,7 +16,55 @@ static int ptdump_show(struct seq_file *m, void *v)
>  	put_online_mems();
>  	return 0;
>  }
> -DEFINE_SHOW_ATTRIBUTE(ptdump);
> +
> +static int ptdump_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +	struct ptdump_info *info = inode->i_private;
> +	struct ptdump_info_file_priv *f_priv;
> +
> +	f_priv = kzalloc(sizeof(struct ptdump_info_file_priv), GFP_KERNEL);
> +	if (!f_priv)
> +		return -ENOMEM;
> +
> +	memcpy(&f_priv->info, info, sizeof(*info));

That doesn't look right. Why would reading the file need a copy of that?

Also, that is a lot of "priv" it's hard to understand which is which.

I suppose you need have the description of the pgtable which is created at the
same time as the debugfs entry is registered.

And you have (or not) the snapshot of the pgtable, which is created only on the
file open.

> +
> +	ret = single_open(file, ptdump_show, f_priv);
> +	if (ret) {
> +		kfree(f_priv);
> +		return ret;
> +	}
> +
> +	if (info->ptdump_prepare_walk) {
> +		ret = info->ptdump_prepare_walk(f_priv);
> +		if (ret)
> +			kfree(f_priv);
> +	}
> +
> +	return ret;
> +}
> +

[...]
