Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD07777E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHJMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjHJMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F161736
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691669497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TpYnbvJHiBn5GPlTGiJdN6VmHzW1BkIuCw6pPI/4rqY=;
        b=T0rnfuHt7SZa7n4XejgIhdblhLGSVRRvR7rHGCQDR3nbCxzmmF0XNpo//9nSJbKprC3038
        NyuRLLrerVJrkgrYbPQjzmI+jlSFe+KU/FcmnMk4NQ5r2jjAhA2GkVMgTD71Cn5YZWOu8b
        LZa4Jxs3F7Ruf7fYF6LdpaKJ0mFRu9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-CzQVt2oYO0WOF0UNjydOeA-1; Thu, 10 Aug 2023 08:11:34 -0400
X-MC-Unique: CzQVt2oYO0WOF0UNjydOeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D39D9101A528;
        Thu, 10 Aug 2023 12:11:33 +0000 (UTC)
Received: from o.redhat.com (unknown [10.39.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25D8640C2076;
        Thu, 10 Aug 2023 12:11:33 +0000 (UTC)
From:   heinzm@redhat.com
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, xni@redhat.com
Subject: [PATCH 0/3] md raid1: Fix writebehind/writemostly
Date:   Thu, 10 Aug 2023 14:11:29 +0200
Message-ID: <cover.1691592775.git.heinzm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

From: heinzm <heinzm@redhat.com>

Writemostly was only respected if set on the first leg.

Set on any other leg(s) but not on the first one did
not enable writebehind at all.

Fix changes the logic using the already defind bool writebehind.

Whilst on this, also make first_clone a bool as write_behind for
consistency and add an empty line.

Patches pass the MD test suite.

heinzm (3):
  md raid1: allow writebehind to work on any leg device set WriteMostly
  md raid1: make first_clone a bool
  md raid1: add empty line

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Tested-by: Xia Ni <xni@redhat.com>

 drivers/md/raid1.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.41.0

