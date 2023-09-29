Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5017B3C99
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjI2WaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2WaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:30:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC98F1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:30:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406650da82bso1602505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696026603; x=1696631403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J4ODyI/xGDfBDr3VSCKLFMfeRUTcBjJWMeC4Qx7RcLU=;
        b=ceYZ/TRYjzLJMUz9TiOyb16DwNx7ybYKb1RzxSlCxtYlM5LLHg5AFVcRxF1sQKfW6R
         PvJPxTxvA9x2uMb8vY3a3Gj/2t7/H+opZwDi41Hlb4zmxc7ydobYuy2V0G3r3F4zW1yI
         j98hv5ZDA6BE1a0FhVbdOwxZEWd85AIXufTrlkVy2FU11ER0nn3AknFSPeWD7V69wK9Z
         zNBMfgIcTMnbw4qX+SS/QWxbmFedBRAkiheCZVOojUuywWC4oLYL+rKetg9SH85E/9zR
         3ZCtUQBKwtDRqQ8FvqbBBRwftf40X8CoVfPlPI/zk0l3xXNfMKNsDWngolHWTfzxN4Mg
         rTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696026603; x=1696631403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4ODyI/xGDfBDr3VSCKLFMfeRUTcBjJWMeC4Qx7RcLU=;
        b=WFkU+upjcgH4DvcBKeWoFzaAsq1r21upIuiVOeb0LmlPaYS7RF8ml//mHIevWQTWtO
         /AoxBq8a0+egWgR/VN9OVCjER/SOQR/RRL53i50rsor54zsauFGx+CZGz/JKDzhKjdWK
         jVrGl5lXavtgRAUovAyjbcYY5slZBM7hd+QKP3QjYyOjVNd+jeSCfqw0CjorVYqFKCQ/
         zt85WqOa/epjB1nusUzB4BMDwDaBL+wxJx26LjwWOd7CrAP/euzEWce8b5bEJ5qLh7ju
         gubzRMuxqDlCgr0l8qB36M+Qy54cuc2u3MeC9xH0NlOMDv6lokFf9gheH4ozCVHO/U4v
         2F0w==
X-Gm-Message-State: AOJu0YwclrOD81mX1Egi2bunbaTxlnpXRSMg++Cg8G3wQGzkFIaqkeSK
        zjUpgYCYj3EtdlG0D0JPI/g=
X-Google-Smtp-Source: AGHT+IHMqmbjL3PpGXeDkwNFoF00EDu0jzJQkz1KBQVWnHJGrsmsq8HADGwhMX77DgL3YjXJ+VnqBw==
X-Received: by 2002:adf:ea49:0:b0:320:485:7010 with SMTP id j9-20020adfea49000000b0032004857010mr4620006wrn.67.1696026603166;
        Fri, 29 Sep 2023 15:30:03 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id b4-20020adfee84000000b003197c7d08ddsm1555572wro.71.2023.09.29.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 15:30:02 -0700 (PDT)
Date:   Fri, 29 Sep 2023 23:30:01 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/3] mmap: Add clarifying comment to vma_merge() code
Message-ID: <1c7c1869-ef9c-487f-9c8e-08a51d9f8efe@lucifer.local>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-4-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929183041.2835469-4-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 02:30:41PM -0400, Liam R. Howlett wrote:
> When tracing through the code in vma_merge(), it was not completely
> clear why the error return to a dup_anon_vma() call would not overwrite
> a previous attempt to the same function.  This commit adds a comment
> specifying why it is safe.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/linux-mm/CAG48ez3iDwFPR=Ed1BfrNuyUJPMK_=StjxhUsCkL6po1s7bONg@mail.gmail.com/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f9f0a5fe4db4..9967acbd070f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -943,6 +943,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_start_write(curr);
>  			remove = curr;
>  			remove2 = next;
> +			/*
> +			 * Note that the dup_anon_vma below cannot overwrite err
> +			 * since the first caller would do nothing unless next
> +			 * has an anon_vma.
> +			 */
>  			if (!next->anon_vma)
>  				err = dup_anon_vma(prev, curr, &anon_dup);
>  		}
> --
> 2.40.1
>

Nice comment! It causes me to sick up a bit in my mouth that this is a thing,
but it's good to have it documented.

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
