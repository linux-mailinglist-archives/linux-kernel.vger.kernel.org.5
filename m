Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348E37871A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbjHXOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbjHXOcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86537193
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692887524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=IGN5BwTI1TXj5JXf6RrJi9vBUlcqrrCxhe7qXqGGUHI=;
        b=dRB+QJlVDX9kF7XWk6vauxVvwEreUxpz4rj4LD1Q6rcLp3jWI0VaMISh5zhcLDK7Wj/+Yu
        d+woHZ3HZqi4wwOwYRXYz9efVvGqXdWDrHT12vI1NBg5rn5Bpe1YGgw2O0KYgFbatu7RHM
        V+qze2ejizVNvhdiQE/tPA8/JlnP7/A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-L7PzL2hePUKCFphb3FajfQ-1; Thu, 24 Aug 2023 10:32:01 -0400
X-MC-Unique: L7PzL2hePUKCFphb3FajfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57D5B1C09A46;
        Thu, 24 Aug 2023 14:32:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3530A2026D68;
        Thu, 24 Aug 2023 14:31:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 24 Aug 2023 16:31:14 +0200 (CEST)
Date:   Thu, 24 Aug 2023 16:31:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterz@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] introduce __next_thread(), change next_thread()
Message-ID: <20230824143112.GA31208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After document-while_each_thread-change-first_tid-to-use-for_each_thread.patch
in mm tree + this series

1. We have only one lockless user of next_thread(), task_group_seq_get_next().
   I think it should be changed too.

2. We have only one user of task_struct->thread_group, thread_group_empty().
   The next patches will change thread_group_empty() and kill ->thread_group.

Oleg.

