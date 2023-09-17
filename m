Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9757A360C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjIQPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjIQPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:07:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642A8B6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yg00tVpU+vjQMn/1hNmj20preqlD9DZBFEgxeYCa3yU=; b=t7nd/iCuSHtXZ2FaEsT9s6n1if
        R/CBvLBcc+fP7J1PgImI7gEnnM5uSPNaCuyCdz0U7I/ku0N1gkxnymnzDtgb1sbe5xXdZMptMDBps
        ocpz62mb5RcTPQkD7yigBTUZLjvbfsYE5anFNNSQM3Yzs+j4pDQyW+j0ClhLQ7XJ42tnpZRkYkSz3
        wNtDCvz31kn6WkwiqY/XNSNFHgbOt2YZ5dJprOQ9+PmPAxeiAwhHQqY/rhyuEWBbbwzSbBYEeZJSr
        DbkV2D6HK1TL/xA0o6WD+4Nm+sduyjDwbUNtocrOTsdP9jUcf8ub+Ar2Jjxmf/Gq6BnHJg7csTf6O
        Qcr5TYrQ==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhtML-00DksC-1I;
        Sun, 17 Sep 2023 15:06:53 +0000
Message-ID: <e248c5c8-e55c-46eb-ae8d-f7539cdbeab2@infradead.org>
Date:   Sun, 17 Sep 2023 08:06:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /proc/*/maps broken on nommu
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAMo8BfLb6U9xtMtt1t9vQX_nKek7kEt+Rvv5NwpvTHu0kdiXcg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMo8BfLb6U9xtMtt1t9vQX_nKek7kEt+Rvv5NwpvTHu0kdiXcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/23 04:38, Max Filippov wrote:
> Hello,
> 
> As of v6.5 cat /proc/*/maps produces empty output on nommu xtensa systems.
> Bisection points to the commit 0c563f148043 ("proc: remove VMA rbtree
> use from nommu").
> It looks like the issue may be not in the m_start (where find_vma(mm,
> addr) returns
> NULL), but in the nommu version of find_vma itself. I've tried replacing nommu
> find_vma implementation with an implementation of the MMU version and it
> fixes the /proc/*/maps output. Kind of (it works as expected on one of
> my systems,
> but consistently locks up on the other).
> 
> Any suggestions of what might be wrong/how to fix it properly?
> 

Hi Max,

There is already a proposed patch and some discussion:

https://lore.kernel.org/lkml/20230915160055.971059-2-ben.wolsieffer@hefring.com/

-- 
~Randy
