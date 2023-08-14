Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7677BCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjHNPWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHNPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB9E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692026488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/V5w2sP0PQIzPQLgm9IttuFV+XYMXraW+Ku5dve1XcM=;
        b=AXLQNPsD510HvDYJPDqc+BtZVloY7CLXBP2RjpmvqKTcCBKkHE2bRVEYEFJmmYIHNHE6Zq
        /HuFvgj8eVkhCTR6ECkpL9j5BlgZyNEgItielGgkJ6mUNyg9CLfiuO6OBFPpCvEDrS5syI
        ycjobuhaiwCl2YPQgVgFZLzphbvvew4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-24Y3TeWKMRGd1quSiVtWPw-1; Mon, 14 Aug 2023 11:21:25 -0400
X-MC-Unique: 24Y3TeWKMRGd1quSiVtWPw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B15A985CCE7;
        Mon, 14 Aug 2023 15:21:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E01C492C13;
        Mon, 14 Aug 2023 15:21:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Aug 2023 17:20:42 +0200 (CEST)
Date:   Mon, 14 Aug 2023 17:20:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com, david@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        dave@stgolabs.net
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
Message-ID: <20230814152038.GA2367@redhat.com>
References: <20230813123333.1705833-1-mjguzik@gmail.com>
 <20230814150530.GB17738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814150530.GB17738@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, Oleg Nesterov wrote:
>
> On 08/13, Mateusz Guzik wrote:
> >
> > fe69d560b5bd ("kernel/fork: always deny write access to current MM
> > exe_file") added another lock trip to synchronize the state of exe_file
> > against fork, further defeating the point of xchg.
> >
> > As such I think the atomic here only adds complexity for no benefit.
> >
> > Just write-lock around the replacement.
>
> Well, I tend to agree but can't really comment because I forgot everything
> about these code paths.
>
> But I have to admit that I don't understand the code in replace_mm_exe_file()
> without this patch...
>
> 	old_exe_file = xchg(&mm->exe_file, new_exe_file);
> 	if (old_exe_file) {
> 		/*
> 		 * Don't race with dup_mmap() getting the file and disallowing
> 		 * write access while someone might open the file writable.
> 		 */
> 		mmap_read_lock(mm);
> 		allow_write_access(old_exe_file);
> 		fput(old_exe_file);
> 		mmap_read_unlock(mm);
> 	}
>
> Can someone please explain me which exactly race this mmap_read_lock() tries
> to avoid and how ?

OK, I seem to understand... without mmap_read_lock() it is possible that

	- dup_mm_exe_file() sees mm->exe_file = old_exe_file

	- replace_mm_exe_file() does allow_write_access(old_exe_file)

	- another process does get_write_access(old_exe_file)

	- dup_mm_exe_file()->deny_write_access() fails

Right?

Or something else?

Well to me Mateusz's patch does make this logic more clear ;)

Oleg.

