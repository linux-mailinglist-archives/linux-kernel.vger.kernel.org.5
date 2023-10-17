Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B1D7CBD24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjJQINP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:13:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA0393
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:13:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A99621CFE;
        Tue, 17 Oct 2023 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697530392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bz4qihpNWVUfRA4T6AtTXOMsnGSJJEDJzprcw5sYRuU=;
        b=PJArQNKzjC+6c6JMPIce3c8GmtsFpcA9oT821juMXeIlkaYkXQUB0z52m2llREjw8uBpZJ
        1DkWe8cmkytXxLWp18WsE4RjML/UW7lkTJbR2e9xn+P5QDLpO1MOjZFkTsJSgAuBpI91QS
        Aw8tzYawuMl0sHVCsn71/fxrLWTK4lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697530392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bz4qihpNWVUfRA4T6AtTXOMsnGSJJEDJzprcw5sYRuU=;
        b=4MmVu2U6Hy+Q3gOjgg6jTEciRJjuFrMNXwCKmgsOqwLAkRyHvBKQZFm0J36dUIiMSLXYuk
        dZOUkkAgIi0FkaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50BC113597;
        Tue, 17 Oct 2023 08:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dKb7EhhCLmXmRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Oct 2023 08:13:12 +0000
Message-ID: <82fc4f64-c1ac-fd74-d094-243d933a6965@suse.cz>
Date:   Tue, 17 Oct 2023 10:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/5] tools/mm: Fix the default case for page_owner_sort
Content-Language: en-US
To:     Audra Mitchell <audra@redhat.com>, linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231013190350.579407-1-audra@redhat.com>
 <20231013190350.579407-5-audra@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231013190350.579407-5-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.00)[40.94%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 21:03, Audra Mitchell wrote:
> With the additional commands and timestamps added to the tool, the default
> case (-t) has been broken. Now that the allocation timestamps are saved
> outside of the txt field, allow us to properly sort the data by number of
> times the record has been seen. Furthermore prevent the misuse of the
> commandline arguments so only one compare option can be used.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

