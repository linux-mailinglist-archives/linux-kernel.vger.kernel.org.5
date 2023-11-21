Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AA57F2B57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjKULCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjKULCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:02:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E3A11A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:02:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFC37C433C9;
        Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700564549;
        bh=mLo7DVRk6BC2SJHa6E2iWbSrid7500eOVL41NJVj/3c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=QLgMT8nB2Jww97e94Mvrs70nJNdtyxszgJ2v6Y0Ls0lbVk8VznTguxd7nwwuurZaF
         ZVSp1EFauFXUOX4/XtYwYxPOqb/DFuG1ugoxsFQIiwERDUH2nyF3VvczWgkuRgU/wy
         BRTCC+Lab6Makyj31Hd6+J/bmmJJQ1CDMPNZgmHDuGYVAl8wtzvckB1FGh5zcY9wVa
         A0W/kJZkFvXb82hT01s7Fb4fJkm2TlTxSdiX5h2ub7aioWpgs01Ar3Yn5CE/i0C2hl
         orkN0+/CdZtfpYReA6fNQXCZv1c4EuxGJb0iH6X0b+ugsz6J5S8lEKvDHtfAnjCXx4
         7L/dOb96MbMEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 9601FC61D92;
        Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Tue, 21 Nov 2023 12:02:18 +0100
Subject: [PATCH 1/3] sysctl: Fix out of bounds access for empty sysctl
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-jag-fix_out_of_bounds_insert-v1-1-571e76d51316@samsung.com>
References: <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
In-Reply-To: <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Joel Granados <j.granados@samsung.com>,
        kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=cobreXk3HCy/fe/+taVz5zdST5AE6mBE5tVF2nKN+38=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlXI5DVBUT0AEE24uCwKvehV839kLHwKXyyRo1X
 n8meDbGo/eJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZVyOQwAKCRC6l81St5ZB
 T4XhDACD0sHFiUWwSvOa9ZrJBdLqmlDgBldpLjQgNwAid0IxTK7ZhuqY2kZAFgM25UUthI0iRBO
 npBTvkRcg3sHn8TBXfKcDE+jQSV0LQ+yJvAMyA0dSd3s1prPiaEfm5Q4NDNI8qvEYb1XV8sbzib
 iA083NLadooMh58eAIIucuVqrJhdCRG3G3ytIlRPfPKsLW0QlaqvGeTAhczW+p1nvju6H5f3t8+
 SqMuB1OLNRbL1f/4h9LAx5/UDWIFYWUkKOPNDpWtaGuQsTpkHiP/+4UjA/Nxth0QDwjWIwNFsDB
 a84glm2I6z8ST3FO2mUTSaXPuSF1DO6rragHWh0X+PqyPStu54XjV5+zebqgGDKcF34tS9c6lND
 owIXwGclXEKsNCWFDFAUQAGV7b6vfHr+Fn5HEAaTGl6guJjU+QPKooGQ7pX/A7lq3zeCMcUDDY4
 sGNpqWTiG4YYPOkjiZ4bWgneZHeYTB2o6zuxAulDipeLQc1Y4oVk23geWgXJRDLFpxSnc=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

When registering tables to the sysctl subsystem there is a check to see
if header is a permanently empty directory (used for mounts). This check
evaluates the first element of the ctl_table. This results in an out of
bounds evaluation when registering empty directories.

The function register_sysctl_mount_point now passes a ctl_table of size
1 instead of size 0. It now relies solely on the type to identify
a permanently empty register.

Make sure that the ctl_table has at least one element before testing for
permanent emptiness.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202311201431.57aae8f3-oliver.sang@intel.com
---
 fs/proc/proc_sysctl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index de484195f49f..5b5cdc747cef 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -44,7 +44,7 @@ static struct ctl_table sysctl_mount_point[] = {
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl_sz(path, sysctl_mount_point, 0);
+	return register_sysctl(path, sysctl_mount_point);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
@@ -233,7 +233,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 		return -EROFS;
 
 	/* Am I creating a permanently empty directory? */
-	if (sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
+	if (header->ctl_table_size > 0 &&
+	    sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
 		if (!RB_EMPTY_ROOT(&dir->root))
 			return -EINVAL;
 		sysctl_set_perm_empty_ctl_header(dir_h);
@@ -1213,6 +1214,10 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table_header *tmp_head;
 	struct ctl_table *entry, *link;
 
+	if (header->ctl_table_size == 0 ||
+	    sysctl_is_perm_empty_ctl_table(header->ctl_table))
+		return true;
+
 	/* Are there links available for every entry in table? */
 	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;

-- 
2.30.2

