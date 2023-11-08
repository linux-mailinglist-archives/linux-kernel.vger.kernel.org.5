Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724267E55B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjKHLld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHLlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:41:32 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5C1A5;
        Wed,  8 Nov 2023 03:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=bmLEr1pWb19NVnljsUvllcFFWGCCprF2QCo+mitQriY=; t=1699443690; x=1700653290; 
        b=imExegtKaubsD2HuITWfhDle5a+vz34HZTTr8YXUHPvHmfKWNqbcBkCQ4yjrnn5nNz7URZC+C+C
        lYrvFj6PfwxqIJdrT+I0FN9Pdmqj33LGOhuha+68ClzuCt3xx6jdBvD4cPpeg8Zfy+JceoWiDcbWP
        GSMpbHPHhSR1iQpgx09QB1NbiTCKXrZbAyFDwH47kmmS4zJNVyDTNHw1MJWl7KjuUXeLDg355p1zW
        DDmmRPKuhjSq8DvieSn7BdwsfuOTj3bncqEvARlG/msyZSoEdli4khNFN6TKBLhSsSP8WgI0aQ0ri
        Q09XHCcZ/OiQsCadj90pYwrRYb4gOLWwF5vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0gw2-00000000Trk-2CuE;
        Wed, 08 Nov 2023 12:41:26 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] Documentation: locking: mutex-design: fix atomic_dec_and_mutex_lock()
Date:   Wed,  8 Nov 2023 12:41:24 +0100
Message-ID: <20231108124123.51c4a7339b7b.Id71e81d75d102fff30d5cd33e39d27caefbf83b7@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since atomic_dec_and_mutex_lock() uses mutex_lock() it is indeed not
interruptible. Fix the documentation.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Fixes: 9161f5409798 ("locking/mutexes: Documentation update/rewrite")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 Documentation/locking/mutex-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 78540cd7f54b..9d75661a60fc 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -124,7 +124,7 @@ Acquire the mutex, interruptible::
 				       unsigned int subclass);
    int mutex_lock_interruptible(struct mutex *lock);
 
-Acquire the mutex, interruptible, if dec to 0::
+Acquire the mutex, uninterruptible, if dec to 0::
 
    int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
-- 
2.41.0

