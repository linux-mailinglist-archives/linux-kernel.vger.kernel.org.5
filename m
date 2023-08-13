Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA9577A461
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 02:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjHMAyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 20:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMAyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:54:07 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812F1706;
        Sat, 12 Aug 2023 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N707t0UnjD5n1c6jBmliOTt/74LPyhSTOmgkCoyTu4E=; b=hAInYZ6VTXQMVGAKjaW+4jr1fi
        KrSKOfVFyAkIfAs61blmYZ0BzFR/oyGtiLnMCvmSpiZUYmok0nIRUDIP0iPUwN/El9wUYAWztKbk9
        XGgOWAgYML3WMbMsLOvLHYa8vLjGx2kaAcGjp8ZIhjQTeCMqTe1rMdvfOCcky6Xeok1viXOMlvMZy
        lbuX4UAD4fvBUrIQh8CQZvUs0GF6DJ5+FRyYBKLSZJ12PUOg6/IaNxwkjFRjzxf99AbEogZXkFKbu
        C6abvMI1VmIUtb8arQsrc3VdFDsprYJN2g2flcs3gxAQqKm5zUr5Cv5AHCTqkfoCr0N+HYRZHfQW5
        pVKDp4Fg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1qUzMe-006b54-OM; Sun, 13 Aug 2023 00:53:51 +0000
From:   linux@treblig.org
To:     smfrench@gmail.com, dave.kleikamp@oracle.com, tom@talpey.com,
        pc@manguebit.com
Cc:     linkinjeon@kernel.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        krisman@collabora.com, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v4 0/4] dedupe smb unicode files
Date:   Sun, 13 Aug 2023 01:53:40 +0100
Message-ID: <20230813005344.112955-1-linux@treblig.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The smb client and server code have (mostly) duplicated code
for unicode manipulation, in particular upper case handling.

Flatten this lot into shared code.

There's some code that's slightly different between the two, and
I've not attempted to share that - this should be strictly a no
behaviour change set.

In addition, the same tables and code are shared in jfs, however
there's very little testing available for the unicode in there,
so just share the raw data tables.

I suspect there's more UCS-2 code that can be shared, in the NLS code
and in the UCS-2 code used by the EFI interfaces.

Lightly tested with a module and a monolithic build, and just mounting
itself.

This dupe was found using PMD:
  https://pmd.github.io/pmd/pmd_userdocs_cpd.html

Dave

Version 4
  Put SPDX tag back to the way the tools like it, thanks to
    Paulo Alcantara for explaining

Version 3
  History comments simplification (Feedback from Tom Talpey)

Dr. David Alan Gilbert (4):
  fs/smb: Remove unicode 'lower' tables
  fs/smb: Swing unicode common code from smb->NLS
  fs/smb/client: Use common code in client
  fs/jfs: Use common ucs2 upper case table

 fs/jfs/Kconfig                                |   1 +
 fs/jfs/Makefile                               |   2 +-
 fs/jfs/jfs_unicode.h                          |  17 +-
 fs/jfs/jfs_uniupr.c                           | 121 -------
 fs/nls/Kconfig                                |   8 +
 fs/nls/Makefile                               |   1 +
 fs/nls/nls_ucs2_data.h                        |  15 +
 .../server/uniupr.h => nls/nls_ucs2_utils.c}  | 156 +--------
 fs/nls/nls_ucs2_utils.h                       | 285 +++++++++++++++
 fs/smb/client/Kconfig                         |   1 +
 fs/smb/client/cifs_unicode.c                  |   1 -
 fs/smb/client/cifs_unicode.h                  | 330 +-----------------
 fs/smb/client/cifs_uniupr.h                   | 239 -------------
 fs/smb/server/Kconfig                         |   1 +
 fs/smb/server/unicode.c                       |   1 -
 fs/smb/server/unicode.h                       | 325 +----------------
 16 files changed, 340 insertions(+), 1164 deletions(-)
 delete mode 100644 fs/jfs/jfs_uniupr.c
 create mode 100644 fs/nls/nls_ucs2_data.h
 rename fs/{smb/server/uniupr.h => nls/nls_ucs2_utils.c} (50%)
 create mode 100644 fs/nls/nls_ucs2_utils.h
 delete mode 100644 fs/smb/client/cifs_uniupr.h

-- 
2.41.0

