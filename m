Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E01812BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443454AbjLNJdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:33:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFAA98
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:33:45 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEA55220E0;
        Thu, 14 Dec 2023 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702546423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
        b=KiyCg9T6jGKbZVGUnw7BORbHd6Z0pp2GszcyINcAEI+B4KSglvg7qvLiTqrF8ahMzUl6Rg
        N+WF9j86ZO5PsJb4ovvO6xNwDD8ekrm3WcRrtT6pkRyn+3m98DTheFVeP8jlJlSAM8+xp3
        WZz1KJxXeh6+t+8WUIFzjxBj+8tMmWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702546423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
        b=fkjkBDFBg5ZewdPz8vlQ2a4obfMBtqOnIjr0gLTCSBWKgDl0pDyebDt4A+XWs2O5QfPtxd
        nKCfqOq1iAega/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702546423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
        b=KiyCg9T6jGKbZVGUnw7BORbHd6Z0pp2GszcyINcAEI+B4KSglvg7qvLiTqrF8ahMzUl6Rg
        N+WF9j86ZO5PsJb4ovvO6xNwDD8ekrm3WcRrtT6pkRyn+3m98DTheFVeP8jlJlSAM8+xp3
        WZz1KJxXeh6+t+8WUIFzjxBj+8tMmWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702546423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LqHwD4UGn1zZYNa5Woz1k2VMDd8pQo3bwLIR8Mlgw0=;
        b=fkjkBDFBg5ZewdPz8vlQ2a4obfMBtqOnIjr0gLTCSBWKgDl0pDyebDt4A+XWs2O5QfPtxd
        nKCfqOq1iAega/Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DEA68138F2;
        Thu, 14 Dec 2023 09:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id WzWuNfbLemU1PwAAn2gu4w
        (envelope-from <dwagner@suse.de>); Thu, 14 Dec 2023 09:33:42 +0000
Date:   Thu, 14 Dec 2023 10:31:28 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Message-ID: <jt7wqbbuk7wh2dxjkkbdxp7afwy5y5yaudz4jg4ucnxbwz3nni@rg7hzchx6qix>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-2-dwagner@suse.de>
 <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me>
 <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
 <20231213153833.GC7301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213153833.GC7301@lst.de>
X-Spam-Level: *********
X-Spam-Score: 9.29
X-Spamd-Result: default: False [-11.17 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_TRACE(0.00)[suse.de:+];
         DMARC_POLICY_ALLOW(0.00)[suse.de,none];
         RCPT_COUNT_SEVEN(0.00)[7];
         MX_GOOD(-0.01)[];
         DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.16)[69.18%];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DWL_DNSWL_HI(-3.50)[suse.de:dkim];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         WHITELIST_DMARC(-7.00)[suse.de:D:+];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: EEA55220E0
X-Spam-Score: -11.17
X-Spam-Flag: NO
Authentication-Results: smtp-out1.suse.de;
        dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KiyCg9T6;
        dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fkjkBDFB;
        dmarc=pass (policy=none) header.from=suse.de;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:38:34PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 13, 2023 at 03:54:25PM +0100, Daniel Wagner wrote:
> > > I think that the whole PI stuff needs to be taken with a bit more
> > > consideration because if not all paths agree on the pi (as we have
> > > hbas with fabrics) we can't just override or do a logical or on
> > > the capabilities/attributes.
> > 
> > So should the PI variables stay in nvme_ns at this point? Or should I
> > add some checks which avoid an override and warn in this case?
> 
> Didn't we merge the patch from max to require uniform PI setups
> for all controllers that we're using in a multipath setup?  I'll
> check the code after finishing a few more things if no one remembers
> offhand.

The newest discussion on this topic I found was this:

https://lore.kernel.org/linux-nvme/ec66d848-5246-529a-7050-afca3d1d981f@nvidia.com/
