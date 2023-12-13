Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F881154B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjLMOyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441963AbjLMOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:54:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E419DE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:54:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E6CA01F37E;
        Wed, 13 Dec 2023 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702479266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
        b=ZLoALqRA7L2gn1jUHhWKPZ8FsqgrNIM6zzyojZ1D4YiV8ITCbBKrb5aFWdPaw/7apJ9fRk
        lT7ODM9G05nPdB3ZC336FWoioHhRCETiWDo32fVdBWj6JCfZ5mEHvF1yije1e+Ud5dJl+q
        WSBP+H8o1s4ZuNBROliQ9WmfdwHuHhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702479266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
        b=k4XKNkO1fxpEKthIeJQMcBp+wK+3nQ/0WCeH0Sx3zwlc1RHZ8LHaacGn5FUKsRBXZqcO4F
        V78dTtJRgrWX0BCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702479265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
        b=VmVAVDx8H8WVlFG1gcuTPGHKGXehPgHgjqPQhYcC5EyK5kjeafD0ny4F02VRIaggUrGjF1
        QnEDIRkac87J4DeuoRpTjDsx3DbHkqThYfBhV7+BdwWiqstROJL5vgc49JQxy6M3WN+/25
        vvGDJ0aZYFCHfe225ukIYEdnpq3yUwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702479265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
        b=OH+jeGOopi9dzJnHLYPtrzIQXer5nFH5NJ8wiLoUrHFr7zr8aMfcZBYJ9wPvVfBjQio7oz
        tD5qOAHujtfNw4Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA25113240;
        Wed, 13 Dec 2023 14:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 87LxL6HFeWUGSgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Wed, 13 Dec 2023 14:54:25 +0000
Date:   Wed, 13 Dec 2023 15:54:25 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Message-ID: <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-2-dwagner@suse.de>
 <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me>
X-Spam-Level: *******
X-Spam-Score: 7.09
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VmVAVDx8;
        dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OH+jeGOo;
        dmarc=pass (policy=none) header.from=suse.de;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-7.84 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         DKIM_TRACE(0.00)[suse.de:+];
         DMARC_POLICY_ALLOW(0.00)[suse.de,none];
         WHITELIST_DMARC(-7.00)[suse.de:D:+];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
         DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
         MX_GOOD(-0.01)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.33)[75.75%]
X-Spam-Score: -7.84
X-Rspamd-Queue-Id: E6CA01F37E
X-Spam-Flag: NO
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:27:12PM +0200, Sagi Grimberg wrote:
> > @@ -841,7 +841,7 @@ static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
> >   	u64 ref48;
> >   	/* both rw and write zeroes share the same reftag format */
> > -	switch (ns->guard_type) {
> > +	switch (ns->head->guard_type) {
> 
> I think that the whole PI stuff needs to be taken with a bit more
> consideration because if not all paths agree on the pi (as we have
> hbas with fabrics) we can't just override or do a logical or on
> the capabilities/attributes.

So should the PI variables stay in nvme_ns at this point? Or should I
add some checks which avoid an override and warn in this case?
