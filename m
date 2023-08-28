Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F130A78AE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjH1K6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjH1K5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD132697
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693220151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CDS5fHYB73gNpd3JPwWKsT/4mQsPDNUXrtDTPKScZC0=;
        b=QX8USWcwC845R48cHY/JL9Zflc+O6vBR8l0vHYxMZet2Wl3jYY7cfw3jGsH6rmzBFhIHcb
        H6XJGbud4IAfh3DqjTmpk4aJURh+pKBjsGbPMXxNm7go9nAw+fSkn/CEFdToz8Ejc0f+MY
        y8EPs1oMF7kj23Jak6NxraEOQmaMtVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-7Ut3NBFGP7OOUFeewqOryQ-1; Mon, 28 Aug 2023 06:55:45 -0400
X-MC-Unique: 7Ut3NBFGP7OOUFeewqOryQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F75E857A84;
        Mon, 28 Aug 2023 10:55:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9089A40C6F4E;
        Mon, 28 Aug 2023 10:55:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 28 Aug 2023 12:54:57 +0200 (CEST)
Date:   Mon, 28 Aug 2023 12:54:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Yonghong Song <yonghong.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Message-ID: <20230828105453.GB19186@redhat.com>
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com>
 <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
 <20230827201909.GC28645@redhat.com>
 <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27, Yonghong Song wrote:
>
> On 8/27/23 1:19 PM, Oleg Nesterov wrote:
> >
> >But. if the group leader M exits then M->files == NULL. And in this case
> >task_seq_get_next() will need to "inspect" all the sub-threads even if they all
> >have the same ->files pointer.
>
> That is correct. I do not have practical experience on how much
> possibility this scenario may happen. I assume it should be very low.

Yes. I just tried to explain why the ->files check looks confusing to me.
Nevermind.

Could you review 6/6 as well?

Should I fold 1-5 into a single patch? I tried to document every change
and simplify the review, but I do not want to blow the git history.

Oleg.

