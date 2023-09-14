Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594517A0E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjINTkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:40:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5726AB;
        Thu, 14 Sep 2023 12:40:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E52C22185C;
        Thu, 14 Sep 2023 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694720399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYluOBaH1EHWk8SrAv7BsePqVdzKSF7hvQZ8jrr6zOA=;
        b=hLv8Q2h+K2BGrnxA69yqxfRxRgvWqDBU5/7xCauJ1LNGdVDe0LlDNnAbTNBRZ7vFbt9uwa
        oaCUGqEHWfh9PcGEm7O76Zd9a0CpWesj/vj2u4+HRY3WIBI+Z/t0zmN9BykdWaQgW0JT/C
        6vEr4GDHDT5MeJAgSxh5K0GcN+YuyHA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA4E413580;
        Thu, 14 Sep 2023 19:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ifydK49hA2VeBQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 14 Sep 2023 19:39:59 +0000
Date:   Thu, 14 Sep 2023 21:39:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZQNhjhhpG2aN8Xi6@dhcp22.suse.cz>
References: <20230626123252.73dbc139@endymion.delvare>
 <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
 <ZKLRaq3pzzE2gfws@dhcp22.suse.cz>
 <ZKhf8bi/eBDhaihD@bombadil.infradead.org>
 <ZKuaZepw51Nriqr8@dhcp22.suse.cz>
 <ZMGJGlJ7XSG+2vjY@bombadil.infradead.org>
 <20230828141830.02de4d90@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828141830.02de4d90@endymion.delvare>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-08-23 14:18:30, Jean Delvare wrote:
[...]
> > > It would likely be better to use refcount_t instead of atomic_t.  
> > 
> > Patches welcomed.
> 
> Michal, do I understand correctly that this would prevent the case our
> customer had (too many gets), but won't make a difference for actual
> too-many-puts situations?


yes, refcount_t cannot protect from too-many-puts because there is not
real way to protect from those AFAICS. At a certain moment you just drop
to 0 and lose your object and all following that is a UAF. But I do not
think this is actually the interesting case at all.
-- 
Michal Hocko
SUSE Labs
