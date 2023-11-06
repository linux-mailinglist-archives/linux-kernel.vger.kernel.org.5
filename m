Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C3F7E272F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjKFOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKFOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:41:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752CBB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699281619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMcYY+5We5ekO94w78KXk/20AylM3Bhsbh1nsFcYRz8=;
        b=CdAjDiHTUbIN3K7+CYcWS+5fh4x8/aEnvfXssN3YnoKfn0fMjXUnivBHbIdiCTmj+Vm+KD
        EYGvdR3lAZCpjKhjII/INGZ+PTaQjVcZEO79/JSnbWOpaypygGWcldWSSW0F5AvPN3aBGH
        w7ZcW7lmMnahF+71cHarVhRTLwMHpgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-urxlaezeP5aguOlBkR_aSA-1; Mon,
 06 Nov 2023 09:40:13 -0500
X-MC-Unique: urxlaezeP5aguOlBkR_aSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086ED3813F25;
        Mon,  6 Nov 2023 14:40:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB9AAC1596F;
        Mon,  6 Nov 2023 14:40:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZUiXkPPP1TuOgmmf@fedora.fritz.box>
References: <ZUiXkPPP1TuOgmmf@fedora.fritz.box> <20231022183917.1013135-1-sanpeqf@gmail.com> <ZUfQo47uo0p2ZsYg@fedora.fritz.box> <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com> <20231105193601.GB91123@sol.localdomain> <ZUfvk-6y2pER6Rmc@fedora.fritz.box> <20231105201516.GC91123@sol.localdomain>
To:     Damian Tometzki <damian@riscv-rocks.de>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
        Steve French <smfrench@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cifs: Fix encryption of cleared, but unset rq_iter data buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2610851.1699281611.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 06 Nov 2023 14:40:11 +0000
Message-ID: <2610852.1699281611@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damian,

Does the attached fix it for you?

David
---
cifs: Fix encryption of cleared, but unset rq_iter data buffers

Each smb_rqst struct contains two things: an array of kvecs (rq_iov) that
contains the protocol data for an RPC op and an iterator (rq_iter) that
contains the data payload of an RPC op.  When an smb_rqst is allocated
rq_iter is it always cleared, but we don't set it up unless we're going to
use it.

The functions that determines the size of the ciphertext buffer that will
be needed to encrypt a request, cifs_get_num_sgs(), assumes that rq_iter i=
s
always initialised - and employs user_backed_iter() to check that the
iterator isn't user-backed.  This used to incidentally work, because
->user_backed was set to false because the iterator has never been
initialised, but with commit f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74[1]
which changes user_backed_iter() to determine this based on the iterator
type insted, a warning is now emitted:

        WARNING: CPU: 7 PID: 4584 at fs/smb/client/cifsglob.h:2165 smb2_ge=
t_aead_req+0x3fc/0x420 [cifs]
        ...
        RIP: 0010:smb2_get_aead_req+0x3fc/0x420 [cifs]
        ...
         crypt_message+0x33e/0x550 [cifs]
         smb3_init_transform_rq+0x27d/0x3f0 [cifs]
         smb_send_rqst+0xc7/0x160 [cifs]
         compound_send_recv+0x3ca/0x9f0 [cifs]
         cifs_send_recv+0x25/0x30 [cifs]
         SMB2_tcon+0x38a/0x820 [cifs]
         cifs_get_smb_ses+0x69c/0xee0 [cifs]
         cifs_mount_get_session+0x76/0x1d0 [cifs]
         dfs_mount_share+0x74/0x9d0 [cifs]
         cifs_mount+0x6e/0x2e0 [cifs]
         cifs_smb3_do_mount+0x143/0x300 [cifs]
         smb3_get_tree+0x15e/0x290 [cifs]
         vfs_get_tree+0x2d/0xe0
         do_new_mount+0x124/0x340
         __se_sys_mount+0x143/0x1a0

The problem is that rq_iter was never set, so the type is 0 (ie. ITER_UBUF=
)
which causes user_backed_iter() to return true.  The code doesn't
malfunction because it checks the size of the iterator - which is 0.

Fix cifs_get_num_sgs() to ignore rq_iter if its count is 0, thereby
bypassing the warnings.

It might be better to explicitly initialise rq_iter to a zero-length
ITER_BVEC, say, as it can always be reinitialised later.

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather=
 than a page list")
Reported-by: Damian Tometzki <damian@riscv-rocks.de>
Link: https://lore.kernel.org/r/ZUfQo47uo0p2ZsYg@fedora.fritz.box/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Namjae Jeon <linkinjeon@kernel.org>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Eric Biggers <ebiggers@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Df1b4cb650b9a0eeba206d8f069fcdc532bfbcd74 [1]
---
 fs/smb/client/cifsglob.h |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 02082621d8e0..c70760871606 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2143,6 +2143,7 @@ static inline int cifs_get_num_sgs(const struct smb_=
rqst *rqst,
 	unsigned int len, skip;
 	unsigned int nents =3D 0;
 	unsigned long addr;
+	size_t data_size;
 	int i, j;
 =

 	/*
@@ -2158,17 +2159,21 @@ static inline int cifs_get_num_sgs(const struct sm=
b_rqst *rqst,
 	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
 	 */
 	for (i =3D 0; i < num_rqst; i++) {
+		data_size =3D iov_iter_count(&rqst[i].rq_iter);
+		    =

 		/* We really don't want a mixture of pinned and unpinned pages
 		 * in the sglist.  It's hard to keep track of which is what.
 		 * Instead, we convert to a BVEC-type iterator higher up.
 		 */
-		if (WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
+		if (data_size &&
+		    WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
 			return -EIO;
 =

 		/* We also don't want to have any extra refs or pins to clean
 		 * up in the sglist.
 		 */
-		if (WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
+		if (data_size &&
+		    WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
 			return -EIO;
 =

 		for (j =3D 0; j < rqst[i].rq_nvec; j++) {
@@ -2184,7 +2189,8 @@ static inline int cifs_get_num_sgs(const struct smb_=
rqst *rqst,
 			}
 			skip =3D 0;
 		}
-		nents +=3D iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
+		if (data_size)
+			nents +=3D iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
 	}
 	nents +=3D DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE, PAGE_=
SIZE);
 	return nents;

