Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48B7E3254
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjKGAnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:43:30 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD45D75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:43:26 -0800 (PST)
Date:   Mon, 6 Nov 2023 19:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699317805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6HnxRoOPPImtylzQDYeZiH0FMhR4x9tENVXHd4saCI=;
        b=Pyyr4jJ5gMNHCJajjVwQncqEuF65FVFmLBbOhW6sOQI9bbomEEQlSpmTDRG1Bqqh0/d0PN
        fD7AaPSCQ9EZ1FzI2aKwws15ibXFiRL/mjpIeGS8+Cc51D5Sb80gfuWkErerJn5lMiL7xs
        7RtZsT+E8yqZAuiAyyWbrW2DMqCEPuA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Use DECLARE_FLEX_ARRAY() helper and fix
 multiple -Warray-bounds warnings
Message-ID: <20231107004321.onldaaepahzapwz5@moria.home.lan>
References: <ZUloNt0HSulJgZNH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUloNt0HSulJgZNH@work>
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

On Mon, Nov 06, 2023 at 04:27:02PM -0600, Gustavo A. R. Silva wrote:
> Transform zero-length array `s` into a proper flexible-array
> member in `struct snapshot_table` via the DECLARE_FLEX_ARRAY()
> helper; and fix tons of the following -Warray-bounds warnings:
> 
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.c:135:70: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> fs/bcachefs/snapshot.h:36:21: warning: array subscript <unknown> is outside array bounds of 'struct snapshot_t[0]' [-Warray-bounds=]
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, applied
