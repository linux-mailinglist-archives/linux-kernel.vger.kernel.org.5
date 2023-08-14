Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FDF77BC68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjHNPHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjHNPHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971BE6A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692025581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=coKMnWWCWtqJjCTkHa6gz6tSlFtfIxurPrU2OkeVbd0=;
        b=G9sVuXeZOD3tLO+8exYYE3WAUSbt/nXtWsO0hVyI+oW9Xf5+wKq9VNmP20tfFGbEmy+KPi
        Ha+jGQc5m6Ra+uQc+DPjnLID6rzhSN/XB1NcTe2SLt95utVUrUX/8WQzglR5wSGaCiaCKe
        fEkZtdHgHNjInSUyp95E3a1iIsPqk/Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-I0CXlIs1MWeF5tyF_66jfg-1; Mon, 14 Aug 2023 11:06:17 -0400
X-MC-Unique: I0CXlIs1MWeF5tyF_66jfg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7338299E749;
        Mon, 14 Aug 2023 15:06:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 731A8492C13;
        Mon, 14 Aug 2023 15:06:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Aug 2023 17:05:34 +0200 (CEST)
Date:   Mon, 14 Aug 2023 17:05:31 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com, david@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        dave@stgolabs.net
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
Message-ID: <20230814150530.GB17738@redhat.com>
References: <20230813123333.1705833-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813123333.1705833-1-mjguzik@gmail.com>
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

On 08/13, Mateusz Guzik wrote:
>
> fe69d560b5bd ("kernel/fork: always deny write access to current MM
> exe_file") added another lock trip to synchronize the state of exe_file
> against fork, further defeating the point of xchg.
>
> As such I think the atomic here only adds complexity for no benefit.
>
> Just write-lock around the replacement.

Well, I tend to agree but can't really comment because I forgot everything
about these code paths.

But I have to admit that I don't understand the code in replace_mm_exe_file()
without this patch...

	old_exe_file = xchg(&mm->exe_file, new_exe_file);
	if (old_exe_file) {
		/*
		 * Don't race with dup_mmap() getting the file and disallowing
		 * write access while someone might open the file writable.
		 */
		mmap_read_lock(mm);
		allow_write_access(old_exe_file);
		fput(old_exe_file);
		mmap_read_unlock(mm);
	}

Can someone please explain me which exactly race this mmap_read_lock() tries
to avoid and how ?

Oleg.

