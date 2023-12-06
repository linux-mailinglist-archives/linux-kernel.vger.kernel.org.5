Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E272D8073A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379137AbjLFPWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379088AbjLFPWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:22:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33083C6;
        Wed,  6 Dec 2023 07:22:18 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8E9F1FD10;
        Wed,  6 Dec 2023 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701876136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gkjHKYAP5twolJ4o2zeIBlBabIi6G0piKzuKxyph/is=;
        b=MdULf2FQpMh7CIDFOz6/1CQ2AvWwRPAclXBWeHxX8E7ca0tpr4W4qpbJrUS8Fit+3D5H8j
        BrcB7llqosZTjB9s7y/NepYDP/2atjTJJZZjjpTJ0Jg8hPoVfIMigbrswCzTKjw6hXTyHB
        lDmLW9gztz9b5nATD4h/8mWBlRo4f5U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EE42136CD;
        Wed,  6 Dec 2023 15:22:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id m2v4GqiRcGUHSwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 06 Dec 2023 15:22:16 +0000
Date:   Wed, 6 Dec 2023 16:22:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Ravi Jonnalagadda <ravis.opensrc@micron.com>
Cc:     Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
        dan.j.williams@intel.com, emirakhur@micron.com, fvdl@google.com,
        gregory.price@memverge.com, hannes@cmpxchg.org, haowang3@fb.com,
        hasanalmaruf@fb.com, hezhongkun.hzk@bytedance.com,
        john@jagalactic.com, linux-api@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sthanneeru.opensrc@micron.com, tj@kernel.org,
        vtavarespetr@micron.com, ying.huang@intel.com
Subject: Re: [RFC PATCH 0/2] Node migration between memory tiers
Message-ID: <ZXCRp78pD0ZMTMBw@tiehlicka>
References: <ZW7km-SED5oIGGnZ@tiehlicka>
 <20231205091958.55-1-ravis.opensrc@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205091958.55-1-ravis.opensrc@micron.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.12
X-Spamd-Result: default: False [0.12 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[20];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.08)[63.83%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-12-23 14:49:58, Ravi Jonnalagadda wrote:
[...]
> There was a prior discussion on this functionality in a previous thread, where
> Huang Ying thought this might be a useful feature to overcome limitations of
> systems where nodes with different bandwidth characteristics are grouped in 
> a single tier.

Please summarize all those prior discussions into the cover letter.
Usecases are really crucial for the justification.
>
-- 
Michal Hocko
SUSE Labs
