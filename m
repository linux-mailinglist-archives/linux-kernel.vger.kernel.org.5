Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8688680CCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbjLKOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjLKOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777B3A84
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702303382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/ItFeG9I3Z0oT+bsnz2Nm0t33eZdTXAx/q4fgwtKPo=;
        b=c1wYYmiUatvz4PBVVt0sNDqEaaNTCdSH3rnh68/g/xNQr2ZNq4pXONhIkGp5PkyIkcorpC
        ZU2HWZUtO/p0tFmt7ieUXWyto82+WLFeyxiOoz9DlWquGn+D5HcQFwecSJriD9noOKCVN3
        BCCsm8q9L9ttdgqfKlDc47hIdBuoAR0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-6_kAC2vdNKWK8F8OWA-jnA-1; Mon,
 11 Dec 2023 09:02:59 -0500
X-MC-Unique: 6_kAC2vdNKWK8F8OWA-jnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F7E53C2AF66;
        Mon, 11 Dec 2023 14:02:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47C5D51E3;
        Mon, 11 Dec 2023 14:02:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231207024323.GA1994@sol.localdomain>
References: <20231207024323.GA1994@sol.localdomain> <20231206145744.17277-1-lhenriques@suse.de> <498294.1701878642@warthog.procyon.org.uk> <87bkb3z047.fsf@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dhowells@redhat.com, Luis Henriques <lhenriques@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] keys: flush work when accessing /proc/key-users
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2744562.1702303367.1@warthog.procyon.org.uk>
Date:   Mon, 11 Dec 2023 14:02:47 +0000
Message-ID: <2744563.1702303367@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:

> If there was a function that fully and synchronously releases a key's quota,
> fs/crypto/ could call it before unlinking the key.  key_payload_reserve(key,
> 0) almost does the trick, but it would release the key's bytes, not the key
> itself.

Umm...  The point of the quota is that the key is occupying unswappable kernel
memory (partly true in the case of big_key) and we need to limit that.
Further, the key is not released until it is unlinked.

> However, that would only fix the flakiness of the key quota for fs/crypto/,
> not for other users of the keyrings service.  Maybe this suggests that
> key_put() should release the key's quota right away if the key's refcount
> drops to 0?

That I would be okay with as the key should be removed in short order.

Note that you'd have to change the spinlocks on key->user->lock to irq-locking
types.  Or maybe we can do without them, at least for key gc, and use atomic
counters.  key_invalidate() should probably drop the quota also.

I'm also working up a patch so that key types can be marked for immediate gc
if they expire, rather than there being a period (key_gc_delay) in which they
cause EKEYEXPIRED rather than ENOKEY to be returned for better indication to
userspace as to what's happened when a filesystem op fails to to key problems.

> Either way, note that where fs/crypto/ does key_put() on a whole keyring at
> once, it would first need to call keyring_clear() to clear it synchronously.

What if there's another link on the keyring?  Should it still be cleared?

Do we need faster disposal of keys?  Perhaps keeping a list of keys that need
destroying rather than scanning the entire key set for them.  We still need to
scan non-destroyed keyrings, though, to find the pointers to defunct keys
unless I have some sort of backpointer list.

David

