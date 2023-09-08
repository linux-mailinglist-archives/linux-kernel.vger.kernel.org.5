Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C945879843E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbjIHIji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:39:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85761173B;
        Fri,  8 Sep 2023 01:39:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37501218E7;
        Fri,  8 Sep 2023 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694162371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbx31EkjZzotYqty93GvSD1Lhn8zAYWbew9Y/e9+J/k=;
        b=qdXyVB+GeZ7xjyEM+8B3z7v/B90Rjshipn9BTq6nq1UUwYXlLJmNGaDKURjIeKAoJLbN+i
        VJVAvWSSWPb5TA4HaTgyixstotOJXmkf4J5/AWMxH+NXG/2NxPktfLxuP43j9/Jw6TZjHO
        lt4IbeDeMkaGR3/b5PM+7anprx44UOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694162371;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbx31EkjZzotYqty93GvSD1Lhn8zAYWbew9Y/e9+J/k=;
        b=OVZArmbicxnYm09FYLfar8yuMGQNs+4+hIn3vfD/D1mB51k1nQaJmp8gUFh7UvPM6qLg/Y
        nw5MdFdYyVWNjMDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A850D131FD;
        Fri,  8 Sep 2023 08:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jy2wJcLd+mTgNwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 08 Sep 2023 08:39:30 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id eba3de06;
        Fri, 8 Sep 2023 08:39:29 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Milind Changire <mchangir@redhat.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] ceph: remove unnecessary check for NULL in
 parse_longname()
In-Reply-To: <3493bd1b-4982-e851-a2bc-c806889af01e@redhat.com> (Xiubo Li's
        message of "Fri, 8 Sep 2023 08:14:19 +0800")
References: <20230907133928.11126-1-lhenriques@suse.de>
        <3493bd1b-4982-e851-a2bc-c806889af01e@redhat.com>
Date:   Fri, 08 Sep 2023 09:39:29 +0100
Message-ID: <877cp1m532.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> On 9/7/23 21:39, Lu=C3=ADs Henriques wrote:
>> Function ceph_get_inode() never returns NULL; instead it returns an
>> ERR_PTR() if something fails.  Thus, the check for NULL in
>> parse_longname() useless and can be dropped.
>>
>> Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/crypto.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> index e4d5cd56a80b..7d0b9b5ccfc6 100644
>> --- a/fs/ceph/crypto.c
>> +++ b/fs/ceph/crypto.c
>> @@ -249,8 +249,6 @@ static struct inode *parse_longname(const struct ino=
de *parent,
>>   	if (!dir) {
>>   		/* This can happen if we're not mounting cephfs on the root */
>>   		dir =3D ceph_get_inode(parent->i_sb, vino, NULL);
>> -		if (!dir)
>> -			dir =3D ERR_PTR(-ENOENT);
>>   	}
>>   	if (IS_ERR(dir))
>>   		dout("Can't find inode %s (%s)\n", inode_number, name);
>>
> Luis,
>
> How about moving the error check into the=C2=A0 'if (!dir) {}' ? Because =
from
> 'ceph_find_inode()' the return value shouldn't be true here. This err che=
ck
> should for 'ceph_get_inode()' only.

Yeah, you're right.  Thanks, Xiubo.  I'll send out v2 shortly.

Cheers,
--=20
Lu=C3=ADs
