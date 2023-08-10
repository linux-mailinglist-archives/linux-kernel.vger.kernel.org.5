Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26052777DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjHJQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjHJQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E22F30DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A13C56629E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FBAC433C9;
        Thu, 10 Aug 2023 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691683808;
        bh=NzYbY6fgKqePhu5kbnmOHqphDUf1P3cZSTDiD6+oCWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrnN1X9SckoYQXfAWns1HxdtwNDdymCiYqpoxmKbzGa2sAxxTzjDyJIsjVMOd2hi8
         qJ9n266NSjQBNARr4Sj0DQoRFWwdWP+dbKJjjInNGN6J4sXk5ylXwWtMzZAZf3E6ua
         m841ZeUjHZ2lPxPzIx/EmrZJhnBgrbfpgr4gD9KS3xut0L5NGnqmgfQql0Z99XnPmF
         xm50O91hOQWkjjRDl/GNZ4p0sWnhcDlWid8LV+Db8Uv16w9xn5CFQdvac2ksfqs9qo
         FzLGG+CBsARBN3YDK9140SmuvbCpDvh8FiAb4Lg7KK247Kjhqf8AZBtH1WQHMamgXt
         38jr6K8xD+/fg==
Date:   Thu, 10 Aug 2023 12:10:03 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230810161003.i65d37ozlt3d5xse@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:44:04PM +0200, Borislav Petkov wrote:
> On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> > Since it is now readily apparent that the two SRSO
> > untrain_ret+return_thunk variants are exactly the same mechanism as
> > the existing (retbleed) zen untrain_ret+return_thunk, add them to the
> > existing retbleed options.
> 
> Except that Zen3/4 are not affected by retbleed, according to my current
> state of information.
> 
> I don't like this lumping together of the issues even if their
> mitigations are more or less similar.

I tend to agree that SRSO is a new issue and should have its own sysfs
and cmdline options (though a separate CONFIG option is overkill IMO).

The mitigations are unfortunately intertwined, but we've been in that
situation several times before (e.g., spectre_v2 + intel retbleed).

-- 
Josh
