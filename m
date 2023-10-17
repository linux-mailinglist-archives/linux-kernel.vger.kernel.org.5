Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9657CBA89
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjJQGGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQGGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:06:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D6B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:06:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4443B1FEFC;
        Tue, 17 Oct 2023 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697522768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHVftjgUsbSoduhlYKO3xpylXbMeB/YigrfNtTGt5qg=;
        b=AyCWdeJCTiQBNMSg+ffSDEipfK5nXBeJc01Z6pl7PTS4Jw23isCj3DqdcO1v4CTsyTN8c0
        w6k39xAltnM22NsziHoOZoLFb7gpNy1E9uaWPVNhibkjXvRbRK+71i0Y+O1yra+P70RYmn
        90J1aBP1ZEdY7hy4RloMV5262uYZrKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697522768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHVftjgUsbSoduhlYKO3xpylXbMeB/YigrfNtTGt5qg=;
        b=5PuC+BLsjSmWB2I7L/lbYvGZo91nwBqtkqwWnn09vXclS9AZWJ67SU8ZvrzqkOwYVfOQ9i
        IdXKVZTnAA3tUcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E341E13597;
        Tue, 17 Oct 2023 06:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2MwLNk8kLmWIAQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 17 Oct 2023 06:06:07 +0000
Message-ID: <41582b35-07a0-40ef-8b52-6148b6cf015b@suse.de>
Date:   Tue, 17 Oct 2023 08:06:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme-auth: use transformed key size to create resp
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org,
        Akash Appaiah <Akash.Appaiah@dell.com>
References: <20231016225857.3085234-1-shiftee@posteo.net>
 <20231016225857.3085234-3-shiftee@posteo.net>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231016225857.3085234-3-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -9.31
X-Spamd-Result: default: False [-9.31 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-1.22)[89.32%];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 00:58, Mark O'Donovan wrote:
> This does not change current behaviour as the driver currently
> verifies that the secret size is the same size as the length of
> the transformation hash.
> 
> Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
> V1 -> V2: support target implementation and controller secrets also
> V2 -> V3: return key from nvme_auth_transform_key
> 
Exactly what I had in mind. Thanks for doing this.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

