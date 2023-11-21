Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA27F2BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjKULfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjKULfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:35:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B589C;
        Tue, 21 Nov 2023 03:35:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D49DC433C8;
        Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700566534;
        bh=jp5zupYC3dqga+xgTeyhYepRQqFBsm6KYR9/rvlBnN0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=dIZji/dplIWVDXMi5aBydWZfQhkFwV/nQTmfrcl5/mRjnQ8IwILaUeQ8UPm68icfC
         BsNwKKAwD4Mt8tE9ffWVfx1acO6caUc3cLcE1auhL942JCo1YnOknjqMijgAQ3md2l
         ipf6nYQyBGaPajGL8CPKy5nivCYpEgv3R+OvqSc4pFVWR5zaU/RJAxRIvw9VtWyJm+
         moul2uap0yKQviiDETrNBqVLLbDy/7dCgoamJCUOROKkRWe69TcFLVcHavj5SmRmNq
         2J/fEQslz4sF4ShNOxte6T7bRzX7xXuGTALwkaLpxH9Id+yqFjnoxOcJGJnEMHeB6e
         ugUfPIxZsvl3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED04C61D92;
        Tue, 21 Nov 2023 11:35:34 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Tue, 21 Nov 2023 12:35:11 +0100
Subject: [PATCH v2 1/4] cachefiles: Remove the now superfluous sentinel
 element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-jag-sysctl_remove_empty_elem_fs-v2-1-39eab723a034@samsung.com>
References: <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
In-Reply-To: <20231121-jag-sysctl_remove_empty_elem_fs-v2-0-39eab723a034@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
        fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=SGTnhgVPbRkVEntdcKFq1I6E3blB6PSwrb9JaawnFFQ=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlXJYE8Ks+z491/DTBZVtz2um8J4jG1nLsD8a3B
 DRhcSRgUfiJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZVyWBAAKCRC6l81St5ZB
 T4IADACOW9MROZFdSM+dnh5/wed5cgaNXnrVn0LBPeHAVDiTQemiyGOrKQAda+vo5Xdn9YTJKCa
 PoC+nOKAf7TcIW5+lSdngPBDLY10Rc+onNncfJVs/pcfUcS7fvUdAe7Oii7yRE0pWXLEO8Yi/bl
 ZQddbvSPByuXt05zL+cFNSFJ6o75hORSBWUkTFgcExgCr6JtZHXh8JGoupxp+6NYOo7KGwZQCir
 gkJt7LSjyMQBBxQiG1wv3Oj3xAGIHT0r5K6FbTYG2CKIShmPRQDSLhCwjGE/Yk5oTfToxFyfUZR
 wtRrWYjHIRxQ2NkgszSSTyHULK6/XiQNiTOBISGnR4JeKsg6f2GnYke60yAYM9PEXCijJqfHNpb
 XP4426A5j7PtMZusLfCzoo/RiIvU0lLYYLW4JMuIj6tCKXVpBnxubPiW+7/0D2mysQGJzwu1Q1h
 2BdXU/cbiWKRzPziKe1iPiDUEN1EizspV1wiEqbmZV51Sz42b2uFSBfcXRFn/uWc0eKXs=
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

This commit comes at the tail end of a greater effort to remove the empty
elements at the end of the ctl_table arrays (sentinels) which will reduce the
overall build time size of the kernel and run time memory bloat by ~64 bytes
per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from cachefiles_sysctls

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/cachefiles/error_inject.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/error_inject.c b/fs/cachefiles/error_inject.c
index 18de8a876b02..1715d5ca2b2d 100644
--- a/fs/cachefiles/error_inject.c
+++ b/fs/cachefiles/error_inject.c
@@ -19,7 +19,6 @@ static struct ctl_table cachefiles_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec,
 	},
-	{}
 };
 
 int __init cachefiles_register_error_injection(void)

-- 
2.30.2

