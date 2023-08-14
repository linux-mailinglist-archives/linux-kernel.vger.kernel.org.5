Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3780577C171
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjHNUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjHNUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A23A11D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692044519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjIaM5pS4IcfSWwLmVHVLlHG83Gxh90rbrqnmEqqDrE=;
        b=b5qvhp6OM8wdtGGzEle9IdGwCVvwGKh/yjkwrDJAtcVqGCBhYpQv4LpfcIuV7FrJIf+p7g
        4qgzwmnxMer805C4Ge5MXpKMT7MqCd1x5W3I2XbjIqTcOR1QY8kVbQhrTCC//xPDkdc4Yx
        Abf+mt2Tbqf+AQjRdkp46oWkij7Diqc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-ssgVjCIJP5quNULEOxwqGw-1; Mon, 14 Aug 2023 16:21:58 -0400
X-MC-Unique: ssgVjCIJP5quNULEOxwqGw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76cf85654a6so118193885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044518; x=1692649318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjIaM5pS4IcfSWwLmVHVLlHG83Gxh90rbrqnmEqqDrE=;
        b=MzL2qqbMu5tIXe6Gki4I+fLpZe0uqgdgFv/fb9DkqIH5336/A+c/1X3V57ZOnrJ+JY
         SkfDeid5/d2eoUZBAuJfRsjTKq+8hTUDTudbKdvzH41svExmvD4Jf4VWWXZpTDNCm5XF
         a/mE2OufbbRPBfo7DgoBtT9WU1bARhZuXEwiMuCz3qfcpU7F4yJr+hCpv9AbZFvsn71j
         JxtHgiUqyZLw5VnNX7zlq0CFFhkTgCv0UGrrHjFxiiDWUsqvUdjV/L4Y2pH5ul5YS5lf
         qTTnYV34mc/4rE3QXTPOf8HX0lNr7MiPDtX+Uq5aZha3SRzxCyd1RaPELy31SlfqfcRm
         lyyQ==
X-Gm-Message-State: AOJu0YyG4KHyIdqvE412de7ojDUN5DEMiYOM3RXeDZgo+FQ7pye9poa1
        JNf5jrM8AEAWWDosXQrv2qJrN7nKiSGwCalbwDEzXiyW8wHezVTIE89x2Rkv2VedQj15O5DnAQT
        n4WqP2bzbzaoTXXSoHZnxA+EE
X-Received: by 2002:a05:620a:170d:b0:76c:f408:6ba6 with SMTP id az13-20020a05620a170d00b0076cf4086ba6mr14812254qkb.2.1692044518076;
        Mon, 14 Aug 2023 13:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfkOOVytY0aBOxkjY3FcQIE3K9VJXH3LQMj6PIPTCx35Eq3D4/zL+o0y8ptn3FX3A0gAXonA==
X-Received: by 2002:a05:620a:170d:b0:76c:f408:6ba6 with SMTP id az13-20020a05620a170d00b0076cf4086ba6mr14812237qkb.2.1692044517797;
        Mon, 14 Aug 2023 13:21:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id pa40-20020a05620a832800b0076c97ae43b9sm3248456qkn.66.2023.08.14.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:21:57 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:21:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 0/3] mm: Properly document tail pages for a folio
Message-ID: <ZNqM43Y9Pa1S8N7D@x1n>
References: <20230814184411.330496-1-peterx@redhat.com>
 <ZNqHdIi8ySqwoswd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNqHdIi8ySqwoswd@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 08:58:44PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 14, 2023 at 02:44:08PM -0400, Peter Xu wrote:
> 
> Look, this is all still too complicated.  And you're trying to make
> something better that I'm trying to make disappear.  I'd really rather
> you spent your time worrying about making userfaultfd use folios
> than faffing with this.

I saw that internally some of uffd already start to use folio, while I
don't think the syscall part needs changing yet - the ranged API should
work for folio when it comes, and other than that folio should be hidden
and transparent, afaiu.

Do you mean when large folios can land on anon/shmem we can start to
allocate large folios there for uffd operations?  Or something else?

> 
> How about this?

I still prefer my version, sorry. But I agree this is better than nothing
to guide what's free to use - it's really not obvious to me, and I suppose
true to most people.  Besides..

> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e74ce4a28cd..873285bb5d45 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -334,11 +334,14 @@ struct folio {
>  	/* public: */
>  			unsigned char _folio_dtor;
>  			unsigned char _folio_order;
> +			/* two bytes available here */
>  			atomic_t _entire_mapcount;
>  			atomic_t _nr_pages_mapped;
>  			atomic_t _pincount;
> +			/* no more space on 32-bt */
>  #ifdef CONFIG_64BIT
>  			unsigned int _folio_nr_pages;
> +			/* twelve bytes available on 64-bit */
>  #endif
>  	/* private: the union with struct page is transitional */
>  		};
> @@ -360,6 +363,7 @@ struct folio {
>  			unsigned long _head_2a;
>  	/* public: */
>  			struct list_head _deferred_list;
> +			/* three more words available here */

.. not really three more words here but 2 for 32 bits and 1 for 64 bits.
In my patch 3 I used "8 bytes free" so it's applicable to both.

I can figure it out in ten seconds now with my documents..

	 * |--------+-------------+-------------------|
	 * |  index | 32 bits     | 64 bits           |
	 * |--------+-------------+-------------------|
	 * |      0 | flags       | flags             |
	 * |      1 | head        | head              |
	 * |      2 | FREE        | FREE              |
	 * |      3 | FREE [1]    | FREE [1]          |
	 * |      4 | FREE        | FREE              |
	 * |      5 | FREE        | private [2]       |
	 * |      6 | mapcnt      | mapcnt+refcnt [3] |
	 * |      7 | refcnt [3]  |                   |
	 * |--------+-------------+-------------------|

Then...

	/* public: WORD 2-3 */
			struct list_head _deferred_list;
        <----- so after this we have WORDs 4/5 free on 32bits and 4 only on
               64 bits, because WORD 5 is used on 64bits

... but I won't be able to if without these documents.  I hope it justifies
that it's still worthwhile.

Thanks,

-- 
Peter Xu

