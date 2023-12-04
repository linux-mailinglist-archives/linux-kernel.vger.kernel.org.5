Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947F780390F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjLDPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:43:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12ECA;
        Mon,  4 Dec 2023 07:43:22 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89F8E1F8CC;
        Mon,  4 Dec 2023 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701704600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YOaNcpQ6My2bUhBcS70FOu0bLg5v5vZHCTRkgHEbbYM=;
        b=tj/UJeCdsMGyPWGdKIizicxYxzBgTyG1loqLjwj9GNYY5CVkpbGvV79Sugd3/xJZYqnx5P
        0cM9dGOVT7TG1MmP/dBn/0UEwDd59VfveUq3avVaAKDudbopYSwMw26Rfmg6R/plnXcaey
        8vK4WDl22XY+fI2mSXzqxXBlvrw21Ps=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64AAF139AA;
        Mon,  4 Dec 2023 15:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id VZXlFZjzbWU9WgAAD6G6ig
        (envelope-from <mhocko@suse.com>); Mon, 04 Dec 2023 15:43:20 +0000
Date:   Mon, 4 Dec 2023 16:43:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     sthanneeru.opensrc@micron.com
Cc:     aneesh.kumar@linux.ibm.com, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, dan.j.williams@intel.com, hannes@cmpxchg.org,
        hasanalmaruf@fb.com, haowang3@fb.com, ying.huang@intel.com,
        gregory.price@memverge.com, tj@kernel.org,
        hezhongkun.hzk@bytedance.com, fvdl@google.com, john@jagalactic.com,
        emirakhur@micron.com, vtavarespetr@micron.com,
        Ravis.OpenSrc@micron.com, Jonathan.Cameron@huawei.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Node migration between memory tiers
Message-ID: <ZW3zl2Fke5FtQCv3@tiehlicka>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.22
X-Spamd-Result: default: False [-3.22 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_TWELVE(0.00)[20];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.62)[98.31%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> The memory tiers feature allows nodes with similar memory types
> or performance characteristics to be grouped together in a
> memory tier. However, there is currently no provision for
> moving a node from one tier to another on demand.

Could you expand on why this is really needed/necessary? What is the
actual usecase?
-- 
Michal Hocko
SUSE Labs
