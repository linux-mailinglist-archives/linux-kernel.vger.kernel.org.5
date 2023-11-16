Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA0B7EE4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjKPPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjKPPxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D71101
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700149998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lHUKvjwQrjXQEAVtUnOqPty0/WpF2RSZ6CP33ILo6BU=;
        b=cXcIT2vBcdAB7AznJs9aaRqv/DXr+CHYkewZ7p5Fc+ZKeWGikrBHAK4mUKPHvgop8DTYKA
        4fcSkzb/D/KaRZcVA6Ni0CgC8+S8qaWghPDQa1Q38DjSgzIHG8D9O+VxT/JvwoydJK5tIS
        F3EJJZ/rLCtJ0+u7EZT0VVGN6/1KOyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-tXaJjjbrOpi8udMbc6GSuQ-1; Thu, 16 Nov 2023 10:53:16 -0500
X-MC-Unique: tXaJjjbrOpi8udMbc6GSuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FA36185A785;
        Thu, 16 Nov 2023 15:53:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70FFD5036;
        Thu, 16 Nov 2023 15:53:15 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] afs: Miscellaneous small fixes
Date:   Thu, 16 Nov 2023 15:53:07 +0000
Message-ID: <20231116155312.156593-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Here are a set of miscellaneous small fixes to the afs filesystem
including:

 (1) Fix the afs_server_list struct to be cleaned up with RCU.

 (2) Fix afs to translate a no-data result from a DNS lookup into ENOENT,
     not EDESTADDRREQ for consistency with OpenAFS.

 (3) Fix afs to translate a negative DNS lookup result into ENOENT rather
     than EDESTADDRREQ.

 (4) Fix file locking on R/O volumes to operate in local mode as the server
     doesn't handle exclusive locks on such files.

 (5) Not a fix per se, but set SB_RDONLY on superblocks for RO and Backup
     volumes so that the VFS can see that they're read only.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

David Howells (5):
  afs: Fix afs_server_list to be cleaned up with RCU
  afs: Make error on cell lookup failure consistent with OpenAFS
  afs: Return ENOENT if no cell DNS record can be found
  afs: Fix file locking on R/O volumes to operate in local mode
  afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY

 fs/afs/dynroot.c     |  4 ++--
 fs/afs/internal.h    |  1 +
 fs/afs/server_list.c |  2 +-
 fs/afs/super.c       |  4 ++++
 fs/afs/vl_rotate.c   | 10 ++++++++++
 5 files changed, 18 insertions(+), 3 deletions(-)

