Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA280086C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378303AbjLAKhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378266AbjLAKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:37:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA22F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:37:36 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5061221C55;
        Fri,  1 Dec 2023 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701427054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3AKHXuA9rkIsDSYU4VYYdpC7Z1E4D6XbgmPzoeVMV08=;
        b=CY5cWtFOcN9jOy0PFWPsrJrLEpFGDaWd6f52ktF+iZ2lmZWLHChlb++7dLUkPDxpsYNoZw
        cVbos4WRyBhkKA8Ojovn8rsa3/Xmd6J20OADutV0XA77pLK1p9OIdUqTTHXWbt62jgMy89
        E4D5c0wnfPIpqefwkppJvFnM515DRS8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EDF81379A;
        Fri,  1 Dec 2023 10:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id D1qICG63aWXNZAAAD6G6ig
        (envelope-from <mhocko@suse.com>); Fri, 01 Dec 2023 10:37:34 +0000
Date:   Fri, 1 Dec 2023 11:37:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pingfan Liu <piliu@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWm3bYYsMXVFqnnj@tiehlicka>
References: <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiOO-KNJ82f6Gxu@tiehlicka>
 <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
 <ZWiRbLGdBMO2jFGs@tiehlicka>
 <CAF+s44TQ2g6VTL4JSubvch5VkW7SSsePp-aBz+kigg563NijJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF+s44TQ2g6VTL4JSubvch5VkW7SSsePp-aBz+kigg563NijJg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.19
X-Spamd-Result: default: False [-1.19 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_SEVEN(0.00)[9];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.59)[81.62%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-12-23 08:54:20, Pingfan Liu wrote:
[...]
> > I am not aware of any method to detect a driver is going to configure a
> > RDMA.
> >
> 
> If there is a pattern, scripts/coccinelle may give some help. But I am
> not sure about that.

I am not aware of any pattern.

> > > If this can be resolved, I think this method is promising.
> >
> > Are you indicating this is a mandatory prerequisite?
> 
> IMHO, that should be mandatory. Otherwise for any unexpected kdump
> kernel collapses,  it can not shake off its suspicion.

I appreciate your carefulness! But I do not really see how such a
detection would work and be maintained over time. What exactly is the
scope of such a tooling? Should it be limited to RDMA drivers? Should we
protect from stray writes in general?

Also to make it clear. Are you going to nak the proposed solution if
there is no such tooling available?
-- 
Michal Hocko
SUSE Labs
