Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A0F7CBD22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjJQIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:12:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0059AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:12:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C86651FF06;
        Tue, 17 Oct 2023 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697530339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ77HGtm1b4uaWPKC3LIfKfaonrDeissPpBqeJTfv8I=;
        b=qFXrs4LlFba+2zSiFNBaM5OBTgyDKF4PZU3hDgp+UcGqoShxOdBLxURND6n1Apli4UMiMq
        hOK0VtfPYch6e4BZlTZVJgQxPcsFw9INduIxhhx9+lRNWYkh2eIzCYJ4EpRNWRbcqmtBDE
        m+G5DnF3GKcpuosraYabkA9dGTzC94c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697530339;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ77HGtm1b4uaWPKC3LIfKfaonrDeissPpBqeJTfv8I=;
        b=Uwm26zNsTnqhvQMghRnH9g9nZfwqPjx/qpOwnyHEMlVOe4XwVEgoFP1BpXlqnkGBQ2jax6
        fxGRpjW3P4ihhtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F09913597;
        Tue, 17 Oct 2023 08:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Nf/5JeNBLmVvRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Oct 2023 08:12:19 +0000
Message-ID: <4923f97e-8afd-37c7-42dc-0b2343e47396@suse.cz>
Date:   Tue, 17 Oct 2023 10:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] tools/mm: Filter out timestamps for correct collation
Content-Language: en-US
To:     Audra Mitchell <audra@redhat.com>, linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231013190350.579407-1-audra@redhat.com>
 <20231013190350.579407-4-audra@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231013190350.579407-4-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.11
X-Spamd-Result: default: False [-4.11 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.01)[48.34%];
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
> With the introduction of allocation timestamps being included in page_owner
> output, each record becomes unique due to the timestamp nanosecond
> granularity. Remove the check in add_list that tries to collate each record
> during processing as the memcmp() is just additional overhead at this
> point.
> 
> Also keep the allocation timestamps, but allow collation to occur without
> consideration of the allocation timestamp except in the case were
> allocation timestamps are requested by the user (the -a option).
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


