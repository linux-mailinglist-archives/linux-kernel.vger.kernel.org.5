Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED277D494
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbjHOUrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbjHOUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C51FFF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692132336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZM8Vus7SYRyjZ9hahA/SIHNX1amWb1Q96RY2XciYRCo=;
        b=bLTf5Gjyx3AZ3iIFcTN+THnnCkyC+nn+EUb2bU7Nex2Gyb0SrRhOgeZfGxOnFNxtWjXxwL
        mQXRcYGNH3msXJfVcNrpKu0CYsdr/Vi+ZZmXAhx348lL3YI4caiXSeKWbpiaZ9ftG/vzZL
        GImvWL+SKPdezyR9XxSS1lS7KDVQwwM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-HZfaK1BCPxqThHVQBWaqhg-1; Tue, 15 Aug 2023 16:39:24 -0400
X-MC-Unique: HZfaK1BCPxqThHVQBWaqhg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40fd74104f3so11052891cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131964; x=1692736764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM8Vus7SYRyjZ9hahA/SIHNX1amWb1Q96RY2XciYRCo=;
        b=SBQ7Uk5ey3i7B5tlghPjd0PRsy3YfCfw9mqp2RHDuZEHNCMnja0S0OohS6bYJvOA1h
         EtNKuFPZKudJhUApkitvUOvFhczAhx8puR9WM8mL6r5oYnLcYqrYe7JoQPD0Z54HDi5z
         ikf+aCVRgyg1G9SfCtKCgfQ4HpiSODuLG0kuSMA34+nk6jcvrPyzo2sg9IbM+sutlBeQ
         4EkIb/vvqmq1ZdcT7t0J9u4l6OOCWPv3JWi5IOCq/VpyCUysnPuJm3utZtMkwncYRpzy
         PYJ5C4uA/tWXnsdUgruunzYJ97sS39N7rcI0AuhOqa+Vm4sYQvv1XF1lX+J+505qxAQz
         E8IA==
X-Gm-Message-State: AOJu0Ywml4cPGDJJFfM8dcWgFkU9Ix5tH1sP3rYbqFLpP7rMTJU36ONu
        Ueqpc6191jv455OAW/xoDkPyk5MtyKqW4JbCAsnWfPZ7Cp5GV25a/9R1m2wmOIR7lQ+pr0iwKFG
        pkllRNuLH86u2vfm/mJFeOu8+
X-Received: by 2002:a05:622a:1a8e:b0:40f:e384:b560 with SMTP id s14-20020a05622a1a8e00b0040fe384b560mr18711833qtc.1.1692131964068;
        Tue, 15 Aug 2023 13:39:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtIAvbXXGEWNKvGaw16dmndy+4r/NC90p8M86FWmqv/yu68WwM5HI6X1kIy7z48YNh6BshRw==
X-Received: by 2002:a05:622a:1a8e:b0:40f:e384:b560 with SMTP id s14-20020a05622a1a8e00b0040fe384b560mr18711822qtc.1.1692131963761;
        Tue, 15 Aug 2023 13:39:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id m19-20020ac86893000000b00403cce833eesm4011916qtq.27.2023.08.15.13.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:39:23 -0700 (PDT)
Date:   Tue, 15 Aug 2023 16:39:16 -0400
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
Message-ID: <ZNvidA8/FkfHk/YU@x1n>
References: <20230814184411.330496-1-peterx@redhat.com>
 <ZNqHdIi8ySqwoswd@casper.infradead.org>
 <ZNqM43Y9Pa1S8N7D@x1n>
 <ZNr08E5bublfQI0J@casper.infradead.org>
 <ZNvT8aFemCdtTpBo@x1n>
 <ZNvdL/3kzIcJWKku@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNvdL/3kzIcJWKku@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:16:47PM +0100, Matthew Wilcox wrote:
> No, sometimes there are things which shouldn't be documented because they
> don't matter, and when changing code sometimes we forget to change the
> documentation, and then people read the documentation which is different
> from the code, and they get confused.
> 
> It matters that the various 'private' members line up.  It matters
> that folio->index matches page->index.  It does not matter what
> offset _entire_mapcount is at.  That can be moved around freely and no
> documentation needs to be changed.
> 
> I don't want you to use FOLIO_MATCH to make any unnecessary assertions.
> The only assertion missing is for _private_1 and _private_2a, and that's
> why I wrote a patch to add them.

I didn't mean to add assertions for _entire_mapcount (I don't even know
how..), but _mapcount and _refcount to clamp the fields, then all fields
can be clear, just like head/flags clamping the start of fields.

One thing I can understand that you'd like to avoid these "offset" things
is perhaps because you keep that in mind to, one day, have mmdesc replacing
folio so folio doesn't need to match struct page at all some day,
ideally. The order of fields, size of fields, etc. none of them should
matter, when it comes, and we should go toward that.  However my argument
would be that, before that day comes IMHO we need some good documentation
for us to know how the fields look like now, why they worked, and how to
reuse new fields.. when that comes, we can just safely remove these
documentations.

It's just that these 'offset's still matter and matters a lot now, imho,
but it's very confusing when read without some help.

Let me try one more time to see how you think about it on an rfcv3.  If
that still doesn't get any form of ack from you, I'll put this aside.

-- 
Peter Xu

