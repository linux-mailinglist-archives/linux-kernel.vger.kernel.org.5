Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2279A7DC10D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjJ3UQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3UQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E53EF9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698696945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jRgWu4wq7HEdb6M9xaqIwEKJPe6YuGuA0xc3W8gBcA=;
        b=Y9JAKpoZpGkrSwuboDes7yeVI1Hbl7RJFCbASaukmMFTCkGiagIJMgWH8RmwVd6DohyUz8
        YoqVocRS87v9jId4/khwbi4L0zoYfaXntglJ0YmGz3hJX1M3AqXgk4Ua3a0lw5Yy9uEl0c
        j5lSzyzdWe9U17HwVLfjeOcIaXu6O2g=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-lvevkqKVNxOHfkWGx-LmZw-1; Mon, 30 Oct 2023 16:15:38 -0400
X-MC-Unique: lvevkqKVNxOHfkWGx-LmZw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cd9e05c8bso6073361cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696936; x=1699301736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jRgWu4wq7HEdb6M9xaqIwEKJPe6YuGuA0xc3W8gBcA=;
        b=uJtC6HpwIKuKcHC21NsrGDkthzGWVvdWdkrSG2AFK7hkIpLpjN3aKrq9MTISVBI/yO
         awz21bAnLzX2zsCiZWFATRj4dkk4DLq/RJYKjoeRIJ40lFpS181ZOgAUNeYYlqj55TCS
         tNCsdpglqzN7o9CLk6UxrY2Rabz1oFGoQJ8qH+fIYlSartFpB1Zi+vewtpN8+wU6Do6K
         AHpL111ki/k3EKoJRgnJQAIFsEcUMfAdYFh8gKE7aKQUfVb4vhIrABLTxOa11ySd/5xK
         zFmI4wUAe/reA0731oQwj/6fhkEe3TiHfoCq7mbCxXFmEDoZ9IEz0DnzxaBi4XoFhIkq
         /WtA==
X-Gm-Message-State: AOJu0YzUuRlZGxVMGIF1lUN5R4ajiCFDkDIpvQLD838QIWSSlmZgaSXQ
        jkFKQEO9vMT72F1O9YEvobVuYE+FX8IAm+PLFJZWWLnrrdBCS28Bd80c8yM4P4TX/vUs0iU90NL
        JapOHkierpybIqtyBhNuE64HY
X-Received: by 2002:ac8:7741:0:b0:41e:49e9:fb18 with SMTP id g1-20020ac87741000000b0041e49e9fb18mr9885708qtu.0.1698696936579;
        Mon, 30 Oct 2023 13:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs/cy69WMD8RMOzsYnwFgEjabUeRS+JD6QpbuLnR8oduRqMTqj5/ONfwGS8jweyifSfqP8yQ==
X-Received: by 2002:ac8:7741:0:b0:41e:49e9:fb18 with SMTP id g1-20020ac87741000000b0041e49e9fb18mr9885676qtu.0.1698696936116;
        Mon, 30 Oct 2023 13:15:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j15-20020a05622a038f00b00410a9dd3d88sm3671836qtx.68.2023.10.30.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:15:35 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:15:13 -0400
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
Subject: Re: [PATCH v4 1/5] mm/rmap: support move to different root anon_vma
 in folio_move_anon_rmap()
Message-ID: <ZUAO0RpbbXurwANo@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231028003819.652322-2-surenb@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:38:11PM -0700, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> For now, folio_move_anon_rmap() was only used to move a folio to a
> different anon_vma after fork(), whereby the root anon_vma stayed
> unchanged. For that, it was sufficient to hold the folio lock when
> calling folio_move_anon_rmap().
> 
> However, we want to make use of folio_move_anon_rmap() to move folios
> between VMAs that have a different root anon_vma. As folio_referenced()
> performs an RMAP walk without holding the folio lock but only holding the
> anon_vma in read mode, holding the folio lock is insufficient.
> 
> When moving to an anon_vma with a different root anon_vma, we'll have to
> hold both, the folio lock and the anon_vma lock in write mode.
> Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
> read-lock the anon_vma, we have to re-check if the mapping was changed
> in the meantime. If that was the case, we have to retry.
> 
> Note that folio_move_anon_rmap() must only be called if the anon page is
> exclusive to a process, and must not be called on KSM folios.
> 
> This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
> the anon_vma lock in write mode, and the mmap_lock in read mode.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

