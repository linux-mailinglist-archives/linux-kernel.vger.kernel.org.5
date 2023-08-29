Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8797278C323
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjH2LOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjH2LOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:14:06 -0400
X-Greylist: delayed 582 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 04:14:03 PDT
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [IPv6:2001:638:700:1038::1:9c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DFBC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:14:03 -0700 (PDT)
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id A9D34608B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:04:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de A9D34608B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1693307059; bh=5N/A+0DvouwHnArmn8QDUh8FA/+WhLeTvx3IWkq7Fe0=;
        h=From:To:Cc:Subject:Date:From;
        b=MDTTWqEqcT/bAXaP/WqEV7z5zs1Hw9Z2WMrhSO27Oe/c/5cXXD0oeXTpYwKjbDeii
         PkHVjAlMsy14C+4yvnW995uzY8BvgVY/0QFflZOUHuV7jYBStFu7hs/xjGZM1KkMPD
         bRs6fl5v317YaJGvZhOrlnb0fhqYYFCoC0/i86Ic=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 9BF00A00B3;
        Tue, 29 Aug 2023 13:04:19 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
        by smtp-m-3.desy.de (Postfix) with ESMTP id 88E9E60041;
        Tue, 29 Aug 2023 13:04:19 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
        by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 9261CA0038;
        Tue, 29 Aug 2023 13:04:18 +0200 (CEST)
Received: from os-46-nfs-devel.novalocal (os-46-nfs-devel.desy.de [131.169.46.178])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 1ABCD100045;
        Tue, 29 Aug 2023 13:04:18 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     linux-kernel@vger.kernel.org
Cc:     anna@kernel.org, trond.myklebust@hammerspace.com,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] nfs41: flexfiles: drop dependency between flexfiles layout driver and NFSv3 modules
Date:   Tue, 29 Aug 2023 11:04:11 +0000
Message-Id: <20230829110411.8394-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flexfiles layout driver depends on NFSv3 module as data servers
might be configure to provide nfsv3 only.

Disabling the nfsv3 protocol completely disables the flexfiles layout driver,
however, the data server still might support v4.1 protocol. Thus the strond
couling betwwen flexfiles and nfsv3 modules should be relaxed, as layout driver
will return UNSUPPORTED if not matching protocol is found.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index b6fc169be1b1..ba95246be09e 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -125,7 +125,7 @@ config PNFS_BLOCK
 
 config PNFS_FLEXFILE_LAYOUT
 	tristate
-	depends on NFS_V4_1 && NFS_V3
+	depends on NFS_V4_1
 	default NFS_V4
 
 config NFS_V4_1_IMPLEMENTATION_ID_DOMAIN
-- 
2.39.1

