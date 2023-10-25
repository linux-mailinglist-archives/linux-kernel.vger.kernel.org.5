Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29DE7D71C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjJYQcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJYQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB7E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698251474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cjxB3xp7qNdoLHO4rmc9qAWqnKY0DCrkevqsgM+Qm2c=;
        b=fzqnmMPQdkT/BdnggzePz3BOEIaCF1dADKCfe4snNu/stowL9gliP6GSTaW/SZoX3uz+Fb
        D+rMlbyIQAE7+V8PMQZEa7nNux5LZBPL1TxnIOWAOTVWp5Wuq97AFiR1nqjcEJ1yCH55fq
        fUwtklcF41zZ0zDXe9QJ3W0EiVp01HM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Z-jgggwrNsevrjYIupxzqw-1; Wed, 25 Oct 2023 12:31:10 -0400
X-MC-Unique: Z-jgggwrNsevrjYIupxzqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C29309423D1;
        Wed, 25 Oct 2023 16:31:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id CB7161121314;
        Wed, 25 Oct 2023 16:31:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Oct 2023 18:30:09 +0200 (CEST)
Date:   Wed, 25 Oct 2023 18:30:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <20231025163006.GA8279@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The usage of writeverf_lock is wrong and misleading no matter what and
I can not understand the intent.

nfsd_copy_write_verifier() uses read_seqbegin_or_lock() incorrectly.
"seq" is always even, so read_seqbegin_or_lock() can never take the
lock for writing. We need to make the counter odd for the 2nd round:

	--- a/fs/nfsd/nfssvc.c
	+++ b/fs/nfsd/nfssvc.c
	@@ -359,11 +359,14 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
	  */
	 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
	 {
	-	int seq = 0;
	+	int seq, nextseq = 0;
	 
		do {
	+		seq = nextseq;
			read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
			memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
	+		/* If lockless access failed, take the lock. */
	+		nextseq = 1;
		} while (need_seqretry(&nn->writeverf_lock, seq));
		done_seqretry(&nn->writeverf_lock, seq);
	 }

OTOH. This function just copies 8 bytes, this makes me think that it doesn't
need the conditional locking and read_seqbegin_or_lock() at all. So perhaps
the (untested) patch below makes more sense? Please note that it should not
change the current behaviour, it just makes the code look correct (and more
optimal but this is minor).

Another question is why we can't simply turn nn->writeverf into seqcount_t.
I guess we can't because nfsd_reset_write_verifier() needs spin_lock() to
serialise with itself, right?

Oleg.
---

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c7af1095f6b5..094b765c5397 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
  */
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
 {
-	int seq = 0;
+	unsigned seq;
 
 	do {
-		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
+		seq = read_seqbegin(&nn->writeverf_lock);
 		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
-	} while (need_seqretry(&nn->writeverf_lock, seq));
-	done_seqretry(&nn->writeverf_lock, seq);
+	} while (read_seqretry(&nn->writeverf_lock, seq));
 }
 
 static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)

