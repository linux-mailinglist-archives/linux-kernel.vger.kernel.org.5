Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202687E2C71
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjKFSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjKFSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:55:08 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77EA2;
        Mon,  6 Nov 2023 10:55:05 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da37522a363so5080328276.0;
        Mon, 06 Nov 2023 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699296905; x=1699901705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhLzSo2ZdsS1cNYMQVnH8qp5KlM4qInxdfA0/jF4QCI=;
        b=khxgnuGJ8j4BGXEo6Y+AnoFsHurQVgtv9XLQzlU4Un1+0sU2/6KWfCfkawt8or96ya
         6bLiZDUiCdQcrkSGL5pRhinRSGh6JmPBPCsJK17jfDLJ14CCYOaOE+uTCT7E8dsinaoR
         ZVWIMS/cMj/mjOWXsYmNqHDBsO4PR9dju6f1up0jAf+/J23B1eUXraJXEHFEcVsVhNfy
         Jg8mdw+G2k1tJPxewDVAHNvcA1lJKSpO8YONkXB9yPChF5AuEGCm9gIcjysyzWXYSo+8
         VaJAD4UtrCf+T404DevLSiBgpThZxYa71Llb1BQonVmAJMMlMCAnpSrbCDTRlXScoq6a
         qmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296905; x=1699901705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhLzSo2ZdsS1cNYMQVnH8qp5KlM4qInxdfA0/jF4QCI=;
        b=VZxHh4ttDCsfLPabi9hdqhpFG4/wW5/DiY/XtL8oOhWjoBMBMi6u4AOGwfAAj0M8Ax
         DL3blCkk03cHgOVnMu2xAAKKxmEWqvaGR0i928X9Sb3EGt1iGXMh4E7WRobItzmjAXwh
         9xHEH/rmi4szFFo+2DSdozW1ePJ1PvW2tJlNJlaEth6dHW9q00ft6VxvNByAKrLm3s7V
         9i4mq07a7b3WXPSqD1rS6Vgz/Wfo3iHfjm4MW1dJHWRvWXeSQElm3FAg6Lz3/5VdAw78
         WD8WiYQsKH5S0YAtBEvyfwdx0rEDgrWRgoJ3uLW4EWDL4J+P+htGTNpLVfslN8fk704K
         mKYw==
X-Gm-Message-State: AOJu0YxCc4MhY1OGBPNMsRnPWiqmNriTiOxpJ2qEgCNewK6yiWi6yYf2
        /bbbLjA5ryrewGiqFEgIP9s=
X-Google-Smtp-Source: AGHT+IEJ7Z/Zl9Si6wi3vI6C5MCyjuEizvr3x7s3+sIED3gUWfaO8DNl9Kxv0Pys3EFaVusnV304EA==
X-Received: by 2002:a5b:d49:0:b0:d9a:6301:c82b with SMTP id f9-20020a5b0d49000000b00d9a6301c82bmr31039102ybr.13.1699296905021;
        Mon, 06 Nov 2023 10:55:05 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id w142-20020a25c794000000b00da0c49a588asm4300672ybe.8.2023.11.06.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 10:55:04 -0800 (PST)
From:   fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date:   Mon, 6 Nov 2023 10:54:38 -0800
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v9 1/3] mm/memory_hotplug: replace an open-coded
 kmemdup() in add_memory_resource()
Message-ID: <ZUk2bqoi6YrgMyyO@debian>
References: <20231102-vv-kmem_memmap-v9-0-973d6b3a8f1a@intel.com>
 <20231102-vv-kmem_memmap-v9-1-973d6b3a8f1a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-vv-kmem_memmap-v9-1-973d6b3a8f1a@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 12:27:13PM -0600, Vishal Verma wrote:
> A review of the memmap_on_memory modifications to add_memory_resource()
> revealed an instance of an open-coded kmemdup(). Replace it with
> kmemdup().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  mm/memory_hotplug.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f8d3e7427e32..6be7de9efa55 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1439,11 +1439,11 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
>  		if (mhp_supports_memmap_on_memory(size)) {
>  			mhp_altmap.free = memory_block_memmap_on_memory_pages();
> -			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
> +			params.altmap = kmemdup(&mhp_altmap,
> +						sizeof(struct vmem_altmap),
> +						GFP_KERNEL);
>  			if (!params.altmap)
>  				goto error;
> -
> -			memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
>  		}
>  		/* fallback to not using altmap  */
>  	}
> 
> -- 
> 2.41.0
> 
