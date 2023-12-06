Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6BF807714
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379008AbjLFRz6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 12:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442777AbjLFRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:55:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D129D46;
        Wed,  6 Dec 2023 09:56:00 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 264911FD19;
        Wed,  6 Dec 2023 17:55:58 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B171013408;
        Wed,  6 Dec 2023 17:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id eiztJ621cGUXAgAAD6G6ig
        (envelope-from <lhenriques@suse.de>); Wed, 06 Dec 2023 17:55:57 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id d7eb9602;
        Wed, 6 Dec 2023 17:55:52 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] keys: flush work when accessing /proc/key-users
In-Reply-To: <498294.1701878642@warthog.procyon.org.uk> (David Howells's
        message of "Wed, 06 Dec 2023 16:04:02 +0000")
References: <20231206145744.17277-1-lhenriques@suse.de>
        <498294.1701878642@warthog.procyon.org.uk>
Date:   Wed, 06 Dec 2023 17:55:52 +0000
Message-ID: <87bkb3z047.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spamd-Bar: ++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of lhenriques@suse.de) smtp.mailfrom=lhenriques@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [10.37 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.89)[99.51%];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(2.97)[0.989];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[5];
         RCVD_COUNT_THREE(0.00)[4];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_LAST(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 10.37
X-Rspamd-Queue-Id: 264911FD19
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Luis Henriques <lhenriques@suse.de> wrote:
>
>> This patch is mostly for getting some feedback on how to fix an fstest
>> failing for ext4/fscrypt (generic/581).  Basically, the test relies on the
>> data read from /proc/key-users to be up-to-date regarding the number of
>> keys a given user currently has.  However, this file can't be trusted
>> because it races against the keys GC.
>
> Unfortunately, I don't think your patch helps.  If the GC hasn't started yet,
> it won't achieve anything and the GC can still be triggered at any time after
> the flush and thus race.
>
> What is it you're actually trying to determine?
>
> And is it only for doing the test?

OK, let me try to describe what the generic/581 fstest does.

After doing a few fscrypt related things, which involve adding and
removing keys, the test will:

1. Get the number of keys for user 'fsgqa' from '/proc/key-users'
2. Set the maxkeys to 5 + <keys the user had in 1.>
3. In a loop, try to add 6 new keys, to confirm the last one will fail

Most of the time the test passes, i.e., the 6th key fails to be added.
However, if, for example, the test is executed in a loop, it is possible
to have it fail because the 6th key was successfully added.  The reason
is, obviously, because the test is racy: the GC can kick-in too late,
after the maxkeys is set in step 2.

So, this is mostly an issue with the test itself, but I couldn't figure
out a way to work around it.

Another solution I thought but I didn't look too deep into was to try to
move the

	atomic_dec(&key->user->nkeys);

out of the GC, in function key_gc_unused_keys().  Decrementing it
synchronously in key_put() (or whatever other functions could schedule GC)
should solve the problem with this test.  But as I said I didn't went too
far looking into that, so I don't really know if that's feasible.

Finally, the test itself could be hacked so that the loop in step 3. would
update the maxkeys value if needed, i.e. if the current number of keys for
the user isn't what was expected in each loop iteration.  But even that
would still be racy.

Cheers,
-- 
Luís
