Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40E77BD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjHNQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjHNP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C512D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692028747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+ZzZLXft52nTXc/yGHvjzSyoTfsadVMBZSnkMauBwU=;
        b=alARDBQeVMwiHSCHAVmPwCAL7GJ0MmYXjRi6ohSmS1CEb06/OI51GZ70m/t7oGSv5rLfZb
        t2WZzgrNpOWThWfeX84voprNvFGOUx4GckqLXNsgsLUWw/+8gMxaqr9gGAeNG1PL+ojZ0A
        HlpxKBMB6d9LLQIhNr7ojr7N1st5e80=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-LYfPDIfUMVCE_zyxgtWkkw-1; Mon, 14 Aug 2023 11:59:03 -0400
X-MC-Unique: LYfPDIfUMVCE_zyxgtWkkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44E972A59577;
        Mon, 14 Aug 2023 15:59:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id E7D652166B25;
        Mon, 14 Aug 2023 15:59:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 14 Aug 2023 17:58:20 +0200 (CEST)
Date:   Mon, 14 Aug 2023 17:58:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, koct9i@gmail.com, dave@stgolabs.net
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file
 replacement
Message-ID: <20230814155817.GC17738@redhat.com>
References: <20230813123333.1705833-1-mjguzik@gmail.com>
 <20230814150530.GB17738@redhat.com>
 <20230814152038.GA2367@redhat.com>
 <52192c2f-c7b1-9c07-7ca2-10fc6bd347b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52192c2f-c7b1-9c07-7ca2-10fc6bd347b0@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, David Hildenbrand wrote:
>
> >OK, I seem to understand... without mmap_read_lock() it is possible that
> >
> >	- dup_mm_exe_file() sees mm->exe_file = old_exe_file
> >
> >	- replace_mm_exe_file() does allow_write_access(old_exe_file)
> >
> >	- another process does get_write_access(old_exe_file)
> >
> >	- dup_mm_exe_file()->deny_write_access() fails
> >
> >Right?
>
> From what I recall, yes.

Thanks! but then... David, this all is subjective, feel free to ignore, but
the current code doesn't look good to me, I mean the purpose of mmap_read_lock()
is very unclear. To me something like

	if (old_exe_file) {
		/*
		 * Ensure that if we race with dup_mm_exe_file() and it sees
		 * mm->exe_file == old_exe_file deny_write_access(old_exe_file)
		 * can't fail after we do allow_write_access() and another task
		 * does get_write_access(old_exe_file).
		 */
		mmap_read_lock(mm);
		mmap_read_unlock(mm);

		allow_write_access(old_exe_file);
		fput(old_exe_file);
	}

looks more understandable...



But this patch from Mateusz looks even better to me. So, FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>

