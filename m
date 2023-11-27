Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF347F9C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjK0JZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjK0JZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:25:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED4CB;
        Mon, 27 Nov 2023 01:25:18 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75EB521A3B;
        Mon, 27 Nov 2023 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701077116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=61MSObp9Cm4wJIwhaJPM5k6K8AWumSd2PvI/OJBZ1Zw=;
        b=WzRoQ47ji2nH27LMWlYI8uNllDtvtpliKYrjoYVIItVlTYdNLSsmL9q355E4bOd2wQfZss
        y0aP9NlHbzulOWxZUzu2dkt6euwiC49Ok0pox/0Vb4MoQWii2CUBbL4atvBaSmybN03Q0e
        QXTlKz5EwpIE+ijj/T2YNQIlV84Ht3Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 696281367B;
        Mon, 27 Nov 2023 09:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id RsU0GXxgZGXpPQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Mon, 27 Nov 2023 09:25:16 +0000
Date:   Mon, 27 Nov 2023 10:25:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     shakeelb@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
        hannes@cmpxchg.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        kernel@sberdevices.ru, rockosov@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-ID: <ZWRgeAMxQ580-Fgd@tiehlicka>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-3-ddrokosov@salutedevices.com>
 <ZV3WnIJMzxT-Zkt4@tiehlicka>
 <20231122105836.xhlgbwmwjdwd3g5v@CAB-WSD-L081021>
 <ZV4BK0wbUAZBIhmA@tiehlicka>
 <20231122185727.vcfg56d7sekdfhnm@CAB-WSD-L081021>
 <20231123112629.2rwxr7gtmbyirwua@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123112629.2rwxr7gtmbyirwua@CAB-WSD-L081021>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: -0.99
X-Spam-Level: 
X-Spamd-Result: default: False [-0.99 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[14];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[google.com,goodmis.org,kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,sberdevices.ru,gmail.com,vger.kernel.org,kvack.org];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.19)[70.78%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-11-23 14:26:29, Dmitry Rokosov wrote:
> Michal, Shakeel,
> 
> Sorry for pinging you here, but I don't quite understand your decision
> on this patchset.
> 
> Is it a NAK or not? If it's not, should I consider redesigning
> something? For instance, introducing stub functions to
> remove ifdefs from shrink_node_memcgs().
> 
> Thank you for taking the time to look into this!

Sorry for a late reply. I have noticed you have posted a new version.
Let me have a look and comment there.

-- 
Michal Hocko
SUSE Labs
