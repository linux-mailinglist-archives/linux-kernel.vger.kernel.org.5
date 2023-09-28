Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730767B2573
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjI1Sos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1Soq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0585BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695926636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KluJiPKqp7sS7ISa/DFd0xZs2vy0KSst25dB4gh/ObE=;
        b=XKexeoWrKrztWvPuBQoKizAkZd2Eg9V36xYyXPxQ18eFnvrRW8hb7qcdIiJcsnbQ8BSty2
        bSZ1xOOj0MFgP3S6xwFCjyEjafkS/Ulthr8Jd/2vUEVl9QasEdTDQzNT153fDnsG2eXlYa
        VLquQiYxoSvp9a4mCr1F/shBATsmx+w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-A8w7pQAtOq6iy61iPKx2fQ-1; Thu, 28 Sep 2023 14:43:55 -0400
X-MC-Unique: A8w7pQAtOq6iy61iPKx2fQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7741abfbe9fso422454085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695926635; x=1696531435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KluJiPKqp7sS7ISa/DFd0xZs2vy0KSst25dB4gh/ObE=;
        b=pjO/8vYYBpNF4DZpqrgVJSA77GzGYj8N94XxQTKh0DfOzDy3TC7hJ1GpjHhhn6xwZA
         /L6EICDkBJto32vMT0B/QDxq6TSx0u2QogTLA3hzOT+4EqAzhaEk9g05DPSgJ0TRECel
         XQcxt392hX61gY/Bj+0M8WQ4NZmMV9wPO+vTipmkEzvqST1FJhgW2ox/GcS9TUpXCOyO
         MG6Z3IupRoo7uQIXcuEQmUqTSCblgmcoVMoF/abQ9nl+oQFBI9Q+9GRaD27gb82DaAHi
         GQF+a3ZcWcTEKtnIOfs+r7EH9WMVWOxCFsXEZ0BPSv43ueWzU+cooT7nC8xsebWmhr1+
         QSiw==
X-Gm-Message-State: AOJu0YyF2EbpYFRg2gyFixpUq9mk4o0XHcfC6fSFghX4d6Z98+iopa0Q
        AeYYnHH9jmyHn9pKZbdg3HBHFDCGE9nGKwX4RcHPbH87Lv8q3fG+yRD58U2bKejQ1iSyQn5T0PF
        2Yv9nIal3nMtHeC1jFWb1QrN6
X-Received: by 2002:a05:620a:4729:b0:770:f2bb:37c3 with SMTP id bs41-20020a05620a472900b00770f2bb37c3mr1269551qkb.6.1695926635009;
        Thu, 28 Sep 2023 11:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3STLuaO2dfs9EPyzarDP6QP4+CJxE/o3EmveXGBIjmuK0WTFRZt6+OwzKEEXFlvXsZ1VOVg==
X-Received: by 2002:a05:620a:4729:b0:770:f2bb:37c3 with SMTP id bs41-20020a05620a472900b00770f2bb37c3mr1269528qkb.6.1695926634714;
        Thu, 28 Sep 2023 11:43:54 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id s24-20020a05620a16b800b007743446efd1sm3252625qkj.35.2023.09.28.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 11:43:54 -0700 (PDT)
Date:   Thu, 28 Sep 2023 14:43:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRXJZyPMdVsQNt4h@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923013148.1390521-3-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing..

On Fri, Sep 22, 2023 at 06:31:45PM -0700, Suren Baghdasaryan wrote:
> +static int remap_pages_pte(struct mm_struct *dst_mm,

[...]

> +retry:
> +	dst_pte = pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &dst_ptl);
> +
> +	/* If an huge pmd materialized from under us fail */
> +	if (unlikely(!dst_pte)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	src_pte = pte_offset_map_nolock(src_mm, src_pmd, src_addr, &src_ptl);
> +
> +	/*
> +	 * We held the mmap_lock for reading so MADV_DONTNEED
> +	 * can zap transparent huge pages under us, or the
> +	 * transparent huge page fault can establish new
> +	 * transparent huge pages under us.
> +	 */
> +	if (unlikely(!src_pte)) {
> +		err = -EFAULT;
> +		goto out;
> +	}

For these two places: I know that thp collapse with mmap read lock hasn't
yet spread to anon (so I assume none of above could trigger yet on the
failure paths), but shall we constantly return -EAGAIN here just in case we
forget that in the future?

For example, for UFFDIO_COPY over shmem which we can already hit similar
case, mfill_atomic_install_pte() has:

	ret = -EAGAIN;
	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
	if (!dst_pte)
		goto out;

Thanks,

-- 
Peter Xu

