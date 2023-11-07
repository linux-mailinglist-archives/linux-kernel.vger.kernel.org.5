Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9CF7E3255
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjKGAoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:44:19 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C5D57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:44:16 -0800 (PST)
Date:   Mon, 6 Nov 2023 19:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699317854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6D02KJAK52DJD0acvzBTsRcEYJsd3WdwHRXSAUb1Ym8=;
        b=aDCHFWOvyuvLEYy0M1h2gFhgUVjw8fNcDT5vEcxZ540cnaqcF6h058VvBTyjz/dhTJGhcO
        jiSgTl++Pknyoeg1jlRD0sKGi7vE8rxgMBL093Vs1F5kPA+oamyzWbQjvFApGk29EGAWph
        +u4FFBwMl/gByt8WmoZNrZp4dXn82E0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Fix multiple -Warray-bounds warnings
Message-ID: <20231107004412.kase3fiwyr5p37gd@moria.home.lan>
References: <ZUldRv35EXKHAt3L@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUldRv35EXKHAt3L@work>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 03:40:22PM -0600, Gustavo A. R. Silva wrote:
> Transform zero-length array `entries` into a proper flexible-array
> member in `struct journal_seq_blacklist_table`; and fix the following
> -Warray-bounds warnings:
> 
> fs/bcachefs/journal_seq_blacklist.c:148:26: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:150:30: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:154:27: warning: array subscript idx is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:176:27: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:177:27: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:297:34: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:298:34: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> fs/bcachefs/journal_seq_blacklist.c:300:31: warning: array subscript i is outside array bounds of 'struct journal_seq_blacklist_table_entry[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output.
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, applied
