Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7F78210A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjHUBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHUBOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E199
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692580440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KBMy+oo3AOKwSxPpgU96xyHXBBu1SbBgI380JczmmIY=;
        b=Ls26SvnrLhjc9vRttr3MSlV1RXYwOwd6ZsPdx/WRR3KO2OBKUjDsoyvBTEt4sPvy83NsKX
        xsnAQjLRHyTZJwXWhCcTOPvQl5miCPxcRSB2hS0ECQ+0PQA+jqgSjeNZeTxJOGqlqZ9pVF
        tMalYBVemzAIWbPj0ztCHAQ8nVFzqPs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-WyHqVo-aP-mSktZazO6q_g-1; Sun, 20 Aug 2023 21:13:58 -0400
X-MC-Unique: WyHqVo-aP-mSktZazO6q_g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6472b47d54bso10515886d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692580438; x=1693185238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBMy+oo3AOKwSxPpgU96xyHXBBu1SbBgI380JczmmIY=;
        b=LiWxKhXU4pv6D2zxGPbuu3mnxRvig03tKIMitVczAcb+8ihMDWM0A5d3OC3MAYXXet
         fwc49c/56A6P2p9dCjj/Il/oym6Adc374Wud+Jy5/M530336Ul0GSwdZ7HtA7stLTFjd
         X7ORPCvRFPxCy7lrOA+2+gTCxLTwtklQunQCgbEcTtpND3Ux50iwaq6fvN47qeuTWl7J
         slAK5ViicPzoZsc+DAnzA1WmTs9l3yVja3uAjp+Eoa2JuG3+vbM1ygCqIAs1Rhgw83KR
         Qx/Rr+ZkmY/DRFnHFzZ23gApSt0Z5aKB6bgW0FVow2mybXIrbehjkK8x1yTvI6hpUVU7
         kuUQ==
X-Gm-Message-State: AOJu0YxcS616S+Pib/WF23874g3nzH9DxH9aAxyM6iSmHilRZObKAl6/
        V0qm/uHqoF5szaNhfbR8D9EOgUY9OLIvyFEaNS0/WAE/ro6c0CTM8Ms6t90Cr4IqmXF7nc+m0ZU
        iYjasVzUXeaeCqW9wd1cot7sz
X-Received: by 2002:ad4:5ba4:0:b0:63c:f852:aa3a with SMTP id 4-20020ad45ba4000000b0063cf852aa3amr7066772qvq.4.1692580438230;
        Sun, 20 Aug 2023 18:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE83FB4TY2zyV41hh07rpKvx6ICHUmv9wlI7ofmsjarLdBFlA4wp2hip7TbUZpeOJv5v32R3g==
X-Received: by 2002:ad4:5ba4:0:b0:63c:f852:aa3a with SMTP id 4-20020ad45ba4000000b0063cf852aa3amr7066732qvq.4.1692580436859;
        Sun, 20 Aug 2023 18:13:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cf1d2000000b006490c2624basm2545336qvl.47.2023.08.20.18.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 18:13:56 -0700 (PDT)
Date:   Sun, 20 Aug 2023 21:13:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Wire up tail page poisoning over ->mappings
Message-ID: <ZOK6U4vOFn8IbcGp@x1n>
References: <20230815210659.430010-1-peterx@redhat.com>
 <ZN/tRLy0e+Iod9z3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZN/tRLy0e+Iod9z3@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:14:28PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 15, 2023 at 05:06:59PM -0400, Peter Xu wrote:
> > I split this out from another rfc series.  Removed RFC tag because it
> > wasn't for this patch but for the documentation updates.  I'll post the rfc
> > part alone.  Comments welcomed, thanks.
> 
> I still hate it, as I explained here:

I still prefer it be merged.

> 
> https://lore.kernel.org/linux-mm/ZNp7yUgUrIpILnXu@casper.infradead.org/

https://lore.kernel.org/linux-mm/ZNqFv0AwkfDKExiw@x1n/#t

Firstly, I've answered and you didn't follow that up.

This is not identical to that version, it added one more change to remove
the other hard coded "2" 

> 
> > > + * When the tail page's mapping field reused, it'll be exempted from
> > > + * ->mapping poisoning and checks.  Also see the macro TAIL_MAPPING.
> > > + */
> > > +#define  TAIL_MAPPING_REUSED_MAX  (2)
> > 
> > More importantly, I think this is over-parametrisation.  If you start to
> > use extra fields in struct folio, just change the code in page_alloc.c
> > directly.

Change the hard-coded "2"s in different functions?  Can you kindly explain
why can't we just have a macro to help?

Setting tail mapping for tail 1/2 is even wrong, which part of this patch
fixes:

@@ -428,7 +428,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 {
        struct page *p = head + tail_idx;

-       p->mapping = TAIL_MAPPING;
+       if (tail_idx > TAIL_MAPPING_REUSED_MAX)
+               p->mapping = TAIL_MAPPING;
        set_compound_head(p, head);
        set_page_private(p, 0);
 }

Do you mean you prefer me to add one more hard-coded "2" and "just boost it
when it's needed"?

Thanks,

-- 
Peter Xu

