Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967A57FCAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376487AbjK1Xbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Xbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:31:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A101AD;
        Tue, 28 Nov 2023 15:31:38 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAD41F898;
        Tue, 28 Nov 2023 23:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701214296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhtBuDaZGYA819mpouZcxSxxgJoRCLewkkNQb5qq+ak=;
        b=DItGLTbAaAMYDM9LJCQSj619BbDcAxCPE6J8TDRdH7N2nffEuOa0O5dxPHUV7YF5k8dQ6Q
        EBtmO2q18FuKLYBnoVIEujaOo421wJDL7pXkWRC+QEd6LK5X0lLkB8icLwbZx3ujg34MkS
        P3R9qSgriY9ZoWptcQyGVQm+mRWnWxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701214296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhtBuDaZGYA819mpouZcxSxxgJoRCLewkkNQb5qq+ak=;
        b=jY4I5ejmx/t9jlh1zSn6SEjz+2pLcB/a0Y3mg1rPbJPnnp5KFl1VspmnrF4qEyg1VVXapT
        InIUpp9YrlhQ8ACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4BE913763;
        Tue, 28 Nov 2023 23:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id jHFRHFV4ZmUFWgAAD6G6ig
        (envelope-from <neilb@suse.de>); Tue, 28 Nov 2023 23:31:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Christian Brauner" <brauner@kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
In-reply-to: <518775f9f9bd3ad1afec0bde4d0a6bee3370bdd4.camel@kernel.org>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>,
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>,
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>,
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>,
 <518775f9f9bd3ad1afec0bde4d0a6bee3370bdd4.camel@kernel.org>
Date:   Wed, 29 Nov 2023 10:31:30 +1100
Message-id: <170121429051.7109.6920588851658122847@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.29 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         NEURAL_HAM_SHORT(-0.19)[-0.952];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.00)[12.59%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.29
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023, Jeff Layton wrote:
> 
> This is another place where we might want to reserve a "rescuer" thread
> that avoids doing work that can end up blocked. Maybe we could switch
> back to queuing them to the list when we're below a certain threshold of
> available threads (1? 2? 4?).

A rescuer isn't for cases where work might be blocked, but for cases
whether otherwise work might be deadlocked - though maybe that is what
you meant.

Could nfsd calling filp_close() or __fput() ever deadlock?
I think we know from the experience pre v5.8 that calling filp_close()
doesn't cause deadlocks.  Could __fput, and particularly ->release ever
deadlock w.r.t nfsd?  i.e.  could a ->release function for a file
exported through NFS ever wait for nfsd to handle an NFS request?

We don't need to worry about indirect dependencies like allocating
memory and waiting for nfsd to flush out writes - that is already
handled so that we can support loop-back mounts.

So to have a problem we would need to nfs-export an NFS filesystem that
was being served by the local NFS server.  Now that we support NFS
re-export, and we support loop-back mounts, it is fair to ask if we
support the combination of the two.  If we did, then calling ->release
from the nfsd thread could deadlock.  But calling ->read and ->write (or
whatever those interfaces are called today) would also deadlock.

So I think we have to say that nfs-reexporting a loop-back NFS mount is
not supported, and not supportable.  Whether we should try to detect and
reject this case is an interesting question, but quite a separate
question from that of how to handle the closing of files.

In short - I don't think there is any need or value in a dedicated
"rescuer" thread here.

Thanks,
NeilBrown
