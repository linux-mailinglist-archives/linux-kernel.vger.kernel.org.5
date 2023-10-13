Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635507C8D72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjJMTFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjJMTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B1183
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697223853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LSa8RIfB8HUiukXJoFl/RC9egsbX37Hy7RQHH6IxQsg=;
        b=P3CrLiBSZKNP5B32lBoKwDGC/wN0CdnZCJwg3lubKqE5jqStHJMe/knWV1gwbwdw8CsI0i
        NKr5fVAU0GBkeVRip3OnkHJ/fjKsutPD/3eRsh9C613qCrtXyHBfA3hGMOYcpL/oFi/rsS
        w5wGe+PQ3vzXZHG6fnLf+aAvozREaTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-iJ50zH8INLqQ5QE5w3DiAA-1; Fri, 13 Oct 2023 15:04:06 -0400
X-MC-Unique: iJ50zH8INLqQ5QE5w3DiAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3114801E62;
        Fri, 13 Oct 2023 19:04:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA522157F5A;
        Fri, 13 Oct 2023 19:04:05 +0000 (UTC)
From:   Audra Mitchell <audra@redhat.com>
To:     linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Fix page_owner's use of free timestamps 
Date:   Fri, 13 Oct 2023 15:03:44 -0400
Message-ID: <20231013190350.579407-1-audra@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While page ower output is used to investigate memory utilization, typically
the allocation pathway, the introduction of timestamps to the page owner 
records caused each record to become unique due to the granularity of the
nanosecond timestamp (for example):

  Page allocated via order 0 ... ts 5206196026 ns, free_ts 5187156703 ns
  Page allocated via order 0 ... ts 5206198540 ns, free_ts 5187162702 ns

Furthermore, the page_owner output only dumps the currently allocated 
records, so having the free timestamps is nonsensical for the typical use 
case.

In addition, the introduction of timestamps was not properly handled in
the page_owner_sort tool causing most use cases to be broken. This series
is meant to remove the free timestamps from the page_owner output and
fix the page_owner_sort tool so proper collation can occur.

Audra Mitchell (5):
  mm/page_owner: Remove free_ts from page_owner output
  tools/mm: Remove references to free_ts from page_owner_sort
  tools/mm: Filter out timestamps for correct collation
  tools/mm: Fix the default case for page_owner_sort
  tools/mm: Update the usage output to be more organized

 mm/page_owner.c            |   4 +-
 tools/mm/page_owner_sort.c | 212 +++++++++++++++++--------------------
 2 files changed, 100 insertions(+), 116 deletions(-)

-- 
2.41.0

